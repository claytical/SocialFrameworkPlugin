var SocialFrameworkPlugin = {

show: function (success, fail, textToShare) {
    return Cordova.exec( success, fail,
                        "com.dataplayed.SocialFrameworkPlugin",
                        "show",
                        [textToShare]);
}

};