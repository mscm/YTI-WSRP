IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WSRP_GetStudentAttendanceTerm]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WSRP_GetStudentAttendanceTerm]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Gets Student Attendance By Term
-- =============================================
CREATE PROCEDURE [dbo].[WSRP_GetStudentAttendanceTerm] 
	@SyStudentID INT
AS
BEGIN
	SET NOCOUNT ON;
	--Get Student Attendance By Term
    SELECT		AdEnrollTerm.AdEnrollTermID,
				AdTerm.Descrip AS Term,
				AdProgram.Descrip AS Program,			
				Attend = (SELECT CAST((SUM(adenrollsched.MinutesAttended)/60.0 )AS DECIMAL(10,2)) FROM AdEnrollSched (NOLOCK) WHERE AdEnrollSched.AdEnrollID = AdEnroll.AdEnrollID AND AdEnrollSched.AdTermID = AdEnrollTerm.AdTermID),
				Absent = (SELECT CAST((SUM(adenrollsched.MinutesAbsent)/60.0 )AS DECIMAL(10,2)) FROM AdEnrollSched (NOLOCK) WHERE AdEnrollSched.AdEnrollID = AdEnroll.AdEnrollID AND AdEnrollSched.AdTermID = AdEnrollTerm.AdTermID),
				AttendanceWarning =		(	
											CASE
												WHEN EXISTS(SELECT DISTINCT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 634 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate) THEN 1
												ELSE 0
											END
										),
				AttendanceWarningDate = (
											CASE
												WHEN EXISTS(SELECT DISTINCT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 634 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate) THEN (SELECT TOP 1 CONVERT(VARCHAR, CmEvent.DueDate, 101) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 634 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate ORDER BY CmEvent.DueDate DESC)
												ELSE NULL
											END
										),
				AttendanceProbation =	(	
											CASE
												WHEN EXISTS(SELECT DISTINCT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 166 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate) THEN 1
												ELSE 0
											END
										),
				AttendanceProbationDate =	(
												CASE
													WHEN EXISTS(SELECT DISTINCT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 166 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate) THEN (SELECT TOP 1 CONVERT(VARCHAR, CmEvent.DueDate, 101) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 166 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate ORDER BY CmEvent.DueDate DESC)
													ELSE NULL
												END
											),
				TardyCount =	(SELECT COUNT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 564 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate),
				TardyWarning =			(	
											CASE
												WHEN EXISTS(SELECT DISTINCT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 726 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate) THEN 1
												ELSE 0
											END
										),
				TardyWarningDate =	(
										CASE
											WHEN EXISTS(SELECT DISTINCT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 726 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate) THEN (SELECT TOP 1 CONVERT(VARCHAR, CmEvent.DueDate, 101) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 726 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate ORDER BY CmEvent.DueDate DESC)
											ELSE NULL
										END
									),
				TardyProbation =		(	
											CASE
												WHEN EXISTS(SELECT DISTINCT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 607 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate) THEN 1
												ELSE 0
											END
										),
				TardyProbationDate =	(
											CASE
												WHEN EXISTS(SELECT DISTINCT(CmEvent.CmEventID) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 607 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate) THEN (SELECT TOP 1 CONVERT(VARCHAR, CmEvent.DueDate, 101) FROM CmEvent (NOLOCK) WHERE CmEvent.CmTemplateID = 607 AND CmEvent.SyStudentID = @SyStudentId AND CmEvent.AdEnrollID = adenroll.AdEnrollID AND CmEvent.DueDate BETWEEN AdTerm.StartDate AND AdTerm.EndDate ORDER BY CmEvent.DueDate DESC)
												ELSE NULL
											END
										)
	FROM		AdEnrollTerm (NOLOCK) join 
				AdTerm (NOLOCK) ON
					AdEnrollTerm.AdTermid  = AdTerm.AdTermID JOIN
				AdEnroll (NOLOCK) ON
					AdEnrollTerm.AdEnrollID = AdEnroll.AdEnrollID JOIN
				AdProgram (NOLOCK) ON
					AdEnroll.AdProgramID = AdProgram.AdProgramID LEFT JOIN
				AdTermOnLineRegistration (NOLOCK) ON
					AdTerm.AdTermID = AdTermOnLineRegistration.AdTermID AND AdTermOnLineRegistration.SyCampusID = adenroll.SyCampusID	
	WHERE		AdEnrollTerm.SyStudentID = @SyStudentId
				AND (GetDate() >= ISNULL(AdTermOnLineRegistration.DateScheduleAvailable, GETDATE())
				OR (adTerm.StartDate IS NULL AND AdTerm.EndDate IS NULL))
	ORDER BY	AdTerm.Code DESC, AdTerm.Descrip, AdProgram.Descrip
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WSRP_GetStudentAttendanceTermCourse]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WSRP_GetStudentAttendanceTermCourse]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =======================================================
-- Description:	Gets Student Attendance For Term By Course
-- =======================================================
CREATE PROCEDURE [dbo].[WSRP_GetStudentAttendanceTermCourse] 
	@AdEnrollTermId INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT		AdClassSched.Section,
				AdCourse.Code as CourseCode,
				AdCourse.Descrip AS Course,
				systaff.descrip as Instructor,
				CAST(CAST(CAST(AdEnrollSched.MinutesAttended / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdEnrollSched.MinutesAttended AS VARCHAR) + ' min)' AS VARCHAR) AS Attend,
				CAST(CAST(CAST(AdEnrollSched.MinutesAbsent / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdEnrollSched.MinutesAbsent AS VARCHAR) + ' min)' AS VARCHAR) AS Absent,		
				AdEnrollSched.AdEnrollSchedId
	FROM		AdEnrollSched (NOLOCK) INNER JOIN
				AdClassSched (NOLOCK) ON
					AdEnrollSched.AdClassSchedID = AdClassSched.AdClassSchedID INNER JOIN
				AdEnrollTerm (NOLOCK) ON
					AdEnrollSched.AdTermID = AdEnrollTerm.AdTermID AND AdEnrollSched.AdEnrollID = AdEnrollTerm.AdEnrollID LEFT JOIN
				AdCourse (NOLOCK) ON
					AdEnrollSched.AdCourseID = AdCourse.AdCourseID LEFT JOIN
				systaff (NOLOCK) ON
					AdClassSched.AdTeacherID = SyStaff.systaffid
	WHERE		AdEnrollTerm.AdEnrollTermID = @AdEnrollTermId
	ORDER BY    AdCourse.Descrip	
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WSRP_GetStudentAttendanceTermCourseDay]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WSRP_GetStudentAttendanceTermCourseDay]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Description:	Gets Student Attendance For Term and Course By Day
-- ===============================================================
CREATE PROCEDURE [dbo].[WSRP_GetStudentAttendanceTermCourseDay] 
	@AdEnrollSchedId INT
AS
BEGIN
	SET NOCOUNT ON;
	--First Get Attendance Type
	DECLARE @AttendanceType CHAR(1)
	
	SELECT @AttendanceType = (SELECT AttendanceType FROM AdClassSched (NOLOCK) INNER JOIN AdEnrollSched (NOLOCK) ON AdClassSched.AdClassSchedID = AdEnrollSched.AdClassSchedID WHERE AdEnrollSched.AdEnrollSchedId = @AdEnrollSchedId)

	--If Time Absent Posting Type then return Data from AdClassAttend and AdAttend
	IF @AttendanceType = 'A'
		BEGIN
			SELECT		AdClassAttend.Date as [Day],
						AdClassAttend.StartTime as [Time],
						CAST(CAST(CAST(AdClassAttend.LengthMinutes / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdClassAttend.LengthMinutes AS VARCHAR) + ' min)' AS VARCHAR) as Scheduled,
						RTRIM(LTRIM(AdRoom.Descrip)) as Room,
						CASE AdClassAttend.Status
							WHEN 'C' THEN 'Cancelled'
							WHEN 'P' THEN 'Posted'
							WHEN 'H' THEN 'Holiday'
							WHEN 'S' THEN 'Scheduled'
						END AS [Status],
						CAST(CAST(CAST(AdAttend.Attend / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdAttend.Attend AS VARCHAR) + ' min)' AS VARCHAR) as Attend,
						CAST(CAST(CAST(AdAttend.Absent / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdAttend.Absent AS VARCHAR) + ' min)' AS VARCHAR) as Absent
			FROM		AdEnrollSched (NOLOCK) INNER JOIN
						AdClassSched (NOLOCK) ON
							AdEnrollSched.AdClassSchedID = AdClassSched.AdClassSchedID INNER JOIN
						AdClassAttend (NOLOCK) ON
							AdClassSched.AdClassSchedID = AdClassAttend.AdClassSchedID LEFT JOIN
						AdAttend (NOLOCK) ON
							AdAttend.AdClassAttendID = AdClassAttend.AdClassAttendID AND AdAttend.AdEnrollSchedID = AdEnrollSched.AdEnrollSchedId LEFT JOIN
						AdRoom (NOLOCK) ON
							AdClassAttend.AdRoomID = AdRoom.AdRoomID
			WHERE		AdEnrollSched.AdEnrollSchedID = @AdEnrollSchedId
			ORDER BY	AdClassAttend.Date, AdClassAttend.StartTime
		END
		
	--If Time Attended Posting Type then return Data from AdAttend only
	IF @AttendanceType = 'P'
		BEGIN
			SELECT		AdAttend.Date as [Day],
						NULL as [Time],
						NULL as Scheduled,
						NULL as Room,
						'Posted' as [Status],
						CAST(CAST(CAST(AdAttend.Attend / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdAttend.Attend AS VARCHAR) + ' min)' AS VARCHAR) AS Attend,
						NULL as Absent
			FROM		AdAttend (NOLOCK) 
			WHERE		AdAttend.AdEnrollSchedID = @AdEnrollSchedId
			ORDER BY	AdAttend.Date
		END	
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WSRP_GetStudentAttendanceTermDay]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WSRP_GetStudentAttendanceTermDay]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ====================================================
-- Description:	Gets Student Attendance For Term by Day
-- ====================================================
CREATE PROCEDURE [dbo].[WSRP_GetStudentAttendanceTermDay] 
	@AdEnrollTermId INT
AS
BEGIN
	SET NOCOUNT ON;
	--Get Days of Attendance for Time Absent Type
	SELECT DISTINCT		AdClassAttend.Date as [Day],
						CAST(CAST(CAST(SUM(AdAttend.Attend) / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(SUM(AdAttend.Attend) AS VARCHAR) + ' min)' AS VARCHAR) AS Attend,
						CAST(CAST(CAST(SUM(AdAttend.Absent) / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(SUM(AdAttend.Absent) AS VARCHAR) + ' min)' AS VARCHAR) AS Absent
	FROM				AdEnrollTerm (NOLOCK) INNER JOIN
						AdEnrollSched (NOLOCK) ON
							AdEnrollTerm.AdTermID = AdEnrollSched.AdTermID AND AdEnrollTerm.AdEnrollID = AdEnrollSched.AdEnrollID INNER JOIN
						AdClassSched (NOLOCK) ON
							AdEnrollSched.AdClassSchedID = AdClassSched.AdClassSchedID INNER JOIN
						AdClassAttend (NOLOCK) ON
							AdClassSched.AdClassSchedID = AdClassAttend.AdClassSchedID LEFT JOIN
						AdAttend (NOLOCK) ON
							AdClassAttend.AdClassAttendID = AdAttend.AdClassAttendID AND AdEnrollSched.AdEnrollSchedId = AdAttend.AdEnrollSchedId
	WHERE				AdEnrollTerm.AdEnrollTermId = @AdEnrollTermId AND AdClassSched.AttendanceType = 'A'
	GROUP BY			AdClassAttend.Date

	UNION
	
	--Get Days of Attendance for Time Posting Type
	SELECT DISTINCT		AdAttend.Date as [Day],
						CAST(CAST(CAST(SUM(AdAttend.Attend) / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(SUM(AdAttend.Attend) AS VARCHAR) + ' min)' AS VARCHAR) AS Attend,
						CAST(CAST(CAST(SUM(AdAttend.Absent) / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(SUM(AdAttend.Absent) AS VARCHAR) + ' min)' AS VARCHAR) AS Absent
	FROM				AdEnrollTerm (NOLOCK) INNER JOIN
						AdEnrollSched (NOLOCK) ON
							AdEnrollTerm.AdTermID = AdEnrollSched.AdTermID AND AdEnrollTerm.AdEnrollID = AdEnrollSched.AdEnrollID INNER JOIN
						AdClassSched (NOLOCK) ON
							AdEnrollSched.AdClassSchedID = AdClassSched.AdClassSchedID INNER JOIN
						AdAttend (NOLOCK) ON
							AdEnrollSched.AdEnrollSchedId = AdAttend.AdEnrollSchedID 
	WHERE				AdEnrollTerm.AdEnrollTermId = @AdEnrollTermId AND AdClassSched.AttendanceType = 'P'
	GROUP BY			AdAttend.Date
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WSRP_GetStudentAttendanceTermDayCourse]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WSRP_GetStudentAttendanceTermDayCourse]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Description:	Gets Student Attendance For Term and Day By Course
-- ===============================================================
CREATE PROCEDURE [dbo].[WSRP_GetStudentAttendanceTermDayCourse] 
	@AdEnrollTermId INT, @Date Date
AS
BEGIN
	SET NOCOUNT ON;
	SELECT		AdClassSched.Section,
				AdCourse.Code as CourseCode,
				AdCourse.Descrip AS Course,
				systaff.descrip as Instructor,
				AdClassAttend.StartTime,
				CAST(CAST(CAST(AdClassAttend.LengthMinutes / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdClassAttend.LengthMinutes AS VARCHAR) + ' min)' AS VARCHAR) as Schedule,
				AdRoom.Descrip AS Room,
				CASE AdClassAttend.Status
							WHEN 'C' THEN 'Cancelled'
							WHEN 'P' THEN 'Posted'
							WHEN 'H' THEN 'Holiday'
							WHEN 'S' THEN 'Scheduled'
						END AS [Status],
				CAST(CAST(CAST(AdAttend.Attend / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdAttend.Attend AS VARCHAR) + ' min)' AS VARCHAR) AS Attend,
				CAST(CAST(CAST(AdAttend.Absent / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdAttend.Absent AS VARCHAR) + ' min)' AS VARCHAR) AS Absent
	FROM		AdEnrollTerm (NOLOCK) INNER JOIN
				AdEnrollSched (NOLOCK) ON
					AdEnrollTerm.AdTermID = AdEnrollSched.AdTermID AND AdEnrollTerm.AdEnrollID = AdEnrollSched.AdEnrollID INNER JOIN
				AdClassSched (NOLOCK) ON
					AdEnrollSched.AdClassSchedID = AdClassSched.AdClassSchedID INNER JOIN
				AdClassAttend (NOLOCK) ON
					AdClassSched.AdClassSchedID = AdClassAttend.AdClassSchedID LEFT JOIN
				AdAttend (NOLOCK) ON
					AdClassAttend.AdClassAttendId = AdAttend.AdClassAttendID AND AdEnrollSched.AdEnrollSchedID = AdAttend.AdEnrollSchedID LEFT JOIN
				AdCourse (NOLOCK) ON
					AdEnrollSched.AdCourseID = AdCourse.AdCourseID LEFT JOIN
				systaff (NOLOCK) ON
					AdClassSched.AdTeacherID = SyStaff.systaffid LEFT JOIN
				AdRoom (NOLOCK) ON
					AdClassAttend.AdRoomID = AdRoom.adroomid
	WHERE		AdClassAttend.Date = @Date and AdEnrollTerm.AdEnrollTermID = @AdEnrollTermId AND AdClassSched.AttendanceType = 'A'

	UNION

	SELECT		AdClassSched.Section,
				AdCourse.Code as CourseCode,
				AdCourse.Descrip AS Course,
				systaff.descrip as Instructor,
				NULL,
				NULL as ScheduledMinutes,
				NULL AS Room,
				'Posted' AS [Status],
				CAST(CAST(CAST(AdAttend.Attend / 60.0 AS Decimal(10,2)) AS VARCHAR) + ' hr (' +CAST(AdAttend.Attend AS VARCHAR) + ' min)' AS VARCHAR) AS Attend,
				NULL AS Absent
	FROM		AdAttend (NOLOCK) INNER JOIN
				AdEnrollSched (NOLOCK) ON
					AdAttend.AdEnrollSchedID = AdEnrollSched.AdEnrollSchedID INNER JOIN
				AdEnrollTerm (NOLOCK) ON
					AdEnrollSched.AdTermID = AdEnrollTerm.AdTermID AND AdEnrollSched.AdEnrollID = AdEnrollTerm.AdEnrollID INNER JOIN
				AdClassSched (NOLOCK) ON
					AdEnrollSched.AdClassSchedID = AdClassSched.AdClassSchedID LEFT JOIN
				AdCourse (NOLOCK) ON
					AdEnrollSched.AdCourseID = AdCourse.AdCourseID LEFT JOIN
				systaff (NOLOCK) ON
					AdClassSched.AdTeacherID = SyStaff.systaffid
	WHERE		AdAttend.Date = @Date and AdEnrollTerm.AdEnrollTermID = @AdEnrollTermId AND AdClassSched.AttendanceType = 'P'
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WSRP_GetStudentTermGrades]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WSRP_GetStudentTermGrades]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Get Student Term Grades
-- =============================================

CREATE PROCEDURE [dbo].[WSRP_GetStudentTermGrades] 
	@SyStudentId INT
AS
BEGIN
	SET NOCOUNT ON;
	--Get Student Term Grades
    SELECT		AdEnrollTerm.AdEnrollTermID,
				AdTerm.Descrip as Term,
				AdProgram.Descrip as Program,
				CASE 
					WHEN GETDATE() NOT BETWEEN AdTerm.StartDate AND AdTerm.EndDate THEN CAST(CAST(AdEnrollTerm.curcreditsearned AS Numeric(9,2)) AS Varchar)
					ELSE 'In Progress' END AS CurrentCreditsEarn, 
				CASE 
					WHEN GETDATE() NOT BETWEEN AdTerm.StartDate AND AdTerm.EndDate THEN CAST(CAST(AdEnrollTerm.CurCreditsAttempt AS Numeric(9,2)) AS Varchar)
					ELSE 'In Progress' END AS CurrentCreditsAtt, 
				CASE 
					WHEN GETDATE() NOT BETWEEN AdTerm.StartDate AND AdTerm.EndDate THEN CAST(CAST(AdEnrollTerm.StudentCurGPA AS Numeric(9,2)) AS Varchar)
					ELSE 'In Progress' END AS CurrentGPA, 
				CASE 
					WHEN GETDATE() NOT BETWEEN AdTerm.StartDate AND AdTerm.EndDate THEN CAST(CAST(AdEnrollTerm.StudentCumGPA AS Numeric(9,2)) AS Varchar)
					ELSE 'In Progress' END AS CumGPA
	FROM		SyStudent (NOLOCK) INNER JOIN
				AdEnroll (NOLOCK) ON
					systudent.SyStudentId = adenroll.SyStudentID INNER JOIN
				AdEnrollTerm (NOLOCK) ON
					adenroll.AdEnrollID = AdEnrollTerm.AdEnrollID INNER JOIN
				AdTerm (NOLOCK) ON
					AdEnrollTerm.AdTermID = AdTerm.AdTermID INNER JOIN
				AdProgram (NOLOCK) ON
					adenroll.AdProgramID = AdProgram.AdProgramID LEFT JOIN
				AdTermOnLineRegistration (NOLOCK) ON
					AdTerm.AdTermID = AdTermOnLineRegistration.AdTermID AND AdTermOnLineRegistration.SyCampusID = adenroll.SyCampusID
	WHERE		systudent.SyStudentId = @SyStudentId
				AND (GetDate() >= ISNULL(AdTermOnLineRegistration.DateScheduleAvailable, GETDATE())
				OR (adTerm.StartDate IS NULL AND AdTerm.EndDate IS NULL))
	ORDER BY	AdTerm.StartDate DESC, AdProgram.Descrip
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WSRP_GetStudentCourseGrades]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WSRP_GetStudentCourseGrades]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Get Student Course Grades for Term and Enrollment
-- =============================================
CREATE PROCEDURE [dbo].[WSRP_GetStudentCourseGrades] 
	@AdEnrollTermId INT
AS
BEGIN
	SET NOCOUNT ON;
	--Get Student Course Grades for Term and Enrollment
     SELECT		AdCourse.Code as CourseCode,
				AdCourse.Descrip AS Course,
				InProgressGrade =	(
										CASE 
											WHEN (SELECT SUM(AdEnrollLesson.PctFinalGrade) FROM AdEnrollLesson (NOLOCK) WHERE AdEnrollLesson.AdEnrollSchedID = AdEnrollSched.AdEnrollSchedID) = 0 THEN CAST('N/A' AS VARCHAR)
											ELSE ISNULL(CAST(CAST(CAST(AdEnrollSched.InProgressGrade as Numeric(9,2)) as VARCHAR) + ' % (' + RTRIM(LTRIM(dbo.WSRP_GetGradeLetterFromNumber(AdEnrollSched.InProgressGrade, AdEnrollSched.AdEnrollSchedID))) + ')' as VARCHAR), CAST('N/P' AS VARCHAR))
										END
									),
				ISNULL(CAST(CAST(CAST(AdEnrollSched.MidTermNumericGrade as Numeric(9,2)) as VARCHAR) + ' % (' + RTRIM(LTRIM(AdEnrollSched.MidTermGradeLetterCode)) + ')' as VARCHAR), ISNULL(LTRIM(RTRIM(Adenrollsched.MidTermGradeLetterCode)), 'N/P')) AS MidTermGrade,
				FinalGrade = (SELECT CASE WHEN AdTermOnlineRegistration.DateGradesAvail < GETDATE() OR AdTermOnlineRegistration.DateGradesAvail IS NULL THEN ISNULL(CAST(CAST(CAST(AdEnrollSched.NumericGrade as Numeric(9,2)) as VARCHAR) + ' % (' + RTRIM(LTRIM(AdEnrollSched.AdGradeLetterCode)) + ')' as VARCHAR), ISNULL(LTRIM(RTRIM(Adenrollsched.adgradelettercode)), CAST('N/P' AS VARCHAR))) ELSE 'N/A' END),
				AdEnrollSched.AdEnrollSchedId
	FROM		syStudent (NOLOCK) INNER JOIN
				AdEnroll (NOLOCK) ON
					syStudent.syStudentID = AdEnroll.syStudentID INNER JOIN
				AdEnrollSched (NOLOCK) ON
					AdEnroll.AdEnrollID = AdEnrollSched.AdEnrollID INNER JOIN
				AdEnrollTerm (NOLOCK) ON
					AdEnrollSched.AdTermID = AdEnrollTerm.AdTermID AND AdEnrollSched.AdEnrollID = AdEnrollTerm.AdEnrollID INNER JOIN
				AdTerm (NOLOCK) ON
					AdEnrollSched.AdTermID = AdTerm.AdTermID LEFT JOIN
				AdTermOnLineRegistration (NOLOCK) ON
					AdTerm.AdTermID = AdTermOnLineRegistration.AdTermID AND AdEnroll.SyCampusID = AdTermOnLineRegistration.SyCampusID INNER JOIN
				AdCourse (NOLOCK) ON
					AdEnrollSched.AdCourseID = AdCourse.AdCourseID
	WHERE		AdEnrollTerm.AdEnrollTermID = @AdEnrollTermId
	ORDER BY    AdCourse.Descrip
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WSRP_GetStudentCourseLessonGrades]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WSRP_GetStudentCourseLessonGrades]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Get Student Lesson Grades for Course
-- =============================================
CREATE PROCEDURE [dbo].[WSRP_GetStudentCourseLessonGrades] 
	@AdEnrollSchedId INT
AS
BEGIN
	SET NOCOUNT ON;
	--Get Student Lesson Grades for Course
    SELECT		AdClassLesson.LessonNumber,
				AdClassLesson.Descrip,
				AdLessonType.Descrip AS LessonType,				
				PctFinalGrade = (AdClassLesson.PctFinalGrade * 100),
				ISNULL(CAST(CAST(CAST(AdEnrollLesson.NumericGrade as Numeric(9,2)) as VARCHAR) + ' % (' + RTRIM(LTRIM(dbo.WSRP_GetGradeLetterFromNumber(AdEnrollLesson.NumericGrade, AdEnrollLesson.AdEnrollSchedID))) + ')' as VARCHAR), CAST('N/P' AS VARCHAR)) AS LessonGrade
	FROM		AdEnrollLesson (NOLOCK) INNER JOIN
				AdClassLesson (NOLOCK) ON
					adenrolllesson.adclasslessonid = adclasslesson.adclasslessonid INNER JOIN
				AdLessonType (NOLOCK) ON
					adclasslesson.adlessontypeid = adlessontype.adlessontypeid
	WHERE		AdEnrollLesson.AdEnrollSchedID = @AdEnrollSchedId
	ORDER BY	AdClassLesson.LessonNumber
END

GO