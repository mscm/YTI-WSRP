<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MyGrades.ascx.vb" Inherits="WSRP.WebParts.MyGrades" %>
<!--StartControl-->
<script type="text/javascript">
function switchViews(obj)
        {
            var div = document.getElementById(obj);
            var img = document.getElementById('img' + obj);
            
            if (div.style.display=="none")
                {
                    div.style.display = "inline";
                    img.src="../../Public/global/images/blinds_open.gif";
                    mce_src="../../Public/global/images/blinds_open.gif";
                    img.alt = "Collapse";
               }
           else
               {
                  div.style.display = "none";
                  img.src = "../../Public/global/images/blinds_closed.gif";  
                  mce_src="../../Public/global/images/blinds_closed.gif";
                  img.alt = "Expand";
               }
       }

</script>
<table id="Table1" cellspacing="3" cellpadding="0" border="0" align="center" width="700px">
   <tr>
      <td>
         <div align="center" >
            <asp:Label ID="lblerror" runat="server" Text="" CssClass="error" Visible="false"></asp:Label>            
         </div>
         <div style="WIDTH: 100%; HEIGHT: 100%; text-align: center;border: solid 1px #9ABBEE;">
             <asp:GridView ID="grdStudentTermGrades" runat="server" Width="100%" 
                 GridLines="None" AutoGenerateColumns="False"
                 EmptyDataText="You currently have no grades posted" DataKeyNames="AdEnrollTermId">
                 <RowStyle CssClass="row" />
                 <HeaderStyle CssClass="tablegridHdr" />
                 <AlternatingRowStyle CssClass="altrow" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <a href="javascript:switchViews('div<%# Eval("AdEnrollTermId") %>');">
                                    <img id="imgdiv<%# Eval("AdEnrollTermId") %>" alt="Click to show/hide Course Grades" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                </a>                                
                            </ItemTemplate>                            
                         </asp:TemplateField>
                         <asp:BoundField DataField="AdEnrollTermId" HeaderText="AdEnrollTermId" Visible="false" />
                         <asp:BoundField DataField="Term" HeaderText="Term" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                         <asp:BoundField DataField="Program" HeaderText="Enrolled Program" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                         <asp:BoundField DataField="CurrentCreditsEarn" HeaderText="Credits Earn" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                         <asp:BoundField DataField="CurrentCreditsAtt" HeaderText="Credits Attempt" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                         <asp:BoundField DataField="CurrentGPA" HeaderText="Cur GPA" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                         <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                            <HeaderTemplate>
                            Cum GPA
                            </HeaderTemplate>
                            <AlternatingItemTemplate>
                                <asp:Label ID="lblCumGPA" runat="server" Text='<%# Bind("CumGPA") %>'></asp:Label>
                                </td>
                                </tr>
                                <tr class="row2">
                                    <td colspan="100%" align="center">
                                        <div id="div<%# Eval("AdEnrollTermId") %>" style="display:none;position:relative;" >
                                            <div style="padding-top:10px;padding-bottom:20px;">
                                                <div style="border: solid 1px #9ABBEE; width: 650px;">
                                                    <asp:GridView ID="grdStudentCourseGrades" runat="server" Width="100%" 
                                                     GridLines="None" AutoGenerateColumns="False" 
                                                     EmptyDataText="You currently have no courses for this Term" DataKeyNames="AdEnrollSchedId">
                                                    <RowStyle CssClass="row" />
                                                    <HeaderStyle CssClass="tablegridHdr" />
                                                    <AlternatingRowStyle CssClass="altrow" />
                                                         <Columns>
                                                             <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <a href="javascript:switchViews('div<%# Eval("AdEnrollSchedId") %>');">
                                                                        <img id="imgdiv<%# Eval("AdEnrollSchedId") %>" alt="Click to show/hide Lesson Grades" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                                                    </a>
                                                                </ItemTemplate>
                                                             </asp:TemplateField>
                                                             <asp:BoundField DataField="AdEnrollSchedId" HeaderText="AdEnrollSchedId" Visible="false" />
                                                             <asp:BoundField DataField="Term" HeaderText="Term" Visible="false" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Course" HeaderText="Course" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="InProgressGrade" HeaderText="In Progress" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                                                             <asp:BoundField DataField="MidTermGrade" HeaderText="Mid Term" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                                                             <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                <HeaderTemplate>
                                                                    Final
                                                                </HeaderTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <asp:Label ID="lblFinalGrade" runat="server" Text='<%# Bind("FinalGrade") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row2">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div<%# Eval("AdEnrollSchedId") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentCourseLessonGrades" runat="server" GridLines="none" Width="600px" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There are currently no lessons for this course">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="LessonNumber" HeaderText="#" />
                                                                                            <asp:BoundField DataField="Descrip" HeaderText="Lesson" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                                                            <asp:BoundField DataField="LessonType" HeaderText="Type" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                                                            <asp:TemplateField HeaderText="Weight (%)" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblWeight" runat="server" Text='<%# Bind("PctFinalGrade", "{0:0.00}") %>'></asp:Label>&nbsp;%                                       
                                                                                                </ItemTemplate>                                                                                     
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="LessonGrade" HeaderText="Grade" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />                                                        
                                                                                        </Columns>
                                                                                    </asp:GridView>   
                                                                                </div>                                         
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </AlternatingItemTemplate>
                                                                <ItemTemplate>                                
                                                                    <asp:Label ID="lblFinalGrade" runat="server" Text='<%# Bind("FinalGrade") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row1">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div<%# Eval("AdEnrollSchedId") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentCourseLessonGrades" runat="server" GridLines="none" Width="600px"
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There are currently no lessons for this course">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="LessonNumber" HeaderText="#" />
                                                                                            <asp:BoundField DataField="Descrip" HeaderText="Lesson" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                                                            <asp:BoundField DataField="LessonType" HeaderText="Type" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                                                            <asp:TemplateField HeaderText="Weight (%)" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" >
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblWeight" runat="server" Text='<%# Bind("PctFinalGrade", "{0:0.00}") %>'></asp:Label>&nbsp;%                                       
                                                                                                </ItemTemplate>                                                                                     
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="LessonGrade" HeaderText="Grade" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />                                                        
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                             </asp:TemplateField>                                       
                                                         </Columns>                                            
                                                 </asp:GridView>
                                             </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </AlternatingItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCumGPA" runat="server" Text='<%# Bind("CumGPA") %>'></asp:Label>
                                </td>
                                </tr>
                                <tr class="row1">
                                    <td colspan="100%" align="center">
                                        <div id="div<%# Eval("AdEnrollTermId") %>" style="display:none;position:relative;" >
                                            <div style="padding-top:10px;padding-bottom:20px;">
                                                <div style="border: solid 1px #9ABBEE; width: 650px;">
                                                    <asp:GridView ID="grdStudentCourseGrades" runat="server" Width="100%" 
                                                     GridLines="None" AutoGenerateColumns="False"
                                                     EmptyDataText="You currently have no courses for this Term" DataKeyNames="AdEnrollSchedId">
                                                    <RowStyle CssClass="row" />
                                                    <HeaderStyle CssClass="tablegridHdr" />
                                                    <AlternatingRowStyle CssClass="altrow" />
                                                         <Columns>
                                                             <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <a href="javascript:switchViews('div<%# Eval("AdEnrollSchedId") %>');">
                                                                        <img id="imgdiv<%# Eval("AdEnrollSchedId") %>" alt="Click to show/hide Lesson Grades" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                                                    </a>
                                                                </ItemTemplate>
                                                             </asp:TemplateField>
                                                             <asp:BoundField DataField="AdEnrollSchedId" HeaderText="AdEnrollSchedId" Visible="false" />
                                                             <asp:BoundField DataField="Term" HeaderText="Term" Visible="false" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Course" HeaderText="Course" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="InProgressGrade" HeaderText="In Progress" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                                                             <asp:BoundField DataField="MidTermGrade" HeaderText="Mid Term" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                                                             <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                                                <HeaderTemplate>
                                                                    Final
                                                                </HeaderTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <asp:Label ID="lblFinalGrade" runat="server" Text='<%# Bind("FinalGrade") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row2">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div<%# Eval("AdEnrollSchedId") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentCourseLessonGrades" runat="server" GridLines="none" Width="600px"
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There are currently no lessons for this course">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="LessonNumber" HeaderText="#" />
                                                                                            <asp:BoundField DataField="Descrip" HeaderText="Lesson" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                                                            <asp:BoundField DataField="LessonType" HeaderText="Type" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                                                            <asp:TemplateField HeaderText="Weight (%)" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" >
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblWeight" runat="server" Text='<%# Bind("PctFinalGrade", "{0:0.00}") %>'></asp:Label>&nbsp;%                                       
                                                                                                </ItemTemplate>                                                                                     
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="LessonGrade" HeaderText="Grade" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />                                                        
                                                                                        </Columns>
                                                                                    </asp:GridView>  
                                                                                </div>                                          
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </AlternatingItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFinalGrade" runat="server" Text='<%# Bind("FinalGrade") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row1">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div<%# Eval("AdEnrollSchedId") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentCourseLessonGrades" runat="server" GridLines="none" Width="600px" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There are currently no lessons for this course">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="LessonNumber" HeaderText="#" />
                                                                                            <asp:BoundField DataField="Descrip" HeaderText="Lesson" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                                                            <asp:BoundField DataField="LessonType" HeaderText="Type" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                                                            <asp:TemplateField HeaderText="Weight (%)" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" >
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblWeight" runat="server" Text='<%# Bind("PctFinalGrade", "{0:0.00}") %>'></asp:Label>&nbsp;%                                       
                                                                                                </ItemTemplate>                                                                                     
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="LessonGrade" HeaderText="Grade" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />                                                        
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                             </asp:TemplateField>                                       
                                                         </Columns>
                                                    <FooterStyle CssClass="text2" />
                                                 </asp:GridView>
                                             </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                         </asp:TemplateField>
                    </Columns>
             </asp:GridView>             
         </div>
      </td>
   </tr>
</table>
<!--EndControl-->
