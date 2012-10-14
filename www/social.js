var SocialFrameworkPlugin = {
    
show: function (success, fail, textToShare, imageToShare) {
    return Cordova.exec( success, fail,
                        "com.dataplayed.SocialFrameworkPlugin",
                        "show",
                        [textToShare, imageToShare]);
},
    
tweet: function (success, fail, textToShare, imageToShare) {
    return Cordova.exec (success, fail, "com.dataplayed.SocialFrameworkPlugin",
                         "tweet", [textToShare, imageToShare]);
},
    
postToFacebook: function (success, fail, textToShare, imageToShare) {
    return Cordova.exec (success, fail, "com.dataplayed.SocialFrameworkPlugin",
                         "postToFacebook", [textToShare, imageToShare]);
}
    
};