<apply template="_layout">
	<h1>Nested Lists</h1>

	<p>This form returns a <code>[(TestItem, [TestItem])]</code>.</p>

	<dfForm>
		<dfInputList ref="nested-list">
			<fieldset>
				<legend>Depth 1</legend>

				<bind tag="listItem">
					<apply template="_test_item" />
					<br />
					dfDebugIndex: <dfDebugIndex />, should be <dfListItemIndex />
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
