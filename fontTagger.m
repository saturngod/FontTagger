//
//  fontTagger.m
//  MyanmarFontTag
//
//  Created by Htain Lin Shwe on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "fontTagger.h"

@implementation fontTagger
+(FontType)whatFont:(NSString*)text {
  
  NSString* regMM = @"[\\u1000-\\u109f\\uaa60-\\uaa7f]+";
  NSString* regKh = @"[\\u1780–\\u17FF]+";
  
  NSString* regexUni = @"[ဃငဆဇဈဉညဋဌဍဎဏဒဓနဘရဝဟဠအ]်|ျ[က-အ]ါ|ျ[ါ-း]|\\u103e|\\u103f|\\u1031[^\\u1000-\\u1021\\u103b\\u1040\\u106a\\u106b\\u107e-\\u1084\\u108f\\u1090]|\\u1031$|\\u1031[က-အ]\\u1032|\\u1025\\u102f|\\u103c\\u103d[\\u1000-\\u1001]|ည်း|ျင်း|င်|န်း|ျာ";
  NSString* regexZG = @"\\s\\u1031| ေ[က-အ]်|[က-အ]း";
  
  NSError *error = NULL;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regMM options:NSRegularExpressionCaseInsensitive error:&error];
  
  NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
  
  if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
    
    regex = [NSRegularExpression regularExpressionWithPattern:regexUni options:NSRegularExpressionCaseInsensitive error:&error];
    rangeOfFirstMatch = [regex rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
      //unicode but test for sure is not zawgyi
      
      regex = [NSRegularExpression regularExpressionWithPattern:regexZG options:NSRegularExpressionCaseInsensitive error:&error];
      rangeOfFirstMatch = [regex rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
      
      if (NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        return Myanmar_Unicode;
      }
      else {
        return Zawgyi_One;
      }
    }
    else {
      return Zawgyi_One;
    }
  }
  else {
    regex = [NSRegularExpression regularExpressionWithPattern:regKh options:NSRegularExpressionCaseInsensitive error:&error];
    rangeOfFirstMatch = [regex rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
      return Khmer_Unicode;
    }
    else {
      return Other_Unicode;
    }
  }
  
}

@end
