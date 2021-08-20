

Declare
@Query_Start_Date DATE,
@Query_End_Date DATE,
@AO_Key int




---------Update the 3 rows below to your query parameters----------------------------------

set @AO_Key = 50005 --update with AO Key
set @Query_Start_Date = '6/1/2021' --update with your query start date
set @Query_End_Date = '8/20/2021' --update with your query end date

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
----------------------------------------------------------------------

where o.is_deleted = 0
and ci.enrollment_datetime >= @Query_Start_Date  -- Replace Date Here
and ci.enrollment_datetime <= @Query_End_Date
and o.external_org_id = @AO_Key

and ci.course_instance_interaction_mode_id <> 6

and ci.course_id in (
'99306077-3AA1-11DC-B824-001517135123',
'607AC975-8FC8-E211-97A9-001517135213',
'C6AE7D88-22AF-E011-B8A9-001517135213',
'208EE82D-23AF-E011-B8A9-001517135213',
'1DCFCE1D-26AF-E011-B8A9-001517135213',
'4050C20C-F2B2-E011-B8A9-001517135213',
'CC7530B1-F2B2-E011-B8A9-001517135213',
'366B618B-F7B2-E011-B8A9-001517135213',
'11405D99-FCB2-E011-B8A9-001517135213',
'30104330-FDB2-E011-B8A9-001517135213',
'661D55D3-FDB2-E011-B8A9-001517135213',
'9F477D55-80AA-E111-9DC1-001517135351',
'5D83A5A4-CEAC-E011-80A1-001517135401',
'6D1ACB6A-ACAE-E211-8AF1-001517135401',
'E122DDED-8CAB-E311-8AD1-001517135511',
'E122DDED-8CAB-E311-8AD1-001517135511',
'30DE5AC9-FCD3-E011-A1D1-001517135511',
'8D6F053F-6C6C-11DC-9E22-001517135513',
'377E690F-B68B-E011-8FB9-001517135721',
'2CD16749-F420-E111-8FB9-001517135721',
'CDD1A557-2C27-11DD-914D-0015171C1A75',
'CDD1A557-2C27-11DD-914D-0015171C1A75',
'CDD1A557-2C27-11DD-914D-0015171C1A75',
'049D12C2-1B66-E011-99B6-0015171C1A75',
'049D12C2-1B66-E011-99B6-0015171C1A75',
'816830C4-1F66-E011-99B6-0015171C1A75',
'816830C4-1F66-E011-99B6-0015171C1A75',
'CC4AFCE7-2066-E011-99B6-0015171C1A75',
'CC4AFCE7-2066-E011-99B6-0015171C1A75',
'99B1E31F-2266-E011-99B6-0015171C1A75',
'99B1E31F-2266-E011-99B6-0015171C1A75',
'D57F340B-6F03-11DD-ACD5-0015171C1A75',
'D57F340B-6F03-11DD-ACD5-0015171C1A75',
'D57F340B-6F03-11DD-ACD5-0015171C1A75',
'EB0EBD58-56BF-11DE-B094-0015171C1A75',
'EE0AE773-668C-E011-AC12-0015171C1B93',
'A9B3562A-6A8C-E011-AC12-0015171C1B93',
'AAC87687-6C8C-E011-AC12-0015171C1B93',
'0976DA07-7B8C-E011-AC12-0015171C1B93',
'2F40F66E-40AE-E011-AC12-0015171C1B93',
'0DEA083E-41AE-E011-AC12-0015171C1B93',
'BAC6FA25-43AE-E011-AC12-0015171C1B93',
'A174C0E2-43AE-E011-AC12-0015171C1B93',
'0ED0BFBC-44AE-E011-AC12-0015171C1B93',
'5D99C27A-45AE-E011-AC12-0015171C1B93',
'BE0056BE-4AAE-E011-AC12-0015171C1B93',
'EA632E6E-4BAE-E011-AC12-0015171C1B93',
'E3CB3B18-4CAE-E011-AC12-0015171C1B93',
'E57498BC-4CAE-E011-AC12-0015171C1B93',
'A2FFDDB5-4DAE-E011-AC12-0015171C1B93',
'E638829D-4EAE-E011-AC12-0015171C1B93',
'4719C55E-4FAE-E011-AC12-0015171C1B93',
'117729FD-4FAE-E011-AC12-0015171C1B93',
'52577D1B-56AE-E011-AC12-0015171C1B93',
'EF398B5B-59AE-E011-AC12-0015171C1B93',
'3E8DCA20-5AAE-E011-AC12-0015171C1B93',
'9B39961C-5BAE-E011-AC12-0015171C1B93',
'4F0CA299-5CAE-E011-AC12-0015171C1B93',
'FF7A5738-5DAE-E011-AC12-0015171C1B93',
'3443DF79-42B2-E011-875E-0015171C5BB1',
'8E5C6AD3-43B2-E011-875E-0015171C5BB1',
'8E5C6AD3-43B2-E011-875E-0015171C5BB1',
'49209758-44B2-E011-875E-0015171C5BB1',
'49209758-44B2-E011-875E-0015171C5BB1',
'ED5D17DE-44B2-E011-875E-0015171C5BB1',
'3023BF5C-45B2-E011-875E-0015171C5BB1',
'E7DC1D61-EDDA-E011-8107-0015171C5BB3',
'182D6E1E-EC49-E111-8642-0015171C5BB3',
'C2C12D17-65D1-E311-9260-0015171C5BB3',
'0B5EB9C8-F2A0-E011-99AA-0015171C5BB3',
'94CA9305-7CAD-E011-99AA-0015171C5BB3',
'FB331FE0-7CAD-E011-99AA-0015171C5BB3',
'872A41D3-7DAD-E011-99AA-0015171C5BB3',
'F1AA498F-7EAD-E011-99AA-0015171C5BB3',
'A05E5758-7FAD-E011-99AA-0015171C5BB3',
'BD6DB920-80AD-E011-99AA-0015171C5BB3',
'2C37D2FF-84AD-E011-99AA-0015171C5BB3',
'71BB34D5-85AD-E011-99AA-0015171C5BB3',
'C5381C96-86AD-E011-99AA-0015171C5BB3',
'FFBE263A-87AD-E011-99AA-0015171C5BB3',
'12D1DCE9-87AD-E011-99AA-0015171C5BB3',
'EF1176B7-88AD-E011-99AA-0015171C5BB3',
'7F47F822-31C9-E211-BD23-0015171C5BB3',
'AD147291-34C9-E211-BD23-0015171C5BB3',
'01DBCF2D-39C9-E211-BD23-0015171C5BB3',
'DE2DDD51-3FC9-E211-BD23-0015171C5BB3',
'8F678FCC-3498-E411-B5CF-005056B10657',
'44CD2EC9-8404-E511-BB0E-005056B10657',
'BBC966AF-8504-E511-BB0E-005056B10657',
'F31344FA-8604-E511-BB0E-005056B10657',
'420CC1A5-7521-E411-80A9-005056B10E33',
'6D11C11F-BF65-E411-B549-005056B10E33',
'47CD2EE3-2EDD-E811-B654-005056B11EEE',
'254AFC31-714D-E411-A2B9-005056B130EF',
'05BBB432-8037-E411-AE60-005056B130EF',
'3066C6FA-7F63-E511-9BA5-005056B136CB',
'28FB1E0C-988A-E411-9566-005056B141CC',
'C0E00F13-690B-E411-AD18-005056B141CC',
'C5AC2BD6-8704-E511-9673-005056B1522B',
'BE0FA70B-2F08-E411-A041-005056B1680C',
'2310CAF2-7279-E411-B504-005056B1680C',
'6E15DCFC-3708-E411-82B4-005056B16BE3',
'6CDB9F8F-411C-E511-B0DE-005056B16BE3',
'71453200-431C-E511-B0DE-005056B16BE3',
'B9FA5AE1-D7D0-4766-A2F4-01770C300FBF',
'6B326DAA-3D53-44C6-9914-023F56DFCAF7',
'A230DDA4-32D7-4947-BA67-07102164976A',
'D757B432-81B0-447B-B0B9-0738109F172B',
'4B0AB6B8-9350-4142-9BFE-08EEE35D8E31',
'4B0AB6B8-9350-4142-9BFE-08EEE35D8E31',
'35B7D007-AE40-4584-A1BB-0C45C9D2CBB8',
'3A92F152-5B98-4E37-8863-1153EC364808',
'EE655AE7-C64A-446E-A398-150CBD17B189',
'0B752411-D99A-44A7-8625-1A7F806AE031',
'0B752411-D99A-44A7-8625-1A7F806AE031',
'89692D58-0942-4BBB-A395-1AF46A09FE63',
'CCF7C0D7-1FED-463B-AE60-1FC88E9C2B6C',
'648BD18D-CA04-46EE-B348-1FEB0030336B',
'3E2FDCF1-D7C4-4C64-98A1-22314F9CB518',
'893BB03B-02AC-4528-8A82-22DD68FC9C2A',
'D0E263FD-79BA-4923-AB02-23065E45A30B',
'D0E263FD-79BA-4923-AB02-23065E45A30B',
'B5AF5C4C-7DCE-4F11-8F58-27A0E0499397',
'5EB5C01D-0BFD-4015-8F41-2C032CB339AF',
'5EB5C01D-0BFD-4015-8F41-2C032CB339AF',
'71BF7D10-BE9C-433D-BA1C-2C41D14C1322',
'63C02523-68DE-4F61-9BA8-2E3CABD9AF11',
'31A52CF0-0742-4D03-96E6-2EA04AA6545F',
'C483BEA1-0BD7-4D64-8605-3119519A62D2',
'5AE3CC97-5C4F-4660-A65E-359A12996853',
'9C959E03-4BC0-48BC-955E-3731341C5AAE',
'F0583315-3296-40AA-B011-3738ECBDB37D',
'2BC8579D-47FD-4B08-8B86-3A0A63F1DDB3',
'043FD025-6189-4C23-9807-3A5CC8DCC0DC',
'B84AB894-9DD0-4E1C-A614-3C34BB683C17',
'B84AB894-9DD0-4E1C-A614-3C34BB683C17',
'EE52B450-E901-41D9-A0D1-3E3E4AE1CC63',
'23593A88-A7C4-442D-990A-3F5232B930DC',
'127310BA-1128-43DF-9876-3FBE0D82339D',
'A51F8D43-D506-437C-BFAF-40F838A0FFE7',
'C82E20EF-E0CB-4CA2-B383-42DB9E92BE66',
'C7C517BC-1166-4ED4-91FE-437B2D6CF632',
'94407518-8A3E-432B-9D38-43EF73E3B599',
'EB4F8A29-9B45-4C80-B78A-4489DC687834',
'4D092AC4-253A-439F-80A9-468A681FFD40',
'1A559BF7-E695-447A-86A1-47A59A3086A5',
'E32FB349-7F76-4343-98D6-4B8948D2D3C8',
'65616430-3FF5-47C2-B392-4D6FF3BA0623',
'DE13E0B1-A507-4317-A3B6-4F14C84D6091',
'E18D0A87-264A-45C3-BC17-4FDB0D089639',
'2A54A9ED-AAE0-4D86-BFEA-51A7DE070F33',
'16B5F524-6C3C-4374-8D9B-52049C6D1B7B',
'D2BBA2FF-40E7-4CFC-9C56-5A9BAF266EF5',
'39387AC4-FBA8-4041-828D-5CCE342EEAE2',
'36F80A05-960B-48C5-9C5C-5CF194FBB780',
'C85F9E8A-446B-45F9-A565-5D58DBE476A0',
'C71759DE-1C6E-4314-B3B5-60CB3F1EFF58',
'27B5A9FC-CDF7-4840-ADFC-60F6C382A120',
'80A6CCAE-544A-4B7F-90F7-622737EDFE6E',
'80A6CCAE-544A-4B7F-90F7-622737EDFE6E',
'AD178755-680B-4E7C-89C8-6774BD70D94D',
'7EF4E48E-D105-4C27-A2D1-6816A33854B9',
'FFF18FC9-D958-4244-B11C-693398237E0C',
'12FB577D-AA52-4C9B-BC27-6B63994523F0',
'D0844D80-FD2A-4036-A223-6E5CEBF82CD8',
'9F323827-E83B-4E55-956D-72E93628B783',
'4EAE3E40-B21D-4568-B9F1-737B15BF3CA8',
'BB5B24DF-84DF-4887-BD8B-778512BB84E0',
'EF9F5F6C-DEE1-4A88-91D7-7DF2E9D4568C',
'CAF6782D-4150-4C2A-9644-7F8DBF24821B',
'86CFAA2D-D745-48F3-94F0-8188B45FEC3A',
'FD96ACD7-A34B-4101-9C28-873DCB37FE06',
'E0F0BB0B-E23E-4E21-812C-89962824DCCE',
'B8F831F0-8E74-439C-9D90-8D1D28E50FBB',
'B021D487-1C83-4955-ACB0-8D906FD01950',
'42856B67-AF8C-43ED-9A7F-8F054E12DBF9',
'42856B67-AF8C-43ED-9A7F-8F054E12DBF9',
'42856B67-AF8C-43ED-9A7F-8F054E12DBF9',
'42856B67-AF8C-43ED-9A7F-8F054E12DBF9',
'087C17CE-F58E-4BC0-8F11-8FBD08792FB5',
'5D1AB165-0452-4D52-8FAB-900A45A6894A',
'C395E82B-B732-471D-A9B1-91CA40C649E3',
'EEC7997E-0BFA-4DB7-8731-9304A9FBB6FC',
'DA7EF883-2AD4-471E-B6DC-95583D10807D',
'93E6E9BB-9889-4B1D-B999-9B1270B257EF',
'98AA730A-0B80-4C61-A7A4-9BCAEEF9E99A',
'09B93AE5-E339-41DF-B954-9C1D830D34CD',
'CCB6ED47-409E-4398-828A-9CFC912E376D',
'18F64D1C-7F6A-47A6-889F-9DEF1CEAB6FE',
'A7B2FF50-BC30-4270-8C15-9FE75A423F29',
'A4FB27C4-0B8C-4129-BBEB-A02F56E5FCCC',
'DF462F0F-D861-407B-9DF3-A07446B2A808',
'91AE3466-6DD0-4490-A9E3-A29FBF737673',
'20EA290F-EE2C-46C1-9A2A-A6E9E269CB9B',
'1E3DAB98-69FC-45A6-BEFF-A8BB238B43BE',
'1E3DAB98-69FC-45A6-BEFF-A8BB238B43BE',
'1E3DAB98-69FC-45A6-BEFF-A8BB238B43BE',
'0424E1BD-D62F-4C5B-A8A4-A9226482C6F7',
'49EEC2D6-74DA-4770-BF5E-AAFE35660A1E',
'49EEC2D6-74DA-4770-BF5E-AAFE35660A1E',
'C8C2D41F-6A32-49A7-8792-AB726726689B',
'8B4144D9-D1E4-485E-91AD-AC7AEF16FD21',
'8B4144D9-D1E4-485E-91AD-AC7AEF16FD21',
'8B4144D9-D1E4-485E-91AD-AC7AEF16FD21',
'44163D36-0604-4128-9AC3-AD7223817D1A',
'A4E3E1E4-685E-4738-9C01-AEC3614A0ACD',
'307AF0CA-6417-4491-9307-AFA4CECE1895',
'307AF0CA-6417-4491-9307-AFA4CECE1895',
'6B90C8D8-6DFE-405D-BED5-B420770C9287',
'DFB45516-A92E-4242-9ABD-B5677CEA45B7',
'EF8A492C-50BC-43DE-BF82-B9E0525EDFBA',
'2E747A67-99A4-4D14-90E4-BCC4D7EAC5BB',
'2E747A67-99A4-4D14-90E4-BCC4D7EAC5BB',
'18B91328-19CD-4D44-8EDF-BD625A0CCAD4',
'CF17506B-9909-4C22-AC0C-BF1C199A821A',
'5AC7F1D0-F62B-4C6F-84D9-BFE60E151462',
'5AC7F1D0-F62B-4C6F-84D9-BFE60E151462',
'8C1D7ACD-05F9-4603-93DC-C0F548521C87',
'5E64BB0D-F8A6-4A90-8948-C1D3BA10188F',
'CA6F273C-5469-40DA-BAC7-C2A1D54320F6',
'9B015677-8BDD-4CF1-A38E-C4CA58FAB1F3',
'ECB976D5-DB87-48F3-BE50-C6CB05F6254C',
--'6A6E3CA6-EB65-4344-8AEE-C6F5E2124B1E', --tied Basic ECG
--'6A6E3CA6-EB65-4344-8AEE-C6F5E2124B1E', --tied to basic ecg

'50255D52-379F-48E7-93A6-C874F8A0C5B3',
'71C1692F-2559-4224-872C-C93362CFC9DB',
'BCE82E47-D3A1-46F4-8AB6-C993333180B8',
'DD5A4B33-F3C0-4090-813E-C9AB943731A3',
'3885C6B2-4C2C-4078-98CA-CA5BD9C72F62',
'58D2FCD8-EB19-4335-9E1E-CF8302108858',
'9B8EE871-0E7B-4E3A-AED7-D0F78EBBFC2C',
'C565FA93-2054-4E43-B6FB-D1BFB8D9C89C',
'52C55C17-90C6-48B7-B0CE-D3FCE4FCA428',
'1C50C94F-6AD4-43F9-9C64-D70E856F095F',
'996F9F4D-E61D-4BA0-B6EE-D711FEA53A2C',
'111CA699-8B07-414E-B6B5-D86E1B0C2CE1',
'AD6F3587-B8B4-4C96-AA44-D9BC7A43952B',
'43965D7A-10EC-43BE-AABC-DE2E971007F7',
'3034F453-5BAA-4BE0-961C-DFD0B0C2DB29',
'AADCD9E4-819F-4B06-AFFC-E020AB899C24',
'614C6FFF-2DBC-44EC-8FCE-E0428AC4C580',
'8C690002-5810-4DF9-820A-E9984820CF79',
'0FF5E5BF-26B6-49A5-83BA-EA7B465A7367',
'523868FC-D740-42D5-B14F-F1984AD5A585',
'4FF078DB-2137-4E5A-BE02-F1BB6F407A45',
'6B66F8C6-5AEA-49D1-8A62-F2502824CA71',
'12446F4C-3C62-46DE-8B9E-F28209BB5EAE',
'3EC00D82-03AC-402D-BFB9-F4A6889239AB',
'DE6C31FA-F0E0-4E52-B95D-FCD5996753CE',
'1FF5E793-229C-4E6A-A463-FDD45835E268',
'80583EB7-6509-4365-B609-FEA99FD6CEEE'

)

 order by 1



