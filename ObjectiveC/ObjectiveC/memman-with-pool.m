//gcc -fconstant-string-class=NSConstantString -c memman-with-pool.m -I /GNUstep/System/Library/Headers
//gcc -o memman-with-pool memman-with-pool.o -L /GNUstep/System/Library/Libraries/ -lobjc -lgnustep-base
//./memman-with-pool

#import <Foundation/Foundation.h>  
 
@interface ClassA : NSObject
{
}
-(void) hello;
@end
 
@implementation ClassA
-(void) hello
{
	NSLog(@"hello\n");
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
	NSLog(@"alloc obj1 and autorelease");
	ClassA *obj1 = [[[ClassA alloc] init] autorelease];
	NSLog(@"obj1's retain count is %d\n", [obj1 retainCount]);
	NSLog(@"assign obj1 to obj2\n");
	ClassA *obj2 = obj1;
	NSLog(@"obj2's retain count is %d before retain\n", [obj2 retainCount]);
	NSLog(@"obj2 retain\n");
	[obj2 retain];
	NSLog(@"obj2's retain count is %d after retain\n", [obj2 retainCount]);
	NSLog(@"obj1 says hello\n");
	[obj1 hello];
	//NSLog(@"releasing obj1\n");
	//NSLog(@"obj1's retain count is %d before release\n", [obj1 retainCount]);
	//[obj1 release]; // Do not release it
	NSLog(@"obj1's retain count is %d after release\n", [obj1 retainCount]);
	NSLog(@"obj2 says hello\n");
	[obj2 hello];
	NSLog(@"releasing obj2\n");
	NSLog(@"obj2's retain count is %d before release\n", [obj2 retainCount]);
	[obj2 release];
	NSLog(@"obj2's retain count is %d after release\n", [obj2 retainCount]);
	NSLog(@"Note: we don't release obj1\n");
	
	NSLog(@"} end\n");
}

int main(int argc, char**argv)  
{    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
 
	func();
	
	NSLog(@"releasing autoreleasePool\n"); 
	[pool release]; 
	NSLog(@"autoreleasePool is released\n"); 
	
	return 0;
}  
