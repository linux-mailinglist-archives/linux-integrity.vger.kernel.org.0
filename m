Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F186B950D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 13:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjCNM7u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjCNM7V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 08:59:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF9366AA;
        Tue, 14 Mar 2023 05:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96573B811F5;
        Tue, 14 Mar 2023 12:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB90C433A4;
        Tue, 14 Mar 2023 12:47:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="b5R/jWL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1678798060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOFa9e8BNmMVgxHJvgqbkR1KMTLdpurluNOIJewz+Gw=;
        b=b5R/jWL60Qdm0/QQGpwEW25FVxsdqdyNFniHB+QAGf5lMwEjUybNaTT3jo3XHmni5GiUrZ
        pIUjvJNZz0AjdVWiFNraUGu4cP5kEfYf42zJr9iavZL/4yz7xk3n/IBZ4pEqA/cOcEa9zK
        jTi8AHO/zVlKVDIOP9RWtsR5JY4R/d4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d2cd63a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 14 Mar 2023 12:47:40 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-53d277c1834so301996047b3.10;
        Tue, 14 Mar 2023 05:47:40 -0700 (PDT)
X-Gm-Message-State: AO0yUKWTRSn/zQBGltMBNoRBYZNkMCnWqnJgA9daj9WhrsjfQ/yQokWm
        a1RqMVMesZKLwmZqG7MFL+cJ8Y5jAzEDIoa81fE=
X-Google-Smtp-Source: AK7set8cHiziQ5N/k4D1qIDmhTeKT6cHmqgyz1r29oB+Y8BS84yMnsHlNg8FYtL/MJx4qt3C8z7VprHNLvqFX6ZEdVc=
X-Received: by 2002:a81:ac61:0:b0:544:6828:3c0f with SMTP id
 z33-20020a81ac61000000b0054468283c0fmr864005ywj.4.1678798058695; Tue, 14 Mar
 2023 05:47:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:53ce:b0:1f4:dffd:2c5c with HTTP; Tue, 14 Mar 2023
 05:47:38 -0700 (PDT)
In-Reply-To: <ZBBmVhwsTf/URoqs@kernel.org>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz> <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
 <Y60RoP77HnwaukEA@zx2c4.com> <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com> <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
 <ZBBmVhwsTf/URoqs@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 14 Mar 2023 13:47:38 +0100
X-Gmail-Original-Message-ID: <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
Message-ID: <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/14/23, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Tue, Mar 14, 2023 at 10:35:33AM +0100, Thorsten Leemhuis wrote:
>> On 09.01.23 17:08, Jason A. Donenfeld wrote:
>> > On Thu, Jan 05, 2023 at 02:59:15PM +0100, Thorsten Leemhuis wrote:
>> >> On 29.12.22 05:03, Jason A. Donenfeld wrote:
>> >>> On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
>> >>>> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
>> >>>>> Ugh, while the problem [1] was fixed in 6.1, it's now happening
>> >>>>> again
>> >>>>> on the T460 with 6.2-rc1. Except I didn't see any oops message or
>> >>>>> "tpm_try_transmit" error this time. The first indication of a
>> >>>>> problem
>> >>>>> is this during a resume from suspend to ram:
>> >>>>> tpm tpm0: A TPM error (28) occurred continue selftest
>> >>>>> and then periodically
>> >>>>> tpm tpm0: A TPM error (28) occurred attempting get random
>> >>>>
>> >>>> That's a TPM 1.2 error which means the TPM failed the selftest.  The
>> >>>> original problem was reported against TPM 2.0  because of a missing
>> >>>> try_get_ops().
>> >>>
>> >>> No, I'm pretty sure the original bug, which was fixed by "char: tpm:
>> >>> Protect tpm_pm_suspend with locks" regards 1.2 as well, especially
>> >>> considering it's the same hardware from Vlastimil causing this. I
>> >>> also
>> >>> recall seeing this in 1.2 when I ran this with the TPM emulator. So
>> >>> that's not correct.
>> > [...]
>> > So, this is now in rc3:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1382999aa0548a171a272ca817f6c38e797c458c
>> >
>> > That should help avoid the worst of the issue -- laptop not sleeping.
>> > But the race or whatever it is still does exist. So you might want to
>> > keep this in your tracker to periodically nudge the TPM folks about it.
>>
>> I did, and with -rc2 out now is a good time to remind everybody about
>> it. Jarkko even looked into it, but no real fix emerged afaics. Or did
>> it?
>
> Jason's workaround was picked. I asked some questions in the thread but
> have not received any responses.

As I've written several times now, that patch doesn't fix the issue.
It makes it less common but it still exists and needs to be addressed.
Please re-read my various messages describing this. I have nothing new
at all to add; you just need to review my prior comments. There's a
bug that probably needs to be fixed here by somebody who understands
the tpm1 code.
