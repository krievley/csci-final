xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);
declare variable $query := request:get-parameter('list','department');

if($query = 'department')
then
<departments>
    {
        for $code in distinct-values($col/courses/course/catalog_info/department/@code)
        let $dept_string := $col/courses/course/catalog_info/department[@code = $code][1]/text()
        where $dept_string != ''
        order by $dept_string
        return 
            <department code="{$code}">
                {$dept_string}
            </department>
    }
</departments>

else if($query = 'instructor')
then
<instructors>
    {
    for $name in distinct-values($col/courses/course/staff/person/display_name/text())
    let $code := encode-for-uri($name)
    where $name != ''
    order by $name
        return 
            <instructor code="{$code}">
                {$name}
            </instructor>
    }
</instructors>

else if($query = 'term')
then
<terms>
    {
    for $course in $col/courses/course
    order by $course/@course_id
        return 
            $course
    }
</terms>

else if($query = 'schedule')
then
<schedule>
    {
    for $meeting in $col/courses/course/catalog_info/meeting_schedule/meeting
    let $order := ("Monday", "Monday Wednesday", "Monday Friday", "Monday Wednesday Friday", "Tuesday", "Tuesday Thursday", "Tuesday Thursday Friday", "Tuesday Wednesday", "Tuesday Friday", "Wednesday", "Wednesday Thursday", "Wednesday Friday", "Thursday", "Friday", "Saturday", "Monday Tuesday", "Monday Tuesday Wednesday", "Monday Tuesday Wednesday Thursday", "Monday Tuesday Wednesday Friday", "Monday Tuesday Thursday Friday", "Monday Tuesday Wednesday Thursday Friday", "Monday Tuesday Wednesday Thursday Friday Saturday", "Monday Wednesday Thursday", "Monday Wednesday Thursday Friday", "Monday Thursday")
    order by 
        index-of($order, $meeting/@days_of_week),
        $meeting/@start_time,
        $meeting/@end_time
    
    return 
        $meeting
    }
</schedule>

else
    <departments></departments>