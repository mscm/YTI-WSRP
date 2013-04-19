<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MyAttendance.ascx.vb" Inherits="WSRP.WebParts.MyAttendance" %>
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

       function ShowByDay() {
           var divByCourseByDay = document.getElementById("divByCourseByDay");
           var divByDayByCourse = document.getElementById("divByDayByCourse");
           if (divByDayByCourse.style.display == "none") {
               divByDayByCourse.style.display = "inline";
           }
           else {
               divByDayByCourse.style.display = "none";
           }
           if (divByCourseByDay.style.display == "none") {
               divByCourseByDay.style.display = "inline";
           }
           else {
               divByCourseByDay.style.display = "none";
           }          
       }
            

</script>
<table id="Table1" cellspacing="3" cellpadding="0" border="0" align="center">
   <tr>
      <td>
         <div align="center">
            <asp:Label ID="lblerror" runat="server" Text="" CssClass="error" Visible="false"></asp:Label>
         </div>
         <div align="Right" style="padding-bottom:10px;">
             <b>Sort Options:&nbsp;</b><input type="checkbox" id="chkByDay" onclick="javascript:ShowByDay();" />&nbsp;Show By Day
         </div>       
         <div id="divByCourseByDay">
            <div style="WIDTH: 100%; text-align: center;border: solid 1px #9ABBEE;">
                <asp:GridView ID="grdStudentAttendanceTerm" runat="server" Width="100%" 
                 GridLines="None" AutoGenerateColumns="False"
                 EmptyDataText="You currently have no attendance posted" DataKeyNames="AdEnrollTermId">
                 <RowStyle CssClass="row" />
                 <HeaderStyle CssClass="tablegridHdr" />
                 <AlternatingRowStyle CssClass="altrow" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <a href="javascript:switchViews('div_<%# Eval("AdEnrollTermId") %>');">
                                    <img id="imgdiv_<%# Eval("AdEnrollTermId") %>" alt="Click to show/hide Course Attendance" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                </a>                                
                            </ItemTemplate>                            
                         </asp:TemplateField>
                         <asp:BoundField DataField="AdEnrollTermId" HeaderText="AdEnrollTermId" Visible="false" />
                         <asp:BoundField DataField="Term" HeaderText="Term" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                         <asp:BoundField DataField="Program" HeaderText="Enrolled Program" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                         <asp:BoundField DataField="Attend" HeaderText="Attended (hr)" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                         <asp:BoundField DataField="Absent" HeaderText="Absent (hr)" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" AlternateText="" ImageUrl="/Public/global/images/icons/green_light.gif" />
                            </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                WARN
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgAttendanceWarning" runat="server" AlternateText='<%# Eval("AttendanceWarningDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                PROB
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgAttendanceProbation" runat="server" AlternateText='<%# Eval("AttendanceProbationDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                NUM
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTardyCount" runat="server" Text='<%# Eval("TardyCount") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                WARN
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgTardyWarning" runat="server" AlternateText='<%# Eval("TardyWarningDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                PROB
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgTardyProbation" runat="server" AlternateText='<%# Eval("TardyProbationDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                NUM
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblLeftClassEarlyCount" runat="server" Text='<%# Eval("LeftClassEarlyCount") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                WARN
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgLeftClassEarlyWarning" runat="server" AlternateText='<%# Eval("LeftClassEarlyWarningDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                PROB
                            </HeaderTemplate>
                            <AlternatingItemTemplate>
                                <asp:Image ID="imgLeftClassEarlyProbation" runat="server" AlternateText='<%# Eval("LeftClassEarlyProbationDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                                </td>
                                </tr>
                                <tr class="row2">
                                    <td colspan="100%" align="center">
                                        <div id="div_<%# Eval("AdEnrollTermId") %>" style="display:none;position:relative;" >
                                            <div style="padding-top:10px;padding-bottom:20px;">
                                                <div style="border: solid 1px #9ABBEE; width: 95%;">
                                                    <asp:GridView ID="grdStudentAttendanceTermCourse" runat="server" Width="100%" 
                                                     GridLines="None" AutoGenerateColumns="False" 
                                                     EmptyDataText="You currently have no courses for this Term" DataKeyNames="AdEnrollSchedId">
                                                    <RowStyle CssClass="row" />
                                                    <HeaderStyle CssClass="tablegridHdr" />
                                                    <AlternatingRowStyle CssClass="altrow" />
                                                         <Columns>
                                                             <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <a href="javascript:switchViews('div_<%# Eval("AdEnrollSchedId") %>');">
                                                                        <img id="imgdiv_<%# Eval("AdEnrollSchedId") %>" alt="Click to show/hide Daily Attendance" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                                                    </a>
                                                                </ItemTemplate>
                                                             </asp:TemplateField>
                                                             <asp:BoundField DataField="AdEnrollSchedId" HeaderText="AdEnrollSchedId" Visible="false" />
                                                             <asp:BoundField DataField="AdEnrollSchedId" HeaderText="AdEnrollSchedId" Visible="false" />
                                                             <asp:BoundField DataField="Section" HeaderText="Sec" />
                                                             <asp:BoundField DataField="CourseCode" HeaderText="Code" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Course" HeaderText="Course" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Instructor" HeaderText="Instructor" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                                                             <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    Absent
                                                                </HeaderTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <asp:Label ID="lblAbsent" runat="server" Text='<%# Bind("Absent") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row2">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div_<%# Eval("AdEnrollSchedId") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentAttendanceTermCourseDay" runat="server" GridLines="none" Width="95%" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There is currently no attendance for this course">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Day" HeaderText="Day" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Time" HeaderText="Time" DataFormatString="{0:t}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                    
                                                                                            <asp:BoundField DataField="Room" HeaderText="Room" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Scheduled" HeaderText="Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Absent" HeaderText="Absent" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                  
                                                                                        </Columns>
                                                                                    </asp:GridView>   
                                                                                </div>                                         
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </AlternatingItemTemplate>
                                                                <ItemTemplate>                                
                                                                    <asp:Label ID="lblAbsent" runat="server" Text='<%# Bind("Absent") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row1">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div_<%# Eval("AdEnrollSchedId") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentAttendanceTermCourseDay" runat="server" GridLines="none" Width="95%" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There is currently no attendance for this course">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Day" HeaderText="Day" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Time" HeaderText="Time" DataFormatString="{0:t}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                    
                                                                                            <asp:BoundField DataField="Room" HeaderText="Room" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Scheduled" HeaderText="Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Absent" HeaderText="Absent" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                    
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
                                <asp:Image ID="imgLeftClassEarlyProbation" runat="server" AlternateText='<%# Eval("LeftClassEarlyProbationDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                                </td>
                                </tr>
                                <tr class="row1">
                                    <td colspan="100%" align="center">
                                        <div id="div_<%# Eval("AdEnrollTermId") %>" style="display:none;position:relative;" >
                                            <div style="padding-top:10px;padding-bottom:20px;">
                                                <div style="border: solid 1px #9ABBEE; width: 95%;">
                                                    <asp:GridView ID="grdStudentAttendanceTermCourse" runat="server" Width="100%" 
                                                     GridLines="None" AutoGenerateColumns="False" 
                                                     EmptyDataText="You currently have no courses for this Term" DataKeyNames="AdEnrollSchedId">
                                                    <RowStyle CssClass="row" />
                                                    <HeaderStyle CssClass="tablegridHdr" />
                                                    <AlternatingRowStyle CssClass="altrow" />
                                                         <Columns>
                                                             <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <a href="javascript:switchViews('div_<%# Eval("AdEnrollSchedId") %>');">
                                                                        <img id="imgdiv_<%# Eval("AdEnrollSchedId") %>" alt="Click to show/hide Daily Attendance" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                                                    </a>
                                                                </ItemTemplate>
                                                             </asp:TemplateField>
                                                             <asp:BoundField DataField="AdEnrollSchedId" HeaderText="AdEnrollSchedId" Visible="false" />
                                                             <asp:BoundField DataField="Section" HeaderText="Sec" />
                                                             <asp:BoundField DataField="CourseCode" HeaderText="Code" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Course" HeaderText="Course" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Instructor" HeaderText="Instructor" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                                                             <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    Absent
                                                                </HeaderTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <asp:Label ID="lblAbsent" runat="server" Text='<%# Bind("Absent") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row2">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div_<%# Eval("AdEnrollSchedId") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentAttendanceTermCourseDay" runat="server" GridLines="none" Width="95%" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There is currently no attendance for this course">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Day" HeaderText="Day" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Time" HeaderText="Time" DataFormatString="{0:t}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                    
                                                                                            <asp:BoundField DataField="Room" HeaderText="Room" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Scheduled" HeaderText="Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Absent" HeaderText="Absent" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                 
                                                                                        </Columns>
                                                                                    </asp:GridView>  
                                                                                </div>                                          
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </AlternatingItemTemplate>
                                                                <ItemTemplate>                                
                                                                    <asp:Label ID="lblAbsent" runat="server" Text='<%# Bind("Absent") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row1">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div_<%# Eval("AdEnrollSchedId") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentAttendanceTermCourseDay" runat="server" GridLines="none" Width="95%" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There is currently no attendance for this course">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Day" HeaderText="Day" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Time" HeaderText="Time" DataFormatString="{0:t}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                    
                                                                                            <asp:BoundField DataField="Room" HeaderText="Room" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Scheduled" HeaderText="Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Absent" HeaderText="Absent" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                  
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
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>                         
                    </Columns>
             </asp:GridView>
            </div>
         </div>
         <div id="divByDayByCourse" style="display:none;">
            <div style="WIDTH: 100%; text-align: center;border: solid 1px #9ABBEE;">
                <asp:GridView ID="grdStudentAttendanceTerm2" runat="server" Width="100%" 
                 GridLines="None" AutoGenerateColumns="False"
                 EmptyDataText="You currently have no attendance posted" DataKeyNames="AdEnrollTermId">
                 <RowStyle CssClass="row" />
                 <HeaderStyle CssClass="tablegridHdr" />
                 <AlternatingRowStyle CssClass="altrow" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <a href="javascript:switchViews('div__<%# Eval("AdEnrollTermId") %>');">
                                    <img id="imgdiv__<%# Eval("AdEnrollTermId") %>" alt="Click to show/hide Course Attendance" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                </a>                                
                            </ItemTemplate>                            
                         </asp:TemplateField>
                         <asp:BoundField DataField="AdEnrollTermId" HeaderText="AdEnrollTermId" Visible="false" />
                         <asp:BoundField DataField="Term" HeaderText="Term" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                         <asp:BoundField DataField="Program" HeaderText="Enrolled Program" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                         <asp:BoundField DataField="Attend" HeaderText="Attended (hr)" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                         <asp:BoundField DataField="Absent" HeaderText="Absent (hr)" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                         <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="imgStatus" runat="server" AlternateText="" ImageUrl="/Public/global/images/icons/green_light.gif" />
                            </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                WARN
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgAttendanceWarning" runat="server" AlternateText='<%# Eval("AttendanceWarningDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                PROB
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgAttendanceProbation" runat="server" AlternateText='<%# Eval("AttendanceProbationDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                NUM
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTardyCount" runat="server" Text='<%# Eval("TardyCount") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                WARN
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgTardyWarning" runat="server" AlternateText='<%# Eval("TardyWarningDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                PROB
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgTardyProbation" runat="server" AlternateText='<%# Eval("TardyProbationDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                NUM
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblLeftClassEarlyCount" runat="server" Text='<%# Eval("LeftClassEarlyCount") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                WARN
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgLeftClassEarlyWarning" runat="server" AlternateText='<%# Eval("LeftClassEarlyWarningDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderTemplate>
                                PROB
                            </HeaderTemplate>
                            <AlternatingItemTemplate>
                                <asp:Image ID="imgLeftClassEarlyProbation" runat="server" AlternateText='<%# Eval("LeftClassEarlyProbationDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                                </td>
                                </tr>
                                <tr class="row2">
                                    <td colspan="100%" align="center">
                                        <div id="div__<%# Eval("AdEnrollTermId") %>" style="display:none;position:relative;" >
                                            <div style="padding-top:10px;padding-bottom:20px;">
                                                <div style="border: solid 1px #9ABBEE; width: 95%;">
                                                    <asp:GridView ID="grdStudentAttendanceTermDay" runat="server" Width="100%" 
                                                     GridLines="None" AutoGenerateColumns="False" 
                                                     EmptyDataText="You currently have no Attendance Days for this Term" DataKeyNames="Day">
                                                    <RowStyle CssClass="row" />
                                                    <HeaderStyle CssClass="tablegridHdr" />
                                                    <AlternatingRowStyle CssClass="altrow" />
                                                         <Columns>
                                                             <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <a href="javascript:switchViews('div__<%# Eval("Day", "{0:d}") %>');">
                                                                        <img id="imgdiv__<%# Eval("Day", "{0:d}") %>" alt="Click to show/hide Daily Attendance" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                                                    </a>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" Width="10%" />
                                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                             </asp:TemplateField>
                                                             <asp:BoundField DataField="Day" HeaderText="Date" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                                                             <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    Absent
                                                                </HeaderTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <asp:Label ID="lblAbsent" runat="server" Text='<%# Bind("Absent") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row2">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div__<%# Eval("Day", "{0:d}") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentAttendanceTermDayCourse" runat="server" GridLines="none" Width="95%" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There is currently no attendance for this day">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Section" HeaderText="Sec" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="CourseCode" HeaderText="Code" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Course" HeaderText="Course" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Instructor" HeaderText="Instructor" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="StartTime" HeaderText="Time" DataFormatString="{0:t}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" /> 
                                                                                            <asp:BoundField DataField="Schedule" HeaderText="Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Absent" HeaderText="Absent" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                     
                                                                                        </Columns>
                                                                                    </asp:GridView>  
                                                                                </div>                                          
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </AlternatingItemTemplate>
                                                                <ItemTemplate>                                
                                                                    <asp:Label ID="lblAbsent" runat="server" Text='<%# Bind("Absent") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row1">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div__<%# Eval("Day", "{0:d}") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentAttendanceTermDayCourse" runat="server" GridLines="none" Width="95%" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There is currently no attendance for this day">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Section" HeaderText="Sec" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="CourseCode" HeaderText="Code" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Course" HeaderText="Course" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Instructor" HeaderText="Instructor" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="StartTime" HeaderText="Time" DataFormatString="{0:t}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" /> 
                                                                                            <asp:BoundField DataField="Schedule" HeaderText="Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Absent" HeaderText="Absent" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                    
                                                                                        </Columns>
                                                                                    </asp:GridView>  
                                                                                </div>                                          
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                <ItemStyle HorizontalAlign="Right" />
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
                                <asp:Image ID="imgLeftClassEarlyProbation" runat="server" AlternateText='<%# Eval("LeftClassEarlyProbationDate") %>' ImageUrl="/Public/global/images/icons/icon_checkmark.png"  />
                                </td>
                                </tr>
                                <tr class="row1">
                                    <td colspan="100%" align="center">
                                        <div id="div__<%# Eval("AdEnrollTermId") %>" style="display:none;position:relative;" >
                                            <div style="padding-top:10px;padding-bottom:20px;">
                                                <div style="border: solid 1px #9ABBEE; width: 95%;">
                                                    <asp:GridView ID="grdStudentAttendanceTermDay" runat="server" Width="100%" 
                                                     GridLines="None" AutoGenerateColumns="False" 
                                                     EmptyDataText="You currently have no Attendance Days for this Term" DataKeyNames="Day">
                                                    <RowStyle CssClass="row" />
                                                    <HeaderStyle CssClass="tablegridHdr" />
                                                    <AlternatingRowStyle CssClass="altrow" />
                                                         <Columns>
                                                             <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <a href="javascript:switchViews('div__<%# Eval("Day", "{0:d}") %>');">
                                                                        <img id="imgdiv__<%# Eval("Day", "{0:d}") %>" alt="Click to show/hide Daily Attendance" border="0" src="../../Public/global/images/blinds_closed.gif" />
                                                                    </a>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" Width="10%" />
                                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                             </asp:TemplateField>
                                                             <asp:BoundField DataField="Day" HeaderText="Date" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                                             <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                                                             <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    Absent
                                                                </HeaderTemplate>
                                                                <AlternatingItemTemplate>
                                                                    <asp:Label ID="lblAbsent" runat="server" Text='<%# Bind("Absent") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row2">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div__<%# Eval("Day", "{0:d}") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentAttendanceTermDayCourse" runat="server" GridLines="none" Width="95%" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There is currently no attendance for this day">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Section" HeaderText="Sec" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="CourseCode" HeaderText="Code" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Course" HeaderText="Course" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Instructor" HeaderText="Instructor" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="StartTime" HeaderText="Time" DataFormatString="{0:t}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" /> 
                                                                                            <asp:BoundField DataField="Schedule" HeaderText="Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Absent" HeaderText="Absent" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                     
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </div>                                            
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </AlternatingItemTemplate>
                                                                <ItemTemplate>                                
                                                                    <asp:Label ID="lblAbsent" runat="server" Text='<%# Bind("Absent") %>'></asp:Label>
                                                                    </td>
                                                                    </tr>
                                                                    <tr class="row1">
                                                                        <td colspan="100%" align="center">
                                                                            <div id="div__<%# Eval("Day", "{0:d}") %>" style="display:none;position:relative;" >
                                                                                <div style="padding-top:10px;padding-bottom:20px;">
                                                                                    <asp:GridView ID="grdStudentAttendanceTermDayCourse" runat="server" GridLines="none" Width="95%" 
                                                                                        CellPadding="5" BorderColor="#9ABBEE" BorderStyle="Solid" BorderWidth="1px" 
                                                                                        AutoGenerateColumns="false" EmptyDataText="There is currently no attendance for this day">
                                                                                        <HeaderStyle CssClass="tableHdr" />
                                                                                        <AlternatingRowStyle CssClass="row2" />
                                                                                        <RowStyle CssClass="row1" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Section" HeaderText="Sec" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="CourseCode" HeaderText="Code" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Course" HeaderText="Course" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Instructor" HeaderText="Instructor" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="StartTime" HeaderText="Time" DataFormatString="{0:t}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" /> 
                                                                                            <asp:BoundField DataField="Schedule" HeaderText="Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Attend" HeaderText="Attended" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                                                            <asp:BoundField DataField="Absent" HeaderText="Absent" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                                                                                     
                                                                                        </Columns>
                                                                                    </asp:GridView>  
                                                                                </div>                                          
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                <ItemStyle HorizontalAlign="Right" />
                                                             </asp:TemplateField>                                       
                                                         </Columns>                                            
                                                 </asp:GridView>
                                             </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>                                           
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                            <HeaderStyle HorizontalAlign="Center" Width="30px" />
                         </asp:TemplateField>                         
                    </Columns>
             </asp:GridView>
            </div>        
         </div>
      </td>
   </tr>
</table>
<!--EndControl-->

