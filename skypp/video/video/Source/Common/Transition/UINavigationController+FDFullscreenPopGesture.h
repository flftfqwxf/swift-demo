
#import <UIKit/UIKit.h>

@interface UINavigationController (FDFullscreenPopGesture)

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fd_fullscreenPopGestureRecognizer;

@property (nonatomic, assign) BOOL fd_viewControllerBasedNavigationBarAppearanceEnabled;

@property (nonatomic, assign) BOOL fd_interactivePopDisabled;

@end

@interface UIViewController (FDFullscreenPopGesture)

@property (nonatomic, assign) BOOL fd_prefersNavigationBarHidden;

@property (nonatomic, assign) CGFloat fd_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end
