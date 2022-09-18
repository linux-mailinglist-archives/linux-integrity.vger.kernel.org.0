Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1C5BC0A9
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Sep 2022 01:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiIRXrh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Sep 2022 19:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIRXrh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Sep 2022 19:47:37 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A08413D25
        for <linux-integrity@vger.kernel.org>; Sun, 18 Sep 2022 16:47:36 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id t65so25303241pgt.2
        for <linux-integrity@vger.kernel.org>; Sun, 18 Sep 2022 16:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TFPwQDGpKxGHCU3i/WHsbI+n7I3u5oaPEEJ6wGMtfx4=;
        b=bx04SoJzLrsqLJK6v2CuTfWWHi1YjurW14PV2PudY+8QF5/SSK0kEbRA/RFNnacDqW
         Mx2iIljYXdmvdQwV/bMhyB9ukIcZnTiOFJl1fcUCvqYu66S3T1b5Ey0dJyg7h9fbW7dV
         kOOQCRo7hre4mMpsCov4bVf0VuQbnO6cfJUgI8UsCnAB+gAdtcR6qz5VUO8wq85pwRAK
         meEV46JmKIT0A/YkVea2F9RvzVUDbkFrrrs/Eixg01vqOq+igHMYLgVfwlTyIOpkZu8b
         kKbmlDS1lqsgagFjJjvwGMfQLXgOtwszPgs60n7efv389ESe/w3SzAesuEovj2oIZh7x
         BIIg==
X-Gm-Message-State: ACrzQf09+8sNakUpBwLJoSzubFxYtn0X37Vdyvx6hv1x/fKnhpuNamSL
        HDxUEXMuLtAe5HhAyLUiNNJAjcYadGc=
X-Google-Smtp-Source: AMsMyM6oJs6cSs6FiWuGqXj7giPa90lI/656I/7X6k+IiX5L2c1z8Ys39nIYjlLve2FRCrJ6CeiqCA==
X-Received: by 2002:a63:da03:0:b0:439:dcdd:67f4 with SMTP id c3-20020a63da03000000b00439dcdd67f4mr6662088pgh.27.1663544855093;
        Sun, 18 Sep 2022 16:47:35 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b00174f7d107c8sm18964152plb.293.2022.09.18.16.47.34
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 16:47:34 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id c24so25270980pgg.11
        for <linux-integrity@vger.kernel.org>; Sun, 18 Sep 2022 16:47:34 -0700 (PDT)
X-Received: by 2002:a63:5b4f:0:b0:426:9c52:a1f with SMTP id
 l15-20020a635b4f000000b004269c520a1fmr13527863pgm.511.1663544854286; Sun, 18
 Sep 2022 16:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
 <d70a3bf1bf8245ed54bd55eafd4fbb98fd08e316.camel@linux.ibm.com>
In-Reply-To: <d70a3bf1bf8245ed54bd55eafd4fbb98fd08e316.camel@linux.ibm.com>
From:   Ken Williams <ken@williamsclan.us>
Date:   Sun, 18 Sep 2022 16:47:20 -0700
X-Gmail-Original-Message-ID: <CADrftwOM6mWaQ+xNbExbgcHisAirBe1vQSRdCEtET7xqQ=_bjg@mail.gmail.com>
Message-ID: <CADrftwOM6mWaQ+xNbExbgcHisAirBe1vQSRdCEtET7xqQ=_bjg@mail.gmail.com>
Subject: Re: User questions
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi and others and thanks for responding.

My primary goal right now is to develop an understanding of IMA for
the purpose of determining if and how it can be useful for my application.
For that, I have outlined below a few implementation scenarios.

I have played around with IMA a bit so as to get some understanding of
the process, configuration and capabilities.  This included creating a
policy file
for measurements as well as signing files and enabling appraisal.
All of this was done on-target and obviously putting a private key on the target
is not right but this was a familiarization exercise.  In any case, my current
understanding is that options available to me, without a TPM device, are:

- Measure files which have no security.ima=<HASH> xattr
  In this case I can detect if a previously measured file has changed.
  This is a nice exercise for getting my feet wet but without a TPM,
  it is hard to embrace this alone as being a security tool that can
  work for me.

- Measure files which do have a security.ima=<HASH> xattr
  This is a good step up but I cannot see how this enables the
  detection of a 'bad' but properly labeled file without a link to
  some kind of file validation server.  Again, I have no TPM.

- Attest to files which have been signed with a private key prior to
installation
 With this, I understand that as long as I have control over the file
installation
  process, I have a level of protection equal to that of the signing algorithm.
  If I am correct, I also understand that this applies only to immutable files,
  typically executable binaries.  The process of signing the files would be
  off-target and outside the scope of my questions and comments here.

  Again, I do not have a TPM so I understand that an off-line attack
is still possible
  but it looks like this might be the best I can get out of IMA for
the environment
  I have.

Russell, regarding your comment regarding inclusion of the i-node in
the signing,
I understood that to be included in signing for EVM, not for the
attestation part of IMA.

Thanks for any comments.

Ken


> Let's add some context to the above quote.  One of the differences
> between IMA-appraisal and IMA-measurement is that IMA-appraisal
> requires quite a bit of configuration (e.g. keys, signing files, and
> policy).  This is in comparison to IMA-measurement, which requires just
> a policy.
>
> As long as the IMA-appraisal policy encompasses just those things that
> can and should be signed, enforcing the IMA-appraisal policy is
> straight forward:
> - Create a local CA key and build it into the kernel.
> - Create a public/private key pair signed by the local CA key
> - Sign files.
> - Load the public key on the IMA keyring.
> - Load the IMA appraise policy.
>
> Examples of the first 2 steps can be seen in the ima-evm-utils README.
> Examples of the last two steps can be seen in dracut 98integrity
> modules.  systemd can be configured to load an IMA custom policy.
>
> --
> thanks,
>
> Mimi
>
