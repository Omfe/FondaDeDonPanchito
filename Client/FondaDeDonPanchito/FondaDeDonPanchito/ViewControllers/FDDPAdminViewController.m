//
//  FDDPAdminViewController.m
//  FondaDeDonPanchito
//
//  Created by Omar Gudino on 5/29/13.
//  Copyright (c) 2013 Omar Gudino. All rights reserved.
//


//* En ese método, regresar YES si el loggedInUser es admin, NO si no
//* En pushToRegistry usar ese método para saber si inicializar y agregarlo al arreglo de los controles del tabBarController

#import "FDDPAdminViewController.h"

@interface FDDPAdminViewController ()

@end

@implementation FDDPAdminViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Admin View";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
