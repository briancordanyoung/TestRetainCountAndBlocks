# TestRetainCountAndBlocks

I have ‘come of age’ in the ARC era. Although I have done some manual reference counting and think I understand it, I took a test on my Obj-C skills lately and ran across this puzzle. My answer was the simple, obvious and incorrect choice.

To understand it better I created this test project and picked it apart until I think I understand it now. The TestRetainCountAndBlock class contains 2 class methods, one that is uncommented for you to test yourself, and one with my reasoning on what is the correct answer.

### The Code
    // Test: Once this method is executed, what will be printed to the console?
    NSObject *object = [NSObject new];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      NSLog(@"A %lu", [object retainCount]);
      
      dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"B %lu", [object retainCount]);
      });
      
      NSLog(@"C %lu", [object retainCount]);
    });
    
    NSLog(@"D %lu", [object retainCount]);

### Your choice of answers

	1.	D 2
		A 1
		C 2
		B 1
	
	2.	B 3
		A 2
		C 2
		D 1
		
	3.	B 1
		A 2
		C 2
		D 1
		
	4.	D 2
		A 2
		C 3
		B 2
		