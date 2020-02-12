Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E5015AC57
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 16:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgBLPtJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 10:49:09 -0500
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:49478 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727458AbgBLPtJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 10:49:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 35642180A68D7;
        Wed, 12 Feb 2020 15:49:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3350:3622:3865:3867:3868:3870:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7903:8985:9025:10004:10400:10848:11232:11658:11914:12043:12048:12297:12555:12740:12760:12895:12986:13069:13095:13311:13357:13439:14181:14659:14721:21067:21080:21324:21433:21451:21611:21627:21740:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:6,LUA_SUMMARY:none
X-HE-Tag: play61_4f690e963e011
X-Filterd-Recvd-Size: 1651
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Feb 2020 15:49:05 +0000 (UTC)
Message-ID: <b9acb7868a1e225db09830d859bfd4cc6ac6330d.camel@perches.com>
Subject: Re: [PATCH v3 3/3] IMA: Add module name and base name prefix to log.
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Feb 2020 07:47:49 -0800
In-Reply-To: <1581521161.3494.7.camel@HansenPartnership.com>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
         <20200211231414.6640-4-tusharsu@linux.microsoft.com>
         <1581517770.8515.35.camel@linux.ibm.com>
         <1581521161.3494.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-12 at 10:26 -0500, James Bottomley wrote:
> Log messages are often consumed by log monitors, which mostly use
> pattern matching to find messages they're interested in, so you have to
> take some care when changing the messages the kernel spits out and you
> have to make sure any change gets well notified so the distributions
> can warn about it.
> 
> For this one, can we see a "before" and "after" message so we know
> what's happening?

https://patchwork.kernel.org/patch/11357335/#23134147


