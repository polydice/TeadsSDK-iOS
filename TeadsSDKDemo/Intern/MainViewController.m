//
//  MainViewController.m
//  TeadsSDKDemo
//
//  Created by Nikolaï Roycourt on 15/01/2015.
//  Copyright (c) 2015 Teads. All rights reserved.
//

#import "MainViewController.h"

#import "InReadTopScrollViewController.h"
#import "InReadTopTableViewController.h"
#import "InReadTopWebViewController.h"
#import "InReadTopWKWebView.h"
#import "InReadTopCollectionViewController.h"
#import "InReadScrollViewController.h"
#import "InReadTableViewController.h"
#import "CustomAdScrollViewController.h"
#import "CustomAdCollectionViewController.h"
#import "MultiCustomAdCollectionViewController.h"
#import "InReadWebViewController.h"
#import "InReadWebViewEmbededInScrollViewViewController.h"
#import "InReadWKWebview.h"
#import "InReadWkWebViewEmbededInScrollViewViewController.h"
#import "inReadWebViewInTableViewViewController.h"
#import "inReadWkWebViewInTableViewViewController.h"
#import "inReadWebViewInCollectionViewController.h"
#import "inReadWkWebViewInCollectionViewControllerCollectionViewController.h"
#import "DemoUtils.h"

@interface MainViewController () {
    NSArray *titlesForHeader;
    NSArray *controllers;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];

    self.title = @"Teads SDK Demo";
    
    titlesForHeader = @[@"Native Video", @"App Parameters"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [titlesForHeader count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 24;
    }
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [titlesForHeader objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTitleIdentifier = @"CellTitle";
    static NSString *CellIdentifier = @"Cell";
    
    NSString *cellTextLabel;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cellTextLabel = @"inRead"; //header
                break;
            case 1:
                cellTextLabel = @"inRead ScrollView";
                break;
            case 2:
                cellTextLabel = @"inRead WebView";
                break;
            case 3:
                cellTextLabel = @"inRead WKWebview";
                break;
            case 4:
                cellTextLabel = @"inRead TableView";
                break;
            case 5:
                cellTextLabel = @"inRead in WebView embeded"; //header
                break;
            case 6:
                cellTextLabel = @"inRead in WebView embeded in ScrollView";
                break;
            case 7:
                cellTextLabel = @"inRead in WKwebView embeded in ScrollView";
                break;
            case 8:
                cellTextLabel = @"inRead in WebView embeded in TableView";
                break;
            case 9:
                cellTextLabel = @"inRead in WKwebView embeded in TableView";
                break;
            case 10:
                cellTextLabel = @"inRead in WebView embeded in CollectionView";
                break;
            case 11:
                cellTextLabel = @"inRead in WKwebView embeded in CollectionView";
                break;
            case 12:
                cellTextLabel = @"inRead Top"; //header
                break;
            case 13:
                cellTextLabel = @"inRead Top ScrollView";
                break;
            case 14:
                cellTextLabel = @"inRead Top WebView";
                break;
            case 15:
                cellTextLabel = @"inRead Top WKWebview";
                break;
            case 16:
                cellTextLabel = @"inRead Top TableView";
                break;
            case 17:
                cellTextLabel = @"inRead Top CollectionView";
                break;
            case 18:
                cellTextLabel = @"Custom Native Video View";
                break;
            case 19:
                cellTextLabel = @"Custom in ScrollView";
                break;
            case 20:
                cellTextLabel = @"Custom in CollectionView";
                break;
            case 21:
                cellTextLabel = @"Multiple inRead (multi-slot)"; //header
                break;
            case 22:
                cellTextLabel = @"Simple inRead in CollectionView";
                break;
            case 23:
                cellTextLabel = @"Multiple inRead in CollectionView";
                break;
            default:
                break;
        }
        
    } else {
        
        switch (indexPath.row) {
            case 0:
                cellTextLabel = @"Change PID";
                break;
            case 1:
                cellTextLabel = @"Change website";
                break;
            default:
                break;
        }
    }
    
    UITableViewCell *cell;
    if ((indexPath.section == 0
         && (indexPath.row == 0
             || indexPath.row == 5
             || indexPath.row == 12
             || indexPath.row == 21))) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellTitleIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTitleIdentifier];
        }
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.userInteractionEnabled = NO;
        cell.backgroundColor = [UIColor  colorWithWhite:1 alpha:0.5];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = cellTextLabel;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id controller = nil;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1: {
                InReadScrollViewController *inReadScrollView = [storyboard  instantiateViewControllerWithIdentifier:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"inReadScrollViewForIPad":@"inReadScrollView"];
                controller = inReadScrollView;
                break;
            }
            case 2: {
                InReadWebViewController *inReadWebView = [storyboard instantiateViewControllerWithIdentifier:@"inReadWebView"];
                controller = inReadWebView;
                break;
            }
            case 3: {
                InReadWKWebview *inReadWKWebView = [storyboard instantiateViewControllerWithIdentifier:@"inReadWKWebView"];
                controller = inReadWKWebView;
                break;
            }
            case 4: {
                InReadTableViewController *inReadTableView = [storyboard instantiateViewControllerWithIdentifier:@"inReadTableView"];
                controller = inReadTableView;
                break;
            }
            case 6: {
                InReadWebViewEmbededInScrollViewViewController *inReadWebViewInScrollView = [storyboard instantiateViewControllerWithIdentifier:@"inRead WebView embeded in Scroll View"];
                controller = inReadWebViewInScrollView;
                break;
            }
            case 7: {
                InReadWkWebViewEmbededInScrollViewViewController *inReadWkWebViewInScrollView = [storyboard instantiateViewControllerWithIdentifier:@"inRead WkWebView embeded in Scroll View"];
                controller = inReadWkWebViewInScrollView;
                break;
            }
            case 8: {
                inReadWebViewInTableViewViewController *inReadWebViewInTableView = [storyboard instantiateViewControllerWithIdentifier:@"inRead WebView In TableView ViewController"];
                controller = inReadWebViewInTableView;
                break;
            }
            case 9: {
                inReadWkWebViewInTableViewViewController *inReadWkWebViewTableView = [storyboard instantiateViewControllerWithIdentifier:@"inRead WkWebView In TableView ViewController"];
                controller = inReadWkWebViewTableView;

                break;
            }
            case 10: {
                inReadWebViewInCollectionViewController *inReadWebViewInCollectionView = [storyboard instantiateViewControllerWithIdentifier:@"inRead WebView In CollectionViewController"];
                controller = inReadWebViewInCollectionView;
                break;
            }
            case 11: {
                inReadWkWebViewInCollectionViewControllerCollectionViewController *inReadWkWebViewInCollectionView = [storyboard instantiateViewControllerWithIdentifier:@"inRead WkWebView In CollectionViewController"];
                controller = inReadWkWebViewInCollectionView;
                break;
            }
            case 13: {
                InReadTopScrollViewController *inReadTopScrollView = [storyboard instantiateViewControllerWithIdentifier:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"inReadTopScrollViewForIPad":@"inReadTopScrollView"];
                controller = inReadTopScrollView;
                break;
            }
            case 14: {
                InReadTopScrollViewController *inReadTopScrollView = [storyboard instantiateViewControllerWithIdentifier:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"inReadTopScrollViewForIPad":@"inReadTopScrollView"];
                controller = inReadTopScrollView;
                break;
            }
            case 15: {
                InReadTopWebViewController *inReadTopWebView = [storyboard instantiateViewControllerWithIdentifier:@"inReadTopWebView"];
                controller = inReadTopWebView;
                break;
            }
            case 16: {
                InReadTopWKWebView *inReadTopWKWebView = [storyboard instantiateViewControllerWithIdentifier:@"inReadTopWKWebView"];
                controller = inReadTopWKWebView;
                break;
            }
            case 17: {
                InReadTopTableViewController *inReadTopTableView = [storyboard instantiateViewControllerWithIdentifier:@"inReadTopTableView"];
                controller = inReadTopTableView;
                break;
            }
            case 18: {
                InReadTopCollectionViewController *inReadTopCollectionView = [storyboard instantiateViewControllerWithIdentifier:@"inReadTopCollectionView"];
                controller = inReadTopCollectionView;
                break;
            }
            case 20: {
                CustomAdScrollViewController *simpleInReadScrollViewController = [storyboard instantiateViewControllerWithIdentifier:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"customAdScrollViewiPad":@"customAdScrollView"];
                controller = simpleInReadScrollViewController;
                break;
            }
            case 22: {
                CustomAdCollectionViewController *simpleInReadCollectionView = [storyboard instantiateViewControllerWithIdentifier:@"customAdCollectionViewController"];
                controller = simpleInReadCollectionView;
                
                break;
            } case 23: {
                MultiCustomAdCollectionViewController *multiCustomAdCollectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"multiCustomAdCollectionViewController"];
                controller = multiCustomAdCollectionViewController;
            }
            default:
                break;
        }
        
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0: {
                [DemoUtils presentControllerToChangePid:self];
                break;
            }
            case 1: {
                [DemoUtils presentControllerToChangeWebsite:self];
                break;
            }
            default:
                break;
        }
    }
    
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}


@end
