<apply template="_layout">
	<h1>Nested Lists</h1>

	<p>This form returns a <code>[(TestItem, [TestItem])]</code>.</p>

	<dfForm>
		<dfInputList ref="nested-list">
			<fieldset>
				<legend>Depth 1</legend>

				<bind tag="listItem">
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
				</bind>

				<dfListItem>
					<legend>
						<fieldset>
							<legend>Item <strong><dfListItemIndex /></strong> (<dfListItemType />)</legend>

							<dfIfInputListTemplate><p>All fields in this fieldset should have the <strong>disabled</strong> attribute.</p></dfIfInputListTemplate>
							<dfIfInputListItem><p>The outer list item should always have the name field <strong>enabled</strong>.  If the code field is populated, it should be <strong>disabled</strong>.  Otherwise, it should be <strong>enabled</strong>.</p>

							<p>For the inner list, both fields should be <strong>disabled</strong> if it is item -1, otherwise it should behave the same as the outer list item.</p></dfIfInputListItem>

							<dfSubView ref="item">
								<listItem />
							</dfSubView>

							<fieldset>
								<legend>Depth 2</legend>

								<dfInputList ref="list">
									<dfListItem>
										<fieldset>
											<legend>Item <strong><dfListItemIndex /></strong> (<dfListItemType />)</legend>

											<dfSubView ref="nested">
												<listItem />
											</dfSubView>
										</fieldset>
									</dfListItem>
								</dfInputList>
							</fieldset>
						</fieldset>
					</legend>
				</dfListItem>
			</fieldset>
		</dfInputList>
	</dfForm>
</apply>
