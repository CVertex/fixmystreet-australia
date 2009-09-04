// HTTPMultiPartPost.m
// FixMyStreet
//
// Created by Jake MacMullin on 22/06/09.
//

#import "HTTPMultiPartPost.h"


@implementation HTTPMultiPartPost

- (id)initWithURL:(NSURL *)aUrl {
  self = [super init];
  url = aUrl;
  requestData = [[NSMutableData alloc] init];
  responseData = [[NSMutableData alloc] init];
  boundary = @"---------------------------14737809831466499882746641449";
//  [requestData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
  return self;
}

- (void)addStringPart:(NSString *)value withKey:(NSString *)aKey {
  [requestData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
  [requestData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", aKey] dataUsingEncoding:NSASCIIStringEncoding]];
	[requestData appendData:[[NSString stringWithFormat:@"%@", value] dataUsingEncoding:NSASCIIStringEncoding]]; 
}

- (void)addFilePart:(NSData *)someData withKey:(NSString *)aKey fileName:(NSString *)fileName contentType:(NSString *)contentType {
  [requestData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
  [requestData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", aKey, fileName] dataUsingEncoding:NSASCIIStringEncoding]];
  [requestData appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", contentType] dataUsingEncoding:NSASCIIStringEncoding]];
  [requestData appendData:[[NSString stringWithString:@"Content-Transfer-Encoding: binary\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
  [requestData appendData:someData];
}

- (void)send {
  [requestData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
  
  NSLog([[NSString alloc] initWithData:requestData encoding:NSASCIIStringEncoding]);
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setHTTPMethod: @"POST"];
	[request addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField: @"Content-Type"];
  [request setHTTPBody:requestData];
  [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
  
  [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSString *returnString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
	if ([returnString isEqualToString:@"SUCCESS"]) {
    NSLog(@"Success");
  } else {
    NSLog(@"Failure");    
  }
  [responseData release];
  responseData = [[NSMutableData alloc] init];
}

- (void)dealloc {
  [responseData dealloc];
  [requestData dealloc];
  [super dealloc];
}


@end
