<apply template="_layout">
	<h1>Group Bool</h1>

	<p>This form returns a <code>[(TestItem, Bool)]</code>.</p>

	<dfForm>
		<dfSubView ref="group-bool">
			<bind tag="listItem">
				<apply template="_test_item" />
				<br />
				<dfDebugShowView />
				should be
				<dfShowView />
			</bind>

			<table border="1">
				<thead>
					<tr>
						<th>Type</th>
						<th>Data</th>
						<th>Selected</th>
					</tr>
				</thead>

				<tbody><dfListGroup ref="choices">
					<dfListItem><tr>
						<td><dfListItemType /></td>
						<td><dfSubView ref="item"><listItem /></dfSubView></td>
						<td><dfGroupRadioText isDisabled ref="elem_index" checked="selection" data-value="index" /></td>
					</tr></dfListItem>
				</dfListGroup></tbody>
			</table>
		</dfSubView>
	</dfForm>
</apply>
