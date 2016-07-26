//
//  GameEngine.m
//  PuzzleGame
//
//  Created by IPHONE-17  on 2/27/14.
//  Copyright (c) 2014 IPHONE-17 . All rights reserved.
//

#import "GameEngine.h"
#import "GridViewController.h"
#import "AppDelegate.h"
@implementation GameEngine
{
    NSMutableArray *displayMatrix;
    NSMutableArray *cornerIndexNo;
    NSMutableArray *tempValueArray;
    NSMutableArray *ontherOneValueArray;
    NSMutableArray *ontherSecondValueArray;
    int count;
    BOOL checkvalidity;
    GridViewController *objctGridView;
    AppDelegate *appDel ;
    
}


-(id)init
{
    checkvalidity=YES;
    if (self == nil)
    {
        self = [super init];
    }
    return self;
}

-(NSDictionary*)xDrowSubViewOnView:(NSInteger)nGridmatrowCount answerCount:(NSInteger)nAnswerCount
{
    appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    tempValueArray=[[NSMutableArray alloc]init];
    [self cornerValueofGridMatrix:nGridmatrowCount];
    [self getTempValue:nGridmatrowCount :nAnswerCount];
    displayMatrix=[self getAnswerMatrix:tempValueArray count:nGridmatrowCount];
    return [NSDictionary dictionaryWithObjectsAndKeys:tempValueArray,@"tempValueArray",displayMatrix,@"displayMatrix",[NSString stringWithFormat:@"%d",count],@"count",nil];
}

-(void)getTempValue:(NSInteger)gridmatrowCount :(NSInteger)answerCount
{
    int arrayIndexNo = rand() % gridmatrowCount*gridmatrowCount+1;
    if(appDel.isEdge)
    {
        arrayIndexNo=[[cornerIndexNo objectAtIndex:(arc4random()%[cornerIndexNo count])] integerValue];
    }
    tempValueArray=[self getQuestionMatrixWithRightAns:gridmatrowCount gap:answerCount xRandomNo:arrayIndexNo];

}

-(void)cornerValueofGridMatrix:(NSInteger)xCount
{
    cornerIndexNo=[[NSMutableArray alloc]init];
    for (int j=1,k=0,l=1; j<=xCount*xCount; j++)
        {
            if (j<=xCount || j==xCount*k+1|| j==xCount*l ||j>=xCount*xCount-(xCount-1))
                {
                    [cornerIndexNo addObject:[NSString stringWithFormat:@"%i",j]];
                }
            if (j%xCount==0)
            {
                k++;
                l++;
            }
        }
}



-(NSMutableArray*)getQuestionMatrixWithRightAns:(NSInteger)nCount gap:(NSInteger)xGap xRandomNo:(int)temp
{
    NSMutableArray *xNewMatrix=[[NSMutableArray alloc]init];
    for (int k=0; [xNewMatrix count]<xGap; k++)
        {
            if (k>50000)
            {
                [self getTempValue:nCount :xGap];
                break;
            }
        int currentValue=(arc4random()%4);
        checkvalidity=YES; 
        switch (currentValue)
        {
            case 0:
                if (!(temp%nCount==1))
                {
                    NSInteger xWrapped = temp-1;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp] ];
                        temp=xWrapped;
                    }
                }
                break;
            case 1:
                if (!(temp<=nCount))
                {
                    NSInteger xWrapped = temp-nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                        temp=xWrapped;
                    }
                }
                break;
            case 2:
                if (!(temp%nCount==0))
                {
                    NSInteger xWrapped = temp+1;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                        temp=xWrapped;
                    }
                }
                break;
            case 3:
                if (!(temp>=nCount*nCount-(nCount-1)))
                {
                    NSInteger xWrapped = temp+nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                        {
                            [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                            temp=xWrapped;
                        }
                }
                break;
        }
        
    }
    return xNewMatrix;
}
-(NSDictionary*)xDrowOntherViewOnView:(NSInteger)gridmatrowCount answerCount:(NSInteger)answerCount
{
    ontherOneValueArray=[[NSMutableArray alloc]init];
    ontherSecondValueArray=[[NSMutableArray alloc]init];
    [self getOntherValue:gridmatrowCount :answerCount];
    [self getOntherSecondValue:gridmatrowCount :answerCount];
    NSLog(@"ontherSecondValueArray%@",ontherOneValueArray);
    NSLog(@"ontherSecondValueArray%@",ontherSecondValueArray);
    NSMutableArray *ontherValueOneArray=[self getAnswerMatrix:ontherOneValueArray count:gridmatrowCount];
    NSMutableArray *ontherValueTwoArray=[self getAnswerMatrix:ontherSecondValueArray count:gridmatrowCount];
    return [NSDictionary dictionaryWithObjectsAndKeys:ontherValueOneArray,@"ontherValueOneArray",ontherValueTwoArray,@"ontherValueTwoArray",[NSString stringWithFormat:@"%d",count],@"count",nil];
}
-(void)getOntherSecondValue:(NSInteger)gridmatrowCount :(NSInteger)answerCount
{
    int randamNo = rand() % answerCount*answerCount+1;
    ontherSecondValueArray=[self getQuestionMatrixWithWrongAnsSecond:gridmatrowCount gap:answerCount xRandomNo:randamNo ];
}

-(void)getOntherValue:(NSInteger)gridmatrowCount :(NSInteger)answerCount
{
    int randamNo = rand() % answerCount*answerCount+1;
    ontherOneValueArray=[self getQuestionMatrixWithWrongAns:gridmatrowCount gap:answerCount xRandomNo:randamNo ];
}


-(NSMutableArray*)getQuestionMatrixWithWrongAns:(NSInteger)nCount gap:(NSInteger)xGap xRandomNo:(int)temp 
{
    NSMutableArray *xNewMatrix=[[NSMutableArray alloc]init];
    for (int k=0; [xNewMatrix count]<xGap; k++)
    {
        if (k>50000)
        {
                [self getOntherValue:nCount :xGap];
             break;
           
        }
        int currentValue=(arc4random()%4);
        checkvalidity=YES;
        switch (currentValue)
        {
            case 0:
                if (!(temp%nCount==1))
                {
                    NSInteger xWrapped = temp-1;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp] ];
                        temp=xWrapped;
                    }
                }
                break;
            case 1:
                if (!(temp<=nCount))
                {
                    NSInteger xWrapped = temp-nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                        temp=xWrapped;
                    }
                }
                break;
            case 2:
                if (!(temp%nCount==0))
                {
                    NSInteger xWrapped = temp+1;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                        temp=xWrapped;
                    }
                }
                break;
            case 3:
                if (!(temp>=nCount*nCount-(nCount-1)))
                {
                    NSInteger xWrapped = temp+nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                        temp=xWrapped;
                    }
                }
                break;
        }
        
    }
    return xNewMatrix;
    
}

-(NSMutableArray*)getQuestionMatrixWithWrongAnsSecond:(NSInteger)nCount gap:(NSInteger)xGap xRandomNo:(int)temp
{
    NSMutableArray *xNewMatrix=[[NSMutableArray alloc]init];
    for (int k=0; [xNewMatrix count]<xGap; k++)
    {
        if (k>50000)
        {
            [self getOntherSecondValue:nCount :xGap];
             break;
        }
        int currentValue=(arc4random()%4);
        checkvalidity=YES;
        switch (currentValue)
        {
            case 0:
                if (!(temp%nCount==1))
                {
                    NSInteger xWrapped = temp-1;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp] ];
                        temp=xWrapped;
                    }
                }
                break;
            case 1:
                if (!(temp<=nCount))
                {
                    NSInteger xWrapped = temp-nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                        temp=xWrapped;
                    }
                }
                break;
            case 2:
                if (!(temp%nCount==0))
                {
                    NSInteger xWrapped = temp+1;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                        temp=xWrapped;
                    }
                }
                break;
            case 3:
                if (!(temp>=nCount*nCount-(nCount-1)))
                {
                    NSInteger xWrapped = temp+nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:(NSMutableArray*)xNewMatrix];
                    if (checkvalidity)
                    {
                        [xNewMatrix addObject:[NSString stringWithFormat:@"%i",temp]];
                        temp=xWrapped;
                    }
                }
                break;
        }
        
    }
    return xNewMatrix;
    
}

-(BOOL)cheknumber:(NSInteger)xWrapped newArray:(NSMutableArray*)xNewMatrix
{
    for (NSString *str in xNewMatrix)
    {
        if (xWrapped==[str integerValue])
        {
            checkvalidity=NO;
        }
    }
    return checkvalidity;
}

-(NSMutableArray*)getAnswerMatrix:(NSMutableArray*)showMatrix  count:(NSInteger)xNoOfCount
{
    displayMatrix =[[NSMutableArray alloc]init];
    NSMutableArray *rowAndColoum = [NSMutableArray arrayWithCapacity:[showMatrix count]];
    for (NSString *str in showMatrix)
    {
        int rows=0,colums=0;
        if ([str intValue]%xNoOfCount==0)
        {
            rows=([str intValue]/xNoOfCount);
            colums=xNoOfCount;
        }
        else
        {
            rows=[str intValue]/ xNoOfCount+1;
            colums=[str intValue]%xNoOfCount;
        }
        NSString *s=[NSString stringWithFormat:@"%i,%i",rows,colums];
        [rowAndColoum addObject:s];
    }
    NSMutableArray *maxrow = [NSMutableArray arrayWithCapacity:[rowAndColoum count]];
    NSMutableArray *maxcol = [NSMutableArray arrayWithCapacity:[rowAndColoum count]];
    for (NSString * stringArray in rowAndColoum)
    {
        NSArray * xRandomNoArr = [stringArray componentsSeparatedByString:@","];
        [maxrow addObject:xRandomNoArr[0]];
        [maxcol addObject:xRandomNoArr[1]];
    }
    
    NSArray *sortedrow = [maxrow sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSArray *sortedcol = [maxcol sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    count=0;
    if ([[sortedcol lastObject] intValue ]-[[sortedcol objectAtIndex:0] intValue]<[[sortedrow lastObject] intValue ]-[[sortedrow objectAtIndex:0] intValue])
    {
        count=[[sortedrow lastObject] intValue ]-[[sortedrow objectAtIndex:0] intValue]+1;
    }
    else
        count=[[sortedcol lastObject] intValue ]-[[sortedcol objectAtIndex:0] intValue]+1;
    for (int gk=0; gk<[rowAndColoum count]; gk++)
    {
        int xRandomNo1=0;
        NSArray *timeArray = [[rowAndColoum objectAtIndex:gk] componentsSeparatedByString:@","];
        int first=[[timeArray  objectAtIndex:0] intValue];
        int second=[[timeArray  objectAtIndex:1] intValue];
        int  row=count-([[sortedrow  lastObject] intValue ]-first);
        int  colum=count-([[sortedcol lastObject ]intValue ]-second);
        xRandomNo1=count*(row-1)+colum;
        [displayMatrix addObject:[NSString stringWithFormat:@"%i",xRandomNo1]];
    }
    return displayMatrix;
}
@end
