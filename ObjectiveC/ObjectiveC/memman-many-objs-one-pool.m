//gcc -fconstant-string-class=NSConstantString -c memman-many-objs-one-pool.m -I /GNUstep/System/Library/Headers
//gcc -o memman-many-objs-one-pool memman-many-objs-one-pool.o -L /GNUstep/System/Library/Libraries/ -lobjc -lgnustep-base
//./memman-many-objs-one-pool

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
	NSLog(@"Many objects but one pool\n");
	
	int i, j;
	for (i = 0; i < 100; i++ )
	{
		for (j = 0; j < 100000; j++ )
			[NSString stringWithFormat:@"1234567890"];
	}

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
