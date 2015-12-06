xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);

<result>
    {
        let $count := count($col/courses/course)
        return
            <courses
                label="Count of Total Courses"
                value="{$count}"/>
    }
    {
        for $t in distinct-values($col/courses/course/@term_code)
        return
            <term
                label="Count for {upper-case($t)} Courses"
                value="{count($col/courses/course[@term_code eq $t])}"/>
    }
    <variable
        label="exist.root"
        value="{request:get-attribute('exist.root')}"/>
    <variable
        label="exist.path"
        value="{request:get-attribute('exist.path')}"/>
    <variable
        label="exist.resource"
        value="{request:get-attribute('exist.resource')}"/>
    <variable
        label="exist.controller"
        value="{request:get-attribute('exist.controller')}"/>
    <variable
        label="exist.prefix"
        value="{request:get-attribute('exist.prefix')}"/>
</result>