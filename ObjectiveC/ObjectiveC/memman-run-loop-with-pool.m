//gcc -fconstant-string-class=NSConstantString -c memman-run-loop-with-pool.m -I /GNUstep/System/Library/Headers
//gcc -o memman-run-loop-with-pool memman-run-loop-with-pool.o -L /GNUstep/System/Library/Libraries/ -lobjc -lgnustep-base
//./memman-run-loop-with-pool

#import <Foundation/Foundation.h>  
 
//-----------------------------------------------
// Class B
@interface ClassB : NSObject
{
}
@end
 
@implementation ClassB
-(void) dealloc
{
	[super dealloc];
	NSLog(@"ClassB destroyed\n");
}
@end

//-----------------------------------------------
// Class A
@interface ClassA : NSObject
{
}
-(ClassB*) createClassB;
@end
 
@implementation ClassA
-(ClassB*) createClassB
{
	NSLog(@"create an instance of ClassB and autorelease\n");
	return [[[ClassB alloc] init] autorelease];
}

-(void) dealloc
{
	[super dealloc];
	NSLog(@"ClassA destroyed\n");
}
@end

void func()
{
	NSLog(@"{ begin\n");
	
	NSLog(@"create an instance of ClassA and autorelease\n");
	ClassA *obj1 = [[[ClassA alloc] init] autorelease];
	NSDate *now = [[NSDate alloc] init];
	NSTimer *timer = [[NSTimer alloc] initWithFireDate:now
		interval:0.0
		target:obj1
		selector:@selector(createClassB)
		userInfo:nil
		repeats:NO];

	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	[runLoop addTimer:timer forMode:NSDefaultRunLoopMode];

	[timer release];
	[now release];

	[runLoop run];
	
	NSLog(@"} end\n");
}

int main(int argc, char**argv)  
{
	NSLog(@"create an autoreleasePool\n");
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
 
	func();
	
	NSLog(@"releasing autoreleasePool\n"); 
	[pool release]; 
	NSLog(@"autoreleasePool is released\n"); 
	
	return 0;
}  
