Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7652D3165
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgLHRoa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 12:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgLHRoa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 12:44:30 -0500
Date:   Tue, 8 Dec 2020 19:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607449429;
        bh=4jaDJ4cW63InYyAcO+7Mk8fItHOLvl2IgoGj31CddDo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kjwf8bc9wBpKUStdt/Oyw4IP3gAG4BibCF9WYfQgVPv+530xR3xCu2Guf/wEDpTZv
         odhZaT7q1+aavhFe4b2TwB68KYqEcC1kF2y9aUSB5cXcJiD941XmhB0McgOaLPIEJZ
         W6EZWxrOQyyvxUrb5Mf1z7g3bFls0bNk46P43gtUy1NO6N+uFlxU64F95VY7/6AWyG
         OWgWWRXFITVRhgvY37HEXXKb0NHWftCC9dIlynHB6m10QZ3d/yFn87P6/tvsnbzcv+
         57bNV7FET+rx6QNmQmTuf5rn0vCg/xB205fxkg3kHIYDsPhCRE+KLbVn//7RPnEhKi
         ZsEcFzQdWFaPA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] tpm_tis: Disable interrupts if interrupt storm
 detected
Message-ID: <20201208174344.GC58213@kernel.org>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-4-jsnitsel@redhat.com>
 <87tusy7n3b.fsf@nanos.tec.linutronix.de>
 <20201207192803.GH5487@ziepe.ca>
 <db6ccb14819c4c7a32e886eade144884fafc55fe.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6ccb14819c4c7a32e886eade144884fafc55fe.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 07, 2020 at 11:58:44AM -0800, James Bottomley wrote:
> On Mon, 2020-12-07 at 15:28 -0400, Jason Gunthorpe wrote:
> > On Sun, Dec 06, 2020 at 08:26:16PM +0100, Thomas Gleixner wrote:
> > > Just as a side note. I was looking at tpm_tis_probe_irq_single()
> > > and that function is leaking the interrupt request if any of the
> > > checks afterwards fails, except for the final interrupt probe check
> > > which does a cleanup. That means on fail before that the interrupt
> > > handler stays requested up to the point where the module is
> > > removed. If that's a shared interrupt and some other device is
> > > active on the same line, then each interrupt from that device will
> > > call into the TPM code. Something like the below is needed.
> > > 
> > > Also the X86 autoprobe mechanism is interesting:
> > > 
> > > 	if (IS_ENABLED(CONFIG_X86))
> > > 		for (i = 3; i <= 15; i++)
> > > 			if (!tpm_tis_probe_irq_single(chip, intmask, 0,
> > > i))
> > > 				return;
> > > 
> > > The third argument is 'flags' which is handed to request_irq(). So
> > > that won't ever be able to probe a shared interrupt. But if an
> > > interrupt number > 0 is handed to tpm_tis_core_init() the interrupt
> > > is requested with IRQF_SHARED. Same issue when the chip has an
> > > interrupt number in the register. It's also requested exclusive
> > > which is pretty likely to fail on ancient x86 machines.
> > 
> > It is very likely none of this works any more, it has been repeatedly
> > reworked over the years and just left behind out of fear someone
> > needs it. I've thought it should be deleted for a while now.
> > 
> > I suppose the original logic was to try and probe without SHARED
> > because a probe would need exclusive access to the interrupt to tell
> > if the TPM was actually the source, not some other device.
> > 
> > It is all very old and very out of step with current thinking, IMHO.
> > I skeptical that TPM interrupts were ever valuable enough to deserve
> > this in the first place.
> 
> For what it's worth, I agree.  Trying to probe all 15 ISA interrupts is
> last millennium thinking we should completely avoid.  If it's not
> described in ACPI then you don't get an interrupt full stop.
> 
> James

Maybe you could add this as part of your patches?

/Jarkko
