Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A27C036B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Oct 2023 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbjJJS3M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Oct 2023 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343537AbjJJS3L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2023 14:29:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A377AA4
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 11:29:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8a822508so1092907166b.0
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696962548; x=1697567348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MMknBzgIfNoTzZSRTfijrObIQYsZ5aDutyDdN6x4cs=;
        b=RIeRuBgf3mX8owjfvZ6XpdWK+qvSymGr1C0KpKLBnXSulHRphzpceT+8KLJv/z8KqB
         1ayWQuz8DF/gfmiPMI65fQS9OPgZPPXkeiVr1cxvLT3sLFSQQgW5EtEHDQqDqL+fHilw
         r0cXXHyxTNjjF2WZ1LEiZzAeqXYnp+fzmODW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962548; x=1697567348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MMknBzgIfNoTzZSRTfijrObIQYsZ5aDutyDdN6x4cs=;
        b=O/xrKAyeAX5/ir7OHNO6ZH2oRyyOVlqvN4rP0OVhE/5Xz23ijEvaTrW1n65z7u1kBv
         oW7N9SaF6tfYQAV/T/wIXVG/Sgo+sIqCWgYB9s6amhTkmZwzs7qXHantjE+/Rx2mS/LQ
         KvQIl/4+DcIc7eZXhA24ZbMxma5NuHrS3mESzJpFzi75OrGnRjnhfe6XNg1UcQg5Czx4
         QRqcI8OKIAK3j6xeeJ6yxvV9Ptv8qkdjTEJOORux8TDlSGOl8AkET3M3RY0AuYyEVKJg
         UobNo6aOoasqfylqFHHorv0HApgmFlGSIQtVrkNe59WUycDtLs7i+NokfkD3I3HVtaqs
         6bqQ==
X-Gm-Message-State: AOJu0YyT6x5TOG7bzoNKbyOqjc026eKOyCWScMQKsFcEbgMFhbQp5bYI
        dyPcna8y3fzf50VvcczuPjiDosvxSQF+isn7FLgP0Vat
X-Google-Smtp-Source: AGHT+IH+AItiT9Qg3MTR4cgjWvR/iLI6kP5iQ4EClnfeghx6LEG4t1svrCCQndAyOnZb6VEpuhsC8g==
X-Received: by 2002:a17:906:cc47:b0:9ae:552a:3d3f with SMTP id mm7-20020a170906cc4700b009ae552a3d3fmr16110901ejb.28.1696962547999;
        Tue, 10 Oct 2023 11:29:07 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id ce24-20020a170906b25800b0098669cc16b2sm8692179ejb.83.2023.10.10.11.29.06
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 11:29:06 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99c1c66876aso1085233566b.2
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 11:29:06 -0700 (PDT)
X-Received: by 2002:a17:906:53:b0:9b2:be4e:4940 with SMTP id
 19-20020a170906005300b009b2be4e4940mr16536884ejg.61.1696962546177; Tue, 10
 Oct 2023 11:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231006051801.423973-1-sumit.garg@linaro.org>
In-Reply-To: <20231006051801.423973-1-sumit.garg@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Oct 2023 11:28:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
Message-ID: <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
To:     Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>
Cc:     jarkko@kernel.org, peterz@infradead.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

On Thu, 5 Oct 2023 at 22:18, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Static calls invocations aren't well supported from module __init and
> __exit functions. Especially the static call from cleanup_trusted() led
> to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.
>
> However, the usage of static call invocations for trusted_key_init()
> and trusted_key_exit() don't add any value from either a performance or
> security perspective. Hence switch to use indirect function calls instead.

I applied this patch to my tree, since it is a fix for the issue, and
doesn't change any logic otherwise.

However, I do note that the code logic is completely broken. It was
broken before too, and apparently causes no problems, but it's still
wrong.

That's a separate issue, and would want a separate patch, but since I
noticed it when applying this one, I'm replying here:

> +               trusted_key_exit = trusted_key_sources[i].ops->exit;
>                 migratable = trusted_key_sources[i].ops->migratable;
>
> -               ret = static_call(trusted_key_init)();
> +               ret = trusted_key_sources[i].ops->init();
>                 if (!ret)
>                         break;

Note how this sets "trusted_key_exit" even when the ->init() function fails.

Then we potentially do the module exit:

>  static void __exit cleanup_trusted(void)
>  {
> -       static_call_cond(trusted_key_exit)();
> +       if (trusted_key_exit)
> +               (*trusted_key_exit)();
>  }

With an exit function that doesn't match a successful init() call.

Now, *normally* this isn't a problem, because if the init() call
fails, we'll go on to the next one, and if they *all* fail, we'll fail
the module load, and we obviously won't call the cleanup_trusted()
function at all.

EXCEPT.

We have this:

        /*
         * encrypted_keys.ko depends on successful load of this module even if
         * trusted key implementation is not found.
         */
        if (ret == -ENODEV)
                return 0;

so that init() may actually have failed, and we still succeed in
loading the module, and now we will call that exit function to clean
up something that was never successfully done.

This hopefully doesn't matter in practice, and the cleanup function
will just not do anything, but it is illogical and inconsistent. So I
think it should be fixed. But as mentioned, this is a separate issue
from the whole "you currently can't do static calls from __exit
functions" issue.

                  Linus
