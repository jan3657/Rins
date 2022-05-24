// Auto-generated. Do not edit!

// (in-package task3.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class Cylinder {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.color = null;
      this.position = null;
    }
    else {
      if (initObj.hasOwnProperty('color')) {
        this.color = initObj.color
      }
      else {
        this.color = '';
      }
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new geometry_msgs.msg.PointStamped();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Cylinder
    // Serialize message field [color]
    bufferOffset = _serializer.string(obj.color, buffer, bufferOffset);
    // Serialize message field [position]
    bufferOffset = geometry_msgs.msg.PointStamped.serialize(obj.position, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Cylinder
    let len;
    let data = new Cylinder(null);
    // Deserialize message field [color]
    data.color = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [position]
    data.position = geometry_msgs.msg.PointStamped.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.color);
    length += geometry_msgs.msg.PointStamped.getMessageSize(object.position);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'task3/Cylinder';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '79e9171f8aab1d9f862baaaf0114ad4a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string color
    geometry_msgs/PointStamped position
    
    ================================================================================
    MSG: geometry_msgs/PointStamped
    # This represents a Point with reference coordinate frame and timestamp
    Header header
    Point point
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Cylinder(null);
    if (msg.color !== undefined) {
      resolved.color = msg.color;
    }
    else {
      resolved.color = ''
    }

    if (msg.position !== undefined) {
      resolved.position = geometry_msgs.msg.PointStamped.Resolve(msg.position)
    }
    else {
      resolved.position = new geometry_msgs.msg.PointStamped()
    }

    return resolved;
    }
};

module.exports = Cylinder;
