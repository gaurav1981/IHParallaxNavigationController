//
//  IHParallaxViewController.m
//  IHParallaxNavigationController
//
//  Created by Fraser Scott-Morrison on 7/04/15.
//  Copyright (c) 2015 Idle Hands. All rights reserved.
//

#import "IHParallaxViewController.h"
#import "UIViewController+TransparentNavBar.h"
#import "IHParallaxNavigationController.h"

@interface IHParallaxViewController ()

@end

@implementation IHParallaxViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:(NSCoder *)aDecoder];
    if (self) {
        // Custom initialization
        [self initialize];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.customNavBarColor = nil; // nil gives a transparent nav bar
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.navLevel = (int)self.navigationController.viewControllers.count - 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavBarColor:self.customNavBarColor];
    
    if ([self.navigationController isKindOfClass:[IHParallaxNavigationController class]]) {
        [((IHParallaxNavigationController *)self.navigationController) performParallaxAnimation:self.navLevel];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(viewWillAppearAnimationFinished)];
    self.view.alpha = 1;
    [UIView commitAnimations];
}

- (void)viewWillAppearAnimationFinished {
    CGPoint viewOrigin = [self.view convertPoint:self.view.frame.origin toView:self.navigationController.view];
    if (viewOrigin.x < 0) {
        self.view.alpha = 0;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self.navigationController isKindOfClass:[IHParallaxNavigationController class]]) {
        [((IHParallaxNavigationController *)self.navigationController) performParallaxAnimation:self.navLevel];
    }
    
    self.view.alpha = 1;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(viewWillDisappearAnimationFinished)];
    self.view.alpha = 0;
    [UIView commitAnimations];
}

- (void)viewWillDisappearAnimationFinished {
    CGPoint viewOrigin = [self.view convertPoint:self.view.frame.origin toView:self.navigationController.view];
    if (viewOrigin.x < 0) {
        self.view.alpha = 0;
    }
    else {
        self.view.alpha = 1;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.view.alpha = 0;
}



@end