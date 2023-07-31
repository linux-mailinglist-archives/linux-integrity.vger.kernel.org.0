Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60F76A0D1
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Jul 2023 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGaTGW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Jul 2023 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGaTGV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Jul 2023 15:06:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C81FCB
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 12:06:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso7202621a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690830360; x=1691435160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l2WxsWAHvSSljtKQmToghU/ZBm1ZT8P5v2Qhy5RjWOk=;
        b=FivhBWf5dm+70AtLuhtGSDQWg5T17ddlB5XsAt1myLyxWnKFK+8Xk7iV1BUtuFBhSU
         ZrSydZjVrkpQbWaZJhZJq+tEpQExDh5AB2N8rT9kJJrbMgXZl8P95YSKDKTB8S2vEBeA
         v1YOpMOWdBt995jFr1PtnzTDjoeJMPF/hE9QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830360; x=1691435160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2WxsWAHvSSljtKQmToghU/ZBm1ZT8P5v2Qhy5RjWOk=;
        b=by0opeOQWpEK+VIM7Ns2I9QekX3wnBoezMNKDI/f9BlLVZ5G+2eoxwlNjxPySLVyVT
         /D8bctZwiz3VY4x796jlbOHsD7fO4hJ921BO1NaFFbZR2I1yUjq8weN5W2gToyZuJ1Fc
         Az1NZdo0tgma3/r0QR+TnDBTt+cLrSFDpqpirsX5rx4YonXajVw7pBrXQLLH6/h90HeX
         WoP1/cCecTEdxvHq02mGSjN7G2Zt4urOXV5+vF/VAZVC1ytHR7+XmQvKyULIt4A+kyLk
         w+60B9cVWjdaXBnNPZ5QTNSmfuHaKhWAc7BOlaMqqPD3imZFvWtutMEiwxzj55dlt0PV
         p9ag==
X-Gm-Message-State: ABy/qLbFAsFc/ZYXP1PrmQSOAc3cIlzydS+QkIZsxfp0+vXcfdqbHHEN
        2xZpPtTnaAyWS5W/E+2xYtQMpDzPLm3YK7JmMCf6XOXH
X-Google-Smtp-Source: APBJJlF6CPttVj5GVrVFjA2UBW0mkWGixGgTE8b2X1SoftbSoH6U54837Q3nWP5gOsAmPOfIJ4UZhg==
X-Received: by 2002:a17:906:1d9:b0:992:9756:6a22 with SMTP id 25-20020a17090601d900b0099297566a22mr427715ejj.48.1690830360023;
        Mon, 31 Jul 2023 12:06:00 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id gy26-20020a170906f25a00b00992b7ff3993sm6469391ejb.126.2023.07.31.12.05.59
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:05:59 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-522ab301692so4506327a12.2
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 12:05:59 -0700 (PDT)
X-Received: by 2002:aa7:dcc3:0:b0:522:31d5:ee8e with SMTP id
 w3-20020aa7dcc3000000b0052231d5ee8emr691287edu.8.1690830358999; Mon, 31 Jul
 2023 12:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
In-Reply-To: <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:05:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
Message-ID: <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Daniil Stas <daniil.stas@posteo.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 31 Jul 2023 at 03:53, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I quickly carved up a patch (attached), which is only compile tested
> because I do not have any AMD hardware at hand.

Is there some way to just see "this is a fTPM"?

Because honestly, even if AMD is the one that has had stuttering
issues, the bigger argument is that there is simply no _point_ in
supporting randomness from a firmware source.

There is no way anybody should believe that a firmware TPM generates
better randomness than we do natively.

And there are many reasons to _not_ believe it. The AMD problem is
just the most user-visible one.

Now, I'm not saying that a fTPM needs to be disabled in general - but
I really feel like we should just do

 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
        if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
                return 0;
        // If it's not hardware, don't treat it as such
        if (tpm_is_fTPM(chip))
                return 0;
        [...]

and be done with it.

But hey, if we have no way to see that whole "this is firmware
emulation", then just blocking AMD might be the only way.

               Linus
