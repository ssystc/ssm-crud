<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>

<!-- 找到web项目的webapp路径 -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>

	
	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <input type="text" name="empName" class="form-control" id="empName_input" placeholder="empName">
				      
				      <span class="help-block"></span>
				      
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_input" placeholder="email@163.com">
				    
				      <span class="help-block"></span>
				    
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				        <label class="radio-inline">
						    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="ckecked"> 男
						</label>
						<label class="radio-inline">
							<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
						</label>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-10">
				        <select class="form-control" name="dId" id="dept_select">

				        </select>
				    </div>
				  </div>
				  
				</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="add_emp_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	

	<!-- 搭建显示页面 -->
	<div class="container">
	
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		
		<!-- 删除和新增两个按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-success" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		
		<!-- 员工数据在表格中显示 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>departName</th>
							<th>操作</th>
						</tr>
					</thead>
					
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 显示分页信息 -->
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>

	</div>
	
	<script type="text/javascript">
		//总记录数，这个数一定大于页数
		var totalRecord;
	
		//页面加载完成后，直接发ajax请求，把结果展示出来
		$(function(){
			to_page(1);
		});
		
		//跳转到指定页码
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pageNum="+pn,
				type:"get",
				success:function(result){
					build_emps_table(result);
					buile_page_info(result);
					build_page_nav(result);
				}
			});
		}
		
		//解析员工数据
		function build_emps_table(result){
			
			//先清空
			$("#emps_table tbody").empty();
			
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn)
				$("<tr></tr>").append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd)
					.appendTo("#emps_table tbody");
			});
		}
		
		//解析分页信息
		function buile_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + 
					"页，总" + result.extend.pageInfo.pages +
					"页，总" + result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.total;
		}
		
		//解析分页数据
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage==false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
			if(result.extend.pageInfo.hasNextPage==false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum + 1);
				});
			}
			
			
			ul.append(firstPageLi).append(prePageLi);
			
			$.each(result.extend.pageInfo.navigatepageNums, function(index, item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active")
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//点击新增将弹出模态框
		$("#emp_add_modal_btn").click(function(){
			
			//先清除表单数据
			$("#empAddModal form")[0].reset();
			
			//发送ajax请求，查询所有部门的信息，显示在下拉选择列表中
			getDepts();
			
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//获取所有部门名称
		function getDepts(){
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//把部门信息显示在下拉选择中
					$.each(result.extend.depts, function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
						optionEle.appendTo("#empAddModal select");
					});
				}
			});
		}
		
		//校验表格中的数据
		function validate_add_form(){
			//拿到数据，使用正则表达式校验
			var empName = $("#empName_input").val();
			//校验用户名
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[u\2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//先清除样式，然后校验如果有错误，会友好的在输入姓名的列表中显示出校验不合格的原因
				show_validate_msg("#empName_input", "error", "用户名必须是2-5位中文或6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_input", "success", "");
			}
			//校验邮箱
			var email = $("#email_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//先清除样式，如果有错误，会友好的在输入email的列表中显示出校验不合格的原因
				show_validate_msg("#email_input", "error", "邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_input", "success", "");
			}
			
			return true;
		}
		
		//清除校验错误时加的样式
		function show_validate_msg(ele, status, msg){
			
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//校验用户名是否可用（即是否重复）
		$("#empName_input").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName=" + empName,
				type:"GET",
				success:function(result){
					if(result.code==0){
						show_validate_msg("#empName_input", "success", "用户名可用");
						$("#add_emp_btn").attr("ajax-va", "success");
					}else{
						show_validate_msg("#empName_input", "error", "用户名已存在");
						$("#add_emp_btn").attr("ajax-va", "error");
					}
				}
			});
			
		});
		
		//新增模态框里的保存按钮
		$("#add_emp_btn").click(function(){
			
			//对数据进行校验
			if(!validate_add_form()){
				return false
			};
			
			//判断检测用户名重复时放入的属性信息，来确定下一步干啥
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				//可以直接把empAddModal form里的值构成json格式
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//应去往最后一页，显示刚刚保存的数据
					to_page(totalRecord);
					//关闭模态框
					$("#empAddModal").modal("hide");
				}
			});
		});
		
	</script>
	
</body>
</html>