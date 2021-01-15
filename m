Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D760A2F86EE
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 21:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbhAOUtF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 15:49:05 -0500
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:50008 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727808AbhAOUtE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 15:49:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5EB171828A0CD;
        Fri, 15 Jan 2021 20:48:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4425:5007:6120:7652:7901:7903:10004:10400:11026:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21433:21627:21990:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: heart92_050e8be27532
X-Filterd-Recvd-Size: 2660
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Jan 2021 20:48:22 +0000 (UTC)
Message-ID: <23f4bef1fa549f6576aab4f115576601e9f58eaf.camel@perches.com>
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Greg KH <greg@kroah.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Date:   Fri, 15 Jan 2021 12:48:20 -0800
In-Reply-To: <7a245c854925c8619eeb02aab6ff32bbccc92ed9.camel@HansenPartnership.com>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
         <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
         <X//55I26mxVQKKOE@kroah.com>
         <ce0ce0c5b3b66e2b1506ab9c4f10ffbbcfa648d8.camel@HansenPartnership.com>
         <YAGeez8OZWDXugTW@kroah.com>
         <eb2acffef1368c48b3ca2d85105ef73b31797fe7.camel@HansenPartnership.com>
         <7a245c854925c8619eeb02aab6ff32bbccc92ed9.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-01-15 at 10:07 -0800, James Bottomley wrote:
> On Fri, 2021-01-15 at 09:26 -0800, James Bottomley wrote:
> > On Fri, 2021-01-15 at 14:54 +0100, Greg KH wrote:
> > > On Thu, Jan 14, 2021 at 04:21:08PM -0800, James Bottomley wrote:
> > [...]
> > > > It looks like we already have a couple of bugs in the kernel
> > > > introduced by this confusion ...  return sysfs_emit() vs return
> > > > sysfs_emit_at() being the most tricky ...
> > > 
> > > Hm, Joe, you did the conversion to these functions (and wrote the
> > > api), care to review this?
> > 
> > A cursory glance tells me that summary_show in 
> > drivers/infiniband/hw/usnic/usnic_ib_sysfs.c has a problem, I think
> > the last = should be +=

No, it's correct and overwriting what would otherwise be a trailing space.

> The use in drivers/base/node.c:node_read_meminfo() is highly
> questionable.  While currently not emitting wrong code, it depends on
> len being 0 when passed in to sysfs_emit_at().  That argues it should
> either be using sysfs_emit() or it should have a len += just in case
> something gets prepended that makes len non zero.

<shrug>, it's currently correct and would be OK to change to += as
len is initialized though I think it's extremely doubtful it would
ever be changed.

sysfs is ABI right so prepending would break things.


