<cfcomponent output="true">

	<cfscript>
		variables.apiKey = "";
	</cfscript>

	<cffunction name="init" access="public" output="false" returntype="any">

		<cfargument name="apiKey" type="string" required="yes">

		<cfscript>
			variables.apiKey = arguments.apiKey;

			return this;
		</cfscript>

	</cffunction>

	<cffunction name="send" access="public" output="true" returntype="struct">

		<cfargument name="issueDataStruct" type="struct" required="yes">

		<cfscript>
			var message = CreateObject("component", "RaygunMessage").init();
			var messageContent = "";
			var jSONData = "";
			var postResult = "";

			if (not Len(variables.apiKey))
			{
				throw("API integration not valid, cannot send message to Raygun");
			}

			messageContent = message.build(arguments.issueDataStruct);
			jSONData = serializeJSON(messageContent);
		</cfscript>

		<cfhttp url="https://api.raygun.io/entries" method="post" charset="utf-8" result="postResult">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam type="header" name="X-ApiKey" value="#variables.apiKey#"/>
			<cfhttpparam type="body" value="#jSONData#"/>
		</cfhttp>

		<cfreturn postResult>
	</cffunction>

</cfcomponent>