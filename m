Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32987C4974
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Oct 2023 07:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbjJKFwR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Oct 2023 01:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjJKFwQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2023 01:52:16 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9A98
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 22:52:14 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4577f61c6adso886988137.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697003533; x=1697608333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlQLZZ3WQmdzwySqmWy0BN8h7pX0WW9J4xU4reoyJFQ=;
        b=Gcrhiu32owL3fUt7Qr7naFGnnVw49ik0s9BNJ5njQzAXH/5Keh5BBUR5mipiKS3LGj
         vEH3eR7B0AtAjr/l0gjPrZNv5SBulCPZHRGZeUdRsAJUE3uNEVtG3GcejhUKUNPJZY1i
         M/sW8NMZkiEtkCATEJ9ORgy7uofUo04BSCBOpdTFYmODSLqyDspLQ+7q+h6Yzg6dsf92
         hzGFijV05cHlh5embMmk+rnuqkvE9HqNSXrrFlgmg+ylUK8TNeUZdRBr/yIlvpmreEaZ
         lvTnqYj7RwzJgFEriaswSJMZuAxzFBHPslHZ4yzsXzPdaY+JINUUxczISwR88htjdJAG
         rp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003533; x=1697608333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlQLZZ3WQmdzwySqmWy0BN8h7pX0WW9J4xU4reoyJFQ=;
        b=sHm2tikENmnOU9uzrfas2pmQJlZEHvH6Dw2zmPDX4Fe5FWPvmEsWJEE5Uj1ssyOg2Q
         zmjCzn197ScinF17i4++PP4Fg82bHx28M0DHssegZK6CDH0kJ5+HhrbCZkBmttJ3zg2d
         ioq4Os7Kspd4xzqtRSbgghpzd1P37MtgKubQVv1qcyzWnspiAGUf/4NMtlFcnkQsDrgv
         Yu6Ttp9SUBUfm6SSndVAlAIRTpbM4hx6/uhQhUSbWE6QJagp3S8dD7NxNH995p0fzMKC
         2li/LklFGjF3qQ/r44sAEp/bR2xP38WrWt3utvkc5Lk00v8ywhCSsAVQ/26TN68u6qot
         RxqA==
X-Gm-Message-State: AOJu0Yw1Q2jH8CdRiAMBCqmR+kUxExdzvXvTvY4hckbOMPW7o0SdNSji
        8Dgw2WQNSbjnpxe+Osx1/1BtnNWarjzQA4a3gHpgl5t8Xen7q89I0MI=
X-Google-Smtp-Source: AGHT+IGmhZ2oEbIJ4JrwhdmJV114Mlgz3c7RIS4tMhZxtuObkq2qomaUF7sUnF9rFRTqqr3qGJHh2N682dVpJIQsPTA=
X-Received: by 2002:a67:b606:0:b0:452:58f8:71de with SMTP id
 d6-20020a67b606000000b0045258f871demr13637693vsm.8.1697003531657; Tue, 10 Oct
 2023 22:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231006051801.423973-1-sumit.garg@linaro.org> <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
In-Reply-To: <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Oct 2023 11:22:00 +0530
Message-ID: <CAFA6WYMsG8e2TCCT39HJ6SE1YKuK0sJRyoyyCYmujh_C_QFfGA@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, jarkko@kernel.org,
        peterz@infradead.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 10 Oct 2023 at 23:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 5 Oct 2023 at 22:18, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Static calls invocations aren't well supported from module __init and
> > __exit functions. Especially the static call from cleanup_trusted() led
> > to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.
> >
> > However, the usage of static call invocations for trusted_key_init()
> > and trusted_key_exit() don't add any value from either a performance or
> > security perspective. Hence switch to use indirect function calls instead.
>
> I applied this patch to my tree, since it is a fix for the issue, and
> doesn't change any logic otherwise.

Thanks.

>
> However, I do note that the code logic is completely broken. It was
> broken before too, and apparently causes no problems, but it's still
> wrong.
>
> That's a separate issue, and would want a separate patch, but since I
> noticed it when applying this one, I'm replying here:
>
> > +               trusted_key_exit = trusted_key_sources[i].ops->exit;
> >                 migratable = trusted_key_sources[i].ops->migratable;
> >
> > -               ret = static_call(trusted_key_init)();
> > +               ret = trusted_key_sources[i].ops->init();
> >                 if (!ret)
> >                         break;
>
> Note how this sets "trusted_key_exit" even when the ->init() function fails.
>
> Then we potentially do the module exit:
>
> >  static void __exit cleanup_trusted(void)
> >  {
> > -       static_call_cond(trusted_key_exit)();
> > +       if (trusted_key_exit)
> > +               (*trusted_key_exit)();
> >  }
>
> With an exit function that doesn't match a successful init() call.
>
> Now, *normally* this isn't a problem, because if the init() call
> fails, we'll go on to the next one, and if they *all* fail, we'll fail
> the module load, and we obviously won't call the cleanup_trusted()
> function at all.
>
> EXCEPT.
>
> We have this:
>
>         /*
>          * encrypted_keys.ko depends on successful load of this module even if
>          * trusted key implementation is not found.
>          */
>         if (ret == -ENODEV)
>                 return 0;
>
> so that init() may actually have failed, and we still succeed in
> loading the module, and now we will call that exit function to clean
> up something that was never successfully done.

Here we consider -ENODEV as a success case since we don't want to
block encrypted keys module loading since it can use user key as
master key instead.

>
> This hopefully doesn't matter in practice, and the cleanup function
> will just not do anything, but it is illogical and inconsistent. So I
> think it should be fixed.

Agree as the exit function won't do anything without the device being
present but we should make it consistent.

-Sumit

> But as mentioned, this is a separate issue
> from the whole "you currently can't do static calls from __exit
> functions" issue.
>
>                   Linus
