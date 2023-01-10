Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A88E664754
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jan 2023 18:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjAJRWc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Jan 2023 12:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbjAJRVv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Jan 2023 12:21:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9961DDC2;
        Tue, 10 Jan 2023 09:21:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00A604D7C5;
        Tue, 10 Jan 2023 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673371299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vei1DaE8uRB41yRSAQ17aS0iN4+zXK6p5LrdkYiuYxg=;
        b=wvN0azli41yMAHd9srw3ORxqNblSGyo9JARChP9gUggYeK9bhuSBt6t8vAt0+OxW2HbY62
        wx0b5ZKcr7/UM4xDAJ3dCUwZ+jjS8bqOP5FdCw+dxKfIR7aTJMeJJm9UBXitwBaVSCj2G+
        mMqXk7QtBLcfxWECBuyRohRPvRjhthA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673371299;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vei1DaE8uRB41yRSAQ17aS0iN4+zXK6p5LrdkYiuYxg=;
        b=k+M/vQfzO4ApPTp4qGb+Ff+OSNq5+frWvkA+9bImmzz6lLX3tkzF7ChaA5oGAL2AFgBp12
        Ek7XXMgf2yRDbnCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7B431358A;
        Tue, 10 Jan 2023 17:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PbD2J6KevWOCPgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 Jan 2023 17:21:38 +0000
Message-ID: <58d7a42c-9e6b-ab2a-617f-d5e373bf63cb@suse.cz>
Date:   Tue, 10 Jan 2023 18:19:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Altmanninger <aclopte@gmail.com>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
 <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
 <Y60RoP77HnwaukEA@zx2c4.com>
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y7w74EBYP3+FHlkw@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/9/23 17:08, Jason A. Donenfeld wrote:
> Hi Thorsten,
> 
> On Thu, Jan 05, 2023 at 02:59:15PM +0100, Thorsten Leemhuis wrote:
>> On 29.12.22 05:03, Jason A. Donenfeld wrote:
>>> On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
>>>> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
>>>>> Ugh, while the problem [1] was fixed in 6.1, it's now happening again
>>>>> on the T460 with 6.2-rc1. Except I didn't see any oops message or
>>>>> "tpm_try_transmit" error this time. The first indication of a problem
>>>>> is this during a resume from suspend to ram:
>>>>>
>>>>> tpm tpm0: A TPM error (28) occurred continue selftest
>>>>>
>>>>> and then periodically 
>>>>>
>>>>> tpm tpm0: A TPM error (28) occurred attempting get random
>>>>
>>>> That's a TPM 1.2 error which means the TPM failed the selftest.  The
>>>> original problem was reported against TPM 2.0  because of a missing
>>>> try_get_ops().
>>>
>>> No, I'm pretty sure the original bug, which was fixed by "char: tpm:
>>> Protect tpm_pm_suspend with locks" regards 1.2 as well, especially
>>> considering it's the same hardware from Vlastimil causing this. I also
>>> recall seeing this in 1.2 when I ran this with the TPM emulator. So
>>> that's not correct.
>>
>> James, are you or some other TPM developer looking into this? Or is this
>> deadlocked now? And if so: how can we get this unstuck to get this
>> regression solved?
>>
>> Side note: I wonder if the problem that Johannes reported yesterday in
>> this thread (
>> https://lore.kernel.org/all/Y7VCcgHUC6JtnO2b@gmail.com/
>> ) is related or something else, as it seems his issue happens with 6.1,
>> while Vlastimil's problems should be fixed there. Or am I missing something?
> 
> So, this is now in rc3:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1382999aa0548a171a272ca817f6c38e797c458c
> 
> That should help avoid the worst of the issue -- laptop not sleeping.
> But the race or whatever it is still does exist. So you might want to
> keep this in your tracker to periodically nudge the TPM folks about it.

Heh, booted rc3 and managed to hit it on very first suspend to ram attempt:

tpm tpm0: A TPM error (28) occurred continue selftest

But thanks to the patch, the next suspend worked:

[  236.598900] tpm tpm0: Error (28) sending savestate before suspend
[  236.598915] tpm_tis 00:08: Ignoring error 28 while suspending

and on resume again:

[  238.196645] tpm tpm0: A TPM error (28) occurred continue selftest

and indeed now I keep getting (as expected)

[  399.671077] tpm tpm0: A TPM error (28) occurred attempting get random

So hopefully somebody will look into the root cause at some point.

> Jason
> 
> 

