package com.reactnativesinocare;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.sinocare.multicriteriasdk.MulticriteriaSDKManager;
import com.sinocare.multicriteriasdk.SnCallBack;
import com.sinocare.multicriteriasdk.bean.DeviceDetectionData;
import com.sinocare.multicriteriasdk.entity.BoothDeviceConnectState;
import com.sinocare.multicriteriasdk.entity.DeviceDetectionState;
import com.sinocare.multicriteriasdk.entity.SNDevice;
import com.sinocare.multicriteriasdk.utils.AuthStatus;

import java.util.ArrayList;
import java.util.List;

@ReactModule(name = SinocareModule.NAME)
public class SinocareModule extends ReactContextBaseJavaModule {
    public static final String NAME = "Sinocare";

    public SinocareModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    // Example method
    // See https://reactnative.dev/docs/native-modules-android
  @ReactMethod
    public void initAndAuthentication(Promise promise) {
    MulticriteriaSDKManager.initAndAuthentication(getCurrentActivity().getApplication(), new AuthStatusListener() {

      public void onAuthStatus(AuthStatus authStatus) {
        promise.resolve(authStatus);
      }
    });
  }
  @ReactMethod
  public void startConnect(Integer snDeviceType,String address, Promise promise) {
    SNDevice snDevice = new SNDevice(snDeviceType, address);
    List<SNDevice> snDevices = new ArrayList<>();
    snDevices.add(snDevice);
    MulticriteriaSDKManager.startConnect(snDevices, new SnCallBack() {
      public void onDataComing(SNDevice device, DeviceDetectionData data) {
        promise.resolve(data);
      }
      @Override
      public void onDeviceStateChange(SNDevice snDevice, BoothDeviceConnectState boothDeviceConnectState) {

      }

      @Override
      public void onDetectionStateChange(SNDevice snDevice, DeviceDetectionState deviceDetectionState) {

      }
    });
    MulticriteriaSDKManager.onResume();
  }
  @ReactMethod
  public void multiply(int a, int b, Promise promise) {
      promise.resolve(a * b);
  }
  public static native int nativeStartConnect(Integer snDeviceType,String address);
  public static native int nativeMultiply(int a, int b);
}
