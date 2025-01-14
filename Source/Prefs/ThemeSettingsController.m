#import "ThemeSettingsController.h"

#define LOC(x) [tweakBundle localizedStringForKey:x value:nil table:nil]

extern NSBundle *YTMusicUltimateBundle();

@implementation ThemeSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];

    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];

    self.navigationItem.leftBarButtonItem = [self backButton];

    UITableViewStyle style;
    if (@available(iOS 13, *)) {
        style = UITableViewStyleInsetGrouped;
    } else {
        style = UITableViewStyleGrouped;
    }

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
}

#pragma mark - Table view stuff
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    NSBundle *tweakBundle = YTMusicUltimateBundle();
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = LOC(@"OLED_DARK_THEME");
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.detailTextLabel.text = LOC(@"OLED_DARK_THEME_DESC");
            cell.detailTextLabel.numberOfLines = 0;

            if (@available(iOS 13, *)) {
                cell.detailTextLabel.textColor = [UIColor secondaryLabelColor];
            } else {
                cell.detailTextLabel.textColor = [UIColor systemGrayColor];
            }

            UISwitch *oledDarkTheme = [[UISwitch alloc] initWithFrame:CGRectZero];
            oledDarkTheme.onTintColor = [UIColor colorWithRed:30.0/255.0 green:150.0/255.0 blue:245.0/255.0 alpha:1.0];
            [oledDarkTheme addTarget:self action:@selector(toggleOledDarkTheme:) forControlEvents:UIControlEventValueChanged];
            oledDarkTheme.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"oledDarkTheme_enabled"];
            cell.accessoryView = oledDarkTheme;
        } if (indexPath.row == 1) {
            cell.textLabel.text = LOC(@"OLED_DARK_KEYBOARD");
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.detailTextLabel.text = LOC(@"OLED_DARK_KEYBOARD_DESC");
            cell.detailTextLabel.numberOfLines = 0;

            if (@available(iOS 13, *)) {
                cell.detailTextLabel.textColor = [UIColor secondaryLabelColor];
            } else {
                cell.detailTextLabel.textColor = [UIColor systemGrayColor];
            }
            UISwitch *oledDarkKeyboard = [[UISwitch alloc] initWithFrame:CGRectZero];
            oledDarkKeyboard.onTintColor = [UIColor colorWithRed:30.0/255.0 green:150.0/255.0 blue:245.0/255.0 alpha:1.0];
            [oledDarkKeyboard addTarget:self action:@selector(toggleOledDarkKeyboard:) forControlEvents:UIControlEventValueChanged];
            oledDarkKeyboard.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"oledDarkKeyboard_enabled"];
            cell.accessoryView = oledDarkKeyboard;
        } if (indexPath.row == 2) {
            cell.textLabel.text = LOC(@"LOW_CONTRAST");
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.detailTextLabel.text = LOC(@"LOW_CONTRAST_DESC");
            cell.detailTextLabel.numberOfLines = 0;

            if (@available(iOS 13, *)) {
                cell.detailTextLabel.textColor = [UIColor secondaryLabelColor];
            } else {
                cell.detailTextLabel.textColor = [UIColor systemGrayColor];
            }
            UISwitch *lowContrast = [[UISwitch alloc] initWithFrame:CGRectZero];
            lowContrast.onTintColor = [UIColor colorWithRed:30.0/255.0 green:150.0/255.0 blue:245.0/255.0 alpha:1.0];
            [lowContrast addTarget:self action:@selector(toggleLowContrast:) forControlEvents:UIControlEventValueChanged];
            lowContrast.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"lowContrast_enabled"];
            cell.accessoryView = lowContrast;
        }
    }

    return cell;
}

#pragma mark - Nav bar stuff
- (NSString *)title {
    NSBundle *tweakBundle = YTMusicUltimateBundle();
    return LOC(@"THEME_SETTINGS");
}

- (UIBarButtonItem *)backButton {
    UIBarButtonItem *item;

    if (@available(iOS 13, *)) {
        item = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"chevron.left"]
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(back)];
    } else {
        NSBundle *tweakBundle = YTMusicUltimateBundle();
        item = [[UIBarButtonItem alloc] initWithTitle:LOC(@"BACK")
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(back)];
    }

    return item;
}

@end

@implementation ThemeSettingsController (Privates)

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)toggleOledDarkTheme:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"oledDarkTheme_enabled"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"oledDarkTheme_enabled"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleOledDarkKeyboard:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"oledDarkKeyboard_enabled"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"oledDarkKeyboard_enabled"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)toggleLowContrast:(UISwitch *)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"lowContrast_enabled"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"lowContrast_enabled"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end