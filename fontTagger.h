//
//  fontTagger.h
//  MyanmarFontTag
//
//  Created by Htain Lin Shwe on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  Myanmar_Unicode =0,
  Zawgyi_One =1,
  Khmer_Unicode=2,
  Other_Unicode=3
}FontType;

@interface fontTagger : NSObject
+(FontType)whatFont:(NSString*)text;
@end
