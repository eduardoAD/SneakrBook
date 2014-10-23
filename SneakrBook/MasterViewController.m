//
//  MasterViewController.m
//  SneakrBook
//
//  Created by Eduardo Alvarado Díaz on 10/23/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Person.h"

@interface MasterViewController ()
@property NSArray *friends;

@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

}

-(void)loadData{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];

    request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
    self.friends = [self.managedObjectContext executeFetchRequest:request error:nil];

    NSLog(@"Number people: %lu",self.friends.count);
    if (self.friends.count == 0) {
        NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            self.friends = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
            for (NSString *name in self.friends) {
                [self savePeopleWithName:name
                                  height:[[NSNumber alloc] initWithInt:arc4random_uniform(10)+1]];
            }
            [self loadData];
        }];
    }

    [self.tableView reloadData];
}

-(void)savePeopleWithName:(NSString *)name height:(NSNumber *)height{
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    person.name = name;
    person.height = height;

    [self.managedObjectContext save:nil];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController *detail = segue.destinationViewController;

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Person *person = [self.friends objectAtIndex:indexPath.row];
        detail.detailItem = person;
    }
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Person *person = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;

    return cell;
}


@end
