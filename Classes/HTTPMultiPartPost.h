// HTTPMultiPartPost.h
// FixMyStreet
//
// Created by Jake MacMullin on 22/06/09.
//

#import <Foundation/Foundation.h>


@interface HTTPMultiPartPost : NSObject {
  @private
  NSMutableData *requestData;
  NSMutableData *responseData;
  NSURL *url;
  NSString *boundary;
}

- (id)initWithURL:(NSURL *)url;
- (void)addFilePart:(NSData *)fileData withKey:(NSString *)key fileName:(NSString *)fileName contentType:(NSString *)contentType;
- (void)addStringPart:(NSString *)value withKey:(NSString *)key;
- (void)send;

@end
