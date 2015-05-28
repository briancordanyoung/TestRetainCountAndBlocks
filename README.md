# TestRetainCountAndBlocks

I have 'come of age' in the ARC era.  Although I have done some manual reference counting and think I understand it, I took a test on my Obj-C skills lately and ran across this puzzle.  My answer was the simple, obvious and incorrect choice.

To undertand it better I created this test project and picked it apart until I think I understand it now.  The TestRetainCountAndBlock class contains 2 class methods, one that is uncommented for you to test yourself, and one with my resoning on what is the correct answer.

### The Code
    NSObject *object = [NSObject new];

    dispatch_async(dispatch_get_main_queue(), ^{
      NSLog(@"A %lu", (unsigned long)[object retainCount]);
      
      dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"B %lu", (unsigned long)[object retainCount]);
      });

      NSLog(@"C %lu", (unsigned long)[object retainCount]);
    });

    NSLog(@"D %lu", (unsigned long)[object retainCount]);

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
		