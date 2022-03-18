
"use strict";

let WheelDropEvent = require('./WheelDropEvent.js');
let VersionInfo = require('./VersionInfo.js');
let MotorPower = require('./MotorPower.js');
let ExternalPower = require('./ExternalPower.js');
let Led = require('./Led.js');
let ScanAngle = require('./ScanAngle.js');
let DigitalInputEvent = require('./DigitalInputEvent.js');
let ControllerInfo = require('./ControllerInfo.js');
let DockInfraRed = require('./DockInfraRed.js');
let DigitalOutput = require('./DigitalOutput.js');
let Sound = require('./Sound.js');
let KeyboardInput = require('./KeyboardInput.js');
let CliffEvent = require('./CliffEvent.js');
let RobotStateEvent = require('./RobotStateEvent.js');
let SensorState = require('./SensorState.js');
let BumperEvent = require('./BumperEvent.js');
let ButtonEvent = require('./ButtonEvent.js');
let PowerSystemEvent = require('./PowerSystemEvent.js');
let AutoDockingActionResult = require('./AutoDockingActionResult.js');
let AutoDockingFeedback = require('./AutoDockingFeedback.js');
let AutoDockingActionGoal = require('./AutoDockingActionGoal.js');
let AutoDockingGoal = require('./AutoDockingGoal.js');
let AutoDockingResult = require('./AutoDockingResult.js');
let AutoDockingAction = require('./AutoDockingAction.js');
let AutoDockingActionFeedback = require('./AutoDockingActionFeedback.js');

module.exports = {
  WheelDropEvent: WheelDropEvent,
  VersionInfo: VersionInfo,
  MotorPower: MotorPower,
  ExternalPower: ExternalPower,
  Led: Led,
  ScanAngle: ScanAngle,
  DigitalInputEvent: DigitalInputEvent,
  ControllerInfo: ControllerInfo,
  DockInfraRed: DockInfraRed,
  DigitalOutput: DigitalOutput,
  Sound: Sound,
  KeyboardInput: KeyboardInput,
  CliffEvent: CliffEvent,
  RobotStateEvent: RobotStateEvent,
  SensorState: SensorState,
  BumperEvent: BumperEvent,
  ButtonEvent: ButtonEvent,
  PowerSystemEvent: PowerSystemEvent,
  AutoDockingActionResult: AutoDockingActionResult,
  AutoDockingFeedback: AutoDockingFeedback,
  AutoDockingActionGoal: AutoDockingActionGoal,
  AutoDockingGoal: AutoDockingGoal,
  AutoDockingResult: AutoDockingResult,
  AutoDockingAction: AutoDockingAction,
  AutoDockingActionFeedback: AutoDockingActionFeedback,
};
