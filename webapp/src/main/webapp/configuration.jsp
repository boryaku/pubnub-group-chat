<%--
/**
 * Copyright (c) Pure Source, LLC All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet_2_0" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ page import="com.liferay.portal.kernel.util.Constants" %>

<portlet:defineObjects />

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
    <input name="<portlet:namespace /><%=Constants.CMD%>" type="hidden" value="<%=Constants.UPDATE%>" />

<table>
<tr>
    <td><label style="font-size: larger;">PUBNUB Publish Key:</label></td>
    <td> <input name="<portlet:namespace />pub" value="${PUB_KEY}" class="nubpub_chat_input"/></td>
</tr>
<tr>
    <td><label style="font-size: larger;">PUBNUB Subscribe Key:</label></td>
    <td> <input name="<portlet:namespace />sub" value="${SUB_KEY}" class="nubpub_chat_input"/></td>
</tr>
 <tr>
    <td><label style="font-size: larger;">PUBNUB SSL Security:</label></td>
    <td> <select name="<portlet:namespace />ssl" class="nubpub_chat_select">
            <option ${SSL_KEY eq "Off" ? 'selected=\"selected\"' : ''}>Off</option>
            <option ${SSL_KEY eq "On" ? 'selected=\"selected\"' : ''}>On</option>
         </select>
    </td>
</tr>
</table>
<input type="button" value="Save" onClick="submitForm(document.<portlet:namespace />fm);" />
</form>