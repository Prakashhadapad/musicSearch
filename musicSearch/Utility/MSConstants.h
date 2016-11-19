//
//  MSConstants.h
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#ifndef MSConstants_h
#define MSConstants_h

//urls
#define iTunesBaseURL @"https://itunes.apple.com/search?term"

//error code

#define noDataErrorCode 111
#define noNetworkErrorCode 440
#define successCode 0

//error message

#define noDataErrorMessage @"No search results to show. Please try with different keyword."
#define noNetworkErrorMessage @"Couldn't reach server. Please try again."
#define defaultErrorMessage @"The operation couldn’t be completed."
#define errorDomian @"ITSErrorDefault"

#define TRACKNAME @"trackName"
#define ARTISTNAME @"artistName"
#define ALBUMIMAGE @"artworkUrl60"
#define ALBUMLARGEIMAGE @"artworkUrl100"
#define ALBUMNAME @"collectionName"

#endif /* MSConstants_h */
