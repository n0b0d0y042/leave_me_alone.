//
//  ViewController.h
//  MyFirstOSXAPP
//
//  Created by Леонид Купченко on 02/03/17.
//  Copyright © 2017 FlatBeat. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@import CoreBluetooth;

@interface ViewController : NSViewController

@property (strong) IBOutlet NSTextField *DataLatencyLable;
@property (strong) IBOutlet NSTextField *dataSizeLable;
@property (strong) IBOutlet NSTextField *MatrixByVecLable;
- (IBAction)LatencyChanged:(NSSlider *)sender;
- (IBAction)DataSizeChanged:(NSSlider *)sender;
- (IBAction)MatrixSizeChanged:(NSSlider *)sender;
- (IBAction)ConnectNrf:(NSButtonCell *)sender;
@property (strong) IBOutlet NSButton *ConnectionButton;
@property (strong) IBOutlet NSSlider *LatencySlider;
@property (strong) IBOutlet NSSlider *DataSlider;
@property (strong) IBOutlet NSSlider *MatrixSizeSlider;
- (void)updateValueOf :(CBPeripheral *)peripheral forCharacteristic: (CBCharacteristic *)characteristic;


@end

