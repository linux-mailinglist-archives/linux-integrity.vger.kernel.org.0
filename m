Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E1565EE1D
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jan 2023 15:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjAEOBh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Jan 2023 09:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjAEOBM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jan 2023 09:01:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB195D439;
        Thu,  5 Jan 2023 05:59:21 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pDQm4-0005sI-Ac; Thu, 05 Jan 2023 14:59:16 +0100
Message-ID: <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
Date:   Thu, 5 Jan 2023 14:59:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
Content-Language: en-US, de-DE
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Johannes Altmanninger <aclopte@gmail.com>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
 <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
 <Y60RoP77HnwaukEA@zx2c4.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y60RoP77HnwaukEA@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672927162;4b000f19;
X-HE-SMSGID: 1pDQm4-0005sI-Ac
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 29.12.22 05:03, Jason A. Donenfeld wrote:
> On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
>> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
>>> Ugh, while the problem [1] was fixed in 6.1, it's now happening again
>>> on the T460 with 6.2-rc1. Except I didn't see any oops message or
>>> "tpm_try_transmit" error this time. The first indication of a problem
>>> is this during a resume from suspend to ram:
>>>
>>> tpm tpm0: A TPM error (28) occurred continue selftest
>>>
>>> and then periodically 
>>>
>>> tpm tpm0: A TPM error (28) occurred attempting get random
>>
>> That's a TPM 1.2 error which means the TPM failed the selftest.  The
>> original problem was reported against TPM 2.0  because of a missing
>> try_get_ops().
> 
> No, I'm pretty sure the original bug, which was fixed by "char: tpm:
> Protect tpm_pm_suspend with locks" regards 1.2 as well, especially
> considering it's the same hardware from Vlastimil causing this. I also
> recall seeing this in 1.2 when I ran this with the TPM emulator. So
> that's not correct.

James, are you or some other TPM developer looking into this? Or is this
deadlocked now? And if so: how can we get this unstuck to get this
regression solved?

Side note: I wonder if the problem that Johannes reported yesterday in
this thread (
https://lore.kernel.org/all/Y7VCcgHUC6JtnO2b@gmail.com/
) is related or something else, as it seems his issue happens with 6.1,
while Vlastimil's problems should be fixed there. Or am I missing something?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>> The tpm 1.2 command path was never changed to require
>> this (and in fact hasn't changed for ages, TPM 1.2 being a bit
>> obsolete).
> 
> False. I'll just copy and paste the diff of that commit:
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce818705..d69905233aff 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -401,13 +401,14 @@ int tpm_pm_suspend(struct device *dev)
>  	    !pm_suspend_via_firmware())
>  		goto suspended;
> 
> -	if (!tpm_chip_start(chip)) {
> +	rc = tpm_try_get_ops(chip);
> +	if (!rc) {
>  		if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  			tpm2_shutdown(chip, TPM2_SU_STATE);
>  		else
>  			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> 
> -		tpm_chip_stop(chip);
> +		tpm_put_ops(chip);
>  	}
> 
>  suspended:
> 
> 
> So, as you can see, this affects the call to tpm1_pm_suspend.
> 
>> So this looks like a new problem with TPM 1.2 and
>> suspend/resume, likely in the BIOS of your system.
> 
> No, this is not a BIOS problem. This is a kernel bug in the TPM 1.2
> driver. Yes, it'd be very nice to wave this all away and blame it on the
> BIOS, but I really don't think that's the case, especially considering
> this is all reproducible in the emulator.
> 
> I recall seeing something pretty similar to this report with the
> selftest as well. Basically, the call to tpm1_do_selftest can race with
> the call to tpm1_get_random, presumably because tpm1_get_random doesn't
> do any locking on its own. So it might be a good idea to make sure that
> tpm1_get_random() isn't running before tpm1_do_selftest() or any other
> TPM commands run.
> 
> I spent a long time working through the TPM code when this came up
> during 6.1. I set up the TPM emulator with QEMU and reproduced this and
> had a whole test setup and S3 fuzzer. It took a long time, and when I was
> done, I paged it all out of my brain. When I found that patch from Jan
> that fixed the problem most of the time (but not all the time), I wasted
> tons of time trying to get the TPM maintainers to take the patch and
> send it to Linus as part of rc7 or rc8. But they all ignored me, and
> eventually Linus just took that patch directly.
> 
> So I don't think I want to go down another rabbit hole here, having
> experienced the TPM maintainers not really caring much, and that sucking
> away the remaining energy I had before to keep looking at the issue and
> its edge cases not handled by Jan's patch.
> 
> On the contrary, it'd make a big difference if the TPM maintainers could
> actually help analyze the code that they're most familiar with, so that
> we can get to the bottom of this. That's a lot better than some random
> drive-by patches from a non-TPM person like me; before the 6.1 bug, I'd
> never even looked at these drivers. 
> 
> My plan is to therefore be available to help and analyze and test and
> maybe even write some code, if the TPM maintainers take the lead on
> getting to the bottom of this. But if this hits neglect again like last
> time, I'll just send a `depends on BROKEN if PM` patch to the TPM
> hw_random driver and see what happens... That's a really awful solution
> though, so I hope the maintainers will wake up this cycle.
> 
> Regards,
> Jason
> 
> 
