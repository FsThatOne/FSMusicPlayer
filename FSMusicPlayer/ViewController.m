//
//  ViewController.m
//  FSMusicPlayer
//
//  Created by FS小一 on 15/12/2.
//  Copyright © 2015年 FSxiaoyi. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "FSMusicModel.h"
#import "FSStatus.h"
#import "FSMusicTools.h"
#import "FSMusicLrcTools.h"
#import "FSLrc.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
- (IBAction)playBtnClick:(UIButton *)sender;
- (IBAction)preMusicBtnClick;
- (IBAction)nextMusicBtnClick;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIView *groupView;
@property (weak, nonatomic) IBOutlet UILabel *zhuanji;

@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UIImageView *zhuanjiImage;
@property (weak, nonatomic) IBOutlet UILabel *lrc;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
- (IBAction)pauseBtnClick;

//当前播放歌曲的索引
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray *allMusics;

@property (nonatomic, strong) NSTimer *mainTimer;

//歌词  歌词模型  (时间   句子)
@property (nonatomic, strong) NSArray *allLrcList;

@end

@implementation ViewController
/*
 {
 "statuses": [
 {
 "created_at": "Tue May 31 17:46:55 +0800 2011",
 "id": 11488058246,
 "user": {
 "id": 1404376560,
 "name": "zaku"
 }
 },
 {
 "created_at": "Tue May 31 17:46:55 +0800 2011",
 "id": 11488058246,
 "user": {
 "id": 1404376560,
 "name": "zaku"
 }
 }
 ],
 "ad": [
 {
 "id": 3366614911586452,
 "mark": "AB21321XDFJJK"
 },
 {
 "id": 3366614911586452,
 "mark": "AB21321XDFJJK"
 }
 ],
 "total_number": 81655
 }
 */


- (NSArray *)allMusics
{
    if (!_allMusics) {
        _allMusics  = [FSMusicModel objectArrayWithFilename:@"mlist.plist"];
    }
    return _allMusics;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //_currentIndex = 3;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"products.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    FSStatus *status =  [FSStatus objectWithKeyValues:json];
    
    NSLog(@"%@",status);
    
    self.allMusics;
    
    //添加玻璃效果
    //toolBar
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    
    //样式
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [self.bgImageView addSubview:toolBar];
    //自动布局代码实现
    //autoreszing
    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *consV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[toolBar]-margin-|" options:0 metrics:@{@"margin" : @0} views:@{@"toolBar" : toolBar}];
    NSArray *consH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolBar]-0-|" options:0 metrics:nil views:@{@"toolBar" : toolBar}];
    
    //添加约束
    
    [self.bgImageView addConstraints:consV];
    [self.bgImageView addConstraints:consH];
    
    
    
    //导航栏的颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playBtnClick:(UIButton *)sender {
    
    //歌曲
    FSMusicModel *model = self.allMusics[_currentIndex];
    [[FSMusicTools shareMusicTool]playWithName:model.mp3];
    
    //暂停显示出来
    //paly隐藏
    self.pauseBtn.hidden = NO;
    self.playBtn.hidden = YES;
    
    //区分
    //切歌 的时候才需要变化
    //更新歌曲信息
    
    
    // 总时间  进度  专辑图片  标题 专辑 歌词
    NSTimeInterval timetotal = [[FSMusicTools shareMusicTool]totalTime];
    NSInteger mT = timetotal/60;
    NSInteger sT = (int)timetotal%60;
    self.totalTime.text = [NSString stringWithFormat:@"%02ld:%02ld",mT,sT];
    self.zhuanji.text = model.zhuanji;
    self.zhuanjiImage.image = [UIImage imageNamed:model.image];
    
    self.bgImageView.image = [UIImage imageNamed:model.image];
    
    self.singer.text = model.singer;
    self.title = model.name;
    
    //获取所有的歌词模型信息 放在数组中
    NSArray *allLrcList =  [FSMusicLrcTools lrcWithName:model.lrc];
    
    self.allLrcList = allLrcList;
    //不停的变化
    self.mainTimer =   [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(mainTimerUpdate) userInfo:nil repeats:YES];
    
}
//主定时器执行方法
//[00:19.00]曲：河合奈保子 词：向雪怀
//[00:42.00]这晚以后音讯隔绝
//[02:38.00]这晚以后音讯隔绝


- (void)mainTimerUpdate
{
    
    //歌曲
//    FSMusicModel *model = self.allMusics[_currentIndex];
    //[[CZMusicTool shareMusicTool]playWithName:model.mp3];
    
    
    //1.当前时间
    //00:00 当前时间
    NSTimeInterval time = [[FSMusicTools shareMusicTool]currentTime];
    NSInteger m = time/60;
    NSInteger s = (int)time%60;
    
    self.currentTime.text = [NSString stringWithFormat:@"%02ld:%02ld",m,s];
    //2.进度条
    self.progressView.progress = [[FSMusicTools shareMusicTool]progress];
    //3.歌词信息
    for (int i = 0 ; i < self.allLrcList.count ; ++i) {
        
        FSLrc *lrcCurrent = self.allLrcList[i];
        FSLrc *lrcNext = nil;
        if (i == self.allLrcList.count - 1) {
            lrcNext  = self.allLrcList[i];
        }else
        {
            lrcNext  = self.allLrcList[i+1];
        }
        
        //当前播放时间  大于 当前行的歌词  并且小于下一行的歌词 就显示当前行的歌词
        NSTimeInterval currentTime = [[FSMusicTools shareMusicTool]currentTime];
        
        if (currentTime >= lrcCurrent.time && currentTime < lrcNext.time) {
            NSLog(@"lrcCurrent.text = %@",lrcCurrent.text);
            self.lrc.text =  lrcCurrent.text;
        }
        
        
    }
    
    
    
}
- (IBAction)pauseBtnClick {
    
    //暂停播放歌曲
    [[FSMusicTools shareMusicTool]pause];
    //停止定时器
    [self.mainTimer invalidate];
    self.mainTimer = nil;
    
    
    self.pauseBtn.hidden = YES;
    self.playBtn.hidden = NO;
}

- (IBAction)preMusicBtnClick {
    _currentIndex =   _currentIndex == 0 ? self.allMusics.count - 1  : _currentIndex - 1;
    [self playBtnClick:nil];
}

- (IBAction)nextMusicBtnClick {
    _currentIndex =   _currentIndex == self.allMusics.count - 1 ? 0 : _currentIndex + 1;
    [self playBtnClick:nil];
    
}
@end
