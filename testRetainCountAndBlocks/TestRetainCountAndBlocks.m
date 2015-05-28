//
//  testRetainCountAndBlocks.m
//  testRetainCountAndBlocks
//
//  Created by Brian Cordan Young on 5/28/15.
//  Copyright (c) 2015 Brian Young. All rights reserved.
//

#import "testRetainCountAndBlocks.h"

@implementation TestRetainCountAndBlocks


+ (void)test {
  // Test: Once this method is executed, what will be printed to the console?
  NSObject *object = [NSObject new];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"A %u", [object retainCount]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
      NSLog(@"B %u", [object retainCount]);
    });
    
    NSLog(@"C %u", [object retainCount]);
  });
  
  NSLog(@"D %u", [object retainCount]);
}























+ (void)testCommented {
  // Test: Once this method is executed, what will be printed to the console?
  // Both the printing/execution order and retain count are important

  NSObject *object = [NSObject new];  // Retain Count: 1
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    // Captured inside a block, increacing retain count to 2
    NSLog(@"A %u", [object retainCount]); // 2
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      // Captured inside another block, increasing retain count to 3?
      // but, NO! It is only 2 still
      // Is this because the blocks are async?
      // The first block has already completed by the time this
      // block executes on the next loop?
      //
      // The answer is that the enclosing block executes,
      // the current block captures 'object' (retain count now 3)
      // places this block on the queue, then completes, popping off the stack &
      // decrementing the retain count back to 2.
      NSLog(@"B %u", [object retainCount]); // 2
      
    });
    
    // The 2nd block have been dispatched, but not yet executed
    // initial-retain-count + block-capture + block-capture = 3
    NSLog(@"C %u", [object retainCount]); // 3
    
  });
  
  // The 1st block has captured 'object', increasing retain count
  // The 2nd block has not yet captured 'object' because the 1st block has not
  // executed yet.
  // initial-retain-count + block-capture = 2
  NSLog(@"D %u", [object retainCount]); // 2
}


@end
