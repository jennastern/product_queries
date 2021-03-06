Declare
@Query_Start_Date DATE,
@Query_End_Date DATE,
@AO_Key int




---------Update the 3 rows below to your query parameters----------------------------------

set @AO_Key = 1 --update with AO Key
set @Query_Start_Date = '1/1/2021' --update with your query start date
set @Query_End_Date = '1/31/2021' --update with your query end date

---------------------------------------------------------------



select distinct

ci.enrollment_datetime,
ci.course_name_at_time_of_enrollment,
u.username,
u.last_name,
u.first_name,
o.org_name,
inst.org_node_name as Institution,
dept.org_node_name as Department,
ci.course_instance_id,
ci.course_id,
ci.course_instance_interaction_mode_id,
ci.estimated_completion_seconds,
cis.description as course_instance_status,
ci.completion_datetime,
ci.is_deleted,
ci.unenrollment_reason_type_id,

o.external_org_id as AO_Key,
us.user_student_id,
inst.org_node_id as Institution_ID,
dept.org_node_code as Dept_ID,
inst.org_node_type_id
----------------------------------------------
from
dbo.org o with (nolock)
----------------------------------------------------------------------
inner join dbo.[user] u with (nolock)
on o.org_id = u.org_id and u.is_deleted = 0

inner join dbo.course_instance ci with (nolock)
on u.user_id = ci.user_id  	and ci.is_deleted in (0,1)

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
----------------------------------------------------------------------

where o.is_deleted = 0
and ci.enrollment_datetime >= @Query_Start_Date  -- Replace Date Here
and ci.enrollment_datetime <= @Query_End_Date  -- Replace Date Here

and u.username not like '%test%'
and u.last_name not like '%test%'
and o.external_org_id = @AO_Key 

and ((ci.unenrollment_reason_type_id not in ('1','5')) or (ci.unenrollment_reason_type_id is null)) --remove unenrollments where record shouldn't be counted

and ((ci.enrollment_datetime <= ci.completion_datetime) or (ci.completion_datetime is null)) --remove imported records

and ci.course_instance_interaction_mode_id <> 6 --remove exempt users from data


and ci.course_id in (

'443061D2-F1ED-EA11-A251-005056B15B8C'

)

order by 1