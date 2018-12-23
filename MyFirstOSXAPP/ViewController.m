//
//  ViewController.m
//  MyFirstOSXAPP
//
//  Created by Леонид Купченко on 02/03/17.
//  Copyright © 2017 FlatBeat. All rights reserved.
//

#import "ViewController.h"
#import "PowerTester.h"

@implementation ViewController
CBCentralManager* BluetoothCM;
PowerTester* powerTester;
CBPeripheral* nordicUsartPeripheral;
CBCharacteristic *writeChar;

NSString * nordicName = @"Nordic_UART";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"veiwDidLoad");
    
    powerTester = [[PowerTester alloc] init];
    
    [powerTester setMatrixSize: [self.MatrixSizeSlider intValue]];
    [powerTester setDataSize: [self.DataSlider intValue]];
    [powerTester setLatencyMs:[self.LatencySlider intValue]];

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)LatencyChanged:(NSSlider *)sender {
    
     NSString *newStr =  [NSString stringWithFormat: @"Sending data once in %d ms", [sender intValue]];
    
    [powerTester setLatencyMs: [sender intValue]];
    
    [_DataLatencyLable setStringValue:newStr];
    
    [self updateValueOf:nordicUsartPeripheral forCharacteristic:writeChar];

}
- (IBAction)DataSizeChanged:(NSSlider *)sender {
    NSString *newStr =  [NSString stringWithFormat: @"Sending %d float value", [sender intValue]];
    
    [powerTester setDataSize: [sender intValue]];
    
    [_dataSizeLable setStringValue:newStr];
    
    [self updateValueOf:nordicUsartPeripheral forCharacteristic:writeChar];
    
}

- (IBAction)MatrixSizeChanged:(NSSlider *)sender {
    NSString *newStr =  [NSString stringWithFormat: @"Matrix size is %dx%d", [sender intValue],[sender intValue]];
    
    [powerTester setMatrixSize: [sender intValue]];
    
    [_MatrixByVecLable setStringValue:newStr];
    [self updateValueOf:nordicUsartPeripheral forCharacteristic:writeChar];
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    
    NSLog(@"Connection with Nordic UART lost");
    [self.ConnectionButton setTitle: @"Connect"];
    nordicUsartPeripheral = nil; 
    
}
- (IBAction)ConnectNrf:(NSButtonCell *)sender {
    
    if([sender.title isEqualToString:@"Connect"]){
    
    BluetoothCM = [ [CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
      
        [sender setTitle:@"Connecting"];
        
    }
    
    if([sender.title isEqualToString:@"Disconnect"]){
        
        [BluetoothCM cancelPeripheralConnection:nordicUsartPeripheral ];
        [self.ConnectionButton setTitle:@"Disconnecting"];
        NSLog(@"Trying to disconnect");
    }
    
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSLog(@"Did Update State");
    switch( [central state]) {
        case CBCentralManagerStateUnknown:
            NSLog(@"Bluetooth state is unknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"Bluetooth is Resetting");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"Bluetooth is Ready to Go");
            // Start Scaning for peripherals Dev
            [central scanForPeripheralsWithServices:nil options:nil];
            
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"Bluetoth accesse denied");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"Bluetoth is off");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"Bleutooth is Unsupported");
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI{
    
    
    if ([peripheral.name isEqualToString: nordicName]){
        
        NSLog(@"Nordic found");
        [BluetoothCM stopScan];
        nordicUsartPeripheral = peripheral;
        [BluetoothCM connectPeripheral: nordicUsartPeripheral options:nil];
    }
    
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    
    [self.ConnectionButton setTitle:@"Disconnect"];
    [peripheral setDelegate: self];
    [peripheral discoverServices:nil];
    NSLog(@"Peripheral connected");
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    
    
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service: %@", service.UUID);
        
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"Did Discover Characters");
    for (CBCharacteristic *aChar in service.characteristics)
    {

        NSLog(@"Char is %@", aChar);
        if (aChar.properties & CBCharacteristicPropertyNotify){
            
            [peripheral setNotifyValue:TRUE forCharacteristic:aChar];
            NSLog(@"Enable notification");
            
        }
        if (aChar.properties & CBCharacteristicPropertyWrite){
            
            writeChar = aChar;
            [self updateValueOf:nordicUsartPeripheral forCharacteristic:writeChar];
            
        }
    }
    
}


- (void)updateValueOf :(CBPeripheral *)peripheral forCharacteristic: (CBCharacteristic *)characteristic{
    
    if ([peripheral isEqual: nil]) return;
    
    NSLog(@"Update value for char");
    
    const unsigned char bytes[] = {0x05,0x07,0x10, 0x0A};
    int dataArray[] = {[ powerTester latencyMs], [ powerTester dataSize], [ powerTester matrixSize]};
    NSData *data = [NSData dataWithBytes:(const unsigned char *)dataArray length:sizeof(dataArray)];;
    
    NSLog(@"The data value is %@", data);
    
    [peripheral writeValue: data
         forCharacteristic: characteristic
                      type: CBCharacteristicWriteWithResponse];
    
    
    
}



@end
