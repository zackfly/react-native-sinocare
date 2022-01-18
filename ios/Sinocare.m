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
                  (int) snDeviceType
                  address:(nonnull NSString*)address
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    SDDeviceModel *scannedDevice = [[SDDeviceModel alloc]init];
    [scannedDevice setUuid:address];
    if(snDeviceType == 7){
     [scannedDevice setName:@"安诺心"];
    [scannedDevice setType:SDCDeviceTypeSinoHeart];
    }
    [scannedDevice setBluetoothType: SDDMBluetoothTypeBLE];
    [scannedDevice setBluetoothName:@"低功耗蓝牙"];
  [[SDDeviceManager sharedDeviceManager] addBoundDevice:scannedDevice];
  [[SDBluetoothManager sharedBluetoothManager] connectDevices];;
    __weak typeof(self) weakSelf = self;
    [SDBluetoothManager sharedBluetoothManager].didReceiveData = ^(SDDetectionDataModel * _Nullable data, SDBussinessStateModel * _Nullable state, SDDeviceModel * _Nonnull boundDevice) {
        __weak typeof(self) strongSelf = weakSelf;
        if(state.state==SDBSMBussinessStateDidReceiveMeasurementResult){
            NSMutableDictionary *dict = [NSMutableDictionary new];
            SDSinoHeartDataModel *heartData =data.data;
            dict[@"bloodMeasureHigh"] =[NSString stringWithFormat:@"%ld", heartData.sbpValue];
            dict[@"bloodMeasureLow"] =  [NSString stringWithFormat:@"%ld", heartData.dbpValue];
            dict[@"checkHeartRate"] = [NSString stringWithFormat:@"%ld", heartData.heartRateValue];
            resolve(dict);
        }
    };

}

@end
