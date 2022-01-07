Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13F4877D0
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 13:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbiAGMxx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 07:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiAGMxw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 07:53:52 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2DC0611FF
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jan 2022 04:53:52 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p5so9196476ybd.13
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jan 2022 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zY4p5e+UHBIq6EO7zUDr20HLdZCFv6UbC5KnzdtPUQA=;
        b=mWTKBQGiGE4YpQ/MzAmuuTcf5kIfWRptbLmjkMjqbMSeBApem7Z/3MEtsXmFNtiOZ3
         U/DPva1JQ3OK8rS8hMHHEN88LU2oqrbek7Gc02jFqhHD1tZk9Zhz3TxrNC74S+XRkWkI
         GmEvsez6RAEiNv41HzKK9Xqe6jZjwd27FsjjO/R7uw2MHT0kvum6shgtn5Iwb9wL7ymh
         Wv3FXCjOlhYOV55h4gOc++PNKTmUg6xjkXvfewc/RUDO3TgySXvYlO3Ey3QTzex9l6Eq
         UOOPuXCNg+WUDqQ9hstFkUhfFwZB1QMNo3FksVFyKt3OUeHG54DJYOyjGx+oSLLSrh1l
         3NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zY4p5e+UHBIq6EO7zUDr20HLdZCFv6UbC5KnzdtPUQA=;
        b=GBEIG4dNYWDGhiqoy5h2Io4Bbq4/Qp7LjFXoOpUjC6qMfwBRVspGczK388Ubg8Kwrr
         bxHv8t+zv8rzgWsLdX8rKaoc0bmGYER3P+WQjAZ2C3I9KUo0rBnbTY4IEDewh3mwCgKF
         0YFF5tXIFv+OF6OEs6vu8c9Jx6L9nbtXeVh9ncMA3YxCrWWAMxCRE0UzkCRYBo+WLCtn
         MdMjzmXTlGKohZzhniY/jX0cq9NomUtJ/+z8wDmRw2I+OcNfnnWhqdYkIP4YUkmg1kau
         435Zu99iPelT1KxXJzaPgI7NDmohBgZZ9zJuzqb/Fjrp6fze+9jDweXLD0DMnnb3WYkx
         Wwkw==
X-Gm-Message-State: AOAM531Mkzj9ScY2I3tDBblAymM5Kuhqmp8k2OTdqQbok3Cw0OinckV1
        m7BImNAjRasaLfraBR+lRYulxFw8CiHkn6wPmHUvSQ==
X-Google-Smtp-Source: ABdhPJw/BgcNtl2GSGA7pLvP9n9FYBqdC3sqrdp8aquloqKiMD2XdBa3Gbj3EF8mOc79ImUq+nt4uUDsuf1y9UCtvnU=
X-Received: by 2002:a25:bbc7:: with SMTP id c7mr75676072ybk.725.1641560031641;
 Fri, 07 Jan 2022 04:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20211229215330.4134835-1-yaelt@google.com> <CAFA6WYPuPHgcnzt6j+Q-EA2Dos6vBDukrjpheo5srLVXFrifEg@mail.gmail.com>
 <5a38824152eeee0fc9ba0a4fd2308bb6e0970059.camel@linux.ibm.com>
 <CAFA6WYOJt3=YMTt_QQSq6Z-MK42hwWspgSpasw2fuPtVFcP3uA@mail.gmail.com>
 <CAKoutNvW1c7MkTaFwyrD7MjUVXvTtcBOGFULMittJ5vzjMN0mg@mail.gmail.com> <CAFA6WYPQRagZF8-grn_LC8_SAaxBzh=cSgHhFAQQOYK+L2KuBQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPQRagZF8-grn_LC8_SAaxBzh=cSgHhFAQQOYK+L2KuBQ@mail.gmail.com>
From:   Yael Tiomkin <yaelt@google.com>
Date:   Fri, 7 Jan 2022 07:53:40 -0500
Message-ID: <CAKoutNtuY0+L29d6xzn6BgEKBytFsBHZ_kgkCOJZuicb_uNPHg@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, Jarkko Sakkinen <jarkko@kernel.org>,
        corbet@lwn.net, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sumit,

On Fri, Jan 7, 2022 at 12:15 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Yael,
>
> On Thu, 6 Jan 2022 at 01:48, Yael Tiomkin <yaelt@google.com> wrote:
> >
> > Hi Sumit,
> >
> > On Mon, Jan 3, 2022 at 1:51 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi Mimi,
> > >
> > > Apologies for the delayed reply as I was on leave for a long new year weekend.
> > >
> > > On Thu, 30 Dec 2021 at 18:59, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Thu, 2021-12-30 at 15:37 +0530, Sumit Garg wrote:
> > > > > + Jan, Ahmad
> > > > >
> > > > > On Thu, 30 Dec 2021 at 03:24, Yael Tiomkin <yaelt@google.com> wrote:
> > > > > >
> > > > > > The encrypted.c class supports instantiation of encrypted keys with
> > > > > > either an already-encrypted key material, or by generating new key
> > > > > > material based on random numbers. This patch defines a new datablob
> > > > > > format: [<format>] <master-key name> <decrypted data length>
> > > > > > <decrypted data> that allows to instantiate encrypted keys using
> > > > > > user-provided decrypted data, and therefore allows to perform key
> > > > > > encryption from userspace. The decrypted key material will be
> > > > > > inaccessible from userspace.
> > > > >
> > > > > This type of user-space key import feature has already been discussed
> > > > > at large in the context of trusted keys here [1]. So what makes it
> > > > > special in case of encrypted keys such that it isn't a "UNSAFE_IMPORT"
> > > > > or "DEBUGGING_IMPORT" or "DEVELOPMENT_IMPORT", ...?
> > > > >
> > > > > [1] https://lore.kernel.org/linux-integrity/74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de/
> > > > >
> > > > > -Sumit
> > > > >
> > > > > >
> > > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > > Signed-off-by: Yael Tiomkin <yaelt@google.com>
> > > >
> > > > There is a difference between trusted and encrypted keys.
> > >
> > > Yeah I understand the implementation differences.
> > >
> > > >  So in
> > > > addition to pointing to the rather long discussion thread, please
> > > > summarize the conclusion and, assuming you agree, include why in once
> > > > case it was acceptable and in the other it wasn't to provide userspace
> > > > key data.
> > >
> > > My major concern with importing user-space key data in *plain* format
> > > is that if import is *not* done in a safe (manufacturing or
> > > production) environment then the plain key data is susceptible to
> > > user-space compromises when the device is in the field.
> >
> > I agree this can happen. Key distribution in any scenario needs to be
> > secure and this could also potentially be an issue if the key is first
> > encrypted and then imported.
>
> Currently its not the case with encrypted keys. These are random keys
> generated within the kernel and encrypted with master key within the
> kernel and then exposed to user-space as encrypted blob only.


There are two different ways to create encrypted keys. One is to have
them generated within the kernel using random numbers, and the other
is by importing them in their encrypted form from user-space.
I was referring to the latter in my previous statement.

>
> > We can make sure the documentation
> > highlights the safety requirement.
> >
>
> IMO, you should enable this feature as a compile time option. The help
> text for that config option should highlight the use-case along with a
> safety warning.
>
> -Sumit
>
> > >
> > > And it sounds like we are diverting from basic definition [1] of encrypted keys:
> > >
> > > "Trusted and Encrypted Keys are two new key types added to the
> > > existing kernel key ring service. Both of these new types are variable
> > > length symmetric keys, and in both cases all keys are created in the
> > > kernel, and **user space sees, stores, and loads** only encrypted
> > > blobs."
> > >
> > > Also, as Jarrko mentioned earlier the use-case is still not clear to
> > > me as well. Isn't user logon keys an alternative option for
> > > non-readable user-space keys?
> >
> > The goal in this change is to allow key encryption from userspace,
> > using user-provided decrypted data. This cannot be achieved in logon
> > keys, which as you mentioned, are simply non-readable user type keys.
> >
> >
> > >
> > > [1] https://www.kernel.org/doc/html/v4.13/security/keys/trusted-encrypted.html
> > >
> > > -Sumit
> > >
> > > >
> > > > thanks,
> > > >
> > > > Mimi
> > > >
> >
> > Yael
