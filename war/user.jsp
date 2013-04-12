<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="js/jquery/jquery.min.js"></script>
<script src="thirdJs/easyui/jquery.easyui.min.js"></script>
<title>用户管理界面</title>
</head>
<body>
	<table id="dg" title="My Users" class="easyui-datagrid" style="width:700px;height:250px"  
            url="get_users.php"  
            toolbar="#toolbar" pagination="true"  
            rownumbers="true" fitColumns="true" singleSelect="true">  
        <thead>  
            <tr>  
                <th field="firstname" width="50">First Name</th>  
                <th field="lastname" width="50">Last Name</th>  
                <th field="phone" width="50">Phone</th>  
                <th field="email" width="50">Email</th>  
            </tr>  
        </thead>  
    </table>  
    <div id="toolbar">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">New User</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">Edit User</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">Remove User</a>  
    </div>  
      
    <div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"  
            closed="true" buttons="#dlg-buttons">  
        <div class="ftitle">User Information</div>  
        <form id="fm" method="post" novalidate>  
            <div class="fitem">  
                <label>First Name:</label>  
                <input name="firstname" class="easyui-validatebox" required="true">  
            </div>  
            <div class="fitem">  
                <label>Last Name:</label>  
                <input name="lastname" class="easyui-validatebox" required="true">  
            </div>  
            <div class="fitem">  
                <label>Phone:</label>  
                <input name="phone">  
            </div>  
            <div class="fitem">  
                <label>Email:</label>  
                <input name="email" class="easyui-validatebox" validType="email">  
            </div>  
        </form>  
    </div>  
    <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>  
    </div>  
</body>
</html>