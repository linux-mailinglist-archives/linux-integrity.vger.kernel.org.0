Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3119306C87
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 05:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhA1E6D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 23:58:03 -0500
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:50834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229545AbhA1E6D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 23:58:03 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 54824181D341E;
        Thu, 28 Jan 2021 04:57:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3874:4250:4321:4385:5007:6119:6120:6742:6743:7652:7807:7901:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13019:13069:13311:13357:13439:14659:21080:21212:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fan51_55072612759c
X-Filterd-Recvd-Size: 2289
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jan 2021 04:57:17 +0000 (UTC)
Message-ID: <d6ddcab2f9db25f49e89f37e1cb4f59ad42651e6.camel@perches.com>
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
From:   Joe Perches <joe@perches.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 27 Jan 2021 20:57:16 -0800
In-Reply-To: <871re5soof.fsf@manicouagan.localdomain>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
         <20210115173017.30617-10-nramas@linux.microsoft.com>
         <20210127165208.GA358@willie-the-truck>
         <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
         <20210127184319.GA676@willie-the-truck>
         <871re5soof.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-28 at 00:52 -0300, Thiago Jung Bauermann wrote:
> The problem is that this patch implements only part of the suggestion,
> which isn't useful in itself. So the patch series should either drop
> this patch or consolidate the FDT allocation between the arches.
> 
> I just tested on powernv and pseries platforms and powerpc can use
> vmalloc for the FDT buffer.

Perhaps more sensible to use kvmalloc/kvfree.



