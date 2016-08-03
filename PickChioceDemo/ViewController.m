//
//  ViewController.m
//  PickChioceDemo
//
//  Created by liujie on 16/8/3.
//  Copyright © 2016年 liujie. All rights reserved.
//

#import "ViewController.h"
#import "PickChoiceView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,LJPickerDelegate>{
    
    NSInteger selectIndex;
    
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSIndexPath *touchRow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"男",@"1993年11月01日",@"", nil];
    
    [self createTabele];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)createTabele{
    UITableView *modifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    modifyTableView.backgroundColor = [UIColor grayColor];
    modifyTableView.delegate = self;
    modifyTableView.dataSource = self;
    self.mainTableView = modifyTableView;
    [self.view addSubview:self.mainTableView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifierStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierStr];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = self.dataArr[indexPath.row];

            break;
        case 1:
            cell.textLabel.text = @"生日";
            cell.detailTextLabel.text = self.dataArr[indexPath.row];
            break;
        case 2:
            cell.textLabel.text = @"身高";
            cell.detailTextLabel.text = self.dataArr[indexPath.row];
            break;
        default:
            break;
    }
    
        
    
    cell .accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        PickChoiceView *picker = [[PickChoiceView alloc] initWithFrame:self.view.bounds];
        selectIndex = indexPath.row;
        picker.delegate = self;
        switch (indexPath.row) {
            case 0:
                picker.arrayType = GenderArray;
                break;
            case 1:
                picker.arrayType = dateArray;
                break;
            case 2:
                picker.arrayType = heightArray;
                break;
            default:
                break;
        }
        [self.view addSubview:picker];
         _touchRow = indexPath;
        
}
#pragma mark -------- TFPickerDelegate


- (void)PickkerSelectorIndeixString:(NSString *)str{
    
    UITableViewCell *cell = [_mainTableView  cellForRowAtIndexPath:_touchRow];
    self.dataArr[_touchRow.row] = str;
    cell.detailTextLabel.text = str;
    
    [self.mainTableView reloadData];
}

@end
