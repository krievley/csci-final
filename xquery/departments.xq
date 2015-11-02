xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);

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