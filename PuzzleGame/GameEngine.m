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
    int count1;
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
 [self getQuestionMatrixWithRightAns:gridmatrowCount gap:answerCount xRandomNo:arrayIndexNo];
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


-(void)getQuestionMatrixWithRightAns:(NSInteger)nCount gap:(NSInteger)xGap xRandomNo:(int)temp
{
    int newValue=0;
    int currentValue=0;
    for (int k=0; [tempValueArray count]<xGap; k++)
        {
            
        if(newValue==0)
        {
            newValue=1;
        currentValue=(arc4random()%4);
        }
        else if (currentValue<=2)
        {
            currentValue=currentValue+1;
        }
            else
            {
                currentValue=0;
            }
        checkvalidity=YES;
        switch (currentValue)
        {
            case 0:
                if (!(temp%nCount==1))
                {
                    NSInteger xWrapped = temp-1;
                    checkvalidity=[self cheknumber:xWrapped newArray:tempValueArray];
                    if (checkvalidity==YES)
                    {
                        [tempValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped] ];
                        temp=xWrapped;
                    }
                }
                break;
            case 1:
                if (!(temp<=nCount))
                {
                    NSInteger xWrapped = temp-nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:tempValueArray];
                    if (checkvalidity==YES)
                    {
                        [tempValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                        temp=xWrapped;
                    }else
                        temp=[[tempValueArray objectAtIndex:(arc4random()%[tempValueArray count])] integerValue];
                }
                break;
            case 2:
                if (!(temp%nCount==0))
                {
                    NSInteger xWrapped = temp+1;
                    checkvalidity=[self cheknumber:xWrapped newArray:tempValueArray];
                    if (checkvalidity==YES)
                    {
                        [tempValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                        temp=xWrapped;
                    }else
                        temp=[[tempValueArray objectAtIndex:(arc4random()%[tempValueArray count])] integerValue];
                }
                break;
            case 3:
                if (!(temp>=nCount*nCount-(nCount-1)))
                {
                    NSInteger xWrapped = temp+nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:tempValueArray];
                    if (checkvalidity==YES)
                        {
                            [tempValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                            temp=xWrapped;
                        }else
                        temp=[[tempValueArray objectAtIndex:(arc4random()%[tempValueArray count])] integerValue];
                }
               
                break;
        }

    }
}

-(NSDictionary*)xDrowOntherViewOnView:(NSInteger)gridmatrowCount answerCount:(NSInteger)answerCount
{
    ontherOneValueArray=[[NSMutableArray alloc]init];
    ontherSecondValueArray=[[NSMutableArray alloc]init];
    [self getOntherValue:gridmatrowCount :answerCount];
    [self getOntherSecondValue:gridmatrowCount :answerCount];
    NSMutableArray *ontherValueOne=[self getAnswerMatrix:ontherOneValueArray count:gridmatrowCount];
    NSMutableArray *ontherValueTwo=[self getAnswerMatrixSecond:ontherSecondValueArray count:gridmatrowCount];
    return [NSDictionary dictionaryWithObjectsAndKeys:ontherValueOne,@"ontherValueOneArray",ontherValueTwo,@"ontherValueTwoArray",[NSString stringWithFormat:@"%i",count],@"count",[NSString stringWithFormat:@"%i",count1],@"count1",nil];
}

-(void)getOntherSecondValue:(NSInteger)gridmatrowCount :(NSInteger)answerCount
{
    int randamNo = rand() % answerCount*answerCount+1;
    [self getQuestionMatrixWithWrongAnsSecond:gridmatrowCount gap:answerCount xRandomNo:randamNo ];
}

-(void)getOntherValue:(NSInteger)gridmatrowCount :(NSInteger)answerCount
{
    int randamNo = rand() % answerCount*answerCount+1;
   [self getQuestionMatrixWithWrongAns:gridmatrowCount gap:answerCount xRandomNo:randamNo ];
}

-(void)getQuestionMatrixWithWrongAns:(NSInteger)nCount gap:(NSInteger)xGap xRandomNo:(int)temp
{
    int newValue=0;
    int currentValue=0;
    for (int k=0; [ontherOneValueArray count]<xGap; k++)
    {
        
        if(newValue==0)
        {
            newValue=1;
            currentValue=(arc4random()%4);
        }
        else if (currentValue<=2)
        {
            currentValue=currentValue+1;
        }
        else
        {
            currentValue=0;
        }
        checkvalidity=YES;
        switch (currentValue)
        {
            case 0:
                if (!(temp%nCount==1))
                {
                    NSInteger xWrapped = temp-1;
                    checkvalidity=[self cheknumber:xWrapped newArray:ontherOneValueArray];
                    if (checkvalidity==YES)
                    {
                        [ontherOneValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped] ];
                        temp=xWrapped;
                    }
                    else
                        temp=[[ontherOneValueArray objectAtIndex:(arc4random()%[ontherOneValueArray count])] integerValue];
                }
                break;
            case 1:
                if (!(temp<=nCount))
                {
                    NSInteger xWrapped = temp-nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:ontherOneValueArray];
                    if (checkvalidity==YES)
                    {
                        [ontherOneValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                        temp=xWrapped;
                    }else
                        temp=[[ontherOneValueArray objectAtIndex:(arc4random()%[ontherOneValueArray count])] integerValue];
                }
                break;
            case 2:
                if (!(temp%nCount==0))
                {
                    NSInteger xWrapped = temp+1;
                    checkvalidity=[self cheknumber:xWrapped newArray:ontherOneValueArray];
                    if (checkvalidity==YES)
                    {
                        [ontherOneValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                        temp=xWrapped;
                    }else
                        temp=[[ontherOneValueArray objectAtIndex:(arc4random()%[ontherOneValueArray count])] integerValue];
                }
                break;
            case 3:
                if (!(temp>=nCount*nCount-(nCount-1)))
                {
                    NSInteger xWrapped = temp+nCount;
                    checkvalidity=[self cheknumber:xWrapped newArray:ontherOneValueArray];
                    if (checkvalidity==YES)
                    {
                        [ontherOneValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                        temp=xWrapped;
                    }else
                        temp=[[ontherOneValueArray objectAtIndex:(arc4random()%[ontherOneValueArray count])] integerValue];
                }
                
                break;
        }
        
    }
    
}

-(void)getQuestionMatrixWithWrongAnsSecond:(NSInteger)nCount gap:(NSInteger)xGap xRandomNo:(int)temp
{        int newValue=0;
        int currentValue=0;
        for (int k=0; [ontherSecondValueArray count]<xGap; k++)
        {
            
            if(newValue==0)
            {
                newValue=1;
                currentValue=(arc4random()%4);
            }
            else if (currentValue<=2)
            {
                currentValue=currentValue+1;
            }
            else
            {
                currentValue=0;
            }
            checkvalidity=YES;
            switch (currentValue)
            {
                case 0:
                    if (!(temp%nCount==1))
                    {
                        NSInteger xWrapped = temp-1;
                        checkvalidity=[self cheknumber:xWrapped newArray:ontherSecondValueArray];
                        if (checkvalidity==YES)
                        {
                            [ontherSecondValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped] ];
                            temp=xWrapped;
                        }
                        else
                            temp=[[ontherSecondValueArray objectAtIndex:(arc4random()%[ontherSecondValueArray count])] integerValue];
                    }
                    break;
                case 1:
                    if (!(temp<=nCount))
                    {
                        NSInteger xWrapped = temp-nCount;
                        checkvalidity=[self cheknumber:xWrapped newArray:ontherSecondValueArray];
                        if (checkvalidity==YES)
                        {
                            [ontherSecondValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                            temp=xWrapped;
                        }else
                            temp=[[ontherSecondValueArray objectAtIndex:(arc4random()%[ontherSecondValueArray count])] integerValue];
                    }
                    break;
                case 2:
                    if (!(temp%nCount==0))
                    {
                        NSInteger xWrapped = temp+1;
                        checkvalidity=[self cheknumber:xWrapped newArray:ontherSecondValueArray];
                        if (checkvalidity==YES)
                        {
                            [ontherSecondValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                            temp=xWrapped;
                        }else
                            temp=[[ontherSecondValueArray objectAtIndex:(arc4random()%[ontherSecondValueArray count])] integerValue];
                    }
                    break;
                case 3:
                    if (!(temp>=nCount*nCount-(nCount-1)))
                    {
                        NSInteger xWrapped = temp+nCount;
                        checkvalidity=[self cheknumber:xWrapped newArray:ontherSecondValueArray];
                        if (checkvalidity==YES)
                        {
                            [ontherSecondValueArray addObject:[NSString stringWithFormat:@"%i",xWrapped]];
                            temp=xWrapped;
                        }else
                            temp=[[ontherSecondValueArray objectAtIndex:(arc4random()%[ontherSecondValueArray count])] integerValue];
                    }
                    
                    break;
            }
            
        }}

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
    
   NSMutableArray  *displayMatrix1 =[[NSMutableArray alloc]init];
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
        NSArray * tempArr = [stringArray componentsSeparatedByString:@","];
        [maxrow addObject:tempArr[0]];
        [maxcol addObject:tempArr[1]];
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
        int temp1=0;
        NSArray *timeArray = [[rowAndColoum objectAtIndex:gk] componentsSeparatedByString:@","];
        int first=[[timeArray  objectAtIndex:0] intValue];
        int second=[[timeArray  objectAtIndex:1] intValue];
        int  row=count-([[sortedrow  lastObject] intValue ]-first);
        int  colum=count-([[sortedcol lastObject ]intValue ]-second);
        temp1=count*(row-1)+colum;
        [displayMatrix1 addObject:[NSString stringWithFormat:@"%i",temp1]];
    }
    return displayMatrix1;
}

-(NSMutableArray*)getAnswerMatrixSecond:(NSMutableArray*)showMatrix  count:(NSInteger)xNoOfCount
{
    
    NSMutableArray    *displayMatrix2 =[[NSMutableArray alloc]init];
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
        NSArray * tempArr = [stringArray componentsSeparatedByString:@","];
        [maxrow addObject:tempArr[0]];
        [maxcol addObject:tempArr[1]];
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

    
    count1=0;
    if ([[sortedcol lastObject] intValue ]-[[sortedcol objectAtIndex:0] intValue]<[[sortedrow lastObject] intValue ]-[[sortedrow objectAtIndex:0] intValue])
    {
        count1=[[sortedrow lastObject] intValue ]-[[sortedrow objectAtIndex:0] intValue]+1;
    }
    else
        count1=[[sortedcol lastObject] intValue ]-[[sortedcol objectAtIndex:0] intValue]+1;
    
    for (int gk=0; gk<[rowAndColoum count]; gk++)
    {
        int temp1=0;
        NSArray *timeArray = [[rowAndColoum objectAtIndex:gk] componentsSeparatedByString:@","];
        int first=[[timeArray  objectAtIndex:0] intValue];
        int second=[[timeArray  objectAtIndex:1] intValue];
        int  row=count1-([[sortedrow  lastObject] intValue ]-first);
        int  colum=count1-([[sortedcol lastObject ]intValue ]-second);
        temp1=count1*(row-1)+colum;
        [displayMatrix2 addObject:[NSString stringWithFormat:@"%i",temp1]];
    }
    return displayMatrix2;
}
@end
