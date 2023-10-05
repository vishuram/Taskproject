<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="taskregister.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="js/JavaScript.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <title>login</title>
    
</head>
<body>
    <div class="container d-flex justify-content-center " style="margin-top:120px;">
    <div class="row">
        
        <div class="col-lg-4"> </div>

    </div>
        <div class="col-lg-4">
         <div class="shadow p-3 mb-5 bg-black rounded" style="height:450px; width:450px;">
             <div class="card-header bg-primary text-white d-flex justify-content-center">LOGIN </div>
             <div class="card-body">
                 <form runat="server">

          <div class="form-group">
          <label for="Email">EmailID</label>
              <asp:TextBox ID="txtemail" class="form-control" placeholder="Enter your EmailId" runat="server"></asp:TextBox>
              <asp:RequiredFieldValidator ValidationGroup="Login" ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ControlToValidate="txtemail" ErrorMessage="Enter your EmailId"></asp:RequiredFieldValidator>
            
              <asp:RegularExpressionValidator  ValidationGroup="login" ID="RegularExpressionValidator1" ForeColor="Red" runat="server" ControlToValidate="txtemail" ErrorMessage=""></asp:RegularExpressionValidator>

          </div>
    
         <div class="form-group">
         <label for="Password">Password</label>
             <asp:TextBox ID="txtpass" class="form-control"  placeholder="Enter Your Password" runat="server"  TextMode="Password"></asp:TextBox>
           <asp:RequiredFieldValidator ValidationGroup="Login" ID="RequiredFieldValidator2" runat="server" ForeColor="Red" ControlToValidate="txtpass" ErrorMessage="Enter your password"></asp:RequiredFieldValidator>
             

         
             <br />
             <br />
           
         </div>
 
                           
           <asp:Button ID="BtnLogin_Click" ValidationGroup="Login" runat="server" style="width:100%;" class="btn btn-primary" Text="Login" OnClick="BtnLogin_Click_Click"/>  
                     
                     <br />
                     <a href="Register.aspx">DON'T HAVE AN ACCOUNT ? Register</a>
      </form>

             </div>
             <div class="card-footer">
                 

                 
  </div>
</div>

             </div>
         </div>
</body>
</html>
