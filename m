Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFCB24BA
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2019 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbfIMRlZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Sep 2019 13:41:25 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:44769 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbfIMRlZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Sep 2019 13:41:25 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 13:41:24 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id ECA6C180013F1;
        Fri, 13 Sep 2019 17:36:19 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 73C7218225E0A;
        Fri, 13 Sep 2019 17:36:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:4321:5007:6119:9545:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21450:21627:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:31,LUA_SUMMARY:none
X-HE-Tag: part18_19b2e2b09e449
X-Filterd-Recvd-Size: 1675
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Sep 2019 17:36:16 +0000 (UTC)
Message-ID: <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add a git and a maintainer entry to
 keyring subsystems
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Sep 2019 10:36:15 -0700
In-Reply-To: <11580.1568387033@warthog.procyon.org.uk>
References: <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com>
         <11580.1568387033@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-09-13 at 16:03 +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Subject: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring subsystems
> 
> I would recommend splitting the patch in two and putting something like:
> 
> 	keys: Add Jarkko Sakkinen as co-maintainer
> 
> as the subject of the keyrings maintainership one.

Why is there utility in micro splitting such a trivial patch?


