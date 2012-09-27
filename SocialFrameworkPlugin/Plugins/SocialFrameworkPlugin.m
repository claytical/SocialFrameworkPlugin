//
//  SocialFrameworkPlugin.m
//  SocialFrameworkPlugin
//
//  Created by Clay Ewing on 9/27/12.
//
//

#import "SocialFrameworkPlugin.h"

@implementation SocialFrameworkPlugin
@synthesize excludedActivityTypes;

-(CDVPlugin*) initWithWebView:(UIWebView *)theWebView {
    self = (SocialFrameworkPlugin*) [super initWithWebView:theWebView];
    return self;
}



- (void) show:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options {
    NSString *callbackId = [arguments pop];

    
    NSString *textToShare = [arguments objectAtIndex:0];
    CDVPluginResult *result;

    NSArray *activityItems = @[textToShare];
    UIActivityViewController *activityController = [[UIActivityViewController alloc]
                                                    initWithActivityItems:activityItems applicationActivities:nil];
    
    //TODO: Make this configurable instead
    activityController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard];

    [self.viewController presentViewController:activityController
                                      animated:YES completion:nil];
    if (textToShare) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
        
    }
    else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
        
    }
    
    
    [activityController release];
    
    
}



@end
