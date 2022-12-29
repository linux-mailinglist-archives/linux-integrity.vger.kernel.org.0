Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19FC658951
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Dec 2022 05:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiL2ED7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Dec 2022 23:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2ED4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Dec 2022 23:03:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B712767;
        Wed, 28 Dec 2022 20:03:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7C0BB818F0;
        Thu, 29 Dec 2022 04:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24094C433EF;
        Thu, 29 Dec 2022 04:03:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fs21zXWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672286628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kb9UvNFwpxHzxaiK0AFEtw4Ov1SgKsqV5mnJobfZPTU=;
        b=fs21zXWbGD7tePI4bbXNGWACXGHiVPHAWzs85NTvYJFBU3wq8aictVEjT9VoKw7283YlgB
        XlbLxf3iAWePgtJ/0gg+eFWzGGHAabksw9KnWKgqrOkT3lczpblYKV8GR2mJZP22g5lBbr
        2PLM31mCOfZMWFkQhe6nSZjbdNBj4P4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e76c06d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 29 Dec 2022 04:03:48 +0000 (UTC)
Date:   Thu, 29 Dec 2022 05:03:44 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
Message-ID: <Y60RoP77HnwaukEA@zx2c4.com>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
 <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
> > Ugh, while the problem [1] was fixed in 6.1, it's now happening again
> > on the T460 with 6.2-rc1. Except I didn't see any oops message or
> > "tpm_try_transmit" error this time. The first indication of a problem
> > is this during a resume from suspend to ram:
> > 
> > tpm tpm0: A TPM error (28) occurred continue selftest
> > 
> > and then periodically 
> > 
> > tpm tpm0: A TPM error (28) occurred attempting get random
> 
> That's a TPM 1.2 error which means the TPM failed the selftest.  The
> original problem was reported against TPM 2.0  because of a missing
> try_get_ops().

No, I'm pretty sure the original bug, which was fixed by "char: tpm:
Protect tpm_pm_suspend with locks" regards 1.2 as well, especially
considering it's the same hardware from Vlastimil causing this. I also
recall seeing this in 1.2 when I ran this with the TPM emulator. So
that's not correct.

> The tpm 1.2 command path was never changed to require
> this (and in fact hasn't changed for ages, TPM 1.2 being a bit
> obsolete).

False. I'll just copy and paste the diff of that commit:

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce818705..d69905233aff 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -401,13 +401,14 @@ int tpm_pm_suspend(struct device *dev)
 	    !pm_suspend_via_firmware())
 		goto suspended;

-	if (!tpm_chip_start(chip)) {
+	rc = tpm_try_get_ops(chip);
+	if (!rc) {
 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
 			tpm2_shutdown(chip, TPM2_SU_STATE);
 		else
 			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);

-		tpm_chip_stop(chip);
+		tpm_put_ops(chip);
 	}

 suspended:


So, as you can see, this affects the call to tpm1_pm_suspend.

> So this looks like a new problem with TPM 1.2 and
> suspend/resume, likely in the BIOS of your system.

No, this is not a BIOS problem. This is a kernel bug in the TPM 1.2
driver. Yes, it'd be very nice to wave this all away and blame it on the
BIOS, but I really don't think that's the case, especially considering
this is all reproducible in the emulator.

I recall seeing something pretty similar to this report with the
selftest as well. Basically, the call to tpm1_do_selftest can race with
the call to tpm1_get_random, presumably because tpm1_get_random doesn't
do any locking on its own. So it might be a good idea to make sure that
tpm1_get_random() isn't running before tpm1_do_selftest() or any other
TPM commands run.

I spent a long time working through the TPM code when this came up
during 6.1. I set up the TPM emulator with QEMU and reproduced this and
had a whole test setup and S3 fuzzer. It took a long time, and when I was
done, I paged it all out of my brain. When I found that patch from Jan
that fixed the problem most of the time (but not all the time), I wasted
tons of time trying to get the TPM maintainers to take the patch and
send it to Linus as part of rc7 or rc8. But they all ignored me, and
eventually Linus just took that patch directly.

So I don't think I want to go down another rabbit hole here, having
experienced the TPM maintainers not really caring much, and that sucking
away the remaining energy I had before to keep looking at the issue and
its edge cases not handled by Jan's patch.

On the contrary, it'd make a big difference if the TPM maintainers could
actually help analyze the code that they're most familiar with, so that
we can get to the bottom of this. That's a lot better than some random
drive-by patches from a non-TPM person like me; before the 6.1 bug, I'd
never even looked at these drivers. 

My plan is to therefore be available to help and analyze and test and
maybe even write some code, if the TPM maintainers take the lead on
getting to the bottom of this. But if this hits neglect again like last
time, I'll just send a `depends on BROKEN if PM` patch to the TPM
hw_random driver and see what happens... That's a really awful solution
though, so I hope the maintainers will wake up this cycle.

Regards,
Jason
