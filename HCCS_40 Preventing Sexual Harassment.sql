
Declare
@Query_Start_Date DATE,
@Query_End_Date DATE,
@AO_Key int




---------Update the 3 rows below to your query parameters----------------------------------

set @AO_Key =  --update with AO Key
set @Query_Start_Date = --update with your query start date
set @Query_End_Date =  --update with your query end date

---------------------------------------------------------------


select distinct
----------------------------------------------------------------------
us.user_student_id,
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
ci.unenrollment_reason_type_id,
ci.course_instance_status_id





from
dbo.org o with (nolock)
inner join dbo.[user] u with (nolock)
on o.org_id = u.org_id and u.is_deleted = 0
inner join dbo.course_instance ci with (nolock)
on u.user_id = ci.user_id and ci.is_deleted = 0
inner join dbo.course_instance_status cis with (nolock)
on cis.course_instance_status_id = ci.course_instance_status_id



----------------------------------------------------------------------
inner join dbo.user_student us with (nolock)
on us.user_student_id = ci.user_student_id
inner join dbo.org_node dept with (nolock)
on us.org_node_id = dept.org_node_id and dept.is_deleted = 0
inner join dbo.org_node inst with (nolock)
on dept.parent_org_node_id = inst.org_node_id and inst.is_deleted = 0
----------------------------------------------------------------------

where o.is_deleted = 0
and ci.enrollment_datetime >= @Query_Start_Date  -- Replace Date Here
and ci.enrollment_datetime <= @Query_End_Date
and o.external_org_id = @AO_Key

and ci.course_instance_interaction_mode_id <> 6
 and u.username not like '%test%'
and u.last_name not like '%test%'


and ((ci.unenrollment_reason_type_id not in ('1','5')) or (ci.unenrollment_reason_type_id is null)) --remove unenrollments where record shouldn't be counted

and ((ci.enrollment_datetime <= ci.completion_datetime) or (ci.completion_datetime is null)) --remove imported records


 and ci.course_id in (

'b5c24e26-d663-e611-bd47-005056b17803',
'395f76b8-bb63-e611-bd47-005056b17803',
'31c4d612-bf63-e611-bd47-005056b17803',
'27ebf8a7-c263-e611-bd47-005056b17803',
'631ab195-c463-e611-bd47-005056b17803',
'b4133cf2-c563-e611-bd47-005056b17803',
'd8f99f57-c663-e611-bd47-005056b17803',
'f68492d5-c663-e611-bd47-005056b17803',
'0d02ca54-c863-e611-bd47-005056b17803',
'c1b632db-c863-e611-bd47-005056b17803',
'84347612-a083-e811-bb5c-005056b14d10',
'a34a5b41-d463-e611-bd47-005056b17803',
'1577f202-ac5a-e811-9d98-005056b130ef'

)

order by 1

