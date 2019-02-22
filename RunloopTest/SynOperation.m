//
//  SynOperation.m
//  RunloopTest
//
//  Created by Robin on 2019/2/22.
//  Copyright © 2019 Robin. All rights reserved.
//

#import "SynOperation.h"

@implementation SynOperation

- (void)main {
    NSLog(@"%s,%@",__PRETTY_FUNCTION__,[NSThread currentThread]);
    sleep(4);
}

@end
