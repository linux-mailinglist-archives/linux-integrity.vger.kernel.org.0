Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6139D266D9
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfEVP1w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 11:27:52 -0400
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:26062 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfEVP1v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 11:27:51 -0400
X-EEMSG-check-017: 400963448|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 May 2019 15:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558538869; x=1590074869;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MzLDIBsdBjlk88XXupJDSIduMBxEg/Gwh+QsPHNSZVw=;
  b=MThWWckyKFZ2dK2ucP7RQtS2c1Mk7wmFh5DwOy4QYvV/1EZlar/sspnW
   rrxI0nN6yhG9haip5TjQoG2tw0g361202egCFCuX8BkGc/CgW5GSKKV33
   5LP1Iv+mCJx2ObuaQ5gPqlPyPuN6qjQP48goQiw9WCxKV+rrY/oT6lMRK
   COxBf0S7jBepF3mLS30OaZ0K81fSVW8rRalI9WEaYYSWJ04zaq/lKJQLJ
   xsg8d26udvBmPXa+XR2zaGzUoSp7prNMpqEx6y7R/PSrfN0VrbBe6EhvS
   Qc8gvAYLnXpe5A91KMzNQDeKJS6epeZn4ByOrjQRFxD0fUpchTX/7VmxU
   g==;
X-IronPort-AV: E=Sophos;i="5.60,499,1549929600"; 
   d="scan'208";a="23983789"
IronPort-PHdr: =?us-ascii?q?9a23=3A0TM+0BWwV0jac4DY6DLRe8u4JpbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRWDuqdThVPEFb/W9+hDw7KP9fy5ACpZuMzK4C5KWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sBjdutMLjYd/NKo9xR?=
 =?us-ascii?q?jEr3pVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWhBOfixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Vwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTrUTCETP2mEXxlqOWcFkr+vO05Oj9Z7Xmp5ucO5d1igH4LKsuhtSyDfk3Pw?=
 =?us-ascii?q?UBRWSW+fmw2Kf98UD2XrlGlOA6nrHcsJ/AJMQboqC5AxVS0oYm8xu/FCqp0M?=
 =?us-ascii?q?8DkHkbLFNKZBKHj4/zN1HIO/D3F+2zg1urkDd13/zGJKHuAo3RLnjfl7fsZb?=
 =?us-ascii?q?d860lcyAUp19BS/JZUCrAHIPLuVU79rt3YAQQ8MwCu3+nnD9B93JsEWW2TGq?=
 =?us-ascii?q?+ZLL/SsViQ6+ItOeaMYokVtyjnJ/gm/fHul385mUIbfaa325sac3+4HvF8LE?=
 =?us-ascii?q?WYZXrgmMsOEWAPvgAmVuzllEWCUSJPZ3a1R688/is0CJ+iDYrYXoCimqGB3C?=
 =?us-ascii?q?OiEp1TYWBGDUqMHmnye4qYXPcMbTqYItV9nTwcSbihV4gh2AmqtA/7zbpnM+?=
 =?us-ascii?q?XV9jQZtZLlyNh6+eLTlQsz9TxoD8WQyH+NT25qkWMSXTM2375woVZ7ylid1a?=
 =?us-ascii?q?h0mftYFcZc5/lRSAc1KYbcz/BmC9D1Qg/BetaJSFC7QtSpGD0xVcw+zMMTY0?=
 =?us-ascii?q?ZnGtWikhDC0zOvA78SirOLGZg0/bzH0njvKMZy1WzG2LMij1Y4WMtPM3Ophq?=
 =?us-ascii?q?pl+wjUHY7JnBbRq6H/UKUZ3Wb/82eK1yLarkZYWRRYVaTDQGBZZ0HT69/+4x?=
 =?us-ascii?q?WGB52nD7IqeihI086fLKZMIonrhFNASbHgMc7efmS8nU+/AB+JwvWHa4+8Py?=
 =?us-ascii?q?0F1TjZIFANjgRW+HGBLwV4DSCk8EzECzk7Lk7ie0Ph96FFrXq/SkIlh1WRY1?=
 =?us-ascii?q?ZJy6u++hlTg+eVDfwUwORX628atzxoEQPljJrtAN2aql8kJfgNbA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CBAwBkaeVc/wHyM5BlHAEBAQQBAQcEAQGBZYFnKoE2B?=
 =?us-ascii?q?TKEO5NaBoE1iU6Jb4UugWcJAQEBAQEBAQEBNAECAQGEQAKCMSM4EwEDAQEBB?=
 =?us-ascii?q?AEBAQEDAQFsKII6KQGCZwEFIw8BBUEQCxgCAiYCAlcGAQwIAQGCXz+BdxSoQ?=
 =?us-ascii?q?IEvhUeDJoFGgQwoi1EXeIEHgTiCaz6EKgKDIoJYBIs0jyyNUQmCD4IRkG8GG?=
 =?us-ascii?q?4IejESHUC2MMIEnljwhgVcrCAIYCCEPgyiQbCMDgTYBAY1qAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 May 2019 15:27:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4MFRl2A016015;
        Wed, 22 May 2019 11:27:47 -0400
Subject: Re: sleep in selinux_audit_rule_init
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
 <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
 <1558530022.4347.11.camel@linux.ibm.com>
 <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
 <1558533420.4347.30.camel@linux.ibm.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov>
Date:   Wed, 22 May 2019 11:27:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558533420.4347.30.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/22/19 9:57 AM, Mimi Zohar wrote:
> On Wed, 2019-05-22 at 09:16 -0400, Stephen Smalley wrote:
>> On 5/22/19 9:00 AM, Mimi Zohar wrote:
>>> On Wed, 2019-05-22 at 08:41 -0400, Stephen Smalley wrote:
>>>> Another potentially worrisome aspect of the current
>>>> ima_lsm_update_rules() logic is that it does a BUG_ON() if the attempt
>>>> to update the rule fails, which could occur if e.g. one had an IMA
>>>> policy rule based on a given domain/type and that domain/type were
>>>> removed from policy (e.g. via policy module removal).  Contrast with the
>>>> handling in audit_dupe_lsm_field().  The existing ima_lsm_update_rules()
>>>> logic could also yield a BUG_ON upon transient memory allocation failure.
>>>
>>> The original design was based on the assumption that SELinux labels
>>> could not be removed, only new ones could be added.  Sounds like that
>>> isn't the case any longer.
>>
>> That's never really been the case for SELinux; it has always been
>> possible to reload with a policy that renders previously valid security
>> contexts invalid.  What has changed over time is the ability of SELinux
>> to gracefully handle the situation where a security context is rendered
>> invalid upon a policy reload and then later restored to validity via a
>> subsequent policy reload (e.g. removing a policy module and then
>> re-adding it), but even that deferred mapping of contexts support has
>> been around since 2008.
>>
>> What you are likely thinking of is the conventional practice of
>> distributions, which is generally to not remove domains/types from their
>> policy or to at least retain a type alias for compatibility reasons.
>> But that's just a convention, not guaranteed by any mechanism, and users
>> are free to remove policy modules.
> 
> Ok.  The question is then how should IMA handle missing domains/types.
>   Just dropping IMA policy rules doesn't sound safe, nor does skipping
> rules in case the domains/types are restored.

You can just do what audit_dupe_lsm_field() does.  It effectively 
disables the rule upon the invalidation (which makes sense, since it can 
no longer match anything since nothing can have that domain/type) but 
retains the string value so it can later re-activate the rule if the 
domain/type becomes valid again later.
