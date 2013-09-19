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



- (void)show:(CDVInvokedUrlCommand*)command
{
    NSString *callbackId = command.callbackId;
    NSArray *arguments = command.arguments;
    NSString *textToShare = [arguments objectAtIndex:0];

/*- (void) show:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options {
    NSString *callbackId = [arguments pop];
    NSString *textToShare = [arguments objectAtIndex:0];*/

    CDVPluginResult *result;
    NSArray *activityItems;
    if ([arguments objectAtIndex:1] == [NSNull null]) {
        activityItems = @[textToShare];
    }
    else {
        NSData *imageData = [NSData dataFromBase64String:[arguments objectAtIndex:1]];
        UIImage *imageToShare = [UIImage imageWithData:imageData];
        activityItems = @[textToShare, imageToShare];
    }


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



-(void) postToFacebook:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options {
    NSString *callbackId = [arguments pop];
    
    NSString *textToShare = [arguments objectAtIndex:0];

    //TODO: figure out how arrays work within cordova to allow image and url sharing
    /*
     NSString *urlToShare = [arguments objectAtIndex:2];
     */
    SLComposeViewController *fbSLComposerSheet;
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        
        fbSLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbSLComposerSheet setInitialText:[NSString stringWithFormat:textToShare,fbSLComposerSheet.serviceType]];
        if ([arguments objectAtIndex:1] != [NSNull null]) {
            NSData *imageToShare = [NSData dataFromBase64String:[arguments objectAtIndex:1]];
            [fbSLComposerSheet addImage:[UIImage imageWithData:imageToShare]];
            
        }
        
        //        [fbSLComposerSheet addURL:[NSURL URLWithString:urlToShare]];
        [self.viewController presentViewController:fbSLComposerSheet animated:YES completion:nil];
    }
    
    [fbSLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        CDVPluginResult *CDVresult;
        
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                CDVresult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
                [self writeJavascript:[CDVresult toSuccessCallbackString:callbackId]];
                break;
            case SLComposeViewControllerResultDone:
                CDVresult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                [self writeJavascript:[CDVresult toSuccessCallbackString:callbackId]];
                break;
            default:
                break;
        }
    }];
    
    [fbSLComposerSheet release];

}

-(void) tweet:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options {
    NSString *callbackId = [arguments pop];
    
    NSString *textToShare = [arguments objectAtIndex:0];
    

    SLComposeViewController *tweetSLComposerSheet;

    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {

        tweetSLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSLComposerSheet setInitialText:[NSString stringWithFormat:textToShare,tweetSLComposerSheet.serviceType]];
        if ([arguments objectAtIndex:1] != [NSNull null]) {
            NSData *imageToShare = [NSData dataFromBase64String:[arguments objectAtIndex:1]];
            [tweetSLComposerSheet addImage:[UIImage imageWithData:imageToShare]];
            
        }

        [self.viewController presentViewController:tweetSLComposerSheet animated:YES completion:nil];
    }

        [tweetSLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            CDVPluginResult *CDVresult;

            switch (result) {
            case SLComposeViewControllerResultCancelled:
                CDVresult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
                [self writeJavascript:[CDVresult toSuccessCallbackString:callbackId]];
                break;
            case SLComposeViewControllerResultDone:
                CDVresult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                [self writeJavascript:[CDVresult toSuccessCallbackString:callbackId]];
                break;
            default:
                break;
        }
    }];
         
         [tweetSLComposerSheet release];

}



@end
