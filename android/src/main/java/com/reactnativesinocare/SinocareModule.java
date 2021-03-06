package com.reactnativesinocare;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.module.annotations.ReactModule;
import com.sinocare.multicriteriasdk.MulticriteriaSDKManager;
import com.sinocare.multicriteriasdk.SnCallBack;
import com.sinocare.multicriteriasdk.auth.AuthStatusListener;
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
        if(authStatus.getCode()==10000){
          promise.resolve(String.valueOf(authStatus.getCode()));
        }else{
          promise.reject(String.valueOf(authStatus.getCode()),authStatus.getMsg());
        }
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
        WritableMap map = Arguments.createMap();
        map.putInt("bloodMeasureHigh",data.getSnDataBp().getBloodMeasureHigh());
        map.putInt("bloodMeasureLow",data.getSnDataBp().getBloodMeasureLow());
        map.putInt("checkHeartRate",data.getSnDataBp().getCheckHeartRate());
        promise.resolve(map);
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
  @ReactMethod
  public void disconnect(Integer snDeviceType,String address, Promise promise) {
    SNDevice snDevice = new SNDevice(snDeviceType, address);
    List<SNDevice> snDevices = new ArrayList<>();
    snDevices.add(snDevice);
    MulticriteriaSDKManager.disConectDevice(snDevices);
  }
  public static native int nativeStartConnect(Integer snDeviceType,String address);
  public static native int nativeMultiply(int a, int b);
}
