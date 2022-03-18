// Auto-generated. Do not edit!

// (in-package exercise1.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class sum_of_arrayRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.array = null;
    }
    else {
      if (initObj.hasOwnProperty('array')) {
        this.array = initObj.array
      }
      else {
        this.array = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type sum_of_arrayRequest
    // Serialize message field [array]
    bufferOffset = _arraySerializer.int8(obj.array, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type sum_of_arrayRequest
    let len;
    let data = new sum_of_arrayRequest(null);
    // Deserialize message field [array]
    data.array = _arrayDeserializer.int8(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.array.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'exercise1/sum_of_arrayRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e243aba2efc0cc55e002c10fece0b044';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int8[] array
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new sum_of_arrayRequest(null);
    if (msg.array !== undefined) {
      resolved.array = msg.array;
    }
    else {
      resolved.array = []
    }

    return resolved;
    }
};

class sum_of_arrayResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.result = null;
    }
    else {
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type sum_of_arrayResponse
    // Serialize message field [result]
    bufferOffset = _serializer.int32(obj.result, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type sum_of_arrayResponse
    let len;
    let data = new sum_of_arrayResponse(null);
    // Deserialize message field [result]
    data.result = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'exercise1/sum_of_arrayResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '034a8e20d6a306665e3a5b340fab3f09';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 result
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new sum_of_arrayResponse(null);
    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: sum_of_arrayRequest,
  Response: sum_of_arrayResponse,
  md5sum() { return '65f9c89928d29d739491ad72c448ad4f'; },
  datatype() { return 'exercise1/sum_of_array'; }
};
