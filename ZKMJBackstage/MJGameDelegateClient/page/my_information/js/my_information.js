$(function(){
	$("#agent_number").val(did);
	$("#agent_id").val(did);
	$("#agent_account").val();
	$("#name").val(nick);
	$("#agent_name").val(level);
    $("#join_time").val(logintime);
})
//修改密码
	$("#submit").on('click', function(e) {
		var btnArray = ['取消', '确定'];
		mui.prompt('','请输入新密码','修改密码',btnArray,function changepwd(e){
			if (e.index == 1) {
            	var newpwd=document.querySelector('.mui-popup-input input').value;
            	alert("修改密码成功！"+newpwd);
            	
            	  $(function(){
			
					$.ajax({
						type:"post",
						url:config.baseUrl+"/deleChangePassword",
						async:true,
						data:{
							'uid':did,
							'passWord':newpwd
							},
							success:function(data){
								if(data.errorcode==0){
									console.log(data);
								}
								//跳转至登录页面
								window.location.href="../../../index.html"
							}
						});
					});

				            	
            } else {
            	alert("你已取消修改密码！");
            }
		},'div');
		document.querySelector('.mui-popup-input input').type='password' 

    });	



