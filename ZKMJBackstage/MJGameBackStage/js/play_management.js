 	var g_pageCount;
    var page=$(".page_input").val();
    var state=$("input[name = 'state']")[0].value;
    state=config_default.userState[state];
    $("input[name = 'state']")[0].checked='checked';
 
 show();
 //      搜索 查询
        $('#search').click(function(){
//      	var uid=$(".agentLocalID").val();
        	var ggid=$(".agentAllID").val();
			var nick=$(".nick").val();
        	var gid=$(".agentLocalID").val();
        	console.log('gid='+gid);
        	console.log("ggid="+ggid);
//      	console.log(gid);
        	$.ajax({
		type: "post",
		url: config.baseUrl + "/adminSearch",
		async: false,
		crossDomain: true,
		data: {
			'page':page,
			'Aid':Aid,
			'token':token,
			'ggid':ggid,
			'nick':nick,
			'gid':gid
//			'uid': uid
		},
		dataType: 'json',
		success: function(data) {

			console.log('28data');
			console.log(data);
			
//			$(".agentAllID").val(data[uid].ggid);
//			$(".nick").val(data[uid].nick);
//			$(".equipid").val(data[uid].equipid);
            //得到错误码
			var code = data.errorcode;
			if(code==0){
							console.log('查询成功');
							console.log(data.userInfo[code].ggid);
							$(".agentAllID").val(data.userInfo[code].ggid);
			                $(".nick").val(data.userInfo[code].nick);
			                $(".equipid").val(data.userInfo[code].equipid);
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
//			mui.toast('服务器异常1');
            serve_error();
        }
    });
        });
//      	拉取数据
	function show(){ 
//		state();
		console.log('page='+page);
		console.log('state='+state);
			$.ajax({
					type:"post",
					url:config.baseUrl+"/adminGetUser",

					async:false,
					crossDomain:true,
					data:{
						'page':page,
						'Aid':Aid,
						'token':token,
						'state':state
						
					},
					dataType:'json',
					success: function(data){
						//得到错误码
						var code = data.errorcode;
//						console.log('ceshi'+config_errordata[code]);
						console.log(data);
						if(code==0){
							$('.countNum')[0].innerHTML=data.pageCount;
							g_pageCount=data.pageCount;
							analysisData(data.userInfo);
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
//					mui.toast('服务器异常!');
					serve_error()
				}	
			});
		}
//			解析数据
	function analysisData(data)
			{
				var html_l='';
//				遍历数组  index索引关键字（114等）
				$.each(data, function(index,item) {
//					console.log(data[index]);
					var a;
					var flage,sex,ban,kick;
					if(item.online)
					{
						
						a='btu_yes';
						flage='是';
						//console.log(item.onLine);
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
					if(item.canForbid)
					{
						forbid='封禁';
					}
					else
					{
						forbid='解禁';
					}	
			   if(item.room)
			   {
			   	
			   	html_l+="<tr><td>"+item.ggid+"</td><td>"+item.gid+"</td><td>"+item.nick+"</td><td>"+sex+"</td><td><button type='button' class='btu td_btu_small "+a+"'>"+flage+"</td><td>"+item.logintime+"</td><td>"+item.money+"</td><td>"+item.rmb+"</td><td>"+item.gold+"</td><td><button type='button'  class='btu td_btu_big red_true'>踢出</button></td><td><button type='button' class='btu td_btu_big td_btu_blue'>"+forbid+"</button></td><td><button type='button' class='btu td_btu_big btu_green'>代理详情</button></td><td>"+item.source+"</td></tr>";		
			   }else{
			   	html_l+="<tr><td>"+item.ggid+"</td><td>"+item.gid+"</td><td>"+item.nick+"</td><td>"+sex+"</td><td><button type='button' class='btu td_btu_small "+a+"'>"+flage+"</td><td>"+item.logintime+"</td><td>"+item.money+"</td><td>"+item.rmb+"</td><td>"+item.gold+"</td><td><button type='button'  disabled='disabled' class='btu td_btu_big red_false'>踢出</button></td><td><button type='button' class='btu td_btu_big td_btu_blue'>"+forbid+"</button></td><td><button type='button' class='btu td_btu_big btu_green'>代理详情</button></td><td>"+item.source+"</td><td><select  class='select-"+item.ggid+"' onchange='getuseragency("+item.gid+")'><option value='0'>玩家</option><option value='3'>三级代理</option></select></td></tr>";
			   }
			   
			   //不在房间的禁止点击
//			   $("#red_false").click(function(){
//			   	
//			   	alert("123");
//			   	$("this").CSS("disabled",'false');
//			   	
//			   });
			   
			   
				
			});
				$('.test').html(html_l);
				$('.pageNum')[0].innerHTML=page;
				ban();kick();
			}
//          封禁效果
	function ban(){  		 
        $(".td_btu_blue").click(function(){
	    	       var trr = $(this).parent().parent();
			       $this = this;
			       var flag;
				   var tdd = trr.children();
				   var gid = tdd[1].innerHTML;
				   var btu_val=this.innerText;
//				   var Aid=localStorage.getItem("Aid");
//				   var token=localStorage.getItem("token");
				   console.log(btu_val); 
				   if(btu_val=='封禁'){
				   	  flag=1;
				   }
				   else{
				   	flag=0;	
				   }
				var confirm1=confirm('确定'+btu_val+'吗?');
                if(confirm1){
					$.ajax({
							type: "post",
							url: config.baseUrl + "/adminBanGamer",
							async: false,
							dataType: 'json',
							data: {
								'gid': gid,
								'forbid':flag,
								'Aid':Aid,
								'token':token
							},
							success: function(data) {
								console.log(data);
								console.log(gid);
//								console.log($this);
                                checkToken();
                                if(data.errorcode==config_error.success){
								if(flag==1){				
									$this.innerHTML='解禁';
									flag=0;								
								}
                             else{
                             	$this.innerHTML='封禁';
                             	flag=1;                          	
                             }}
                               else if(data.errorcode==config_error.adminRights){
                               	alert("你没有权限！");
                               }
							}
					});	
				}
       }); 
   } 
//踢出
			function kick(){
				$(".red_true").click(function(){
				//定义$this 为当前点击的按钮	
				$this = this;
				
			
				confirm_1=confirm("确定要踢出本玩家？");
				if(confirm_1)
				{
					var Aid=localStorage.getItem('Aid');
					var token=localStorage.getItem('token');
					//获取当前点击按钮的tr
					var trr=$(this).parent().parent();
					var b=trr.children();
					//定义id为游戏ID名
					var id=b[1].innerHTML;
			
					
					$.ajax({
						type:"post",
						url:config.baseUrl+"/adminKickGamer",
						async:false,
						crossDomain:true,
						data:{
							'Aid':Aid,
							'token':token,
							'id':id
						},
						dataType:'json',
						success: function(data){
							if(data.errorcode==config_error.success)
							{
								alert("操作成功!");
								 //按钮不可点击
								$this.disabled = true;
								$this.style.backgroundColor="#DDDDDD";  
								$this.style.borderColor="#DDDDDD";
							}
							else if(data.errorcode==config_error.notinroom){
							    alert(config_errordata[data.errorcode]);	
							}
							
						},
					     error:
					     function(xhr, type, errorThrown) {
						//异常处理；
//						mui.toast('服务器异常！');
					   serve_error();
					     }
					
				    });
		        }
				else{
					return 0;
				}
			});
			}
			
			/*为每个代理信息添加点击事件
			gid:获取到的代理id作为变量*/			
			function getuseragency(gid)
			{
				var result=confirm('你是否要更改信息');
				if(result==true)
				{
					var dlevel=0;
					var newlv=3;
					var parent=-1;
					$.ajax({
						type:"post",
						url:config.baseUrl+"/adminChangeDInfo",
						async:true,
						data:{
							'Aid':Aid,
							'token':token,
							'did':gid,
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
						}
					});
				}
				else{
					window.location.reload();
				}
			}
