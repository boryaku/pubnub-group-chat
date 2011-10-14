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
package com.ps.pt.configuration;

import com.liferay.portal.kernel.portlet.ConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

import javax.portlet.*;

/**
 * Author: cnbuckley
 * Date: 10/12/11
 * Time: 10:14 AM
 */
public class Action implements ConfigurationAction {

    public static final String PUB_KEY = "PUB_KEY";
    public static final String SUB_KEY = "SUB_KEY";
    public static final String SSL_KEY = "SSL_KEY";

    @Override
    public void processAction(PortletConfig portletConfig, ActionRequest actionRequest, ActionResponse actionResponse) throws Exception {
        String portletResource = ParamUtil.getString(actionRequest, "portletResource");

        PortletPreferences prefs = PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource);
        prefs.setValue(PUB_KEY, actionRequest.getParameter("pub"));
        prefs.setValue(SUB_KEY, actionRequest.getParameter("sub"));
        prefs.setValue(SSL_KEY, actionRequest.getParameter("ssl"));
        prefs.store();

        actionRequest.setAttribute(PUB_KEY, prefs.getValue(Action.PUB_KEY, ""));
        actionRequest.setAttribute(SUB_KEY, prefs.getValue(Action.SUB_KEY, ""));
        actionRequest.setAttribute(SSL_KEY, prefs.getValue(Action.SSL_KEY, ""));

        SessionMessages.add(actionRequest, portletConfig.getPortletName() + ".doConfigure");
    }

    @Override
    public String render(PortletConfig portletConfig, RenderRequest renderRequest, RenderResponse renderResponse) throws Exception {

        String portletResource = ParamUtil.getString(renderRequest, "portletResource");
        PortletPreferences prefs = PortletPreferencesFactoryUtil.getPortletSetup(renderRequest, portletResource);

        renderRequest.setAttribute(PUB_KEY, prefs.getValue(Action.PUB_KEY, ""));
        renderRequest.setAttribute(SUB_KEY, prefs.getValue(Action.SUB_KEY, ""));
        renderRequest.setAttribute(SSL_KEY, prefs.getValue(Action.SSL_KEY, ""));

        return "/configuration.jsp";
    }
}
