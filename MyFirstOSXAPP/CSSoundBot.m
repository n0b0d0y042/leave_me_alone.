//
//  CSSoundBot.m
//  MyFirstOSXAPP
//
//  Created by Леонид Купченко on 07/03/17.
//  Copyright © 2017 FlatBeat. All rights reserved.
//

#import "CSSoundBot.h"

@implementation CSSoundBot


- (bool)isAround{
    return true;
}
- (void)establishConnection{

}


- (void)writeSoundSample:(NSData*) fileData withError:(NSError **)errorPtr{

}
- (void)readSoundSample: (NSData*)fileData withError:(NSError **)errorPtr{

}
- (bool)deleteSoundSample:(SBSampleID*) SBSample{
    
    return true;
}


- (void)writeValue:(NSData*) Value ToRegister:(SBRegisterAddress* )RegAddr withError:(NSError **)errorPtr{

}
- (void)readRegister:(SBRegisterAddress* )RegAddr Value:(NSData*)Value  withError:(NSError **)errorPtr{

}


- (bool)runEmulation{
    
    return true;
}
- (bool)stopEmulation{
    
    return true;
}


- (bool)writeBridgeFirmware:(NSData*) fileData withError:(NSError **)errorPtr{
    return true;
}
- (bool)writeSoundBotFrimware:(NSData*) fileData withError:(NSError **)errorPtr{
    return true;
}


- (void)readStatusReg:(NSData*) Value ToRegister:(SBRegisterAddress* )RegAddr withError:(NSError **)errorPtr{
    
}
- (bool)isSoundBotAlive{
    return true;
}




@end
