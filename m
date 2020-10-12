Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45C28BF63
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Oct 2020 20:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404165AbgJLSGI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 14:06:08 -0400
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:48904 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403943AbgJLSGI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 14:06:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5256018029129;
        Mon, 12 Oct 2020 18:06:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2693:2828:2894:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:8603:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21212:21611:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: comb67_5601f4e271fc
X-Filterd-Recvd-Size: 2685
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Oct 2020 18:06:05 +0000 (UTC)
Message-ID: <ea06c7431075c57d274a9076077f28fd2c7634a5.camel@perches.com>
Subject: Re: [PATCH] ima: Fix sizeof mismatches
From:   Joe Perches <joe@perches.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Colin King <colin.king@canonical.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@polito.it>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 11:06:04 -0700
In-Reply-To: <a9a35d8b480112fe40b45392d0f0e9dcb5be536e.camel@linux.ibm.com>
References: <20201007110243.19033-1-colin.king@canonical.com>
         <55ae0b6152c84013d483b1bbecb28a425801c408.camel@perches.com>
         <a9a35d8b480112fe40b45392d0f0e9dcb5be536e.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-10-12 at 13:51 -0400, Mimi Zohar wrote:
> On Wed, 2020-10-07 at 11:27 -0700, Joe Perches wrote:
> > On Wed, 2020-10-07 at 12:02 +0100, Colin King wrote:
> > > An incorrect sizeof is being used, sizeof(*fields) is not correct,
> > > it should be sizeof(**fields). This is not causing a problem since
> > > the size of these is the same. Fix this in the kmalloc_array and
> > > memcpy calls.
> > []
> > > diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> > []
> > > @@ -216,11 +216,11 @@ int template_desc_init_fields(const char *template_fmt,
> > >  	}
> > >  
> > >  	if (fields && num_fields) {
> > > -		*fields = kmalloc_array(i, sizeof(*fields), GFP_KERNEL);
> > > +		*fields = kmalloc_array(i, sizeof(**fields), GFP_KERNEL);
> > >  		if (*fields == NULL)
> > >  			return -ENOMEM;
> > >  
> > > -		memcpy(*fields, found_fields, i * sizeof(*fields));
> > > +		memcpy(*fields, found_fields, i * sizeof(**fields));
> > 
> > Maybe use kmemdup instead.
> > 
> > 	if (fields && num_fields) {
> > 		*fields = kmemdup(found_fields, i * sizeof(**fields), GFP_KERNEL);
> > 		etc...
> > 
> 
> Thanks, Joe.  Since this patch will be backported, perhaps it would be
> better to leave this as a bug fix and upstream other changes
> independently.

IMO:

This patch doesn't need need backporting as it doesn't
actually fix anything other than a style defect.

void * and void ** are the same size.

cheers, Joe

