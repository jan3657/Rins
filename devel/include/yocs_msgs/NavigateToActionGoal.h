// Generated by gencpp from file yocs_msgs/NavigateToActionGoal.msg
// DO NOT EDIT!


#ifndef YOCS_MSGS_MESSAGE_NAVIGATETOACTIONGOAL_H
#define YOCS_MSGS_MESSAGE_NAVIGATETOACTIONGOAL_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>
#include <actionlib_msgs/GoalID.h>
#include <yocs_msgs/NavigateToGoal.h>

namespace yocs_msgs
{
template <class ContainerAllocator>
struct NavigateToActionGoal_
{
  typedef NavigateToActionGoal_<ContainerAllocator> Type;

  NavigateToActionGoal_()
    : header()
    , goal_id()
    , goal()  {
    }
  NavigateToActionGoal_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , goal_id(_alloc)
    , goal(_alloc)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef  ::actionlib_msgs::GoalID_<ContainerAllocator>  _goal_id_type;
  _goal_id_type goal_id;

   typedef  ::yocs_msgs::NavigateToGoal_<ContainerAllocator>  _goal_type;
  _goal_type goal;





  typedef boost::shared_ptr< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> const> ConstPtr;

}; // struct NavigateToActionGoal_

typedef ::yocs_msgs::NavigateToActionGoal_<std::allocator<void> > NavigateToActionGoal;

typedef boost::shared_ptr< ::yocs_msgs::NavigateToActionGoal > NavigateToActionGoalPtr;
typedef boost::shared_ptr< ::yocs_msgs::NavigateToActionGoal const> NavigateToActionGoalConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator1> & lhs, const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator2> & rhs)
{
  return lhs.header == rhs.header &&
    lhs.goal_id == rhs.goal_id &&
    lhs.goal == rhs.goal;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator1> & lhs, const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace yocs_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ffa50cda52f07e2549da7c2006eeb671";
  }

  static const char* value(const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xffa50cda52f07e25ULL;
  static const uint64_t static_value2 = 0x49da7c2006eeb671ULL;
};

template<class ContainerAllocator>
struct DataType< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "yocs_msgs/NavigateToActionGoal";
  }

  static const char* value(const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n"
"\n"
"Header header\n"
"actionlib_msgs/GoalID goal_id\n"
"NavigateToGoal goal\n"
"\n"
"================================================================================\n"
"MSG: std_msgs/Header\n"
"# Standard metadata for higher-level stamped data types.\n"
"# This is generally used to communicate timestamped data \n"
"# in a particular coordinate frame.\n"
"# \n"
"# sequence ID: consecutively increasing ID \n"
"uint32 seq\n"
"#Two-integer timestamp that is expressed as:\n"
"# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n"
"# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n"
"# time-handling sugar is provided by the client library\n"
"time stamp\n"
"#Frame this data is associated with\n"
"string frame_id\n"
"\n"
"================================================================================\n"
"MSG: actionlib_msgs/GoalID\n"
"# The stamp should store the time at which this goal was requested.\n"
"# It is used by an action server when it tries to preempt all\n"
"# goals that were requested before a certain time\n"
"time stamp\n"
"\n"
"# The id provides a way to associate feedback and\n"
"# result message with specific goal requests. The id\n"
"# specified must be unique.\n"
"string id\n"
"\n"
"\n"
"================================================================================\n"
"MSG: yocs_msgs/NavigateToGoal\n"
"# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n"
"# Goal\n"
"string location\n"
"int8   approach_type\n"
"int8   num_retry\n"
"float32 timeout\n"
"\n"
"# This variable used when approach near is requested\n"
"float32 distance\n"
"\n"
"int8 APPROACH_NEAR = 11\n"
"int8 APPROACH_ON   = 12\n"
;
  }

  static const char* value(const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.goal_id);
      stream.next(m.goal);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct NavigateToActionGoal_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::yocs_msgs::NavigateToActionGoal_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "goal_id: ";
    s << std::endl;
    Printer< ::actionlib_msgs::GoalID_<ContainerAllocator> >::stream(s, indent + "  ", v.goal_id);
    s << indent << "goal: ";
    s << std::endl;
    Printer< ::yocs_msgs::NavigateToGoal_<ContainerAllocator> >::stream(s, indent + "  ", v.goal);
  }
};

} // namespace message_operations
} // namespace ros

#endif // YOCS_MSGS_MESSAGE_NAVIGATETOACTIONGOAL_H
