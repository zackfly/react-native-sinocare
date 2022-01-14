#import "Sinocare.h"

@implementation Sinocare

RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(nonnull NSNumber*)a withB:(nonnull NSNumber*)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *result = @([a floatValue] * [b floatValue]);

  resolve(result);
}
// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(initAndAuthentication,
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  [[SDAuthManager sharedAuthManager] authWithAppKey:SDAppKey];
  resolve();
}
RCT_REMAP_METHOD(startConnect,
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    SDDeviceModel *scannedDevice = [[SDDeviceModel alloc]init];
    [scannedDevice setUuid:@"Test"];
    [scannedDevice setName:<#(NSString * _Nonnull)#>:@"安诺心"];
    [scannedDevice setBluetoothType:<#(SDDMBluetoothType)#>:<#(NSString * _Nonnull)#>:SDDMBluetoothTypeBLE];
    [scannedDevice setBluetoothName:<#(NSString * _Nonnull)#>:<#(NSString * _Nonnull)#>:@"低功耗蓝牙"];
  [[SDDeviceManager sharedDeviceManager] addBoundDevice:scannedDevice];
  [[SDBluetoothManager sharedBluetoothManager] connectDevices];;
    __weak typeof(self) weakSelf = self;
    [SDBluetoothManager sharedBluetoothManager].didReceiveData = ^(SDDetectionDataModel * _Nullable data, SDBussinessStateModel * _Nullable state, SDDeviceModel * _Nonnull boundDevice) {
        __weak typeof(self) strongSelf = weakSelf;
        NSString *time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        if (state) {
            NSMutableDictionary *dict = [NSMutableDictionary new];
            dict[kTCState] = state;
            dict[kTCBoundDevice] = boundDevice;
            dict[kTCTime] = time;
            [strongSelf.states insertObject:[dict copy] atIndex:0];
            [strongSelf.stateView reloadData];
        }
        if (data) {
            NSMutableDictionary *dict = [NSMutableDictionary new];
            dict[kTCData] = data;
            dict[kTCBoundDevice] = boundDevice;
            dict[kTCTime] = time;
            [strongSelf.datas insertObject:dict atIndex:0];
            [strongSelf.dataView reloadData];
        }
    };

}

@end
