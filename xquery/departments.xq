xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);

<result>
    {   
        for $department in $col/courses/course/catalog_info/department
        where $department != ''
        order by $department
        return $department
    }
</result>