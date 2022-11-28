Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597CF63A9B5
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 14:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiK1NgH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 08:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiK1NgC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 08:36:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6461EEE1;
        Mon, 28 Nov 2022 05:35:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25F571F381;
        Mon, 28 Nov 2022 13:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669642555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TY7/7AgLrq4nTnUbMFstKjsYLVXpbbNEZVUDr1fnyEo=;
        b=Z64fkzaQ1NzT1oE7SOTCu/aiWrW21a0pepwxqTitNRD+x3vPFnsCXOQv9k26wu10KW2lst
        +/+lgGlpWCsEUs+jAWcfJF4cAKBM8fTmYcONmxL6TjMUrlwYrDgsAZDvo2/uhKBpPYxrUH
        /H7eshMzTlA/MHZQm6/hOXvF+rNmzu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669642555;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TY7/7AgLrq4nTnUbMFstKjsYLVXpbbNEZVUDr1fnyEo=;
        b=8PcQ3RitgPSEuNjx/4GFpmHA640HgCeS40CwkL+layZUdqOaa63xV7mTs8j+I/24VfCjm/
        II1gZvdj8ywebMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFDD413273;
        Mon, 28 Nov 2022 13:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M/fIOTq5hGOfCQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 28 Nov 2022 13:35:54 +0000
Message-ID: <d659c6cc-9c32-1e0b-4fc9-986f124e987b@suse.cz>
Date:   Mon, 28 Nov 2022 14:35:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [REGRESSION] suspend to ram fails in 6.1 due to tpm errors
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz>
 <Y4Sjk+Fibcsihg4Y@zx2c4.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y4Sjk+Fibcsihg4Y@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/28/22 13:03, Jason A. Donenfeld wrote:
> Hi Vlastimil,
> 
> Thanks for CC'ing me.
> 
> On Mon, Nov 28, 2022 at 09:15:33AM +0100, Vlastimil Babka wrote:
>> Dominik on IRC pointed me to commit b006c439d58d ("hwrng: core - start hwrng
>> kthread also for untrusted sources"), which could make sense if the TPM was not
>> used at all before and now it's used for randomness. But then it probably "just"
>> uncovered a pre-existing issue? Maybe there's a race with getting the randomness
>> and suspend? Could it be exactly what this patch is attempting to fix?
>> https://lore.kernel.org/all/20221103145450.1409273-2-jsd@semihalf.com/
> 
> The commit you referenced just turns on some functionality that most
> people previously didn't have (but maybe could have, manually). So this
> is a case of a new commit unearthing a bug in some old code. We had
> something similar happen with a raspi driver and fixed the bug there.

Right, I suspected as much.

> From the looks of the lore link you provided, it sounds like the same
> thing has happened already there to tpm? That this is already fixed by
> that commit? I think if you have a system that's readily exhibiting the

Well it was a patch series where a v3 was promised with more info about the
bug it fixes, but I haven't found a v3. So if the author or TPM maintainers
can confirm that it does (or can) indeed fix such a bug I'm observing, I'd
hope for it to be fasttracked to 6.1.

> issue, the best thing to do would be to try that series, and report
> back, maybe even providing your `Tested-by:` line if it works.

Yeah, I have compiled rc7 with patch 1/3, without the rest as that didn't
seem necessary, and there was some review feedback that some parts need
fixing. So far it didn't exhibit the bug when suspending/resuming 10 times,
but that's not yet a guarantee due to nondeterministic nature of the issue
and usually the suspends weren't happening in such rapid succession... I'll
keep using that kernel for now on the laptop, fwiw.

> I'll play around and see if I can repro too. Looks like you have a T460?
> I don't have exactly that but maybe something close enough.

Great, thanks!

> Jason

