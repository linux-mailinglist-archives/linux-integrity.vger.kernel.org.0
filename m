Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362C565EEB4
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jan 2023 15:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAEO0g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Jan 2023 09:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjAEO0E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jan 2023 09:26:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71E934762;
        Thu,  5 Jan 2023 06:26:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D29D2434D;
        Thu,  5 Jan 2023 14:25:41 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4799C13338;
        Thu,  5 Jan 2023 14:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J9S5EOXdtmMLCwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Jan 2023 14:25:41 +0000
Message-ID: <370a2808-a19b-b512-4cd3-72dc69dfe8b0@suse.cz>
Date:   Thu, 5 Jan 2023 15:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
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
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.10
X-Spamd-Result: default: False [-0.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_TWELVE(0.00)[14];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,semihalf.com,lists.linux.dev,vger.kernel.org,dominikbrodowski.net,gondor.apana.org.au,linux-foundation.org,zx2c4.com,gmail.com]
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/5/23 14:59, Thorsten Leemhuis wrote:
> On 29.12.22 05:03, Jason A. Donenfeld wrote:
>> On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
>>> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
>>>> Ugh, while the problem [1] was fixed in 6.1, it's now happening again
>>>> on the T460 with 6.2-rc1. Except I didn't see any oops message or
>>>> "tpm_try_transmit" error this time. The first indication of a problem
>>>> is this during a resume from suspend to ram:
>>>>
>>>> tpm tpm0: A TPM error (28) occurred continue selftest
>>>>
>>>> and then periodically 
>>>>
>>>> tpm tpm0: A TPM error (28) occurred attempting get random
>>>
>>> That's a TPM 1.2 error which means the TPM failed the selftest.  The
>>> original problem was reported against TPM 2.0  because of a missing
>>> try_get_ops().
>> 
>> No, I'm pretty sure the original bug, which was fixed by "char: tpm:
>> Protect tpm_pm_suspend with locks" regards 1.2 as well, especially
>> considering it's the same hardware from Vlastimil causing this. I also
>> recall seeing this in 1.2 when I ran this with the TPM emulator. So
>> that's not correct.
> 
> James, are you or some other TPM developer looking into this? Or is this
> deadlocked now? And if so: how can we get this unstuck to get this
> regression solved?
> 
> Side note: I wonder if the problem that Johannes reported yesterday in
> this thread (
> https://lore.kernel.org/all/Y7VCcgHUC6JtnO2b@gmail.com/
> ) is related or something else, as it seems his issue happens with 6.1,
> while Vlastimil's problems should be fixed there. Or am I missing something?

Yaeh, as Jason noted, the fix in 6.1 probably covered only the most common
race scenario, yet other(s) were still possible, just more rare. So most
likely I just happened not to trigger it anymore with 6.1, only after
switching to 6.2 - but it's not really a new bug in 6.2. And 6.1 also only
started to exhibit it because hwrng started using the tpm, which would just
sit unused before that.

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 

