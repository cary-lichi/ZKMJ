function checkToken()
{
	console.log(localStorage.getItem("Aid"));
	console.log(localStorage.getItem("token"));
	if(localStorage.getItem("Aid")&&localStorage.getItem("token"))
	{
		var Aid=localStorage.getItem('Aid');
		var token=localStorage.getItem("token");
		var yes_no;
		$.ajax({
			type:"post",
			url:config.baseUrl+"/adminLoginHeart",
			data:{
				'Aid':Aid,
				'token':token
				},
			async:false,
			dataType:'json',
			success:function(data)
			{
				console.log(data);
				if(data.errorcode==0)
				{
					yes_no=true;
				}else{
					yes_no=false;
					quit();
					jump_login();		
				}
			},
			error:function(xhr,status,error)
			{
			    mui.toast("服务器出错！");	
			}
		});
		return yes_no;
	}else{
		console.log(localStorage.getItem("Aid"));
		console.log(localStorage.getItem("token"));
		jump_login();
		quit();
	}
}
//setInterval(checkToken,10000);
function  jump_login()
{
	window.location.href = "../index.html";
}


/*
 * 退出登录函数
 */
function quit() {
	localStorage.removeItem("token");
//	localStorage.removeItem("userDepart");
//	localStorage.removeItem("userRoleID");
//	localStorage.removeItem("userID");
	localStorage.removeItem("Aid");
	console.log("您已经退出");
	
}