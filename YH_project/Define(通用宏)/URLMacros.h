//
//  URLMacros.h
//  YH_project
//  定义服务器接口地址及开发环境
//  Created by Angzeng on 2018/5/14.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h

/**
 *项目网络请求集合
 */

//用户登录数据地址
#define YHurl_login                 @"http://zhujinchi.com/index.php/Mobile/Login/login"
//用户注册路径
#define YHurl_register              @"http://zhujinchi.com/index.php/Mobile/Register/register"
//获取文章
#define YHurl_article               @"http://zhujinchi.com/index.php/Mobile/Article/article"
//获取文章图片
#define YHurl_articleImage          @"http://zhujinchi.com/index.php/ArticleImage/articleImage"
//关注某用户动作
#define YHurl_focus                 @"http://zhujinchi.com/index.php/Mobile/Focus/focus"
//收藏某文章动作
#define YHurl_collect               @"http://zhujinchi.com/index.php/Mobile/Collect/collect"
//获取名人信息
#define YHurl_celebrity             @"http://zhujinchi.com/index.php/Mobile/Celebrity/celebrity"
//评论相关动作
#define YHurl_comment               @"http://zhujinchi.com/index.php/Mobile/Comment/comment"
//文章信息修改
#define YHurl_articleUpdate         @"http://zhujinchi.com/index.php/Mobile/ArticleUpdate/articleUpdate"
//签到动作
#define YHurl_signIn                @"http://zhujinchi.com/index.php/Mobile/SignIn/signIn"
//获取用户签到信息
#define YHurl_getSign               @"http://zhujinchi.com/index.php/Mobile/SignIn/getSign"
//获取用户特征信息
#define YHurl_feature               @"http://zhujinchi.com/index.php/Mobile/Feature/feature"
//获取匹配模型数据
#define YHurl_getModel              @"http://zhujinchi.com/index.php/Mobile/GetModel/getModel"
//用户头像上传
#define YHurl_avatarUpload          @"http://zhujinchi.com/index.php/Mobile/AvatarUpload/avatarUpload"
//文章上传路径
#define YHurl_articleUpload         @"http://zhujinchi.com/index.php/Mobile/ArticleUpload/articleUpload"
//问题获取路径
#define YHurl_question              @"http://zhujinchi.com/index.php/Mobile/Question/question"
//用户名搜索
#define YHurl_search                @"http://zhujinchi.com/index.php/Mobile/Search/search"
//用户名搜索，好友内搜索
#define YHurl_searchFriend          @"http://zhujinchi.com/index.php/Mobile/Search/searchFriend"
//名人特征路径
#define YHurl_famousfeature         @"http://zhujinchi.com/index.php/Mobile/FamousFeature/famousfeature"
//个人标签的获取与设置
#define YHurl_opLabel               @"http://zhujinchi.com/index.php/Mobile/Feature/opLabel"
//个人信息的获取与设置
#define YHurl_user                  @"http://zhujinchi.com/index.php/Mobile/User/user"
//通过uid获取用户信息
#define YHurl_getUserById           @"http://zhujinchi.com/index.php/Mobile/User/getUserById"
//通过uid修改用户信息
#define YHurl_modValue              @"http://zhujinchi.com/index.php/Mobile/User/modValue"
//融云token获取
#define YHurl_getToken              @"http://zhujinchi.com/index.php/Mobile/IMUser/getToken"
//查询群组
#define YHurl_getTeamByName         @"http://zhujinchi.com/index.php/Mobile/Team/getTeamByName"
//用户信息刷新
#define YHurl_refresh               @"http://zhujinchi.com/index.php/Mobile/IMUser/refresh"
//用户在线状态查询
#define YHurl_checkOnline           @"http://zhujinchi.com/index.php/Mobile/IMUser/checkOnline"
//好友列表
#define YHurl_friendList            @"http://zhujinchi.com/index.php/Mobile/Friend/friendList"
//请求添加好友
#define YHurl_getFriend             @"http://zhujinchi.com/index.php/Mobile/Friend/getFriend"
//拒绝添加好友
#define YHurl_rejectFriend          @"http://zhujinchi.com/index.php/Mobile/Friend/rejectFriend"
//接受添加好友
#define YHurl_agreeFriend           @"http://zhujinchi.com/index.php/Mobile/Friend/agreeFriend"
//开启好友请求好友
#define YHurl_openFriend            @"http://zhujinchi.com/index.php/Mobile/Friend/openFriend"
//关闭好友请求好友
#define YHurl_closeFriend           @"http://zhujinchi.com/index.php/Mobile/Friend/closeFriend"
//删除好友
#define YHurl_delFriend             @"http://zhujinchi.com/index.php/Mobile/Friend/delFriend"
//是否好友
#define YHurl_isFriend              @"http://zhujinchi.com/index.php/Mobile/Friend/isFriend"
//群组操作
#define YHurl_team                  @"http://zhujinchi.com/index.php/Mobile/Team/team"
//组信息路径
#define YHurl_teamUser              @"http://zhujinchi.com/index.php/Mobile/TeamUser/teamUser"
//获取群组用户列表
#define YHurl_getTeamById           @"http://zhujinchi.com/index.php/Mobile/Team/getTeamById"
//(直接加入无通知)加入群组
#define YHurl_joinTeamUser          @"http://zhujinchi.com/index.php/Mobile/TeamUser/joinTeamUser"
//踢出或者退出群组
#define YHurl_outTeamUser           @"http://zhujinchi.com/index.php/Mobile/TeamUser/outTeamUser"
//群主拉入多人进群
#define YHurl_addTeamUsers          @"http://zhujinchi.com/index.php/Mobile/TeamUser/addTeamUsers"
//解散群组用户列表
#define YHurl_adelTeamById          @"http://zhujinchi.com/index.php/Mobile/Team/delTeamById"
//查询用户是否在群组中
#define YHurl_isTeamUser            @"http://zhujinchi.com/index.php/Mobile/TeamUser/isTeamUser"
//向群主申请加入群
#define YHurl_getInTeam             @"http://zhujinchi.com/index.php/Mobile/TeamUser/getInTeam"
//群主同意某人加入群
#define YHurl_agreeInTeam           @"http://zhujinchi.com/index.php/Mobile/TeamUser/agreeInTeam"
//群主拒绝某用户加入群
#define YHurl_rejectInTeam          @"http://zhujinchi.com/index.php/Mobile/TeamUser/rejectInTeam"
//获取用户所在的群列表
#define YHurl_getTeamList           @"http://zhujinchi.com/index.php/Mobile/TeamUser/getTeamList"
//获取群组信息
#define YHurl_getTeamInfo           @"http://zhujinchi.com/index.php/Mobile/Team/getTeamInfo"
//群组信息更新
#define YHurl_updateTeamInfo        @"http://zhujinchi.com/index.php/Mobile/Team/updateTeamInfo"
//群组头像上传
#define YHurl_uploadAvatar          @"http://zhujinchi.com/index.php/Mobile/Team/uploadAvatar"
//短信接口
#define YHurl_sendSMS               @"http://zhujinchi.com/index.php/Mobile/SMS/sendSMS"
//多问题获取路径
#define YHurl_getQuestionsOfUser    @"http://zhujinchi.com/index.php/Mobile/Question/getQuestionsOfUser"
//52、名人文章获取
#define YHurl_CelebrityArticle      @"http://zhujinchi.com/index.php/Mobile/CelebrityArticle/article"
//


#endif /* URLMacros_h */
