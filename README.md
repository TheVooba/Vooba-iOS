Vooba for iOS
=============

More README info coming soon, but one important piece to document:

To successfully compile and use the Vooba-iOS app, you will need to get an API token from [Vooba](http://vooba.net/). This will need to be placed in a file named "Tokens.h" that you are responsible for creating. It should look something like:

```objective-c
#ifndef Vooba_Tokens_h
#define Vooba_Tokens_h

#define VOOBA_APP_TOKEN @"<paste_your_app_token_here>"

#endif
```