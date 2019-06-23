    var g_pageCount;
    var page=$(".page_input").val();
    var state=$("input[name = 'state']")[0].value;
    state=config_default.userState[state];
    $("input[name = 'state']")[0].checked='checked';
        show();
//      充值
    $("#charge-money").click(function() {
    	var uid=$("#agentLocalID").val();
    	if(uid=='')
		{
			alert("请输入玩家id");
			return false;
		}
   	    $('.charge-money-list').css('display','block');
   	    $('.change_page').css('z-index','-1');
   	    
   	    $("#charge-quit").click(function() {
   	 		$('.charge-money-list').css('display','none');
   	 		$('.change_page').css('z-index','0');
   	    });  
});

 $("#charge-sure").click(function() {
	var uid=$("#agentLocalID").val();
	var value_m=$(".value-money").val();
	var value_g=$(".value-gold").val();
	
	if(value_g=='')
	{
		value_g=0;
	}
	if(value_m=='')
	{
		value_m=0;
	}
	$.ajax({
		type: "post",
		url: config.baseUrl + "/adminRecharge",
		async: false,
		crossDomain: true,
		data: {
			'uid': uid,
			'Aid':Aid,
			'token':token,
			'money':value_m,
			'gold': value_g
		},
		dataType: 'json',
		success: function(data) {

			console.log(data);
			var code = data.errorcode;
			if(code==0){			
				alert("充值成功！");
				var data = $(".money-"+uid).html();
				data = parseInt(data)+parseInt(value_m);
				$(".money-"+uid).html(data);
				$(".value-money").val('');
				$(".value-gold").val('')
				$('.charge-money-list').css('display','none');	
				console.log(this);
			}else{
				alert("充值失败！");
			}
		},
		error: 
		function(xhr, type, errorThrown) {
			//异常处理；
//			mui.toast('服务器异常!');
			serve_error();
        }
    });
});

//      	拉取数据
function show() {
	console.log('page='+page);
    console.log('state='+state);
	$.ajax({
		type: "post",
		url: config.baseUrl + "/adminGetDelegate",

		async: false,
		crossDomain: true,
		data: {
			'Aid':Aid,
			'token':token,
			'state':state,
			'page':page
		},
		dataType: 'json',
		success: function(data) {
console.log(data);
                       //得到错误码
						var code = data.errorcode;
						console.log(data);
						if(code==0){
							$('.countNum')[0].innerHTML=data.pageCount;
							g_pageCount=data.pageCount;
							analysisData(data.deleInfo);
						}
						else
						{
							//错误报表
							alert(config_errordata[code]);
						}

		},
		error: 
		function(xhr, type, errorThrown) {
			//异常处理；
//			mui.toast('服务器异常!');
		    serve_error();
		}

	});
}//			解析数据
			function analysisData(data)
			{
				console.log(data);
				var html_l='';
//				遍历数组  index索引关键字（114等）
				$.each(data, function(index,item) {
					console.log(data[index]);
					var a;
					var flage,sex,f,f2,f3,f4;
					if(item.onLine)
					{
						a='btu_yes';
						flage='是';
					}
					else
					{
						a='btu_no';
						flage='否';
					}
					if(item.gender==1)
					{
						sex='男';
					}
					else
					{
						sex='女';
					}
			        switch(item.dlevel){
			        	case 0:
			        	f="selected='selected'";f1=f2=f3='';break;
			        	case 1:
			        	f1="selected='selected'";f=f2=f3='';break;
			        	case 2:
			        	f2="selected='selected'";f=f1=f3='';break;
			        	case 3:
			        	f3="selected='selected'";f=f1=f2='';break;
			        }
			        var txt;
					if(item.parent==undefined||item.parent=='0')
					{
						txt='<input type="text" class="th4"  />';
					}
					else{
						txt='<input type="text" class="th4"  disabled="disabled" value='+item.parent+' />';
					}

			    console.log("item.money");
				html_l+="<tr><td class='agentAllID-"+item.dgid+"'>"+item.dgid+"</td><td class='agentLocalID-"+item.account+"'>"+item.account+"</td><td class='agentLocalID-"+item.dgid+"'>"+item.did+"</td><td class='nick-"+item.dgid+"'>"+item.nick+"</td><td class='sex-"+item.dgid+"'>"+sex+"</td><td><button type='button' class='btu td_btu_small "+a+"'>"+flage+"</td><td class='logintime-"+item.dgid+"'>"+item.logintime+"</td><td>"+item.totalmoney+"</td><td>"+item.rmb+"</td><td>"+item.awards+"</td><td class='money-"+item.did+"'>"+item.money+"</td><td>"+item.shareawards+"</td><td>"+item.newawards+"</td><td>"+item.levelawards+"</td><td>"+item.actawards+"</td><td class='equipid-"+item.dgid+"'>"+item.equipid+"</td><td class='lastagent-"+item.dgid+"'>"+txt+"</td><td><select onchange='getuseragency("+item.dgid+","+item.did+","+item.dlevel+",this.value,"+item.parent+")' class='select-"+item.dgid+"'><option value='0' "+f+">玩家</option><option value='1' "+f1+">一级代理</option><option value='2' "+f2+">二级代理</option><option value='3' "+f3+">三级代理</option></select></td><td id='"+item.dgid+"' class='content'>详情</td></tr>";		
			});
				$('.test').html(html_l);
				$('.pageNum')[0].innerHTML=page;
				contentList();
			}
//			详情的点击函数
			function contentList()
			{
				$('.content').click(function(){
				   var id_l=this.id;
				   console.log(id_l);
				   var class_dgid='agentAllID-'+id_l;
				   var class_did='agentLocalID-'+id_l;
				   var class_nick='nick-'+id_l;
				   var class_equipid='equipid-'+id_l;
				   var class_dlevel='select-'+id_l;
				   var value_dgid=document.getElementsByClassName(class_dgid)[0].innerText;	
				   var value_did=document.getElementsByClassName(class_did)[0].innerText;
				   var value_nick=document.getElementsByClassName(class_nick)[0].innerText;
				   var value_equipid=document.getElementsByClassName(class_equipid)[0].innerText;
				   var value_dlevel=$('.'+class_dlevel+' option:selected').text();
				   $(".agentAllID").val(value_dgid);
				   $(".agentLocalID").val(value_did);
				   $(".nick").val(value_nick);
				   $(".equipid").val(value_equipid);
				   $(".select").val(value_dlevel);
			 });
			}
			
			
	
	/*为每个代理信息添加点击事件
	variate:获取到的代理id作为变量
	did：代理本地id
	dlevel：此玩家的原始级别
	newlv：此玩家的新级别
	oldtext：原始的上级代理id*/	
	function getuseragency(variate,did,dlevel,newlv,oldtext)
	{
		var result=confirm('你是否要更改信息');
		if(result==true)
		{
			var parent;
			var agencyid=$('.lastagent-'+variate+' input');
			if(agencyid.val()!=''&&agencyid.val()!=oldtext)
			{
				parent=agencyid.val();
				agencyid.disabled='disabled';
			}
			else
			{
				parent=-1;
			}
			$.ajax({
				type:"post",
				url:config.baseUrl+"/adminChangeDInfo",
				async:true,
				data:{
					'Aid':Aid,
					'token':token,
					'did':did,
					'oldlv':dlevel,
					'newlv':newlv,
					'parent':parent
				},
				dataType:'json',
				success:function(data){						
					console.log(data);
					if(data.errorcode==0)
					{
						window.location.reload(); 
					}
					else if(data.errorcode==20)
					{
						alert('没有找到此用户');
						window.location.reload(); 
					}
					else if(data.errorcode==23)
					{
						alert('代理等级错误');
						window.location.reload(); 
					}

				},
				error:
				function(xhr, type, errorThrown) {
//					mui.toast('服务器异常!');
				    serve_error();
				}
			});
		}
		else{
			window.location.reload();
		}
	}