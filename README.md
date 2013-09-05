#SocialFrameworkPlugin for Cordova / PhoneGap & iOS 6

Coded by Clay Ewing (c.ewing@miami.edu)
www.claytical.com

This is a really simple plugin to just push the new share activity in iOS6 out.  Anyone that wants to add to this, please feel free and keep me in the loop!


##INSTALLATION:

1. Copy SocialFrameworkPlugin.m and SocialFrameworkPlugin.h to your plugin directory
2. Copy social.js to your www directory
3. Add the Social and Accounts frameworks to your project under Build Settings
4. Take a look at index.html for full use, but basically calling it is really straight forward:

 SocialFrameworkPlugin.show( shareSuccessCallback, shareErrorCallback, textToYouWantToPushToShareActivity );

##NOTES:

I have noticed in PhoneGap with the iPhone 5 simulator that the icon for Messages doesn't exist.

If you want to modify what services show up, modify the line 33 in SocialFrameworkPlugin.m:

activityController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard];

A full list can be found at http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIActivity_Class/Reference/Reference.html#//apple_ref/occ/cl/UIActivity
