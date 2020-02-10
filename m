Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAEBE15802B
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 17:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBJQv7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 11:51:59 -0500
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:57461 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727003AbgBJQv7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 11:51:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DFEA2182CED34;
        Mon, 10 Feb 2020 16:51:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2894:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4031:4321:5007:6119:7903:8985:9025:10004:10400:10848:11232:11658:11914:12043:12048:12296:12297:12438:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21324:21451:21611:21627:21740:21811:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: birds64_4b141cff4044f
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Feb 2020 16:51:55 +0000 (UTC)
Message-ID: <13eb9760ba13cee2f25c74c665198faac6a5a2f3.camel@perches.com>
Subject: Re: [PATCH] IMA: Add log statements for failure conditions.
From:   Joe Perches <joe@perches.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 08:50:40 -0800
In-Reply-To: <41d61aa5-db98-6291-d91f-104f029c897f@linux.microsoft.com>
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
         <20200207195346.4017-2-tusharsu@linux.microsoft.com>
         <1581253027.5585.671.camel@linux.ibm.com>
         <da7bd0441ef3044cb40d705b8bb176bfdf391557.camel@perches.com>
         <41d61aa5-db98-6291-d91f-104f029c897f@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 08:40 -0800, Lakshmi Ramasubramanian wrote:
> On 2/9/20 6:46 PM, Joe Perches wrote:
> 
> > > In addition, as Shuah Khan suggested for the security/integrity/
> > > directory, "there is an opportunity here to add #define pr_fmt(fmt)
> > > KBUILD_MODNAME ": " fmt to integrity.h and get rid of duplicate
> > > defines."  
> 
> Good point - we'll make that change.
> 
> With Joe Perches patch (waiting for it to be re-posted),
> > > are all the pr_fmt definitions needed in each file in the
> > > integrity/ima directory?
> > 
> > btw Tushar and Lakshmi:
> > 
> > I am not formally submitting a patch here.
> > 
> > I was just making suggestions and please do
> > with it as you think appropriate.
> 
> Joe - it's not clear to me what you are suggesting.
> We'll move the #define for pr_fmt to integrity.h.
> 
> What's other changes are you proposing?

https://lore.kernel.org/lkml/4b4ee302f2f97e3907ab03e55a92ccd46b6cf171.camel@perches.com/


