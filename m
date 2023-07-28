Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED6F76772A
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jul 2023 22:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjG1Ulm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jul 2023 16:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjG1Ull (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jul 2023 16:41:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369F10DD
        for <linux-integrity@vger.kernel.org>; Fri, 28 Jul 2023 13:41:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe11652b64so4465462e87.0
        for <linux-integrity@vger.kernel.org>; Fri, 28 Jul 2023 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690576898; x=1691181698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1o44kCiViu9poWK+pr269ZTRZv94Q/szYxEaIBZbPhc=;
        b=PWaHtGPoN5IQlEquCn4tZQ9Xaw8HZBNIeKlodAQFA9UjMmPbEx4Zvik+rmvi3Xl2z1
         Xbj/BWXP+kirOWjWdBCB8SRhKojOTkZeB3KyV9xtbK5YO/ezCWaWvVVNtjpX7o7fsouj
         AeL8LN4YTxu9oul07qxtWCCQ2Ob9TTv02Xb4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690576898; x=1691181698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1o44kCiViu9poWK+pr269ZTRZv94Q/szYxEaIBZbPhc=;
        b=J5SaAQttpx6/4yOsE0Gkmq9Lji9iUJ9hr2ExW1k6jDLorPkT/NqcxYVX2BGtNYmA06
         qYUE3o2AUvmpo7jofNi19kOfIcgeBago9TFzOFqF9aPdYBz9NSvHfCR9lHKEA+MyzEZO
         OSKgzEtD4R+3lv8Hdb1DsyNocAp6WojoVPzH61tjNGObbW0W897akr4rhIBMigqUMntl
         Uk9Kx5Tfv9ojQ/c8m5Db5kQWgkLB0NjsfhFYMVCLmi2cQZJp/y86OiSmkKQekpD8Sgwy
         5hKRdpImDBj4GkzMYefnl7dPHVWWP763E8dvccUj0MdFplFkW9AcxvKu5LdGN05Pzk7M
         BgLw==
X-Gm-Message-State: ABy/qLY6dgcmZ2figJLHqIE7vlEGywPrHJrkU19Y0ibKaAEo5XKEgSdW
        2tVVfO3vVNuVQfEde5Obk8OB1ah5YzZHh3bn9HawzWt9
X-Google-Smtp-Source: APBJJlGmBPq6wYYN8h5BoRnj74oIvVYnGCNnskoaNgiMRKojiklNOBpOm1dWcBORMKgM+KnB8wYK+g==
X-Received: by 2002:a05:6512:3b13:b0:4fb:cab9:ddf with SMTP id f19-20020a0565123b1300b004fbcab90ddfmr3509612lfv.57.1690576898122;
        Fri, 28 Jul 2023 13:41:38 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v27-20020ac2561b000000b004ec84d24818sm953587lfd.282.2023.07.28.13.41.37
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 13:41:37 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe1a35a135so3620054e87.1
        for <linux-integrity@vger.kernel.org>; Fri, 28 Jul 2023 13:41:37 -0700 (PDT)
X-Received: by 2002:a05:6512:61c:b0:4fb:90c6:c31a with SMTP id
 b28-20020a056512061c00b004fb90c6c31amr2404424lfe.14.1690576896802; Fri, 28
 Jul 2023 13:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com> <20230727200527.4080c595@g14>
In-Reply-To: <20230727200527.4080c595@g14>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 13:41:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
Message-ID: <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Daniil Stas <daniil.stas@posteo.net>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 27 Jul 2023 at 10:05, Daniil Stas <daniil.stas@posteo.net> wrote:
>
> Here is the bug report I created:
> https://bugzilla.kernel.org/show_bug.cgi?id=217719

Let's just disable the stupid fTPM hwrnd thing.

Maybe use it for the boot-time "gather entropy from different
sources", but clearly it should *not* be used at runtime.

Why would anybody use that crud when any machine that has it
supposedly fixed (which apparently didn't turn out to be true after
all) would also have the CPU rdrand instruction that doesn't have the
problem?

If you don't trust the CPU rdrand implementation (and that has had
bugs too - see clear_rdrand_cpuid_bit() and x86_init_rdrand()), why
would you trust the fTPM version that has caused even *more* problems?

So I don't see any downside to just saying "that fTPM thing is not
working". Even if it ends up working in the future, there are
alternatives that aren't any worse.

                 Linus
