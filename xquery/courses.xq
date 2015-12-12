xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);
declare variable $dept := request:get-parameter('department','');
declare variable $code := request:get-parameter('course','');
declare variable $classnum := request:get-parameter('classnum','');

if($dept != "")
then
<department>
    {   
        for $course in $col/courses/course
        where $course/catalog_info/department/@code eq $dept
        return $course
    }
</department>

else if ($code != "" and $classnum != "")
then
<course>
    {   
        for $course in $col/courses/course
        where $course/@course_id eq $code and $course/@class_number eq $classnum
        return $course
    }
</course>

else
    <none></none>
