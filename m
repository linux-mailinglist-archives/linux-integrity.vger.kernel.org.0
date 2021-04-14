Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55435F1DC
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Apr 2021 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhDNLFi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Apr 2021 07:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231764AbhDNLFg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Apr 2021 07:05:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F13361249;
        Wed, 14 Apr 2021 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618398315;
        bh=mZpKNAhEho5Ixyv0/V5hyPgR75cXSvs6lqr/DX83MyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boH6KcAymj7C5bfct3z+C1+DrUvLGVH341IyeI4yvIBPMmoBhWvyCGPOrHxOUgiQq
         iCANAL/FW1hYD0AqsVfrCv+IeedPbodVMKc+2lwWcM7Q21ST5WGFdkHYueRmFy2SDM
         xhG0tY+TVmmuujerWGnFhMlueD8JPui54tDTtzQzbPAIyJpfifOUhq0ur2en2a1cED
         587jDmgNOh9yJ9Qc5YmtSBlv+wNSLz9alrnC8GMhE22n2BiAznjq2h0FadpPTIjgxR
         AmoVSzunYbjnP+vRXycgLkvd6+SK+Mp/0OMpWFGMDcksPOGkibN67kbR5smnxJYFoW
         Y7N0cRTqULfEw==
Date:   Wed, 14 Apr 2021 14:05:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
        Kees Cook <keescook@chromium.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, jsnitsel@redhat.com
Subject: Re: Re: Bug: TPM returned invalid status
Message-ID: <YHbMaDfHTdE1s32l@kernel.org>
References: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
 <YBGpranyEwXaqAUg@kernel.org>
 <YBGqWp5FqKQJK1is@kernel.org>
 <b1e71d07546ccce7957ead9cc80303734251f6c9.camel@HansenPartnership.com>
 <202103291901.F15EA83FB6@keescook>
 <5e48c9ad-9e53-c079-83d1-7fea50412142@elloe.vision>
 <trinity-7c4b1b78-7c33-480e-a8bd-0536a4c67599-1617962105587@3c-app-gmx-bs15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-7c4b1b78-7c33-480e-a8bd-0536a4c67599-1617962105587@3c-app-gmx-bs15>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 09, 2021 at 11:55:05AM +0200, Lino Sanfilippo wrote:
> 
> Hi,
> 
> >
> > On 30/03/2021 03:04, Kees Cook wrote:
> > >
> > > Does this series solve the issue too?
> > >
> > > https://lore.kernel.org/linux-integrity/1613955394-13152-1-git-send-email-LinoSanfilippo@gmx.de/
> > >
> > > (I haven't had a chance to test either series with my TPM, but I see the
> > > same "TPM returned invalid status" errors recently.)
> > >
> >
> > Unfortunately no. I tested it immediately but forgot to let you know.
> >
> >
> > kernel: Linux version 5.12.0-rc5tpm-fix+ (tj@elloe000) (gcc (Ubuntu
> > 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #29
> > SMP PREEMPT Tue Mar 30 09:05:15 BST 2021
> > ...
> 
> Well you tested the series with 5.12-rc5 while it was based on 5.11. Patch 2
> in the series is supposed to fix the "invalid status" warning by making sure
> that the required locality has been requested before.
> To avoid such issues at all and to simplify the whole locality handling (and
> also to be prepared for interrupt handling which also requires locality management)
> that patch furthermore ensures that the locality is requested only once at driver
> startup and not released until driver shutdown.
> 
> However between 5.11 and 5.12-rc5 there have been at least two patches that
> again introduced a locality request/release combo (d53a6adfb553 "tpm, tpm_tis:
> Decorate tpm_tis_gen_interrupt() with request_locality()" and a5665ec2affd
> "tpm, tpm_tis: Decorate tpm_get_timeouts() with request_locality()").
> 
> The latter results in the locality being released again before tpm_tis_status()
> is called and thus reintroduced the issue patch 2 fixed.
> 
> I will prepare another series based on the latest kernel but at least for 5.11
> the series should fix the issue (and also make interrupts working).
 
Thanks, I can review patches after coming from two week leave and include
them to 5.13-rcX. Add stable cc in addition to the fixes tag.

/Jarkko
