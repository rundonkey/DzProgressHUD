//
//  ViewController.m
//  Dz_BestNetworkRequest
//
//  Created by 李志学 on 17/2/14.
//  Copyright © 2017年 张达. All rights reserved.
//

#import "ViewController.h"
#import "DzNetWorkingWeapons.h"
#import "DzProgressHUD.h"
#import "tableViewForHeader.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * tableView;
@property(strong,nonatomic)NSMutableArray * dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupTableView];
}

-(void)setupTableView
{
    self.title = @"DzGroceryStories";
    _dataSource = [NSMutableArray arrayWithObjects:@"    网络请求菊花",@"    网络请求带提示菊花",@"    操作成功提示",@"    带文字提醒操作成功提示",@"    操作失败",@"    带文字提醒操作失败",@"    操作成功自动消失，自定义时间",@"    操作失败自动消失,自定义时间",@"    QQ提示框效果,缩放消失",@"    QQ提示框,平移消失",@"    gif加载图",@"    清除", nil];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"true.jpeg"]];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"systemCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [tableViewForHeader ceartHeaderView];
    _tableView.tableHeaderView.height = 80;
    _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"systemCell"];
    UIImageView * img  = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"successQQ.png"];
    img.frame = CGRectMake(10, (cell.height-20)/2, 20, 20);
    [cell.contentView addSubview:img];
    cell.textLabel.text =_dataSource[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
        
            [DzProgressHUD show:@""];
        }break;

        case 1:{
            [DzProgressHUD show:@"正在加载..."];
        }break;
            
        case 2:{
            [DzNetWorkingWeapons getWithUrl:@"https://www.ailetugo.com/newtourism/public/phoneinterface/main?page=1" parme:nil successful:^(id responseInfo) {
                NSLog(@"加载成功:%@",responseInfo);
            } faildError:^(NSError *error) {
                
            }];
        }break;
        case 3:{
            [DzProgressHUD showSuccess:@"加载完成"];
        }break;
        case 4:{
            [DzNetWorkingWeapons getWithUrl:@"https://www.ailetugo.com/newtourism/public/phoneinterface/man?page=1" parme:nil successful:^(id responseInfo) {
                NSLog(@"加载成功:%@",responseInfo);
            } faildError:^(NSError *error) {
                NSLog(@"操作失败:%@",error);
            }];
        }break;
        case 5:{
            [DzProgressHUD showFaild:@"加载失败"];
        }break;
        case 6:{
            [DzProgressHUD showSuccess:@"加载成功" intervalTime:1.0];
        }break;
        case 7:{
            [DzProgressHUD showFaild:@"加载失败" intervalTime:1.0];
        }break;
        case 8:{
            [DzProgressHUD showQQPromatBoxForGreenTitle:@"您已成功更换了帅帅的头像。"];
        }break;
            
        case 9:{
            [DzProgressHUD showQQPromatBoxForRedTitle:@"一天最多给好友点十个赞,去送礼物吧👍"];
        }break;
        
        case 10:{
            [DzProgressHUD showGifImage];
        }break;
        case 11:{
            [DzProgressHUD dismiss];
        }break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
