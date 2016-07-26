//
//  ViewController.m
//  PuzzleGame
//
//  Created by IPHONE-17  on 2/12/14.
//  Copyright (c) 2014 IPHONE-17 . All rights reserved.
//

#import "GridViewController.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "GameEngine.h"
@interface GridViewController ()
{
    NSMutableArray *tempValueArray;
    NSMutableArray *displayMatrix;
    BOOL checkvalidity;
    int finalcount;
    CGFloat sizeofWindo;
    GameEngine *objGameEngine;
}
@end

@implementation GridViewController
int cal=0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _ansmatrowcount=10;
    _gridmatrowcount=20;
    objGameEngine=[[GameEngine alloc]init];
    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    sizeofWindo=appDel.window.frame.size.width;
    [self xDrowImageViewOnView];
    [self xDrowOptionMatrix];
    [self xColorHideImageView];
    [gapButton setTitle:[NSString stringWithFormat:@"G - %d",_ansmatrowcount] forState:UIControlStateNormal];
    [rowButton setTitle:[NSString stringWithFormat:@"R - %d",_gridmatrowcount] forState:UIControlStateNormal];
  
}

- (IBAction)changematrix:(id)sender
{
    [self ResetScrollView:self.view];
    [self xDrowImageViewOnView];
    [self xDrowOptionMatrix];
    [self xColorHideImageView];
}

- (IBAction)toggleMode:(id)sender
{
    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDel.isEdge = !appDel.isEdge;
    [self changematrix:nil];
    if(appDel.isEdge)
    {
        [((UIButton*)sender) setTitle:@"Edge" forState:UIControlStateNormal];
    }
    else
    {
        [((UIButton*)sender) setTitle:@"Rand" forState:UIControlStateNormal];
    }
    
}


-(void)xDrowImageViewOnView
{
    int  x=0,y=0;
    for (int i=1; i<=_gridmatrowcount*_gridmatrowcount; i++)
        {
            uiImageView =[[UIImageView alloc]init];
            [uiImageView setBackgroundColor:[UIColor redColor]];
            [uiImageView.layer setBorderWidth:kBoarderWidth];
            [uiImageView.layer setBorderColor:[[UIColor blackColor] CGColor]];
            uiImageView.frame=CGRectMake(x, y, sizeofWindo/_gridmatrowcount, sizeofWindo/_gridmatrowcount);
            x+=(sizeofWindo/_gridmatrowcount);
            if (i%_gridmatrowcount==0)
                {
                    x=0;
                    y+=(sizeofWindo/_gridmatrowcount);
                }
            uiImageView.tag=i;
            [self.view addSubview:uiImageView];
        }
   
}


- (void) ResetScrollView:(UIView *)scrlView
{
    for (UIImageView * anImageView in [scrlView subviews])
        {
            if ([anImageView isKindOfClass:[UIImageView class]])
                [anImageView removeFromSuperview];
        }
}


-(void) xDrowImageViewOnScrollview:(int)count1 width:(CGFloat)xwidth
{
    CGFloat scrolheight=self.uiScrollView.frame.size.height;
    [self.uiScrollView setContentSize:CGSizeMake(scrolheight*3,self.uiScrollView.frame.size.height)];
    UITapGestureRecognizer *recongnizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch:)];
    [self.uiScrollView addGestureRecognizer:recongnizer];
    int x=xwidth,y=0;
    for (int i=1; i<=count1*count1; i++)
    {
        uiImageView =[[UIImageView alloc]init];
        [uiImageView setBackgroundColor:[UIColor redColor]];
        [uiImageView.layer setBorderWidth:kBoarderWidth];
        [uiImageView.layer setBorderColor:[[UIColor blackColor] CGColor]];
        uiImageView.frame=CGRectMake(x, y, scrolheight/count1, scrolheight/count1);
        x+=(scrolheight/count1);
        if (i%count1==0)
        {
            x=xwidth;
            y+=(scrolheight/count1);
        }
        cal++;
        uiImageView.tag=cal+1000;
        [uiImageView setBackgroundColor:[UIColor lightGrayColor]];
        [self.uiScrollView addSubview:uiImageView];
    }
    
}


-(void)touch:(UITapGestureRecognizer*)recogniser
{
    
    CGPoint touchPoint = [recogniser locationInView:recogniser.view];
    if (touchPoint.x>=0 && touchPoint.x<=sizeofWindo/3)
    {
        if (0==finalcount)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Guess" message:@"Your Guess is Right" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            for (NSString *str in tempValueArray)
            {
                UIImageView *imageViewMatrix=(UIImageView*)[self.view viewWithTag:[str intValue]];
                [imageViewMatrix setBackgroundColor:[UIColor blackColor]];
                imageViewMatrix.hidden=NO;
            }
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Guess" message:@"Your Guess is Wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if (touchPoint.x>=sizeofWindo/3 && touchPoint.x<=sizeofWindo/2)
    {
        if (1==finalcount)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Guess" message:@"Your Guess is Rightt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            for (NSString *str in tempValueArray)
            {
                UIImageView *imageViewMatrix=(UIImageView*)[self.view viewWithTag:[str intValue]];
                [imageViewMatrix setBackgroundColor:[UIColor blackColor]];
                imageViewMatrix.hidden=NO;
            }
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Guess" message:@"Your Guess is Wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if (touchPoint.x>=sizeofWindo/2 && touchPoint.x<=sizeofWindo)
    {
        if (2==finalcount)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Guess" message:@"Your Guess is Right" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            for (NSString *str in tempValueArray)
            {
                UIImageView *imageViewMatrix=(UIImageView*)[self.view viewWithTag:[str intValue]];
                [imageViewMatrix setBackgroundColor:[UIColor blackColor]];
                imageViewMatrix.hidden=NO;
            }

        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Guess" message:@"Your Guess is Wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}


-(void)xDrowOptionMatrix
{
    displayMatrix=[[NSMutableArray alloc]init];
    [self ResetScrollView:self.uiScrollView];
    cal=0;
    int total;
    NSArray  *number=[NSArray arrayWithObjects:@"0",@"1",@"2",nil];
    finalcount=[[number objectAtIndex:(arc4random()%[number count])] integerValue];
    CGFloat xaxis=0.0;
    CGFloat y=self.uiScrollView.frame.size.width-self.uiScrollView.frame.size.height*3;
    y=y/2;
    BOOL chekisused=YES;
     NSDictionary * dict = [objGameEngine xDrowSubViewOnView:_gridmatrowcount answerCount:_ansmatrowcount];
    NSMutableArray *arrayfromdict=[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"displayMatrix"]];
    tempValueArray=[[NSMutableArray alloc]initWithArray:[dict valueForKey:@"tempValueArray"]];
    NSString *strfromdict=[dict valueForKey:@"count"];
     NSDictionary * dicta =[objGameEngine xDrowOntherViewOnView:_ansmatrowcount answerCount:_ansmatrowcount];
    for (int t=0; t<3; t++)
    {        
         xaxis=(self.uiScrollView.frame.size.height)*t+y*t;
         total=cal;
        if (t==finalcount)
        {
            [self xDrowImageViewOnScrollview:[strfromdict intValue] width:xaxis];
          for (NSString * stringArray in arrayfromdict)
                {
                    int countvalue=total+[stringArray integerValue];
                    [displayMatrix addObject:[NSString stringWithFormat:@"%i",countvalue]];
                   
                }
            
            }
        else
            {
                NSMutableArray *arrayfromdic=[[NSMutableArray alloc]init];
            if (chekisused) {
                  arrayfromdic=[[NSMutableArray alloc]initWithArray:[dicta valueForKey:@"ontherValueOneArray"]];
                chekisused=FALSE;
                }else
                arrayfromdic=[[NSMutableArray alloc]initWithArray:[dicta valueForKey:@"ontherValueTwoArray"]];
                NSString *strfromdict=[dict valueForKey:@"count"];
                [self xDrowImageViewOnScrollview:[strfromdict intValue] width:xaxis];
                for (NSString * stringArray in arrayfromdic)
                {
                    int countvalue=total+[stringArray integerValue];
                    [displayMatrix addObject:[NSString stringWithFormat:@"%i",countvalue]];
                }
            }
    }
}



-(void)xColorHideImageView
{
    for (NSString *str in displayMatrix)
        {
            UIImageView *imageVw=(UIImageView*)[self.uiScrollView 	viewWithTag:(1000+[str intValue])];
            [imageVw setBackgroundColor:[UIColor purpleColor]];
        }
    for (NSString *str in tempValueArray)
        {
            UIImageView *imageViewMatrix=(UIImageView*)[self.view viewWithTag:[str integerValue]];
            imageViewMatrix.hidden=YES;
        }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self changematrix:self.xChangeButton];
}


- (IBAction)gDecrementButton:(id)sender
{
    if (_ansmatrowcount <= 5)
    {
        return;
    }
    _ansmatrowcount--;
    [gapButton setTitle:[NSString stringWithFormat:@"G - %d",_ansmatrowcount] forState:UIControlStateNormal];
    [self changematrix:self.xChangeButton];
    
}
- (IBAction)gIncrementButton:(id)sender
{
    _ansmatrowcount++;
    [gapButton setTitle:[NSString stringWithFormat:@"G - %d",_ansmatrowcount] forState:UIControlStateNormal];
    [self changematrix:self.xChangeButton];

}



- (IBAction)rIncrementButton:(id)sender {
    _gridmatrowcount++;
    [rowButton setTitle:[NSString stringWithFormat:@"R - %d",_gridmatrowcount] forState:UIControlStateNormal];
    [self changematrix:self.xChangeButton];
}
- (IBAction)rDecrementButton:(id)sender {
    
    if (_gridmatrowcount <= 5)
    {
        return;
    }
    _gridmatrowcount--;
    [rowButton setTitle:[NSString stringWithFormat:@"R - %d",_gridmatrowcount] forState:UIControlStateNormal];
    [self changematrix:self.xChangeButton];
}



@end
