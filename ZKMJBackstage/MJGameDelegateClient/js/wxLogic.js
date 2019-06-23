/*
 * 
 * 游戏初始获取微信数据页面
 * 
 */
var reUrl = location.href;
//全局ID
var openid;     
var name;
var sex;
var headimgurl;
var payid;

	
//url获取后台带回来的数据
var Request = new UrlSearch();
//unionid 唯一的标识 后期版本修改将unionid作为openid
openid = Request.unionid;
payid = Request.openid;
name = decodeURI(Request.nickname);
sex = Request.sex;
roomid = Request.roomid;
inviterID = Request.inviterID;
headimgurl = Request.headimgurl;


function UrlSearch() {
                    var name, value;
                    var str = reUrl; //取得整个地址栏
                    var num = str.indexOf("?")
                    str = str.substr(num + 1); //取得所有参数   stringvar.substr(start [, length ]
                    var arr = str.split("&"); //各个参数放到数组里
                    for(var i = 0; i < arr.length; i++) {
                        num = arr[i].indexOf("=");
                        if(num > 0) {
                            name = arr[i].substring(0, num);
                            value = arr[i].substr(num + 1);
                            this[name] = value;
                        }
                    }
                }

/*
function get(uri) {
                return http(uri, 'GET', null);
            }

function http(uri, method, data, headers) {
    //alert('promise: ' + typeof Promise);
    return new Promise(function(resolve, reject) {
        var xhr = new XMLHttpRequest();
        xhr.open(method, uri, true);
        if(headers) {
            for(var p in headers) {
                xhr.setRequestHeader(p, headers[p]);
            }
        }
        xhr.addEventListener('readystatechange', function(e) {
            if(xhr.readyState === 4) {
                if(String(xhr.status).match(/^2\d\d$/)) {
                    try {
                        var data = JSON.parse(xhr.responseText);
                        resolve(data);
                    }
                    catch(e) {
                        reject(e);
                    }
                }
                else {
                    reject(xhr);
                }
            }
        });
        xhr.send(data);
    });
}
            
function wechatShare(cfg) {
    var inter = setInterval(function() {
        try {
            wx.config(cfg);
            clearInterval(inter);
        }
        catch(e) {
            console.log('wait ready');
        }
    }, 200);

    wx.ready(function() {
        //分享到微信朋友圈
        wx.onMenuShareTimeline({
            title: name + '邀您一起玩麻将，最地道的本地麻将，局组起来', // 分享标题
            link: 'http://wx.tianhgame.com/wxFirst/index.html', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
            //imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            success: function() {
                // 用户确认分享后执行的回调函数
                //alert('朋友圈分享成功');
            },
            cancel: function() {
                // 用户取消分享后执行的回调函数
            }
        });

        //分享到微信好友
		
        wx.onMenuShareAppMessage({
            title: name + '邀您一起组局打牌', // 分享标题
            desc: name + '分享了微信打牌神器官方『地道黑龙江棋牌』，无需下载，即点即玩。专业防外挂，服务器稳定。', // 分享描述
            link: 'http://wx.tianhgame.com/wxFirst/index.html', // 
            imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            type: '', // 分享类型,music、video或link，不填默认为link
            dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
            success: function() {
                //alert('好友分享成功');
            },
            cancel: function() {
                // 用户取消分享后执行的回调函数
            }
        });
		

        //分享到QQ好友
        wx.onMenuShareQQ({
            title: name+'邀您一起组局打牌', // 分享标题
            desc: name+'分享了微信打牌神器官方『地道黑龙江棋牌』，无需下载，即点即玩。专业防外挂，服务器稳定。', // 分享描述
            link: 'http://wx.tianhgame.com/wxFirst/index.html', // 分享链接
            imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
            }
        });

        //分享到QQ空间
        wx.onMenuShareQZone({
            title: name+'邀您一起玩麻将，最地道的本地麻将，局组起来', // 分享标题
            desc: name+'分享了微信打牌神器官方『地道黑龙江棋牌』，无需下载，即点即玩。专业防外挂，服务器稳定。', // 分享描述
            link: 'http://wx.tianhgame.com/wxFirst/index.html', // 分享链接
            imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
            }
        });
    });

    wx.error(function(res) {
        alert("服务器错误，请重试...");
    });
}

function regConfig() {
    var uri = 'http://wx.tianhgame.com/wxFirst/jssdk/wxShare/jssdk.php' +
        '?url=' + window.btoa(location.href);
    get(uri).then(function(data) {
        //data.debug = true;
        data.debug = false;
        wechatShare(data);
    }).catch(function(err) {
        //alert('request error:' + err);
    });
}

window.onload = function() {
    setTimeout(regConfig, 600);
};

//点击按钮分享到微信好友
function btnShareAppMessage(roomid,inviterID)
{
        wx.onMenuShareAppMessage({
            title: name + '邀您一起打麻将速来,房间号：'+roomid, // 分享标题
            desc:  '『地道黑龙江棋牌』即点即玩，无需下载。专业防外挂，服务器稳定。', // 分享描述
            link: 'http://wx.tianhgame.com/wxFirst/index.html?roomid='+roomid+'&inviterID='+inviterID, 
            imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            type: '', // 分享类型,music、video或link，不填默认为link
            dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
            success: function() {
                //alert('好友分享成功');
            },
            cancel: function() {
                // 用户取消分享后执行的回调函数
            }
        });
}
//分享到朋友圈奖励
function btnShareMessage(coller)
{
        wx.onMenuShareTimeline({
            title: name + '邀您一起玩麻将，最地道的本地麻将，局组起来', // 分享标题
            link: 'http://wx.tianhgame.com/wxFirst/index.html', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
            //imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            success: function() {
                // 用户确认分享后执行的回调函数
                //alert('朋友圈分享成功');
				coller.ShareSuccess();
            },
            cancel: function() {
                // 用户取消分享后执行的回调函数
            }
        });

        //分享到微信好友
		
        wx.onMenuShareAppMessage({
            title: name + '邀您一起组局打牌', // 分享标题
            desc: name + '分享了微信打牌神器官方『地道黑龙江棋牌』，无需下载，即点即玩。专业防外挂，服务器稳定。', // 分享描述
            link: 'http://wx.tianhgame.com/wxFirst/index.html', // 
            imgUrl: 'http://wx.tianhgame.com/wxFirst/img/512.png', // 分享图标
            type: '', // 分享类型,music、video或link，不填默认为link
            dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
            success: function() {
                //alert('好友分享成功');
				coller.ShareSuccess();
            },
            cancel: function() {
                // 用户取消分享后执行的回调函数
            }
        });
}


//微信公众号支付接口
function callpay(userId,goodsId,caller)
{
	 //caller.buyGoods(7);
    if (typeof WeixinJSBridge == "undefined"){
        if( document.addEventListener ){
            document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
        }else if (document.attachEvent){
            document.attachEvent('WeixinJSBridgeReady', jsApiCall);
            document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
        }
    }else{
        jsApiCall(userId,goodsId,caller);
    }
}

function jsApiCall(userId,goodsId,caller)
{
    goodsInfo = '?openid='+payid+'&userId='+userId+'&goodsId='+goodsId;
    var xhr=new XMLHttpRequest();
    xhr.onreadystatechange=function () {
        if(xhr.readyState==4 && xhr.status==200){
            var jsApiParameters = JSON.parse(xhr.responseText);
            WeixinJSBridge.invoke(
                'getBrandWCPayRequest',
                {
                    "appId":jsApiParameters['appId'],
                    "timeStamp":jsApiParameters['timeStamp'],
                    "nonceStr":jsApiParameters['nonceStr'],
                    "package":jsApiParameters['package'],
                    "signType":jsApiParameters['signType'],
                    "paySign":jsApiParameters['paySign']
                },
                function(res){
                    WeixinJSBridge.log(res.err_msg);
                    if(res.err_msg == 'get_brand_wcpay_request:ok')
                    {
                        //alert('支付成功');
						caller.buyGoods(goodsId);
                    }
                    else {
                        //alert('支付失败'+res.err_msg);
						//支付失败传空值
						caller.buyGoods();
                    }
                }
            );
        }
    }
	//xhr.open('GET','http://wx.tianhgame.com/wxFirst/jssdk/wxPay/example/test.php'+goodsInfo,true);
    xhr.open('GET','http://wx.tianhgame.com/wxFirst/jssdk/wxPay/example/jsapi.php'+goodsInfo,true);
    xhr.send(null);
	
}

*/