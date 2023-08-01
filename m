Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC12676BCB3
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjHASnF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 14:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjHASmu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E92E26A4
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 11:42:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bf3f59905so676145966b.3
        for <linux-integrity@vger.kernel.org>; Tue, 01 Aug 2023 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690915350; x=1691520150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VhUDsrggxWE6/cGjEOALfjpnRWj6WRZJe/kOVyWiR0I=;
        b=EqSe7pFOurEseFRF56MMkhsqVIuFka3xZBIiptwb/MRsMrmvfb+uNNuu2FQOMlQS/A
         LsgMhlJNlHWAO28Q1CE+vP9Q2VaEBvzuc7EN72nzNikBsDwN3ds+b4MIqP5bMuouYhIa
         nPkRRtLtXCA++yz7k5mOUzQpoVS9pPkBEo+BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915350; x=1691520150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhUDsrggxWE6/cGjEOALfjpnRWj6WRZJe/kOVyWiR0I=;
        b=iJB3AkJ1zBdH1Fx98iBxsse2udQ+2ofYIoxDzklf+O3OtUpA9ldUN8mOPDOS8KiMe+
         HDTSIYcvY5hu2QwNfaY/aAFTmzkoiWc/7lY4EswC7L4JYhj9EiN19L9dNgnjOCfytQyW
         UVcnn9UOdgoWCrLe3KkiulPLssmuxw1OVYGFjWpw0Ut6jwD/QHZgOQnVn0TxgFnJfwb+
         nHGx59xa5hnMhW6KVumX1WskN1fiF+nhUUo7dOBYGq5aUvEuIYCdJOavAhObA3EvnMdu
         UfQITOptC98PQP37lupAUUBFnj0dwlUCPHXLFqHudvz9yPJxM2+IqBe1rSWLVE4htTL0
         J3GA==
X-Gm-Message-State: ABy/qLb39Gzwh784Z7aGlLqTB4HAxpW4pl26XDSMoErRvpU7n5ZJuXU7
        INXLdk2SxDSi2Vi2kJOXks85pR3G71tPjS9EzUbLng7Z
X-Google-Smtp-Source: APBJJlGdVUJ2dGnI7V8z5LlFXsYstiRPsBIdcMYBnlsevIy3QNmYV5aYid9gGJGn3ey/aIPkTYRajQ==
X-Received: by 2002:a17:906:142:b0:99b:bca6:cf94 with SMTP id 2-20020a170906014200b0099bbca6cf94mr2937507ejh.14.1690915350053;
        Tue, 01 Aug 2023 11:42:30 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090622d200b0099bc80d5575sm7938996eja.200.2023.08.01.11.42.28
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:42:29 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so9106842a12.3
        for <linux-integrity@vger.kernel.org>; Tue, 01 Aug 2023 11:42:28 -0700 (PDT)
X-Received: by 2002:aa7:c6d2:0:b0:522:21a1:4245 with SMTP id
 b18-20020aa7c6d2000000b0052221a14245mr2802747eds.27.1690915348590; Tue, 01
 Aug 2023 11:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
In-Reply-To: <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Aug 2023 11:42:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
Message-ID: <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 1 Aug 2023 at 11:28, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I would disable it inside tpm_crb driver, which is the driver used
> for fTPM's: they are identified by MSFT0101 ACPI identifier.
>
> I think the right scope is still AMD because we don't have such
> regressions with Intel fTPM.

I'm ok with that.

> I.e. I would move the helper I created inside tpm_crb driver, and
> a new flag, let's say "TPM_CHIP_FLAG_HWRNG_DISABLED", which tpm_crb
> sets before calling tpm_chip_register().
>
> Finally, tpm_add_hwrng() needs the following invariant:
>
>         if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>                 return 0;
>
> How does this sound? I can refine this quickly from my first trial.

Sounds fine.

My only worry comes from my ignorance: do these fTPM devices *always*
end up being enumerated through CRB, or do they potentially look
"normal enough" that you can actually end up using them even without
having that CRB driver loaded?

Put another way: is the CRB driver the _only_ way they are visible, or
could some people hit on this through the TPM TIS interface if they
have CRB disabled?

I see, for example, that qemu ends up emulating the TIS layer, and it
might end up forwarding the TPM requests to something that is natively
CRB?

But again: I don't know enough about CRB vs TIS, so the above may be a
stupid question.

           Linus
