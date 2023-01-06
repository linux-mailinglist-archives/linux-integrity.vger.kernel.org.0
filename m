Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240B6606DE
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jan 2023 20:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjAFTCl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Jan 2023 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjAFTBq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jan 2023 14:01:46 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735AA84BEF
        for <linux-integrity@vger.kernel.org>; Fri,  6 Jan 2023 11:00:11 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c11so2743912qtn.11
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jan 2023 11:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xXu0UrxATTjQV5tOMZWsigK936HnNawUgyg/NFmPfog=;
        b=WcF+YXOaqvpE/ecoEANu1yF1O+Aukjs7Um8ujF3uWejFh8Ota9tqhXwPE/nYYpPO9x
         YAFPfTmjZPQBY1g17l1dVR0vtyz6t//giJBIlDkMhndMs1nkqUyzyOlsm/w6aKY/UF/E
         ZWEm2doRox7auXvyEHevuIoxPtagRQmAOYrvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXu0UrxATTjQV5tOMZWsigK936HnNawUgyg/NFmPfog=;
        b=oD7i1tBvFKStfBpj01nNNBP4zndO81QiGp/PwJZHPK3dWCOgxN+cmWhmLLiXOg1peq
         jX34TiSSVxfJkRKzkAEbOeBp2EkXyIyFOa3FBnwynZjjugJEPpw37CwAbHRHiCz3n9rz
         Kqkyfb0IYRfycshk01EVK7FPTzJaKLG5r1HbQCN3xgjh9XvaQiUiJMpq7nm26ALbWnNO
         1DDWdIdnD8moPFH+tGEdM5PnQQHW8DJjVSLqlPWpK9UDp62yJCWPKNixqHupRPA2y6rE
         7FnUHLvZ3UtmEt5HY1ZBki/PSYPPyaMRzGFzRVU3IeDcP9ocIQai4njlgl+htKzlPi7c
         3xNg==
X-Gm-Message-State: AFqh2kpO0b0MAhwXOGZByxh0oW5O2f08kojMxXz7OFBdBEy22No/vm6s
        LOt9jZIcO5hT1anoDPywEDLuHTJN39kHMjN2
X-Google-Smtp-Source: AMrXdXs2uOA2BlotMK6FnWwEaNM0/Kq27GU/vLxZ4+qS1lb1zOq228lDt+3tphJ6QILCnO2kI0Hqrg==
X-Received: by 2002:ac8:7457:0:b0:3a8:2122:7c28 with SMTP id h23-20020ac87457000000b003a821227c28mr83125851qtr.47.1673031608477;
        Fri, 06 Jan 2023 11:00:08 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003a82ca4e81csm851509qtp.80.2023.01.06.11.00.07
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 11:00:07 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id jr11so2806716qtb.7
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jan 2023 11:00:07 -0800 (PST)
X-Received: by 2002:a05:622a:428c:b0:3a6:8b84:47ce with SMTP id
 cr12-20020a05622a428c00b003a68b8447cemr1560637qtb.678.1673031606753; Fri, 06
 Jan 2023 11:00:06 -0800 (PST)
MIME-Version: 1.0
References: <Y7dPV5BK6jk1KvX+@zx2c4.com> <20230106030156.3258307-1-Jason@zx2c4.com>
In-Reply-To: <20230106030156.3258307-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 10:59:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjin0Rn6j+EvYV9pzrbA0G2xnHKdp_EAB6XnansQ8kpUA@mail.gmail.com>
Message-ID: <CAHk-=wjin0Rn6j+EvYV9pzrbA0G2xnHKdp_EAB6XnansQ8kpUA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Allow system suspend to continue when TPM suspend fails
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Altmanninger <aclopte@gmail.com>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        tbroch@chromium.org, semenzato@chromium.org,
        dbasehore@chromium.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 5, 2023 at 7:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> In lieu of actually fixing the underlying bug, just allow system suspend
> to continue, so that laptops still go to sleep fine. Later, this can be
> reverted when the real bug is fixed.

So the patch looks fine to me, but since there's still the ChromeOS
discussion pending I'll wait for that to finish.

Perhaps re-send or at least remind me if/when it does?

Also, a query about the printout:

> +       if (rc)
> +               pr_err("Unable to suspend tpm-%d (error %d), but continuing system suspend\n",
> +                      chip->dev_num, rc);

so I suspect that 99% of the time the dev_num isn't actually all that
useful, but what *might* be useful is which tpm driver it is.

Just comparing the error dmesg output you had:

  ..
  tpm tpm0: Error (28) sending savestate before suspend
  tpm_tis 00:08: PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x80 returns 28
  ..

that "tpm tpm0" output is kind of useless compared to the "tpm_tis 00:08" one.

So I think "dev_err(dev, ...)" would be more useful here.

Finally - and maybe I'm just being difficult here, I will note here
again that TPM2 devices don't have this issue, because the TPM2 path
for suspend doesn't do any of this at all.

It just does

        tpm_transmit_cmd(..);

with a TPM2_CC_SHUTDOWN TPM_SU_STATE command, and doesn't even check
the return value. In fact, the tpm2 code *used* to have this comment:

        /* In places where shutdown command is sent there's no much we can do
         * except print the error code on a system failure.
         */
        if (rc < 0 && rc != -EPIPE)
                dev_warn(&chip->dev, "transmit returned %d while
stopping the TPM",
                         rc);

but it was summarily removed when doing some re-organization around
buffer handling.

So just by looking at what tpm2 does, I'm not 100% convinced that tpm1
should do this dance at all.

But having a dev_err() is probably a good idea at least as a transitional thing.

                  Linus
