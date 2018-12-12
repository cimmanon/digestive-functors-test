<label>Code:<br />
<dfInputText ref="code" /></label>
	(<dfIfInputListTemplate><!--
		--><dfEditEnabled ref="code"><span class="success">Enabled</span></dfEditEnabled><!--
		--><dfEditDisabled ref="code"><span class="failure">Disabled</span></dfEditDisabled><!--
	--></dfIfInputListTemplate><!--
	--><dfIfInputListItem><!--
		--><dfEditEnabled ref="code"><span class="failure">Enabled</span>... unless item 0 and empty</dfEditEnabled><!--
		--><dfEditDisabled ref="code"><span class="success">Disabled</span></dfEditDisabled><!--
	--></dfIfInputListItem>)<br />

<label>Name:<br />
<dfInputText ref="name" /></label>
	(Edit <!--
		--><dfEditEnabled ref="name"><span class="success">Enabled</span></dfEditEnabled><!--
		--><dfEditDisabled ref="name"><span class="failure">Disabled</span></dfEditDisabled><!--
	-->, field <!--
	--><dfIfInputListTemplate><!--
		--><dfIfEnabled ref="name"><span class="failure">Enabled</span></dfIfEnabled><!--
		--><dfIfDisabled ref="name"><span class="success">Disabled</span></dfIfDisabled><!--
	--></dfIfInputListTemplate><!--
	--><dfIfInputListItem><!--
		--><dfIfEnabled ref="name"><span class="success">Enabled</span></dfIfEnabled><!--
		--><dfIfDisabled ref="name"><span class="failure">Disabled</span>... unless this is nested list and the parent element is a template</dfIfDisabled><!--
	--></dfIfInputListItem><!--
	-->)
