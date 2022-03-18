// Auto-generated. Do not edit!

// (in-package exercise2.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class MovementTypeRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.shape = null;
      this.duration = null;
    }
    else {
      if (initObj.hasOwnProperty('shape')) {
        this.shape = initObj.shape
      }
      else {
        this.shape = '';
      }
      if (initObj.hasOwnProperty('duration')) {
        this.duration = initObj.duration
      }
      else {
        this.duration = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MovementTypeRequest
    // Serialize message field [shape]
    bufferOffset = _serializer.string(obj.shape, buffer, bufferOffset);
    // Serialize message field [duration]
    bufferOffset = _serializer.int32(obj.duration, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MovementTypeRequest
    let len;
    let data = new MovementTypeRequest(null);
    // Deserialize message field [shape]
    data.shape = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [duration]
    data.duration = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.shape);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'exercise2/MovementTypeRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f6931f5ad45d359f8a33a0c8c7b70720';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string shape
    int32 duration
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MovementTypeRequest(null);
    if (msg.shape !== undefined) {
      resolved.shape = msg.shape;
    }
    else {
      resolved.shape = ''
    }

    if (msg.duration !== undefined) {
      resolved.duration = msg.duration;
    }
    else {
      resolved.duration = 0
    }

    return resolved;
    }
};

class MovementTypeResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lastDrawnShape = null;
    }
    else {
      if (initObj.hasOwnProperty('lastDrawnShape')) {
        this.lastDrawnShape = initObj.lastDrawnShape
      }
      else {
        this.lastDrawnShape = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MovementTypeResponse
    // Serialize message field [lastDrawnShape]
    bufferOffset = _serializer.string(obj.lastDrawnShape, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MovementTypeResponse
    let len;
    let data = new MovementTypeResponse(null);
    // Deserialize message field [lastDrawnShape]
    data.lastDrawnShape = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.lastDrawnShape);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'exercise2/MovementTypeResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '481ecc921d6d791c3739bcd08045190b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string lastDrawnShape
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MovementTypeResponse(null);
    if (msg.lastDrawnShape !== undefined) {
      resolved.lastDrawnShape = msg.lastDrawnShape;
    }
    else {
      resolved.lastDrawnShape = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: MovementTypeRequest,
  Response: MovementTypeResponse,
  md5sum() { return 'f747a6d49b629ea3b92ea322ab71d841'; },
  datatype() { return 'exercise2/MovementType'; }
};
