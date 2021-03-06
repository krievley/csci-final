xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);
declare variable $dept := request:get-parameter('department','*');
declare variable $instructor := request:get-parameter('instructor','*');
declare variable $course_id := request:get-parameter('id','*');
declare variable $days := request:get-parameter('days','*');
declare variable $start := request:get-parameter('start','*');
declare variable $end := request:get-parameter('end','*');
declare variable $search := request:get-parameter('q','*');

if($search != '*')
then
<result>
    {   
        for $course in $col/courses/course
        where (matches($course/catalog_info/title, $search, 'i') or $search = '*')
        or (matches($course/catalog_info/description, $search, 'i') or $search = '*')
        order by $course/catalog_info/title
        return $course
    }
</result>

else 
    <result>
    {   
        for $course in $col/courses/course
        where ($course/catalog_info/department/@code eq $dept or $dept = '*')
        and ($course/staff/person/display_name eq $instructor or $instructor = '*')
        and ($course/@course_id eq $course_id or $course_id = '*')
        and ($course/catalog_info/meeting_schedule/meeting/@days_of_week eq $days or $days = '*')
        and ($course/catalog_info/meeting_schedule/meeting/@start_time eq $start or $start = '*')
        and ($course/catalog_info/meeting_schedule/meeting/@end_time eq $end or $end = '*')
        order by $course/catalog_info/title
        return $course
    }
    
(: Added by LEO - extending XQ Logic to include passed instructor name into XML so that I can reference it for page data :)
<instructorname>
{ if ($instructor != '*') 
    then $instructor
    else ()
}
</instructorname>    

</result>
