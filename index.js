"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.multiply = multiply;
exports.startConnect = startConnect;

var _reactNative = require("react-native");

const LINKING_ERROR = `The package 'react-native-sinocare' doesn't seem to be linked. Make sure: \n\n` + _reactNative.Platform.select({
  ios: "- You have run 'pod install'\n",
  default: ''
}) + '- You rebuilt the app after installing the package\n' + '- You are not using Expo managed workflow\n';
const Sinocare = _reactNative.NativeModules.Sinocare ? _reactNative.NativeModules.Sinocare : new Proxy({}, {
  get() {
    throw new Error(LINKING_ERROR);
  }

});

function multiply(a, b) {
  return Sinocare.multiply(a, b);
}

function startConnect(snDeviceType, address) {
  debugger;
  return Sinocare.startConnect(snDeviceType, address);
}
//# sourceMappingURL=index.js.map