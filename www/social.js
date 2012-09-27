var SocialFrameworkPlugin = {

show: function (success, fail, textToShare) {
    return Cordova.exec( success, fail,
                        "com.dataplayed.SocialFrameworkPlugin",
                        "show",
                        [textToShare]);
}
/*show: function (textToShare) {
    return Cordova.exec(
                        "com.dataplayed.SocialFrameworkPlugin.show",
                        [textToShare]);
}
  */
};