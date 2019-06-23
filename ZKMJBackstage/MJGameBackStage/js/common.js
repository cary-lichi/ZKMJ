//禁止页面滚动
    document.documentElement.style.overflow='auto';
//禁止页面左右滚动
    document.documentElement.style.overflowX='hidden';
    
    var nickName=localStorage.getItem('nickName');
    var Aid=localStorage.getItem('Aid');
    var token=localStorage.getItem('token');
    var passWord=localStorage.getItem('passWord');
    
//  $('#current_name')[0].innerText = nickName;
    //服务器异常
    function serve_error()
    {
    	alert("网络异常,请重新登录！");
    	window.location.href = "../index.html";
    }
    //页
