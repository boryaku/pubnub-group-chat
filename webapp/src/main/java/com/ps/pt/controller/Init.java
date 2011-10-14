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
package com.ps.pt.controller;

import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.User;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.PortletPreferencesFactoryUtil;
import com.ps.pt.configuration.Action;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;
import java.util.Date;

/**
 * Author: cnbuckley
 * Date: 10/5/11
 * Time: 3:40 PM
 */
@Controller
@RequestMapping("VIEW")
public class Init {
    private Logger logger = LoggerFactory.getLogger(Init.class);

    @RequestMapping
    public String index(ModelMap map, PortletRequest request){

        try{
            String portletResource = "pureTalkChat_WAR_pubnubgroupchat";
            PortletPreferences prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource);

            String pubKey = prefs.getValue(Action.PUB_KEY, "");
            String subKey = prefs.getValue(Action.SUB_KEY, "");
            String sslKey = prefs.getValue(Action.SSL_KEY, "");

            ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);

            User user =  PortalUtil.getUser(request);
            map.addAttribute("user", user);
            map.addAttribute(Action.PUB_KEY, pubKey.equals("") ? "demo" : pubKey);
            map.addAttribute(Action.SUB_KEY, subKey.equals("") ? "demo" : subKey);
            map.addAttribute(Action.SSL_KEY, subKey.equals("") ? "off" : sslKey);

            //the group url-page ie my-program-home
            String channel = pubKey.equals("") ? "chat" :
                                                    themeDisplay.getScopeGroup().getFriendlyURL().replace("/", "")+"-"+
                                                            themeDisplay.getLayout().getFriendlyURL().replace("/","");
            map.addAttribute("channel", channel);
            map.addAttribute("now", new Date().getTime());
        }catch (Exception ex){
            logger.error("Init exception", ex);
        }

        return "index";
    }
}
