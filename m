Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5C86B8EDA
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 10:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCNJfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCNJfo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 05:35:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262C16A426;
        Tue, 14 Mar 2023 02:35:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pc14E-0005Zv-CV; Tue, 14 Mar 2023 10:35:38 +0100
Message-ID: <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
Date:   Tue, 14 Mar 2023 10:35:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
Content-Language: en-US, de-DE
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y7w74EBYP3+FHlkw@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678786543;a6c33ef7;
X-HE-SMSGID: 1pc14E-0005Zv-CV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 09.01.23 17:08, Jason A. Donenfeld wrote:
> On Thu, Jan 05, 2023 at 02:59:15PM +0100, Thorsten Leemhuis wrote:
>> On 29.12.22 05:03, Jason A. Donenfeld wrote:
>>> On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
>>>> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
>>>>> Ugh, while the problem [1] was fixed in 6.1, it's now happening again
>>>>> on the T460 with 6.2-rc1. Except I didn't see any oops message or
>>>>> "tpm_try_transmit" error this time. The first indication of a problem
>>>>> is this during a resume from suspend to ram:
>>>>> tpm tpm0: A TPM error (28) occurred continue selftest
>>>>> and then periodically 
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
> [...]
> So, this is now in rc3:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1382999aa0548a171a272ca817f6c38e797c458c
> 
> That should help avoid the worst of the issue -- laptop not sleeping.
> But the race or whatever it is still does exist. So you might want to
> keep this in your tracker to periodically nudge the TPM folks about it.

I did, and with -rc2 out now is a good time to remind everybody about
it. Jarkko even looked into it, but no real fix emerged afaics. Or did it?

Ciao, Thorsten
