

Drop table if exists #t1
Drop table if exists #t2


Declare 
@Query_Start_Date DATE,
@Query_End_Date DATE,
@Exclude_Priors DATE,
@AO_Key int,
@PriorYearStart DATE,
@PriorYearEnd Date,
@PriorPurchases int

---------UPDATE THE 4 FIELDS BELOW---------------------------------------------------------------------
set @AO_Key =  --update with AO Key
set @Query_Start_Date =  --update with your query start date
set @Query_End_Date = --update with your query end date
set @PriorPurchases = 1 --IF Prior Purchases type 1, if no Prior Purchases type 0
--------------------------------------------------------------------------------------------------------

If @PriorPurchases = 1
Begin

set @PriorYearStart = dateadd(year, -1, @Query_Start_Date)
set @PriorYearEnd = dateadd(day, -1, @Query_Start_Date)



select distinct
ci.enrollment_datetime,
u.username

into #t1

from
dbo.org o with (nolock)

inner join dbo.[user] u with (nolock)
on o.org_id = u.org_id and u.is_deleted = 0
inner join dbo.course_instance ci with (nolock)
on u.user_id = ci.user_id 
inner join dbo.course_instance_status cis with (nolock)
on cis.course_instance_status_id = ci.course_instance_status_id
inner join dbo.course_category_course_mapping cccm with (nolock)
on ci.course_id = cccm.course_id
inner join dbo.course_category cc with (nolock)
on cccm.course_category_id = cc.course_category_id
inner join dbo.user_student us with (nolock)
on us.user_student_id = ci.user_student_id
inner join dbo.org_node dept with (nolock)
on us.org_node_id = dept.org_node_id and dept.is_deleted = 0
inner join dbo.org_node inst with (nolock)
on dept.parent_org_node_id = inst.org_node_id and inst.is_deleted = 0

where o.is_deleted = 0
and ci.enrollment_datetime >= @PriorYearStart
and ci.enrollment_datetime <= @PriorYearEnd
and ((ci.completion_datetime >= ci.enrollment_datetime) or (ci.completion_datetime is NULL))
and o.external_org_id = @ao_key
and ci.course_instance_interaction_mode_id <> 6
and ((ci.unenrollment_reason_type_id is NULL) or (ci.unenrollment_reason_type_id in ('0', '2', '3', '4')))
and u.username not like '%test%'
and u.last_name not like '%test%'
and cccm.course_category_id = '15042364-D61C-E811-8806-005056B10652'
and ci.course_id not in ('03726C21-D332-E811-A509-005056B133C3') --removing implementation guide



group by 
u.username,
ci.enrollment_datetime


-------------------------
select distinct

us.user_student_id,
inst.org_node_id as Institution_ID,
inst.org_node_name as Institution,
dept.org_node_code as Dept_ID,
dept.org_node_name as Department,
inst.org_node_type_id,
u.last_name,
u.first_name,
u.system_identifier,
u.username,
ci.course_instance_id,
ci.course_name_at_time_of_enrollment,
ci.course_id,
ci.course_instance_id,
ci.course_instance_interaction_mode_id,
ci.estimated_completion_seconds,
cis.description as course_instance_status,
ci.enrollment_datetime,
ci.completion_datetime,
ci.is_deleted,
ci.unenrollment_reason_type_id

from
dbo.org o with (nolock)
inner join dbo.[user] u with (nolock)
on o.org_id = u.org_id and u.is_deleted = 0
inner join dbo.course_instance ci with (nolock)
on u.user_id = ci.user_id 
inner join dbo.course_instance_status cis with (nolock)
on cis.course_instance_status_id = ci.course_instance_status_id
inner join dbo.course_category_course_mapping cccm with (nolock)
on ci.course_id = cccm.course_id
inner join dbo.course_category cc with (nolock)
on cccm.course_category_id = cc.course_category_id
inner join dbo.user_student us with (nolock)
on us.user_student_id = ci.user_student_id
inner join dbo.org_node dept with (nolock)
on us.org_node_id = dept.org_node_id and dept.is_deleted = 0
inner join dbo.org_node inst with (nolock)
on dept.parent_org_node_id = inst.org_node_id and inst.is_deleted = 0

where 
u.username not in (select username from #t1)
and o.is_deleted = 0
and ci.enrollment_datetime >= @Query_Start_Date-- Replace Date Here
and ci.enrollment_datetime <= @Query_End_Date
and ((ci.completion_datetime >= ci.enrollment_datetime) or (ci.completion_datetime is NULL))
and o.external_org_id = @AO_Key
and ci.course_instance_interaction_mode_id <> 6
and ((ci.unenrollment_reason_type_id is NULL) or (ci.unenrollment_reason_type_id in ('0','2', '3', '4')))
and u.username not like '%test%'
and u.last_name not like '%test%'
and cccm.course_category_id = '15042364-D61C-E811-8806-005056B10652'
and ci.course_id not in ('03726C21-D332-E811-A509-005056B133C3') --removing implementation guide


group by 
u.username,
us.user_student_id,
inst.org_node_id,
inst.org_node_name,
dept.org_node_code,
dept.org_node_name,
inst.org_node_type_id,
u.last_name,
u.first_name,
u.system_identifier,
ci.course_instance_id,
ci.course_name_at_time_of_enrollment,
ci.course_id,
ci.course_instance_id,
ci.course_instance_interaction_mode_id,
ci.estimated_completion_seconds,
cis.[description],
ci.enrollment_datetime,
ci.completion_datetime,
ci.is_deleted,
ci.unenrollment_reason_type_id





END;

------------------------------------------
ELSE
BEGIN






select distinct
----------------------------------------------------------------------
us.user_student_id,
on5.org_node_name as on5,
on4.org_node_name as on4,
on3.org_node_name as on3,
inst.org_node_id as Institution_ID,
inst.org_node_name as Institution,
dept.org_node_code as Dept_ID,
dept.org_node_name as Department,
inst.org_node_type_id,
----------------------------------------------------------------------




u.last_name,
u.first_name,
u.system_identifier,
u.username,
ci.course_instance_id,
ci.course_name_at_time_of_enrollment,
ci.course_id,
ci.course_instance_id,
ci.course_instance_interaction_mode_id,
ci.estimated_completion_seconds,
cis.description as course_instance_status,
ci.enrollment_datetime,
ci.completion_datetime,
ci.is_deleted,
ci.unenrollment_reason_type_id





from
dbo.org o with (nolock)
inner join dbo.[user] u with (nolock)
on o.org_id = u.org_id and u.is_deleted = 0
inner join dbo.course_instance ci with (nolock)
on u.user_id = ci.user_id 
inner join dbo.course_instance_status cis with (nolock)
on cis.course_instance_status_id = ci.course_instance_status_id





inner join dbo.course_category_course_mapping cccm with (nolock)
on ci.course_id = cccm.course_id

inner join dbo.course_category cc with (nolock)
on cccm.course_category_id = cc.course_category_id
----------------------------------------------------------------------
inner join dbo.user_student us with (nolock)
on us.user_student_id = ci.user_student_id
inner join dbo.org_node dept with (nolock)
on us.org_node_id = dept.org_node_id and dept.is_deleted = 0
inner join dbo.org_node inst with (nolock)
on dept.parent_org_node_id = inst.org_node_id and inst.is_deleted = 0

inner join dbo.org_node on3 with (nolock)
on inst.parent_org_node_id = on3.org_node_id

inner join dbo.org_node on4 with (nolock)
on on3.parent_org_node_id = on4.org_node_id

inner join dbo.org_node on5 with (nolock)
on on4.parent_org_node_id = on5.org_node_id
----------------------------------------------------------------------

where
((ci.unenrollment_reason_type_id is NULL) or (ci.unenrollment_reason_type_id in ('0', '2', '3', '4')))
and ((ci.completion_datetime >= ci.enrollment_datetime) or (ci.completion_datetime is NULL))

and o.is_deleted = 0
and ci.enrollment_datetime >= @Query_Start_Date  -- Replace Date Here
and ci.enrollment_datetime <= @Query_End_Date
and o.external_org_id = @AO_Key
and ci.course_instance_interaction_mode_id <> 6
and cccm.course_category_id = '15042364-D61C-E811-8806-005056B10652'
and ci.course_id not in ('03726C21-D332-E811-A509-005056B133C3') --removing implementation guide

END
