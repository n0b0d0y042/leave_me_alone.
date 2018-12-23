//
//  PowerTester.h
//  MyFirstOSXAPP
//
//  Created by Леонид Купченко on 19/12/2018.
//  Copyright © 2018 FlatBeat. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreBluetooth;

@interface PowerTester : NSObject

@property (nonatomic) int latencyMs;
@property (nonatomic) int dataSize;
@property (nonatomic) int matrixSize;
@property (nonatomic) bool comptEnable;

- (void)updateValueOf :(CBPeripheral *)peripheral forCharacteristic: (CBCharacteristic *)characteristic;
- (void ) debugFuch;
@end
