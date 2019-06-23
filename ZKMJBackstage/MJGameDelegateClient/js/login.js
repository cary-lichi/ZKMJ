$('#login').on('click',function(){
	var deleName=$('#inputsfirst').val();
	var passWord=$('#inputssecond').val();
	if(deleName==""){
		alert("请输入用户名");
	}
	else if(passWord==""){
		alert("请输入密码");
	}
	else if(deleName==""&&passWord==""){
		alert("请输入用户名及密码");
	}
	else{
		$.ajax({
		type:"post",
		url:config.baseUrl+"/deleWxLogin",
		async:true,
		dataType:'json',
		data:{
			'deleName':deleName,
			'passWord':passWord
		},
		success:function(data){
			console.log(data);
			if(data.errorcode==0)
      		{
      			localStorage.setItem('did',data.deleInfo.did);
      			localStorage.setItem('gender',data.deleInfo.gender);
      			localStorage.setItem('headimg',data.deleInfo.headimg);
      			localStorage.setItem('icode',data.deleInfo.icode);
      			localStorage.setItem('level',data.deleInfo.level);
      			localStorage.setItem('money',data.deleInfo.money);
      			localStorage.setItem('nick',data.deleInfo.nick);
      			localStorage.setItem('logintime',data.deleInfo.logintime);
				window.location.href="page/admin_info/admin_info.html";
				   
        			
      		}else{
      			alert("用户名或密码错误!");
      		}
		},
		error:function(xhr,status,error){
//						(data);
			console.log(error);
			mui.alert("服务异常请确定已连接网络后尝试","提示",function(){});
		}
	});
	}
	
})


