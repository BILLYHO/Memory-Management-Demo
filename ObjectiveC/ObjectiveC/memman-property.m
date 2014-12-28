//gcc -fconstant-string-class=NSConstantString -c memman-property.m -I /GNUstep/System/Library/Headers
//gcc -o memman-property memman-property.o -L /GNUstep/System/Library/Libraries/ -lobjc -lgnustep-base
//./memman-property

#import <Foundation/Foundation.h>  

@interface ClassB : NSObject
{
	int index;
}

@property int index;

-(void) hello;
@end

@implementation ClassB

@synthesize index;

-(void) hello
{
	NSLog(@"hello ClassB\n");
}

-(void) dealloc
{
	[super dealloc];
	NSLog(@"ClassB %d destroyed\n", index);
	
}
@end

@interface ClassA : NSObject
{
	ClassB* objB;
}

@property (retain) ClassB* objB;
-(void) hello;
@end

@implementation ClassA

@synthesize objB;

-(void) hello
{
	NSLog(@"hello ClassA\n");
}

-(void) dealloc
{
	NSLog(@"releasing internal member objB\n");
	[objB release];
	[super dealloc];
	NSLog(@"ClassA destroyed\n");
}
@end

void funcNoAutorelease()
{
	NSLog(@"---------No autorelase---------\n");
	
	ClassB *objB1 = [[ClassB alloc]init];
	objB1.index = 1;
	
	ClassA *objA = [[ClassA alloc]init];
	NSLog(@"setting objB1\n");
	objA.objB = objB1;
	[objB1 release];
	
	ClassB *objB2 = [[ClassB alloc]init];
	objB2.index = 2;
	
	NSLog(@"setting objB2\n");
	objA.objB = objB2;
	[objB2 release];
	
	[objA release];
	
}

void funcAutorelease()
{
	NSLog(@"---------autorelase---------\n");
	
	ClassB *objB1 = [[[ClassB alloc]init] autorelease];
	objB1.index = 1;
	
	ClassA *objA = [[[ClassA alloc]init] autorelease];
	NSLog(@"setting objB1\n");
	objA.objB = objB1;
	
	ClassB *objB2 = [[[ClassB alloc]init] autorelease];
	objB2.index = 2;
	
	NSLog(@"setting objB2\n");
	objA.objB = objB2;
}

int main (int argc, const char * argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
	
	funcNoAutorelease();
	funcAutorelease();
	
	NSLog(@"releasing autoreleasePool\n"); 
	[pool release]; 
	NSLog(@"autoreleasePool is released\n"); 
	
	return 0;
}
