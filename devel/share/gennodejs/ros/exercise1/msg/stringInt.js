// Auto-generated. Do not edit!

// (in-package exercise1.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class stringInt {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.content = null;
      this.sequenceID = null;
    }
    else {
      if (initObj.hasOwnProperty('content')) {
        this.content = initObj.content
      }
      else {
        this.content = '';
      }
      if (initObj.hasOwnProperty('sequenceID')) {
        this.sequenceID = initObj.sequenceID
      }
      else {
        this.sequenceID = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type stringInt
    // Serialize message field [content]
    bufferOffset = _serializer.string(obj.content, buffer, bufferOffset);
    // Serialize message field [sequenceID]
    bufferOffset = _serializer.int8(obj.sequenceID, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type stringInt
    let len;
    let data = new stringInt(null);
    // Deserialize message field [content]
    data.content = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [sequenceID]
    data.sequenceID = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.content);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'exercise1/stringInt';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0ea9fbf91a022147e4b89365a664c9cb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string content
    int8 sequenceID
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new stringInt(null);
    if (msg.content !== undefined) {
      resolved.content = msg.content;
    }
    else {
      resolved.content = ''
    }

    if (msg.sequenceID !== undefined) {
      resolved.sequenceID = msg.sequenceID;
    }
    else {
      resolved.sequenceID = 0
    }

    return resolved;
    }
};

module.exports = stringInt;
