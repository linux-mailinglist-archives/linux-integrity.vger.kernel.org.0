Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15631CDC9
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 17:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhBPQPi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 11:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230446AbhBPQPJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 11:15:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0394564E07;
        Tue, 16 Feb 2021 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613492069;
        bh=WIx1Yk1IheiU5oaRpK6bTqTY9UOifeJJPUUd31D0IOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvCo6Rltn9HJimexRyQvZ15aibjbmd+WxLLy+nfTBvneNymKqxU2Sv5BnOIOs1Tcc
         V1BQcjFqfeOOpWYLugz1Ugl+GGfsX20UU6KIciimShabaEWdipYOINqSduCUMF0hPA
         fNVkW1dLkb2jOINfzv2oLJ9dd7K/Wg3Lgad6Z8tD2jSzukdH6dHxQ8NuJPo3MHaUMB
         r/LmfxK8mdYR++WqqDqk/C/5l0gnWYPgUDXRbLvB+Rwfg/FW3DSR5e8CuCgzaK4Mvm
         b0cJjcjU53FH2jLB8qimT92Jj/ij2c5GRFsPoHY8+ZroezXVhF00jzvnujdDcKrDHo
         CriezYLVy8/AA==
Date:   Tue, 16 Feb 2021 18:14:17 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Laurent Bigonville <bigon@debian.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in
 tpm_tis_gen_interrupt() and tpm_get_timeouts()
Message-ID: <YCvvWTq2CaJvEFcJ@kernel.org>
References: <20210216081750.191250-1-jarkko@kernel.org>
 <5bd42a4c-56db-3be5-953f-a85336fe0175@molgen.mpg.de>
 <YCuEwiBmV5067AYj@kernel.org>
 <bcd119a8-e4e7-395f-f88d-1f4789a13bc1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcd119a8-e4e7-395f-f88d-1f4789a13bc1@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 16, 2021 at 09:50:40AM +0100, Paul Menzel wrote:
> Dear Jarko,
> 
> 
> Am 16.02.21 um 09:39 schrieb Jarkko Sakkinen:
> > On Tue, Feb 16, 2021 at 09:26:49AM +0100, Paul Menzel wrote:
> 
> > > Am 16.02.21 um 09:17 schrieb Jarkko Sakkinen:
> > > > From: Lukasz Majczak <lma@semihalf.com>
> > > > 
> > > > This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
> > > > (SLB 9670):
> > > > 
> > > > [    4.324298] TPM returned invalid status
> > > > [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
> > > > 
> > > > Background
> > > > ==========
> > > > 
> > > > TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 FIFO
> > > > Interface Locality Usage per Register, Table 39 Register Behavior Based on
> > > > Locality Setting for FIFO - a read attempt to TPM_STS_x Registers returns
> > > > 0xFF in case of lack of locality. The described situation manifests itself
> > > > with the following warning trace:
> > > 
> > > Did you miss to paste the trace?
> > > 
> > > […]
> 
> > There is partial trace, which I took from the Lukasz patch. IMHO that is
> > sufficient.
> 
> Reading the paragraph with “ with the following warning trace:” (and colon),
> I would expect to see some trace, and not the next section header *The fix*.


Aah! I took the paragraph from the original commit. So, what if I just
remove the last sentence? I see what you mean.

> 
> > And I have no means to generate the full trace anyway.
> 
> No problem.
> 
> 
> Kind regards,
> 
> Paul
> 

/Jarkko
