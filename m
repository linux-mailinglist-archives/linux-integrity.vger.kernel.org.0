Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0561931C779
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 09:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBPIls (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 03:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhBPIk0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 03:40:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5BA364DAF;
        Tue, 16 Feb 2021 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613464783;
        bh=wT0wO5i8JjzB/3WyoPYbp7wCp1+pYU1sQ9p+Wiojyvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5/J06GSzTeih59VMVUD0mwdfJZ8Tzku2A/c8TFklHCMdT8Sa0REfgHbPxQmrG2q7
         4ScqEVrzHMhy8WU0XQgst/BwCFC6kLhXXVuoW+k0jBY78Sw8AOkyMZvNZd1hYCce3L
         0BeShkbV0XpXTX3JGzZDlFQS9UPZI9b3965CdHvtzCHiPuUhR035HRwWfgOjM6L6mL
         AlHa7B4IpJvVjsxJca7+TiR6Lbm1LClUDaG25N8aOP1hDM9efUIQZzkZD0s0clLpB+
         gX38KHvGo8/X7UM13OOcJY8XzkmZTG0ftwUBgHEQOMcK9xS/YSO4S4syOkamrgjZjU
         Q9PYfar+KdmEA==
Date:   Tue, 16 Feb 2021 10:39:30 +0200
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
Message-ID: <YCuEwiBmV5067AYj@kernel.org>
References: <20210216081750.191250-1-jarkko@kernel.org>
 <5bd42a4c-56db-3be5-953f-a85336fe0175@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bd42a4c-56db-3be5-953f-a85336fe0175@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 16, 2021 at 09:26:49AM +0100, Paul Menzel wrote:
> Dear Jarkko,
> 
> 
> Am 16.02.21 um 09:17 schrieb Jarkko Sakkinen:
> > From: Lukasz Majczak <lma@semihalf.com>
> > 
> > This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
> > (SLB 9670):
> > 
> > [    4.324298] TPM returned invalid status
> > [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
> > 
> > Background
> > ==========
> > 
> > TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 FIFO
> > Interface Locality Usage per Register, Table 39 Register Behavior Based on
> > Locality Setting for FIFO - a read attempt to TPM_STS_x Registers returns
> > 0xFF in case of lack of locality. The described situation manifests itself
> > with the following warning trace:
> 
> Did you miss to paste the trace?
> 
> […]
> 
> 
> Kind regards,
> 
> Paul

There is partial trace, which I took from the Lukasz patch. IMHO that is
sufficient.

And I have no means to generate the full trace anyway.

/Jarkko
