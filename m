Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450D22D3161
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 18:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgLHRnd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 12:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730732AbgLHRnd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 12:43:33 -0500
Date:   Tue, 8 Dec 2020 19:42:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607449372;
        bh=BftUl2M64lQHtLnTxOiHMi7sfSYR5CWaxkC+KmCM7iA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CboFcSX9DF/ccKwCw3g3G7AMkHU6RwGXd6EhUwYLarUVQmQqkTTu1hVbbYLlT9Pu4
         6ol3agoXGVmewMw36lEqKoJV2CxCo7MeHPX6SQIZt76KJ4zyKEtJBRPW/dPshNI1r5
         OIKqh783vTlDFY1ymcE4sZNQ+/omhudZi2YeZJlsOTyERbDfj/+SjNI7ixm/dNByUS
         LV0ahU5geeb5mURgtpNiMSdgO6HExtXNo8W5419tfGmGseHd8v5j9k3Ps0NBsH3SAe
         LoGGh7Ckb8QT9z461GlIqQ9Gxy8zvmI5g2vRz+3KXv5BXZcFOjLKSHU8bpHY1QlW7/
         CU+tRnzAJpCRQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] tpm_tis: Disable interrupts if interrupt storm
 detected
Message-ID: <20201208174246.GB58213@kernel.org>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-4-jsnitsel@redhat.com>
 <87tusy7n3b.fsf@nanos.tec.linutronix.de>
 <20201207192803.GH5487@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207192803.GH5487@ziepe.ca>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 07, 2020 at 03:28:03PM -0400, Jason Gunthorpe wrote:
> On Sun, Dec 06, 2020 at 08:26:16PM +0100, Thomas Gleixner wrote:
> > Just as a side note. I was looking at tpm_tis_probe_irq_single() and
> > that function is leaking the interrupt request if any of the checks
> > afterwards fails, except for the final interrupt probe check which does
> > a cleanup. That means on fail before that the interrupt handler stays
> > requested up to the point where the module is removed. If that's a
> > shared interrupt and some other device is active on the same line, then
> > each interrupt from that device will call into the TPM code. Something
> > like the below is needed.
> > 
> > Also the X86 autoprobe mechanism is interesting:
> > 
> > 	if (IS_ENABLED(CONFIG_X86))
> > 		for (i = 3; i <= 15; i++)
> > 			if (!tpm_tis_probe_irq_single(chip, intmask, 0, i))
> > 				return;
> > 
> > The third argument is 'flags' which is handed to request_irq(). So that
> > won't ever be able to probe a shared interrupt. But if an interrupt
> > number > 0 is handed to tpm_tis_core_init() the interrupt is requested
> > with IRQF_SHARED. Same issue when the chip has an interrupt number in
> > the register. It's also requested exclusive which is pretty likely
> > to fail on ancient x86 machines.
> 
> It is very likely none of this works any more, it has been repeatedly
> reworked over the years and just left behind out of fear someone needs
> it. I've thought it should be deleted for a while now.
> 
> I suppose the original logic was to try and probe without SHARED
> because a probe would need exclusive access to the interrupt to tell
> if the TPM was actually the source, not some other device.
> 
> It is all very old and very out of step with current thinking, IMHO. I
> skeptical that TPM interrupts were ever valuable enough to deserve
> this in the first place.
> 
> Jason

+1 for removing it.

/Jarkko
