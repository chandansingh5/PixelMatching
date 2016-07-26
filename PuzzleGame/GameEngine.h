//
//  GameEngine.h
//  PuzzleGame
//
//  Created by IPHONE-17  on 2/27/14.
//  Copyright (c) 2014 IPHONE-17 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEngine : NSObject
-(NSDictionary*)xDrowSubViewOnView:(NSInteger)gridmatrowCount answerCount:(NSInteger)answerCount;
-(NSDictionary*)xDrowOntherViewOnView:(NSInteger)gridmatrowCount answerCount:(NSInteger)answerCount;
@end


