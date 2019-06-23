$(function(){
	$.ajax({
		type:"post",
		url:config.baseUrl+"/deleWxLogin",
		async:true,
		dataType:'json',
		data:{
			'deleName':1,
			'passWord':123456
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
        			
        			
        			
				    window.location.href="../../../index.html";
				   
          			
        		}else{
        			alert("用户名或密码错误!");
        		}
		}
	});
	
	
//	$("#login").click(function(){
//      				window.location.href="../../../index.html";
//      	});
//	
});