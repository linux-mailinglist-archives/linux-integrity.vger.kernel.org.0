Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A847B7BFD0B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Oct 2023 15:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjJJNPB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Oct 2023 09:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjJJNPB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2023 09:15:01 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1136A9
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 06:14:59 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f6e6b206fso70412587b3.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696943699; x=1697548499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qCK/iSIBEVJhUBSFPGxg1tamM9UsdvKCPylqLfCbsyM=;
        b=YGv/s29L/J2WF2MHNwFak21XJFMXyghxOKJGebaQ7X9wgCFFwjup5+recQP4fXAUPB
         BVmJDmWHbQ7PuHqvl6/CF82rr22HmRA1DlIyFxKhLpo7fDyrTDUoxEehjyEf9Efr9Xr9
         rUEwWLRNJ36tXXq8m5CfwVILijvRGGfCTYYsRKNw21DEsg6HOguAwuDwNaHpuZC9K7mk
         Xdp+29aHm+CGjE3GkwwYfAX7Dm+JhMm7il3EellsvQJST+hAya2OH2CXmy1lOHfDvoqD
         ZSK4IgstoK9CsUmZU99i5Gh+1k/7xkSU4RO+gaeh1PqiPRTrJ4MR7i8kYXZGwqD1LRZ2
         fYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696943699; x=1697548499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCK/iSIBEVJhUBSFPGxg1tamM9UsdvKCPylqLfCbsyM=;
        b=b79iKKtTRVlSHzz8C0VJK1UFzakZSfhTDKiAszp3QmkSOeDM8he0n94L1U0HhFMh4j
         kbbGfcEPLH9C55ZKnbcKE+lU0i1NNsqgoYH0tYdWDcxSZPnAxqlTSgR97hSHq06egLnI
         bmxtQFq5b9ZVTQabC6FhcFHR8Zc7IEsNcTWUkOnUJKgFjKRBwmCcu0C1kRBgLcNTeXNq
         CTtS3gaRvTAbY9zu4Y0gN7oAp/TLDa1vc38QXR6o5sl7us2MVToJnTdqDk8FfleHYOoP
         zaZfw3MNEAo/QoMfhU2Gsj4/KR8sdjDbf0Q1VR05ldlF0EsDFv6FMyGG2RDzmBNlgaa+
         DI/w==
X-Gm-Message-State: AOJu0YxqW1wuz9ZqH/wT97+BeOL1SRust22u2messwzMStGyC5nywGvr
        rdNsjw7Q1lzvuInDDmZdAC9bw1N+HAbUhGaaBvKrYsHIGOviFAU4z88=
X-Google-Smtp-Source: AGHT+IGIjkY8fpBrVuBfe0Dn67SLpAJC5kVo9XDURP7C3vKAcbx8vXqFzdGmtrjTGhChQLt+xjcvUUBnudQ243TZAnY=
X-Received: by 2002:a0d:d40c:0:b0:5a7:bcbb:b948 with SMTP id
 w12-20020a0dd40c000000b005a7bcbbb948mr2205295ywd.15.1696943699056; Tue, 10
 Oct 2023 06:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231006051801.423973-1-sumit.garg@linaro.org> <8eeac047a59667912a45b21050a6e4c57d7cccd5.camel@kernel.org>
In-Reply-To: <8eeac047a59667912a45b21050a6e4c57d7cccd5.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 10 Oct 2023 18:44:47 +0530
Message-ID: <CAFA6WYNamspdK=RakirdS3fiHrmmaPXcgEcZeNn5z2DRNdE3Rw@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        David.Kaplan@amd.com, bp@alien8.de, mingo@kernel.org,
        x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 10 Oct 2023 at 18:03, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri, 2023-10-06 at 10:48 +0530, Sumit Garg wrote:
> > Static calls invocations aren't well supported from module __init and
> > __exit functions. Especially the static call from cleanup_trusted() led
> > to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.
> >
> > However, the usage of static call invocations for trusted_key_init()
> > and trusted_key_exit() don't add any value from either a performance or
> > security perspective. Hence switch to use indirect function calls instead.
> >
> > Note here that although it will fix the current crash report, ultimately
> > the static call infrastructure should be fixed to either support its
> > future usage from module __init and __exit functions or not.
> >
> > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Link: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t
> > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v2:
> > - Polish commit message as per comments from Mimi
> >
> >  security/keys/trusted-keys/trusted_core.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > index c6fc50d67214..85fb5c22529a 100644
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -44,13 +44,12 @@ static const struct trusted_key_source trusted_key_sources[] = {
> >  #endif
> >  };
> >
> > -DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
> >  DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
> >  DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
> >                         *trusted_key_sources[0].ops->unseal);
> >  DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
> >                         *trusted_key_sources[0].ops->get_random);
> > -DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
> > +static void (*trusted_key_exit)(void);
> >  static unsigned char migratable;
> >
> >  enum {
> > @@ -359,19 +358,16 @@ static int __init init_trusted(void)
> >                 if (!get_random)
> >                         get_random = kernel_get_random;
> >
> > -               static_call_update(trusted_key_init,
> > -                                  trusted_key_sources[i].ops->init);
> >                 static_call_update(trusted_key_seal,
> >                                    trusted_key_sources[i].ops->seal);
> >                 static_call_update(trusted_key_unseal,
> >                                    trusted_key_sources[i].ops->unseal);
> >                 static_call_update(trusted_key_get_random,
> >                                    get_random);
> > -               static_call_update(trusted_key_exit,
> > -                                  trusted_key_sources[i].ops->exit);
> > +               trusted_key_exit = trusted_key_sources[i].ops->exit;
> >                 migratable = trusted_key_sources[i].ops->migratable;
> >
> > -               ret = static_call(trusted_key_init)();
> > +               ret = trusted_key_sources[i].ops->init();
> >                 if (!ret)
> >                         break;
> >         }
> > @@ -388,7 +384,8 @@ static int __init init_trusted(void)
> >
> >  static void __exit cleanup_trusted(void)
> >  {
> > -       static_call_cond(trusted_key_exit)();
> > +       if (trusted_key_exit)
> > +               (*trusted_key_exit)();
> >  }
> >
> >  late_initcall(init_trusted);
>
> Would it be less confusing to require trusted_key_exit from each?
>

It is already required for each trust source to provide exit callback
but this NULL check was added via this fix [1] in case there isn't any
trust source present.

[1] https://lkml.kernel.org/stable/20220126184155.220814-1-dave.kleikamp@oracle.com/

-Sumit

> BR, Jarkko
>
