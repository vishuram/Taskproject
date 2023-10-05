<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="taskregister.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
 
    <title>Registration Form</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 254px;
        }
        .auto-style3 {
            margin-left: 158px;
        }
        .auto-style4 {
            width: 254px;
            height: 34px;
        }
        .auto-style5 {
            height: 34px;
        }
        .auto-style6 {
            margin-left: 124px;
        }
    </style>
    <script>
        function validate() {
            var str = document.getElementById('<%=txtpassword.ClientID%>').value;

            if (str.length < 8) {
                document.getElementById("demo").innerHTML = "Password must be 8 char";
                document.getElementById("demo").style.color = "Red";
                return ("too short");
            }
            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("demo").innerHTML = "Password atleast one number";
                document.getElementById("demo").style.color = "Red";
                return ("no_num");
            }
            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("demo").innerHTML = "must be atlast 1 small letter";
                document.getElementById("demo").style.color = "Red";
                return ("no_small_letter");
            }
            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("demo").innerHTML = "must be atlast 1 Upper letter";
                document.getElementById("demo").style.color = "Red";
                return ("no_Uper_letter");
            }
            else if (str.search(/[!\@\#\$\%\^\&\(\)\_\+\.\,\;\:]/) == -1) {
                document.getElementById("demo").innerHTML = "must be atlast 1 special char Not ~,`,* ";
                document.getElementById("demo").style.color = "Red";
                return ("no_letter");
            }
            document.getElementById("demo").innerHTML = "Excellent";
            document.getElementById("demo").style.color = "Green";
            return ("OK");
        }
    </script>
   <%-- <script type="text/javascript">
        function showDeleteConfirmation(btn) {
            var row = btn.parentNode.parentNode; // Get the GridView row
            var firstName = row.cells[1].innerText;
            var lastName = row.cells[2].innerText;
            var confirmDelete = confirm(`Are you sure you want to delete ${firstName}${lastName} Enter remark:`);

            if (confirmDelete) {
                var remark = prompt("Please enter a remark:");
                if (remark !== null) {
                    // Proceed with the delete operation by calling the server-side event
                    __doPostBack('<asp:Button ID="save" Text="save" OnClick="Save_Click"></asp:Button>');
                }
            }

            return false; // Prevent the postback if canceled
        }
    </script>--%>
    

</head>
<body>
    <form runat="server">
        <div>
            <h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Registration Form</h1>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">FirstName:</td>
                    <td>
                        <asp:TextBox ID="txtfirstname" runat="server" placeholder="Enter your Firstname"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revFirstName" runat="server" ControlToValidate="txtfirstname" 
        ValidationExpression="^[A-Za-z]+$" Display="Dynamic" 
        ErrorMessage="First Name should only contain alphabetic characters." ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">LastName:</td>
                    <td>
                        <asp:TextBox ID="txtlastname" runat="server" placeholder="Enter your Lastname"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revFirstName0" runat="server" ControlToValidate="txtlastname" 
        ValidationExpression="^[A-Za-z]+$" Display="Dynamic" 
        ErrorMessage="LastName should only contain alphabetic characters." ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Mobile No.:</td>
                    <td>
                        <asp:TextBox ID="txtmobileno" runat="server" MaxLength="10" placeholder="Enter your Mobile"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="validationfname1" runat="server" ErrorMessage="please Enter MobileNo" ForeColor="Red" ControlToValidate="txtmobileno"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revMobileNo" runat="server" ControlToValidate="txtmobileno" 
        ValidationExpression="^\d{10}$" Display="Dynamic" 
        ErrorMessage="Mobile Number should be exactly 10 digits and contain only numbers." ForeColor="Red" />
                        <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Your phone no Is already REgistered" ControlToValidate="txtmobileno"  forecolor="Red" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Email:</td>
                    <td>
                        <asp:TextBox ID="txtemail" runat="server" TextMode="Email" placeholder="Enter your Email"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtemail" 
        InitialValue="" Display="Dynamic" ErrorMessage="Email is required." ForeColor="Red" />
    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtemail" 
        ValidationExpression="^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$" Display="Dynamic" 
        ErrorMessage="Invalid Email Format" ForeColor="Red" />
                        
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Your Email Is Already Registered" ControlToValidate="txtmobileno"  forecolor="Red" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                        
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Password:</td>
                    <td>
                        <span id="demo"></span> <br />
                        <asp:TextBox ID="txtpassword" runat="server" placeholder="Enter your password"  onkeyup="javascript:return validate();"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtpassword" 
        InitialValue="" Display="Dynamic" ErrorMessage="Password is required." ForeColor="Red" />
                       
                    </td>
                </tr>
                 <tr>
                    <td class="auto-style2">Confirm Password:</td>
                    <td>
                        <asp:TextBox ID="txtconfirmpass" runat="server"  placeholder="Enter your Confirm Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtconfirmpass" 
        InitialValue="" Display="Dynamic" ErrorMessage="Confirm Password is required." ForeColor="Red" />
    <asp:CompareValidator ID="cvPasswordMatch" runat="server" ControlToValidate="txtconfirmpass" 
        ControlToCompare="txtpassword" Operator="Equal" Type="String" Display="Dynamic" 
        ErrorMessage="Passwords do not match." ForeColor="Red" />
                    </td>
                </tr>
                 <tr>
                    <td class="auto-style2">Address:</td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" placeholder="Enter your Address"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="validationfname3" runat="server" ErrorMessage="please Enter Address" ForeColor="Red" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
                     </td>
                </tr>
                --
                 <tr>
                        <td><font color="Black">Gender:</font></td>
                        <td>
                         &nbsp; <asp:RadioButton ID="radiomale"
                                GroupName="gender"
                                runat="server" Text="Male" CssClass="customRadioButton" />
&nbsp;<asp:RadioButton ID="radiofemale"
                                GroupName="gender"
                                runat="server" Text="Female" CssClass="customRadioButton" />
                        </td>
                    </tr>
                 <tr>
                    <td class="auto-style2">Pincode:</td>
                    <td>
                        <asp:TextBox ID="txtpincode" runat="server" MaxLength="6" placeholder="Enter your Pincode"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revMobileNo0" runat="server" ControlToValidate="txtpincode" 
        ValidationExpression="^\d{6}$" Display="Dynamic" 
        ErrorMessage="Pincode Number should be exactly 6 digits and contain only numbers." ForeColor="Red" />
                        <asp:RequiredFieldValidator ID="validationfname6" runat="server" ErrorMessage="please Enter pincode" ForeColor="Red" ControlToValidate="txtpincode"></asp:RequiredFieldValidator>
                     </td>
                      
                </tr>
                 <tr>
                    <td class="auto-style4">Country:</td>
                    <td class="auto-style5">
                        <asp:DropDownList ID="DropDownList1" runat="server">
                            <asp:ListItem>India</asp:ListItem>
                            <asp:ListItem>Uk</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="validationfname5" runat="server" ErrorMessage="please select Country" ForeColor="Red" ControlToValidate="DropDownList1"></asp:RequiredFieldValidator>
                     </td>
                </tr>
                 <tr>
                    <td class="auto-style2">Status:</td>
                    <td>
                        <asp:CheckBox ID="status" runat="server" CssClass="form-check-input" Text="Active" /></td>
                </tr>
            </table>
            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="auto-style3" OnClick="btnRegister_Click" ForeColor="#00CC00" />

            <asp:Button ID="btnupdate" runat="server" OnClick="btnUpdate_Click" Text="update" CssClass="auto-style6" ForeColor="Yellow" />
            <asp:Label ID="Label2" runat="server" Text="Label" Visible="false"></asp:Label>

            <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label>
            <br />
           <div id="popup" runat="server">
            <div>
                 <lable style="color:Black">Remarks</lable>
            </div>
            <div>
           
             <asp:TextBox ID="txtremark" Width="50px" runat="server"></asp:TextBox>
           
        </div>
        <div>
              <asp:Button ID="btndelete" runat="server" Text="Delete" Height="41px"  ValidationGroup="ConfirmDelete" Width="120px" OnClick="btndelete_Click"  />
              <asp:Button ID="btnCancel" runat="server" Text="Cancle" Height="41px" ValidationGroup="ConfirmDelete" Width="120px" OnClick="btnCancel_Click" />
        </div>
        </div>




            
          

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"   OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound ="GridView1_RowDataBound"  DataKeyNames="userId" Width="100%">
                <Columns>

                     <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" Text="Select" CommandName="Select" CausesValidation="False" ID="LinkButton1"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("userId") %>' CausesValidation="False" ID="LinkButton2"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                   


                    <asp:BoundField DataField="firstName" HeaderText="firstName" SortExpression="firstName"></asp:BoundField>
                    <asp:BoundField DataField="lastName" HeaderText="lastName" SortExpression="lastName"></asp:BoundField>
                    <asp:BoundField DataField="mobileNo" HeaderText="mobileNo" SortExpression="mobileNo"></asp:BoundField>
                    <asp:BoundField DataField="email" HeaderText="email" SortExpression="email"></asp:BoundField>
                    <asp:BoundField DataField="password" HeaderText="Password" SortExpression="password"></asp:BoundField>
                    <asp:BoundField DataField="confirmPassword" HeaderText="ConfirmPassword" SortExpression="confirmPassword"></asp:BoundField>
                    <asp:BoundField DataField="address" HeaderText="address" SortExpression="address"></asp:BoundField>
                    <asp:BoundField DataField="gender" HeaderText="gender" SortExpression="gender"></asp:BoundField>
                    <asp:BoundField DataField="pincode" HeaderText="pincode" SortExpression="pincode"></asp:BoundField>
                    <asp:BoundField DataField="country" HeaderText="country" SortExpression="country"></asp:BoundField>
                    <asp:BoundField DataField="status" HeaderText="status" SortExpression="status"></asp:BoundField>
                    <asp:TemplateField HeaderText="ModifyBy">
                        <ItemTemplate>
                            <%# Eval("lmodifyby") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Modifydt">
                        <ItemTemplate>
                            <%# Eval("modufydt") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                   
                </Columns>

            </asp:GridView>


            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DemoConnectionString2 %>' SelectCommand="SELECT [firstName], [lastName], [mobileNo], [email], [password], [confirmPassword], [address], [gender], [pincode], [country], [status], [modifyid] FROM [taskRegister6]">
              
            </asp:SqlDataSource>
            

        </div>
    </form>
</body>
</html>
