#import "Sinocare.h"
#import <SinoDetection/SDBluetoothManager.h>
#import <SinoDetection/SDDeviceManager.h>
#import <SinoDetection/NSDate+SDAddition.h>
#import <SinoDetection/SDDetectionDataModel.h>
#import <SinoDetection/SDAuthManager.h>

#define SDAppKey @"9d299af53a42df7040b6a54cd1153f04"

@implementation Sinocare

RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_EXPORT_METHOD(multiply:(nonnull NSNumber*)b a:(nonnull NSNumber*)a
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *result = @([a floatValue] * [b floatValue]);

  resolve(result);
}
// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_EXPORT_METHOD(initAndAuthentication:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  [[SDAuthManager sharedAuthManager] authWithAppKey:SDAppKey];
  resolve(NULL);
}
RCT_EXPORT_METHOD(startConnect:
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    SDDeviceModel *scannedDevice = [[SDDeviceModel alloc]init];
    [scannedDevice setUuid:@"Test"];
    [scannedDevice setName:@"安诺心"];
    [scannedDevice setBluetoothType: SDDMBluetoothTypeBLE];
    [scannedDevice setBluetoothName:@"低功耗蓝牙"];
  [[SDDeviceManager sharedDeviceManager] addBoundDevice:scannedDevice];
  [[SDBluetoothManager sharedBluetoothManager] connectDevices];;
    __weak typeof(self) weakSelf = self;
    [SDBluetoothManager sharedBluetoothManager].didReceiveData = ^(SDDetectionDataModel * _Nullable data, SDBussinessStateModel * _Nullable state, SDDeviceModel * _Nonnull boundDevice) {
        __weak typeof(self) strongSelf = weakSelf;
        NSString *time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    };

}

@end
