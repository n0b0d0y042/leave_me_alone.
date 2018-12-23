//
//  CSSoundBot.h
//  MyOSXAPP
//
//  Created by Леонид Купченко on 07/03/17.
//  Copyright © 2017 FlatBeat. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, SBRegisterAddress) {
    SBSerialIDnumber = 0,
    SBFirmwareIDVersion = 1,
    SBBridgeFirmwareVersion
    // etc.
};


typedef NS_ENUM(NSInteger, SBSampleID){
    SBSample1 = 0,
    SBSample2
};


@interface CSSoundBot : NSObject

- (bool)isAround;
- (void)establishConnection;


- (void)writeSoundSample:(NSData*) fileData withError:(NSError **)errorPtr;
- (void)readSoundSample: (NSData*)fileData withError:(NSError **)errorPtr;
- (bool)deleteSoundSample:(SBSampleID*) SBSample;


- (void)writeValue:(NSData*) Value ToRegister:(SBRegisterAddress* )RegAddr withError:(NSError **)errorPtr;
- (void)readRegister:(SBRegisterAddress* )RegAddr Value:(NSData*)Value  withError:(NSError **)errorPtr;


- (bool)runEmulation;
- (bool)stopEmulation;


- (bool)writeBridgeFirmware:(NSData*) fileData withError:(NSError **)errorPtr;
- (bool)writeSoundBotFrimware:(NSData*) fileData withError:(NSError **)errorPtr;


- (void)readStatusReg:(NSData*) Value ToRegister:(SBRegisterAddress* )RegAddr withError:(NSError **)errorPtr;
- (bool)isSoundBotAlive;


@end
