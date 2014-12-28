//gcc -fconstant-string-class=NSConstantString -c memman-getter-setter.m -I /GNUstep/System/Library/Headers
//gcc -o memman-getter-setter memman-getter-setter.o -L /GNUstep/System/Library/Libraries/ -lobjc -lgnustep-base
//./memman-getter-setter

#import <Foundation/Foundation.h>  
 
//-----------------------------------------------
// Class B
@interface ClassB : NSObject
{
	int index;
}

-(int) getIndex;
-(void) setIndex:(int) value;

-(void) hello;
@end
 
@implementation ClassB

-(int) getIndex
{
	return index;
}

-(void) setIndex:(int) value
{
	index = value;
}

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

//-----------------------------------------------
// Class A
@interface ClassA : NSObject
{
	ClassB *objB;
}

-(ClassB *) getObjB;
-(void) setObjB:(ClassB *) value;

-(void) hello;
@end
 
@implementation ClassA

-(ClassB*) getObjB
{
	return objB;
}

-(void) setObjB:(ClassB*) value
{
	if (objB != value)
	{
		[objB release];
		objB = [value retain];
		NSLog(@"objB's retain count is %lu\n", [objB retainCount]);
	}
}


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
	NSLog(@"---------No autorelease---------\n");
	
	ClassB *objB1 = [[ClassB alloc]init];
	[objB1 setIndex:1];

	ClassA *objA = [[ClassA alloc]init];
	NSLog(@"setting objB1\n");
	[objA setObjB:objB1];
	[objB1 release];

	ClassB *objB2 = [[ClassB alloc]init];
	[objB2 setIndex:2];

	NSLog(@"setting objB2\n");
	[objA setObjB:objB2];
	[objB2 release];

	[objA release];

}

void funcAutorelease()
{
	NSLog(@"--------autorelease-----------\n");
	
	ClassB *objB1 = [[[ClassB alloc]init] autorelease];
	[objB1 setIndex:1];

	ClassA *objA = [[[ClassA alloc]init] autorelease];
	NSLog(@"setting objB1\n");
	[objA setObjB:objB1];

	ClassB *objB2 = [[[ClassB alloc]init] autorelease];
	[objB2 setIndex:2];

	NSLog(@"setting objB2\n");
	[objA setObjB:objB2];
}

int main(int argc, char**argv)  
{    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
 
	funcNoAutorelease();
	funcAutorelease();
	
	NSLog(@"releasing autoreleasePool\n"); 
	[pool release]; 
	NSLog(@"autoreleasePool is released\n"); 
	
	return 0;
}  
