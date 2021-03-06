<!---
Copyright 2013-2014 Kai Koenig, Ventego Creative Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->

<cfcomponent>
    <cffunction name="onError">
        <cfargument name="Exception" required="true"/>
        <cfargument name="EventName" required="true"/>

        <cfscript>
            sessionData = {"memberID" = "5747854", "memberFirstName" = "test"};
            paramsData = {"currentAction" = "IwasDoingThis", "justAnotherParam" = "test"};
            customRequestData = createObject("nz.co.ventego-creative.raygun4cfml.RaygunCustomData").init(sessionData,paramsData);

            raygun = createObject("component","nz.co.ventego-creative.raygun4cfml.RaygunClient").init(
                apiKey = "YOURAPIKEYHERE",
                customRequestData = customRequestData
            );

            result = raygun.send(arguments.Exception);
        </cfscript>
    </cffunction>
</cfcomponent>
