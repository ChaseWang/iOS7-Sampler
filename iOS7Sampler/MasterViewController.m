//
//  MasterViewController.m
//  iOS7Sampler
//
//  Created by shuichi on 9/21/13.
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"


#define kItemKeyTitle       @"title"
#define kItemKeyDescription @"description"
#define kItemKeyClassPrefix @"prefix"


@interface MasterViewController ()
@property (nonatomic, strong) NSArray *items;
@end


@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   // Dynamic Behaviors
                   @{kItemKeyTitle: @"Dynamic Behaviors",
                     kItemKeyDescription: @"UIDynamicAnimator, UICollisionBehavior, etc...",
                     kItemKeyClassPrefix: @"DynamicBehaviors",
                     },
                   
                   // Speech Synthesis
                   @{kItemKeyTitle: @"Speech Synthesis",
                     kItemKeyDescription: @"Synthesized speech from text using AVSpeechSynthesizer and AVSpeechUtterance.",
                     kItemKeyClassPrefix: @"SpeechSynthesis",
                     },

                   // Custom Transition
                   @{kItemKeyTitle: @"Custom Transition",
                     kItemKeyDescription: @"UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate",
                     kItemKeyClassPrefix: @"CustomTransition",
                     },

                   // 3D Map
                   @{kItemKeyTitle: @"3D Map",
                     kItemKeyDescription: @"3D Map using MKMapCamera",
                     kItemKeyClassPrefix: @"Map3D",
                     },

                   // Motion Effect
                   @{kItemKeyTitle: @"Motion Effects (Parallax)",
                     kItemKeyDescription: @"Parallax effect using UIMotionEffect",
                     kItemKeyClassPrefix: @"MotionEffect",
                     },
                   
                   // Added Activity Types
                   @{kItemKeyTitle: @"AirDrop/Flickr/Vimeo/ReadingList",
                     kItemKeyDescription: @"New Activity Types: AirDrop, Post to Flickr / Vimeo, Add to ReadingList",
                     kItemKeyClassPrefix: @"ActivityTypes",
                     },
                   
                   // Static Map Snapshots
                   @{kItemKeyTitle: @"Static Map Snapshots",
                     kItemKeyDescription: @"Creating a snapshot with MKMapSnapshotOptions, MKMapSnapshotter.",
                     kItemKeyClassPrefix: @"MapSnapshot",
                     },
                   ];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // Needed after custome transition
    self.navigationController.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


// =============================================================================
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithRed:51./255.
                                                   green:153./255.
                                                    blue:204./255.
                                                   alpha:1.0];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
	NSDictionary *info = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = info[kItemKeyTitle];
    cell.detailTextLabel.text = info[kItemKeyDescription];
    
    return cell;
}


// =============================================================================
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *item = self.items[indexPath.row];
    NSString *className = [item[kItemKeyClassPrefix] stringByAppendingString:@"ViewController"];
    
    if (NSClassFromString(className)) {

        Class aClass = NSClassFromString(className);
        id instance = [[aClass alloc] init];
        
        if ([instance isKindOfClass:[UIViewController class]]) {
            
            [(UIViewController *)instance setTitle:item[kItemKeyTitle]];
            [self.navigationController pushViewController:(UIViewController *)instance
                                                 animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
