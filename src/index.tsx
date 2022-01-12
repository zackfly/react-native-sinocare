import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-sinocare' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const Sinocare = NativeModules.Sinocare
  ? NativeModules.Sinocare
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function multiply(a: number, b: number): Promise<number> {
  return Sinocare.multiply(a, b);
}
export function startConnect(snDeviceType:number, address:string): Promise<number> {
  return Sinocare.startConnect(snDeviceType, address);
}
export function initAndAuthentication(): Promise<number> {
  return Sinocare.multiinitAndAuthenticationply()
}
