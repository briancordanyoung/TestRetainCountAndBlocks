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
    NSLog(@"A %lu", (unsigned long)[object retainCount]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
      NSLog(@"B %lu", (unsigned long)[object retainCount]);
    
    });

    NSLog(@"C %lu", (unsigned long)[object retainCount]);
    
  });

  NSLog(@"D %lu", (unsigned long)[object retainCount]);
}























+ (void)testCommented {
  // Test: Once this method is executed, what will be printed to the console?
  // Both the printing/execution order and retain count are important

  NSObject *object = [NSObject new];  // Retain Count: 1
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    // Captured inside a block, increacing retain count to 2
    NSLog(@"A %lu", (unsigned long)[object retainCount]); // 2
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      // Captured inside another block, increacing retain count to 3?
      // but, NO. It is only 2 still
      // Is this because the blocks are async?
      // The first block has already completed by the time this
      // block executes on the next loop?
      NSLog(@"B %lu", (unsigned long)[object retainCount]); // 2
      
    });
    
    // The 2nd block have been dispatched, but not yet executed
    // original-retain-count + block-capture + block-capture = 3
    NSLog(@"C %lu", (unsigned long)[object retainCount]); // 3
    
  });
  
  // The 1st block has captured 'object', increasing retain count
  // The 2nd block has not yet captured 'object' because the 1st block has not
  // executed yet.
  // original-retain-count + block-capture = 2
  NSLog(@"D %lu", (unsigned long)[object retainCount]); // 2
}


@end
