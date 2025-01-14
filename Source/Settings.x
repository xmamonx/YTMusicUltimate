#import <UIKit/UIKit.h>
#include "Prefs/YTMUltimateSettingsController.h"

@interface YTMAccountButton : UIButton
- (id)initWithTitle:(id)arg1 identifier:(id)arg2 icon:(id)arg3 actionBlock:(void (^)(BOOL finished))arg4;
@end

@interface YTMAvatarAccountView : UIView
@end

@interface UIView (Private)
- (id)_viewControllerForAncestor;
@end

extern NSBundle *YTMusicUltimateBundle();

%group SettingsPage
%hook YTMAvatarAccountView

- (void)setAccountMenuUpperButtons:(id)arg1 lowerButtons:(id)arg2 {
    NSBundle *tweakBundle = YTMusicUltimateBundle();
    UIImage *icon = [UIImage imageWithContentsOfFile:[tweakBundle pathForResource:@"ytmicon-24@2x" ofType:@"png" inDirectory:@"icons"]];
    
    //Create the YTMusicUltimate button
    YTMAccountButton *button = [[%c(YTMAccountButton) alloc] initWithTitle:@"YTMusicUltimate" identifier:@"ytmult" icon:icon actionBlock:^(BOOL arg4) {
        //Push YTMusicUltimate view controller.
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[YTMUltimateSettingsController alloc] init]];
        [nav setModalPresentationStyle: UIModalPresentationFullScreen];
        [self._viewControllerForAncestor presentViewController:nav animated:YES completion:nil];
    }];

    // button.tintColor = [UIColor redColor];

    //Add our custom button to the list.
    NSMutableArray *arrDown = [[NSMutableArray alloc] init];
    [arrDown addObjectsFromArray:arg2];
    [arrDown addObject:button];

    //Remove the subscribe to premium button.
    NSMutableArray *arrUp = [[NSMutableArray alloc] init];
    for (YTMAccountButton *yt_button in arg1) {
        if (![[yt_button.titleLabel text] containsString:@"Premium"]) {
            [arrUp addObject:yt_button];
        }
    }

    //Continue the function with our own parameters.
    %orig(arrUp, arrDown);
}
%end
%end

%ctor {
    %init(SettingsPage);
}