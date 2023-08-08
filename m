Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946B2773B04
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjHHD23 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Aug 2023 23:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjHHD2B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Aug 2023 23:28:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C410CC
        for <linux-integrity@vger.kernel.org>; Mon,  7 Aug 2023 20:26:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so83370051fa.0
        for <linux-integrity@vger.kernel.org>; Mon, 07 Aug 2023 20:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691465182; x=1692069982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2PshCcHXpSizN0WTlCYzw/czaRnP5WjNB+/CARvAIhU=;
        b=V2PvIVndGCdt6RlV9mgVaBnOY/fEXPgs6jOFbwf8BFQ6LhhMbiZRt83Muer6HGCGvH
         CFi5KGEOTfEtUr89DVsNL7pNSzzW5VYn0Nfqq/7kd1bDBrmx34u7pj7qO1OSj/J6MIki
         v091agBbRuYhcuMlKUytXIVAG6U77PzTeqaak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465182; x=1692069982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PshCcHXpSizN0WTlCYzw/czaRnP5WjNB+/CARvAIhU=;
        b=j7Vva7uLJUpTIjVFXYSazpqRlJEA/PSQZWA7ijIx39v6ZsNZbzGBVsXzlWjcrZYYE9
         ZiUf9UyKQV8x5crfOLkD7o89sDf6YqhyDbLDPEzNxbdY+u/VWGUsKCOkZBEEQWFXts8l
         vCkAJt3N9Q6OwlxVFtTptg9INjxNJw5I2EROMGvho2OFUkU3Br/81HIPTYRJjzwB1iQN
         ZFBu+ZlLNHYhYFMfilpnzgUdzsO/bTTnmAAZ4Oc1mhB5XqUv7TICJsCCR1d+L98v5wax
         XrCv8ZfMdZqxU7RxxSQHXnDfZZrgvtMeUiZnqBkYO8ARkFz1Q1JyRyhdaNiIn2yJvRQ6
         IV/g==
X-Gm-Message-State: AOJu0YzV+g/NXGBWYYIJ9EVlHZnuJdu7HSXImmM+jyoQwgPY0J6Kv/WE
        Eu639356f48kaZ5ewFGQWQO8C8mVLYkTJarHoJBq0g+C
X-Google-Smtp-Source: AGHT+IFrS3FmvI7CCiXPwUyarNcbvbKrdA0AE/MQ93Fwl4sxd5mioM8zJrSmGprZftNzWM7mOrHY8A==
X-Received: by 2002:a05:651c:208:b0:2b6:cf0f:1fbf with SMTP id y8-20020a05651c020800b002b6cf0f1fbfmr8416853ljn.42.1691465182034;
        Mon, 07 Aug 2023 20:26:22 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y15-20020a2e7d0f000000b002b9cd2d0d39sm2081567ljc.28.2023.08.07.20.26.20
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 20:26:20 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe0c566788so8052527e87.0
        for <linux-integrity@vger.kernel.org>; Mon, 07 Aug 2023 20:26:20 -0700 (PDT)
X-Received: by 2002:a05:6512:ad5:b0:4f9:607a:6508 with SMTP id
 n21-20020a0565120ad500b004f9607a6508mr7359752lfu.50.1691465180198; Mon, 07
 Aug 2023 20:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi> <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi> <ZNFv8f3r86zq3JSh@zx2c4.com>
 <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com> <ZNGOpFbH43qQ/v5T@zx2c4.com>
In-Reply-To: <ZNGOpFbH43qQ/v5T@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Aug 2023 20:26:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
Message-ID: <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        linux@dominikbrodowski.net, linux-integrity@vger.kernel.org,
        daniil.stas@posteo.net, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 7 Aug 2023 at 17:39, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> I'm not sure what's best or what Linus prefers. Linus - Jarkko sent you
> the wrong version patch. Do you want a fixup patch that accounts for the
> difference, and then I'll address the stable@ metadata deficiency
> manually by talking to Greg, or would you rather some merge commit
> magic, or something else?

Either works for me, whatever ends up being easiest.

However, looking at that v3 patch, that "should we enable/disable the
hwrng" is now repeated *three* times, and that first one is

  if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
-     tpm_amd_is_rng_defective(chip))
+     chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)

and wants fixing anyway: you want parenthesis around the '&'.

Yes, yes, it works (because bitwise ops have higher precedence than
logical ones), but let's not do that.

But more importantly, can we just have a single helper inline function
for this and *not* repeat the same multi-line expression three times
(just in negated and then 2x non-negated format)?

That test is ugly anyway. Why is "tpm_is_firmware_upgrade()" a wrapper
function around testing "chip->flags", but then right next to it it
tests them explicitly.

So if we have to re-do this all, let's re-do it properly. Ok?

Thinking about it, I do guess that makes it easier to just send an
incremental patch on top.

              Linus
