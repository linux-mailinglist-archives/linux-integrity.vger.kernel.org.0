Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF17976A14A
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Jul 2023 21:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGaTbT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Jul 2023 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGaTbS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Jul 2023 15:31:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E61F199D
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 12:31:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so72177121fa.2
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690831874; x=1691436674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANccUczuCdN/Ctbbd+CLowkmR/s9+vGuLKhYUkmLMiM=;
        b=g3DHojZdzR4AtFnafLgXcdiYZhs/PUZV9eFNZwj2qDJmppmTMxtgdctVcFk+XYdSuS
         39bdNJZN0ISfpf9OF29Z1NG1w9zDF+12g/Jy+AmtYLP6t2W/nrETrFfc5sCh9LEB9O2W
         fWSPBg1/18olsNfxyLiexST/xgjfElDpEJEMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831874; x=1691436674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANccUczuCdN/Ctbbd+CLowkmR/s9+vGuLKhYUkmLMiM=;
        b=F9rdmBFhJI8jTfHv5mPkudjofkW21KmWBHpIAdIG44OivEn+agUESEZpjsnuvSjq/6
         jxewmODuq9qmsr2+eRwcEHUG0T7xPlOZQKnnM0Y45ZTzYNY5LgHtkBvWhzjBP1GmuCTh
         0IVZ6CaisP0in7oohL5nixIXsrdSR4eWRkmq45esBpkzoPnvMDAggCJqvMsTCxbPzGgc
         3qP12Igl3NnWwkJowETxHVadpKPuQ9D1m6JdF+Y/BoF0aYhojDgQlLLvCfp1nY9pE3eT
         3mnd1R7JHGukVMPit+yKMozSWJorw87he0rDQ0S+x6bpAx2YIkd9r7uLStDaSw4FPzuv
         zOKw==
X-Gm-Message-State: ABy/qLboJDFiHDuvF1omw0X4J4PdIFj+SYf+gqjDqGKEDIvGH1hotmIw
        pQ3B/LnB1zAZKzgave6lm4EF11ZIDJbdSRvf9CwGbzXN
X-Google-Smtp-Source: APBJJlEFVhDODM390Fn2a6mWVcDHGQpXiQnp8b84tRfHaxpZNvZFQYOuaniF+LqKkkw5kNrJG01ciw==
X-Received: by 2002:a2e:9dc7:0:b0:2b9:d71c:b4a4 with SMTP id x7-20020a2e9dc7000000b002b9d71cb4a4mr727013ljj.12.1690831874162;
        Mon, 31 Jul 2023 12:31:14 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p21-20020a2e93d5000000b002b6ece2456csm2699221ljh.121.2023.07.31.12.31.13
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:31:13 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fe383c1a26so2025390e87.1
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 12:31:13 -0700 (PDT)
X-Received: by 2002:ac2:5931:0:b0:4fb:92df:a27b with SMTP id
 v17-20020ac25931000000b004fb92dfa27bmr523833lfi.39.1690831873036; Mon, 31 Jul
 2023 12:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
In-Reply-To: <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:30:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
Message-ID: <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 31 Jul 2023 at 12:18, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> > Is there some way to just see "this is a fTPM"?
>
> How many fTPM implementations are there?  We're talking like less than 5
> right?  Maybe just check against a static list when
> calling tpm_add_hwrng().

Sounds sane. But I was hoping for some direct way to just query "are
you a firmware SMI hook, or real hardware".

It would be lovely to avoid the list, because maybe AMD does - or in
the past have done - discrete TPM hardware?  So it might not be as
easy as just checking against the manufacturer..

That said, maybe it really doesn't matter. I'm perfectly fine with
just the "check for AMD as a manufacturer" too.

In fact, I'd be perfectly happy with not using the TPM for run-time
randomness at all, and purely doing it for the bootup entropy, which
is where I feel it matters a lot m ore.

> I've had some discussions today with a variety of people on this problem
> and there is no advantage to get RNG through the fTPM over RDRAND.

Ack.

And that's true even if you _trust_ the fTPM.

That said, I see no real downside to using the TPM (whether firmware
or discrete) to just add to the boot-time "we'll gather entropy for
our random number generator from any source".

So it's purely the runtime randomness where I feel that the upside
just isn't there, and the downsides are real.

                  Linus
