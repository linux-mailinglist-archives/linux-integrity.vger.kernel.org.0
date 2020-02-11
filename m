Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7ECE158891
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2020 04:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgBKDKw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 22:10:52 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:39617 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727962AbgBKDKw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 22:10:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8AAEB181D3026;
        Tue, 11 Feb 2020 03:10:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3873:4321:5007:10004:10400:10848:11026:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21060:21080:21611:21627:30030:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: group71_5e7f9e52c8b5d
X-Filterd-Recvd-Size: 1344
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Feb 2020 03:10:49 +0000 (UTC)
Message-ID: <225b88ac1abcb293bf9d55ca53009015b1baa81c.camel@perches.com>
Subject: Re: [PATCH v2 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
From:   Joe Perches <joe@perches.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 19:09:34 -0800
In-Reply-To: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
References: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 18:47 -0800, Tushar Sugandhi wrote:
> Log statements from ima_mok.c, ima_asymmetric_keys.c, and
> ima_queue_keys.c are prefixed with the respective file names
> and not with the string "ima". 

Series seems sensible, thanks Tushar.

Next time you might choose to use

	git format-patch --cover-letter

and write in the 0/n cover letter what the point
of the patch series is.

cheers and welcome... Joe

