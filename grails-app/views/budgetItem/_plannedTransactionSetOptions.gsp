<div style="height: 7em;">
	<div style = "float: left; width: 14em; margin : 0em 4em 0em 5.5em;">
		Amount Options<br/>
		<table>
			<tr>
				<td><g:radio name = "amountOption" value="deriveAmount" checked="checked" /> Derive from Budget Amount</td>
			</tr>
			<tr>
				<td><g:radio name = "amountOption" value="addAmount" onchange = "displayMessage('Specify an Amount in the amount field',this.id)"/> Add to get budget amount</td>
			</tr>
			<tr>
				<td>Amount <g:field name = "amount" id = "amount" type="text" size = "10" /> </td>
			</tr>
		</table>
	</div>
	
	<div style = "width: 14em; float:left;" >
		Frequency Options
		<table>
			<tr>
				<td><g:radio name="frequencyOption" value="daily"  checked="checked"/> Daily</td>
				<td><g:radio name="frequencyOption" value="biDaily"/> Bi-Daily</td>
			</tr>
			<tr>
				<td><g:radio name="frequencyOption" value="weekly"/> Weekly</td>
				<td><g:radio name="frequencyOption" value="biWeekly"/> Bi Weekly</td>
			</tr>
			<tr>
				<td><g:radio name="frequencyOption" value="monthly"/> Monthly</td>
				<!-- <td><g:radio name="frequencyOption" value="semiMonthly"/> Semi Monthly </td>  -->
			</tr>
		</table>
	</div>
</div>
<div style = "width: 37em; height:10em ;margin : 0 0 0 5em;  border: outset; border-width: 5px; padding:5px;">
							<h5>Message Area</h5>
							<div id="messageBox" style="width: 100%; height: 85%; margin-top: 10px; font-size: 14px; overflow: scroll">
								<g:if test="${flash.message}">
									<div class="message" role="status">${flash.message}</div>
								</g:if>
								<g:each in = "${flash.messages}" var = "message">
									<div class="message" role="status">${message.value}</div>
								</g:each>
								<g:if test="${flash.errors}">
									<ul class="errors" role="alert">
										<g:each in="${flash.errors}" var="error">
											<li>${error.value}</li>
										</g:each>
									</ul>	
								</g:if>
							</div>						
						</div>