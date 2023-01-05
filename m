Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E165F652
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jan 2023 22:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjAEV7J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Jan 2023 16:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjAEV7I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jan 2023 16:59:08 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9D6950D
        for <linux-integrity@vger.kernel.org>; Thu,  5 Jan 2023 13:59:07 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h21so31222103qta.12
        for <linux-integrity@vger.kernel.org>; Thu, 05 Jan 2023 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j0w58Jmxv23GOP82cSaTaJVOpSQ/WlFhaNSuDNLLtbw=;
        b=ZWrnuV/+oK0I3Jv9lK5gtYSMcmV/0S825Fft8v4+B9jE01S0vbNlAglhlXm1JBzOnt
         hA789qQ/CxOJyLAVaAiljJ8LwxY9uzFDesBGbhGuh64/4VlEraovgbmSdg4YkcLxbAsy
         KmBIDGAcYFHhTBTNHQpsOXZR/a/BtttWpNy4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0w58Jmxv23GOP82cSaTaJVOpSQ/WlFhaNSuDNLLtbw=;
        b=KGctyBvKWG3EpzR2fDs3CdSF40oKB5LWSzAKwPKXT3JZgNU/6iGZROL/QrLGRAf44i
         pCGoJyYSFdhj7YjitHdRGXJU2Tpee30zkKBeP5Y3tEpBU/U3/PD9ihIAsZtEP+U0nQqT
         kyUClzBwiYl5uUcMBCpU0+7F/pLUijCraDwpymgGrYW+NAzYOMGP6CvL7kJdf+NMLuo/
         ZXok30Jh5moJuMVf3X2e5Ge/Gv4gIpksy3z/c3tIoDC4QNH26zhbVRHWniUU6lbwy8b4
         8aF3RMs9HAdKz7QgvvxRp41992MrchJ25FeUkwgEJavh6xbHwy3U3C+5FZtTZ47GPQSR
         JhOg==
X-Gm-Message-State: AFqh2kokwLpVgvRLN9CQf8BCkLkD5pjzD+16fwUGK+DrMw9GlzvVDYiT
        VMGi1VI2rVOuwyXhJCW0NFtbr/7/3PjXihAl
X-Google-Smtp-Source: AMrXdXsIH0CkoxQZzGHKUdUVcvT/b0PoIhZEfAtVPb0fzLAaA/9s6ydZU80nNayxgCT8vfbcY1B6zg==
X-Received: by 2002:ac8:450e:0:b0:3a9:6b73:fb91 with SMTP id q14-20020ac8450e000000b003a96b73fb91mr66098732qtn.64.1672955946108;
        Thu, 05 Jan 2023 13:59:06 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id q12-20020a05620a2a4c00b006fef61300fesm26689763qkp.16.2023.01.05.13.59.04
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 13:59:04 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id o14so18567958qkk.5
        for <linux-integrity@vger.kernel.org>; Thu, 05 Jan 2023 13:59:04 -0800 (PST)
X-Received: by 2002:a37:a93:0:b0:6ff:812e:a82f with SMTP id
 141-20020a370a93000000b006ff812ea82fmr2294712qkk.336.1672955943954; Thu, 05
 Jan 2023 13:59:03 -0800 (PST)
MIME-Version: 1.0
References: <370a2808-a19b-b512-4cd3-72dc69dfe8b0@suse.cz> <20230105144742.3219571-1-Jason@zx2c4.com>
In-Reply-To: <20230105144742.3219571-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 13:58:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxaSHcHeo10JGz3EMJZBfC1LarcrerLos7uHbE1URhtQ@mail.gmail.com>
Message-ID: <CAHk-=whxaSHcHeo10JGz3EMJZBfC1LarcrerLos7uHbE1URhtQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable hwrng for TPM 1 if PM_SLEEP is enabled
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
        stable@vger.kernel.org
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

On Thu, Jan 5, 2023 at 6:48 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> TPM 1's support for its hardware RNG is broken across system suspends,
> due to races or locking issues or something else that haven't been
> diagnosed or fixed yet. These issues prevent the system from actually
> suspending. So disable the driver in this case. Later, when this is
> fixed properly, we can remove this.

How about just keeping it enabled, but not making it a fatal error if
the TPM saving doesn't work? IOW, just print the warning, and then
"return 0" from the suspend function.

I doubt anybody cares, but your patch disables that TPM device just
because PM is *enabled*. That's basically "all the time".

Imagine being on a desktop with a distro kernel that enables suspend -
because that kernel obviously is expected to work on laptops too.
You're never actually going to suspend things on that machine, but
maybe you still want to register it as a source of hw random data?

          Linus
