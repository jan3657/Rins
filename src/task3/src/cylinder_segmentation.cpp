#include <iostream>
#include <ros/ros.h>
#include <math.h>
#include <visualization_msgs/Marker.h>
#include <sensor_msgs/PointCloud2.h>
#include <pcl_conversions/pcl_conversions.h>
#include <pcl/ModelCoefficients.h>
#include <pcl/io/pcd_io.h>
#include <pcl/point_types.h>
#include <pcl/filters/extract_indices.h>
#include <pcl/filters/passthrough.h>
#include <pcl/features/normal_3d.h>
#include <pcl/sample_consensus/method_types.h>
#include <pcl/sample_consensus/model_types.h>
#include <pcl/segmentation/sac_segmentation.h>
#include "pcl/point_cloud.h"
#include "tf2_ros/transform_listener.h"
#include "tf2_geometry_msgs/tf2_geometry_msgs.h"
#include "geometry_msgs/PointStamped.h"
#include "task3/Cylinder.h"
#include <string>

ros::Publisher cylinder_publisher;
ros::Publisher pubx;
ros::Publisher puby;
ros::Publisher pubm;

tf2_ros::Buffer tf2_buffer;

typedef pcl::PointXYZRGBA PointT;

void cloud_cb(const pcl::PCLPointCloud2ConstPtr &cloud_blob) {
    // All the objects needed

    ros::Time time_rec, time_test;
    time_rec = ros::Time::now();

    pcl::PassThrough<PointT> pass;
    pcl::NormalEstimation<PointT, pcl::Normal> ne;
    pcl::SACSegmentationFromNormals<PointT, pcl::Normal> seg;
    pcl::PCDWriter writer;
    pcl::ExtractIndices<PointT> extract;
    pcl::ExtractIndices<pcl::Normal> extract_normals;
    pcl::search::KdTree<PointT>::Ptr tree(new pcl::search::KdTree<PointT>());
    Eigen::Vector4f centroid;

    // Datasets
    pcl::PointCloud<PointT>::Ptr cloud(new pcl::PointCloud<PointT>);
    pcl::PointCloud<PointT>::Ptr cloud_filtered(new pcl::PointCloud<PointT>);
    pcl::PointCloud<pcl::Normal>::Ptr cloud_normals(new pcl::PointCloud<pcl::Normal>);
    pcl::PointCloud<PointT>::Ptr cloud_filtered2(new pcl::PointCloud<PointT>);
    pcl::PointCloud<pcl::Normal>::Ptr cloud_normals2(new pcl::PointCloud<pcl::Normal>);
    pcl::ModelCoefficients::Ptr coefficients_plane(new pcl::ModelCoefficients), coefficients_cylinder(new pcl::ModelCoefficients);
    pcl::PointIndices::Ptr inliers_plane(new pcl::PointIndices), inliers_cylinder(new pcl::PointIndices);

    // Read in the cloud data
    pcl::fromPCLPointCloud2(*cloud_blob, *cloud);

    // Build a passthrough filter to remove spurious NaNs
    pass.setInputCloud(cloud);
    pass.setFilterFieldName("z");
    pass.setFilterLimits(0, 1.5);
    pass.filter(*cloud_filtered);
    //std::cerr << "PointCloud after filtering has: " << cloud_filtered->points.size() << " data points." << std::endl;

    pass.setInputCloud(cloud_filtered);
    pass.setFilterFieldName("y");
    pass.setFilterLimits(0, 0.1);
    pass.filter(*cloud_filtered);

    // Estimate point normals
    ne.setSearchMethod(tree);
    ne.setInputCloud(cloud_filtered);
    ne.setKSearch(50);
    ne.compute(*cloud_normals);

    // Create the segmentation object for the planar model and set all the parameters
    seg.setOptimizeCoefficients(true);
    seg.setModelType(pcl::SACMODEL_NORMAL_PLANE);
    seg.setNormalDistanceWeight(0.1);
    seg.setMethodType(pcl::SAC_RANSAC);
    seg.setMaxIterations(100);
    seg.setDistanceThreshold(0.01);
    
    int initial_size = cloud_filtered->height * cloud_filtered->width;
    int count = 0;
    
    while (cloud_filtered->height * cloud_filtered->width > initial_size * 0.1 && count++ < 3) {
    
        seg.setInputCloud(cloud_filtered);
        seg.setInputNormals(cloud_normals);
        
        // Obtain the plane inliers and coefficients
        (void)seg.segment(*inliers_plane, *coefficients_plane);
        //std::cerr << "Plane coefficients: " << *coefficients_plane << std::endl;
        
        // Extract the planar inliers from the input cloud
        extract.setInputCloud(cloud_filtered);
        extract.setIndices(inliers_plane);
        extract.setNegative(true);
        
        extract_normals.setInputCloud(cloud_normals);
        extract_normals.setIndices(inliers_plane);
        extract_normals.setNegative(true);
        
        extract.filter(*cloud_filtered2);
        cloud_filtered.swap(cloud_filtered2);

        extract_normals.filter(*cloud_normals2);
        cloud_normals.swap(cloud_normals2);
        
    }
    
    if (cloud_filtered->height * cloud_filtered->width < 10)
        return;
    
    // Write the planar inliers to disk
    //pcl::PointCloud<PointT>::Ptr cloud_plane(new pcl::PointCloud<PointT>());
    //extract.filter(*cloud_plane);
    //std::cerr << "PointCloud representing the planar component: " << cloud_plane->points.size() << " data points." << std::endl;

    pcl::PCLPointCloud2 outcloud_plane;
    pcl::toPCLPointCloud2(*cloud_filtered, outcloud_plane);
    pubx.publish(outcloud_plane);

    // Remove the planar inliers, extract the rest
    //extract.setNegative(true);
    //extract.filter(*cloud_filtered2);
    //extract_normals.setNegative(true);
    //extract_normals.setInputCloud(cloud_normals);
    //extract_normals.setIndices(inliers_plane);
    //extract_normals.filter(*cloud_normals2);

    // Create the segmentation object for cylinder segmentation and set all the parameters
    seg.setOptimizeCoefficients(true);
    seg.setModelType(pcl::SACMODEL_CYLINDER);
    seg.setMethodType(pcl::SAC_RANSAC);
    seg.setNormalDistanceWeight(0.1);
    seg.setMaxIterations(10000);
    seg.setDistanceThreshold(0.005);
    seg.setRadiusLimits(0.115, 0.122);
    seg.setInputCloud(cloud_filtered);
    seg.setInputNormals(cloud_normals);

    // Obtain the cylinder inliers and coefficients
    (void)seg.segment(*inliers_cylinder, *coefficients_cylinder);
    //std::cerr << "Cylinder coefficients: " << *coefficients_cylinder << std::endl;

    // Write the cylinder inliers to disk
    extract.setInputCloud(cloud_filtered);
    extract.setIndices(inliers_cylinder);
    extract.setNegative(false);
    pcl::PointCloud<PointT>::Ptr cloud_cylinder(new pcl::PointCloud<PointT>());
    extract.filter(*cloud_cylinder);

    if (cloud_cylinder->points.empty())
        std::cerr << "Can't find the cylindrical component." << std::endl;
    else {
        //std::cerr << "PointCloud representing the cylindrical component: " << cloud_cylinder->points.size() << " data points." << std::endl;

        pcl::compute3DCentroid(*cloud_cylinder, centroid);
        //std::cerr << "centroid of the cylindrical component: " << centroid[0] << " " << centroid[1] << " " << centroid[2] << " " << centroid[3] << std::endl;

        // Create a point in the "camera_rgb_optical_frame"
        geometry_msgs::PointStamped point_camera;
        geometry_msgs::PointStamped point_map;
        visualization_msgs::Marker marker;
        geometry_msgs::TransformStamped tss;

        point_camera.header.frame_id = "camera_rgb_optical_frame";
        point_camera.header.stamp = ros::Time::now();

        point_map.header.frame_id = "map";
        point_map.header.stamp = ros::Time::now();

        point_camera.point.x = centroid[0];
        point_camera.point.y = centroid[1];
        point_camera.point.z = centroid[2];

        float radius = coefficients_cylinder->values[6];
        std::cerr << "Radius: " << radius << std::endl;

        uint32_t r = 0;
        uint32_t g = 0;
        uint32_t b = 0;
        uint32_t rgb;
        int size = cloud_cylinder->points.size();

        int step = 500;
        int i = 0;
        
        for (; i < size; i += step) {
            rgb = *reinterpret_cast<int *>(&cloud_cylinder->points[i].rgb);

            r += (rgb >> 16) & 0x0000ff;
            g += (rgb >> 8) & 0x0000ff;
            b += (rgb)&0x0000ff;
            
        }

        r = r / (i / step);
        g = g / (i / step);
        b = b / (i / step);

        if (abs(radius - 0.12) > 0.005 || size < 2500 || size > 10000)
            return;

        // RGB to name
        uint32_t minimum = r < g ? (r < b ? r : b) : (g < b ? g : b);
        uint32_t rNormalized = r - minimum;
        uint32_t gNormalized = g - minimum;
        uint32_t bNormalized = b - minimum;
        const char *colour = "";
        uint32_t limit = 20;
        
        if (rNormalized == 0) {
            if (gNormalized > bNormalized) {
                colour = gNormalized - bNormalized > limit ? "green" : "cyan";
            }
            else {
                colour = bNormalized - gNormalized > limit ? "blue" : "cyan";
            }
        }
        else if (gNormalized == 0) {
            if (rNormalized > bNormalized) {
                colour = rNormalized - bNormalized > limit ? "red" : "magenta";
            }
            else {
                colour = bNormalized - rNormalized > limit ? "blue" : "magenta";
            }
        }
        else if (bNormalized == 0) {
            if (gNormalized > rNormalized) {
                colour = gNormalized - rNormalized > limit ? "green" : "yellow";
            }
            else {
                colour = rNormalized - gNormalized > limit ? "red" : "yellow";
            }
        }
        else {
            colour = "siva";
        }
        
        std::cerr << colour << std::endl;

        // std::cerr << "Rdeca Zelena Modra " << r << " " << g << " " << b << std::endl;

        try {
            time_test = ros::Time::now();
            std::cerr << time_rec << std::endl;
            std::cerr << time_test << std::endl;
            tss = tf2_buffer.lookupTransform("map", "camera_rgb_optical_frame", time_rec);
            // tf2_buffer.transform(point_camera, point_map, "map", ros::Duration(2));
        }
        catch (tf2::TransformException &ex) {
            ROS_WARN("Transform warning: %s\n", ex.what());
        }

        // std::cerr << tss ;

        tf2::doTransform(point_camera, point_map, tss);

        //std::cerr << "point_camera: " << point_camera.point.x << " " << point_camera.point.y << " " << point_camera.point.z << std::endl;

        //std::cerr << "point_map: " << point_map.point.x << " " << point_map.point.y << " " << point_map.point.z << std::endl;

        task3::Cylinder msg;
        msg.color = colour;
        msg.position = point_map;
        
        cylinder_publisher.publish(msg);
        /*
        marker.header.frame_id = "map";
        marker.header.stamp = ros::Time::now();

        marker.ns = "cylinder";
        marker.id = 0;

        marker.type = visualization_msgs::Marker::CYLINDER;
        marker.action = visualization_msgs::Marker::ADD;

        marker.pose.position.x = point_map.point.x;
        marker.pose.position.y = point_map.point.y;
        marker.pose.position.z = point_map.point.z;
        marker.pose.orientation.x = 0.0;
        marker.pose.orientation.y = 0.0;
        marker.pose.orientation.z = 0.0;
        marker.pose.orientation.w = 1.0;

        marker.scale.x = 0.1;
        marker.scale.y = 0.1;
        marker.scale.z = 0.1;

        marker.color.r = 0.0f;
        marker.color.g = 1.0f;
        marker.color.b = 0.0f;
        marker.color.a = 1.0f;

        marker.lifetime = ros::Duration();
        
        pubm.publish(marker);
        */    
        //pcl::PCLPointCloud2 outcloud_cylinder;
        //pcl::toPCLPointCloud2(*cloud_cylinder, outcloud_cylinder);
        //puby.publish(outcloud_cylinder);
    }
}

int main(int argc, char **argv) {
    // Initialize ROS
    ros::init(argc, argv, "cylinder_segment");
    ros::NodeHandle nh;

    // For transforming between coordinate frames
    tf2_ros::TransformListener tf2_listener(tf2_buffer);

    // Create a ROS subscriber for the input point cloud
    ros::Subscriber sub = nh.subscribe("/camera/depth/points", 1, cloud_cb);

    // Create a ROS publisher for the output point cloud
    pubx = nh.advertise<pcl::PCLPointCloud2>("planes", 1);
    puby = nh.advertise<pcl::PCLPointCloud2>("cylinder", 1);

    //pubm = nh.advertise<visualization_msgs::Marker>("detected_cylinder", 1);

    cylinder_publisher = nh.advertise<task3::Cylinder>("detected_cylinder_color", 1);

    // Spin
    ros::spin();
}
