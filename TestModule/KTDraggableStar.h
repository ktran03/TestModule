//
//  KTDraggableStar.h
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Questionable usage of UIControl. My justification is that the Star is indeed a control, simply because it recieves user input and acts upon it. Another way to look at it is the star is a view. In that case, we can get touch events based using UIGestureRecognizer (pan gesture). UIControl seems like a cleaner implementation.
 
     From Apple Docs:
     
     You may want to extend a UIControl subclass for either of two reasons:
     
     To observe or modify the dispatch of action messages to targets for particular events
     To do this, override sendAction:to:forEvent:, evaluate the passed-in selector, target object, or UIControlEvents bit mask, and proceed as required
     
     To provide custom tracking behavior (for example, to change the highlight appearance)
     To do this, override one or all of the following methods: beginTrackingWithTouch:withEvent:, continueTrackingWithTouch:withEvent:, endTrackingWithTouch:withEvent:.
 
 */
@interface KTDraggableStar : UIControl

@end
