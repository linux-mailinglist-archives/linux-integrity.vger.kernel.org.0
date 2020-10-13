Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F278528D14E
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 17:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgJMPao (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 11:30:44 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:54280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726749AbgJMPao (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 11:30:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 75E3B837F24D;
        Tue, 13 Oct 2020 15:30:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3622:3865:3867:4321:5007:10004:10400:10848:11232:11658:11914:12043:12114:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30003:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: kiss33_4a0b51627204
X-Filterd-Recvd-Size: 1377
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Oct 2020 15:30:41 +0000 (UTC)
Message-ID: <dce9442565fc3176ad770788bc1cf76b02080486.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: jarkko.sakkinen@linux.intel.com ->
 jarkko@kernel.org
From:   Joe Perches <joe@perches.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-sgx@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Date:   Tue, 13 Oct 2020 08:30:38 -0700
In-Reply-To: <20201013104705.140127-1-jarkko.sakkinen@linux.intel.com>
References: <20201013104705.140127-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-10-13 at 13:46 +0300, Jarkko Sakkinen wrote:
> Use korg address as the main communications end point. Update the
> corresponding M-entries.

Maybe add an equivalent entry to .mailmap?

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> -M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +M:	Jarkko Sakkinen <jarkko@kernel.org>


