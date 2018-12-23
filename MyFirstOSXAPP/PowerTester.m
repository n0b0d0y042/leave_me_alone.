//
//  PowerTester.m
//  MyFirstOSXAPP
//
//  Created by Леонид Купченко on 19/12/2018.
//  Copyright © 2018 FlatBeat. All rights reserved.
//

#import "PowerTester.h"

@implementation PowerTester


- (void)updateValueOf :(CBPeripheral *)peripheral forCharacteristic: (CBCharacteristic *)characteristic{
    
    NSLog(@"Update value for cahr");
    
    if ([peripheral isEqual: nil]) return;
    
    
    NSData *bytes = [@"0xDE" dataUsingEncoding:NSUTF8StringEncoding];
    
    [peripheral writeValue:bytes
         forCharacteristic:characteristic
                      type:CBCharacteristicWriteWithResponse];
    
    
}
- (void ) debugFuch{
    NSLog(@"WTF???");
}
@end
