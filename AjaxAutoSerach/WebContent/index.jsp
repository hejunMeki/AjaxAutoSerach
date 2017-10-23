<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <style type="text/css">
      #mydiv{
        position: absolute;
        left: 50%;
        top:50%;
        margin-left: -200px;
        margin-top: -50px;
      }
      .mouseOver{
      background:#cdcdcd;
      color:#FFFAFA;
      }
      .mouseOut{
      background:#FFFAFA;
      color:#000000;
      }
      
    </style>
  <script type="text/javascript">
      var xmlHttp;
     function getMoreContents(){
         //获得用户的输入
         var content=document.getElementById("keyword");
         //如果输入为空
         if(content.value==""){
             //清空
             clearContent();
             return;
         }
        //给服务器发送用户输入的内容，采用XmlHttp对象来ajax异步发送数据
         xmlHttp=creareXMLHttp();
        //向服务器发送数据，通过URL  escape对中文可以处理
         var url="ajaxSerach?keyword="+escape(content.value);
         //建立连接 true表示JavaScript脚本会在send发送之后继续执行，而不是一直等待服务器的响应
         xmlHttp.open("GET",url,true);
         //xmlHttp绑定一个回调方法 用于接受服务器的响应 xmlHttp状态改变时被调用
        //xmlHttp的状态0---4    我们只关心4，此时交互才完成
         //完成之后调用回调函数才有意义
         xmlHttp.onreadystatechange=clback;
         xmlHttp.send(null);
     }

      //显示数据
      function setContent(contents) {
         //清空之前的数据
          clearContent();
         //设定关联信息的位置
         setLocation();
          //获取数据的长度 判断生成多少行
          var size=contents.length;
          //设置内容
          for(var i=0;i<size;i++){
              //文本内容
              var nextNode=contents[i];   //contents[i]代表返回结果的第i个元素
              //动态生成tr和td等节点
              var tr=document.createElement("tr");
              var td=document.createElement("td");
              td.setAttribute("border","0");
              td.setAttribute("bgcolor","#FFFAFA");
              //鼠标滑过
           		td.onmouseover=function(){
            	  //样式
                  this.className='mouseOver';
              };   
              //鼠标移出
              td.onmouseout=function(){
            	  //样式
                  this.className='mouseOut';
              };
              //点击鼠标选择关联数据时，关联数据显示在输入框
              td.onclick=function () {
					

              };
              var text=document.createTextNode(nextNode);
              td.appendChild(text);
              tr.appendChild(td);
              document.getElementById("content_table_body").appendChild(tr);
          }

      }

     //获得xmlhttp对象
     function creareXMLHttp() {
         //对于大多数的浏览器
         var xmlHttp;
         //如果支持这种
         if(window.XMLHttpRequest){
             xmlHttp=new XMLHttpRequest();
         }
         //或者这种
         if(window.ActiveXObject){
             xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
             //如果该参数不支持
             if(!xmlHttp) {
                 xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
             }
         }
         return xmlHttp;
     }
      //回调函数
      function clback() {
          //服务器响应
          if(xmlHttp.readyState==4){
              //成功响应 200
              if(xmlHttp.status==200){
                  //交互成功，获取响应的文本格式
                  var result=xmlHttp.responseText;
                  //解析获得的数据 最外层加小括号
                  var json=eval("("+result+")");
                  //动态显示这些数据，展示到输入框下面                 
                  setContent(json);
              }
              else{
                  alert(xmlHttp.status);
              }
          }
      }
      //清空数据 tbbody里面的数据
    function  clearContent() {
        var contentTableBody=document.getElementById("content_table_body");
        var size=contentTableBody.childNodes.length;
        //从后往前删
        for(var i=size-1;i>=0;i--)
        {
            //删除指定的子节点
            contentTableBody.removeChild(contentTableBody.childNodes[i]);
        }
        //清空边框
        document.getElementById("popDiv").style.border="none";
    }
    //失去焦点 关联信息清空
    function keywordBlur() {
         clearContent();
    }
    //设置关联信息的位置
    function setLocation() {
		//位置和输入框一致
		var content=document.getElementById("keyword");
		//输入框的宽度
		var width=content.offsetWidth;
		//距离左边框距离
		var left=content["offsetLeft"];
		//关联信息距离顶部距离
		var top=content["offsetTop"]+content.offsetHeight;
		//获取显示数据的div
		var popDiv=document.getElementById("popDiv");
		//设置边框
		popDiv.style.border="black 1px solid";
		//设置到左边框距离
		popDiv.style.left=left+"px";
		//设置距离上边框距离
		popDiv.style.top=top+"px";
		//设置div的宽度
		popDiv.style.width=width+"px";
		document.getElementById("content_table").style.width=width+"px";
	} 
  </script>
    <title>智能搜索框</title>
  </head>
  <body>
    <div id="mydiv">
      <!--输入框  onblur失去焦点 onfocus获得焦点 onkeyup当一个非系统键被释放的时候，框架调用这个成员函数-->
      <input type="text" size="50" id="keyword" onblur="keywordBlur()" onfocus="getMoreContents()" onkeyup="getMoreContents()"/>
      <input type="button" value="搜索" width="50px" />
      <!--内容展示的区域-->
      <div id="popDiv">
        <table id="content_table" bgcolor="#FFFAFA" border="0" cellpadding="0" cellspacing="0">
          <tbody id="content_table_body">
              <!--数据动态显示的地方-->
          </tbody>
        </table>
      </div>
    </div>
  </body>
</html>
