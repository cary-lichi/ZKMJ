setUserInfo();
function setUserInfo(){
	//------微信中对当前网址进行判断
			var reUrl = location.href;
			if(reUrl.length < 0) {
				var url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx5d11076d0c7f9cc2&redirect_uri=http%3a%2f%2fwx.tianhgame.com%2fwxGamePay%2fWxpayAPI_php_v3%2fexample%2foauth2.php&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
				location.href = url;
			} else {
				//url获取后台带回来的数据
				var Request = new UrlSearch();
				var openid = Request.openid;
				var name = decodeURI(Request.nickname);
				var headimgurl = Request.headimgurl;
				var roomid = Request.roomid;
				var userInfo = {"openid":openid,"name":name,"headimgurl":headimgurl,"roomid":roomid};
				return userInfo;
				
			}

			//------获取地址参数函数
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
}