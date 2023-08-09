Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40347776620
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Aug 2023 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjHIRGw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 13:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIRGw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 13:06:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD1A1FD4
        for <linux-integrity@vger.kernel.org>; Wed,  9 Aug 2023 10:06:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52328e96869so6740274a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 09 Aug 2023 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691600809; x=1692205609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38UHClcvqpkCQ/hZ/v+b8/k52MfO049KbKWxtuGEmkM=;
        b=H0IAfkEx0DaZRorSw3Bm1Wd2jwBGyuGfxdFUedlUFKH+CV/mWiP4Iw+QGEGBuAQmTt
         SpXaMdTi7uUbK6CfZVke3o1mNKePm0Tl0fZCTUPnDB2Cq+M+vdbZ2eVuRGmT5SwqVrrf
         kAF3Q3W2enk99r/dbhtBDkkj98d2EjwdUdZ1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600809; x=1692205609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38UHClcvqpkCQ/hZ/v+b8/k52MfO049KbKWxtuGEmkM=;
        b=VWoP1KPfQHUzkSXFhsbxH31gemcqyCKiaVAOD7quvhHA1ab3vR0dV1H7w1yc2/ECiB
         /CEIU+0Pf3mKCUk1uLcHs9GQ4rOeQLAIWuRI5/awDGEMtCVKDkUPtrxtfsqDnHB6KNyV
         lOpVg1tJswnGwwlZAt2t2l2YdC6qKW5YLQRPItJfkGPKXiKxWokw/3FobT3KSv/ST3Ki
         edk5hsVxNmAJJLErtyPRPvEhe+XBU5OWdraB17A+4wSB0iULXPshO4e6avMwujzuzyQi
         JWd0qA1UbCzkYy6sNxlXftZp+56mB+Jl86RjsLOp2kvLKUzmA7FSCeqiggEraJBGfaNc
         5LCQ==
X-Gm-Message-State: AOJu0YwHDp/IkZK1wX+mBYkdzXGlxXDCgkKbtMMRVvKpfAJ2SDOmzxvx
        xLomX5yXyZtpy3K0/urFCxTTl4/pj0VE+1CTIJCM/Hut
X-Google-Smtp-Source: AGHT+IFzRf+o/xoLPJ1aqn2Y/GcKoUvyXkheWMzonE8GvJN5Qhco11HiE5y1CiQGqoRpQQ0Y6v1k2g==
X-Received: by 2002:a17:906:10cc:b0:993:f081:2c58 with SMTP id v12-20020a17090610cc00b00993f0812c58mr2011685ejv.4.1691600809168;
        Wed, 09 Aug 2023 10:06:49 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709063bc200b009890e402a6bsm8262653ejf.221.2023.08.09.10.06.48
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 10:06:48 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so1723869a12.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Aug 2023 10:06:48 -0700 (PDT)
X-Received: by 2002:a17:906:7393:b0:99b:c0a0:8e17 with SMTP id
 f19-20020a170906739300b0099bc0a08e17mr2762211ejl.52.1691600807957; Wed, 09
 Aug 2023 10:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi> <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi> <ZNFv8f3r86zq3JSh@zx2c4.com>
 <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com> <ZNGOpFbH43qQ/v5T@zx2c4.com>
 <CAHk-=whT2hf5f6SwK32J4cF2Yu+q9SZaO6JZVzBOsLz63uPW1w@mail.gmail.com> <ZNJ5IZjpOdOBFFja@zx2c4.com>
In-Reply-To: <ZNJ5IZjpOdOBFFja@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 10:06:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQFZ=KqUWiFUP7s=t4tKs8Aga=Gq5LvS5Ugyk-nMTF1w@mail.gmail.com>
Message-ID: <CAHk-=whQFZ=KqUWiFUP7s=t4tKs8Aga=Gq5LvS5Ugyk-nMTF1w@mail.gmail.com>
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        linux@dominikbrodowski.net, linux-integrity@vger.kernel.org,
        daniil.stas@posteo.net, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 8 Aug 2023 at 10:19, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Alright, looks like Mario took care of that:

Ok, I just took that patch directly, so that we can close this issue.

It's

    cacc6e22932f ("tpm: Add a helper for checking hwrng enabled")

in my tree, and I'll push out shortly after it's gone through my trivial tests.

                  Linus
