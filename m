Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F40491F76
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 07:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiARGrM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 01:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiARGrK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 01:47:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E825C061574
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jan 2022 22:47:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p27so55005150lfa.1
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jan 2022 22:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndRmdqMdJ9799j8PWgE96Wh//o3D2hfldSG13u5SeAM=;
        b=YB+Kge9lFu1w7LVUa5FlGUi7PZaLnS8FNV8sMwK0FPqqG0Lk2PUL7PRgao61YZQSU8
         3/JPbrKoffRa3xJh3qPEuFRzwkbTeYnhZK0i3jHv7Q7X2waL25oHJU1p6im42FbswCSs
         Ug69yVzHk9/Wmztwy3F8QTh8w2X6tZjB36qmOuzjwqEg4ZdDg1m2wZWDLniLM00kGvDN
         7tTN5RWg6e9J+S9w5Cc2SEcm7/jA6zzRdoUnhJNiSN7hO/EyjynW9TVag9qAp2VVtfE4
         wj4QBzzIlAqEZb63Nh++4Y9PPsElMmAn3PShGpukX0PibdcmJlXUdOqIb9oLyi9WcFXd
         5T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndRmdqMdJ9799j8PWgE96Wh//o3D2hfldSG13u5SeAM=;
        b=M7dhdFvbkTbEECNIlj3cb3MASHyGDYm8F7YKNbVHn62vj6W2ZWI88LNdtAa97AaHdl
         QLzF8RZ7BH1sO1buusqiz4Nsl87YwK0yfv4cAFw6m/EJiY9BvUp0bmYMjDHF4eB/LOCA
         P8UY3b3uU9xJRwtzmH2osjYn5ap0z24T1B2CbJembRLdJDx5MoYrW5Ku2XtzqDkxEluc
         1DVdCFv9M9alMGE8uNBEEyGWikIKFpugM9bi6v4cM8EnZKQclG+oB4l5oP30wNjv5tb6
         L5y7Q6iiGAZcwJa6QdPvy3ua13DOLfPB3pcrkbEV151Iqmxtt2nsn2dIJo7VsC1s5pVL
         MpyA==
X-Gm-Message-State: AOAM5327pEWxhoZVHxCWMiw4htMLhzVjhTy/uRNINOWpFx3EZDoagD16
        WoqFOto6Aj5lmNrkZm2qnpNf/yQOo5Gkuj8jjsy6mg==
X-Google-Smtp-Source: ABdhPJzjbz4/fCjr33TO7htvx9gliX688kTeU0cO2lulCwM/tQ2dIG+ra+iboLhNbvF1fx0/jEaSHO1aZFb/EfqXukY=
X-Received: by 2002:a2e:bf01:: with SMTP id c1mr18353250ljr.511.1642488428506;
 Mon, 17 Jan 2022 22:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20211229215330.4134835-1-yaelt@google.com> <CAFA6WYPuPHgcnzt6j+Q-EA2Dos6vBDukrjpheo5srLVXFrifEg@mail.gmail.com>
 <5a38824152eeee0fc9ba0a4fd2308bb6e0970059.camel@linux.ibm.com>
 <CAFA6WYOJt3=YMTt_QQSq6Z-MK42hwWspgSpasw2fuPtVFcP3uA@mail.gmail.com>
 <CAKoutNvW1c7MkTaFwyrD7MjUVXvTtcBOGFULMittJ5vzjMN0mg@mail.gmail.com>
 <CAFA6WYPQRagZF8-grn_LC8_SAaxBzh=cSgHhFAQQOYK+L2KuBQ@mail.gmail.com>
 <CAKoutNtuY0+L29d6xzn6BgEKBytFsBHZ_kgkCOJZuicb_uNPHg@mail.gmail.com>
 <CAFA6WYPxogLMk1EDqvM_mwgCmU1s_yDwYFPjq6wurnQGhG=-_w@mail.gmail.com> <CAKoutNtj8nxvGyZu=m1_7+rGck9dm76E=O93333Yfb5En+8HNQ@mail.gmail.com>
In-Reply-To: <CAKoutNtj8nxvGyZu=m1_7+rGck9dm76E=O93333Yfb5En+8HNQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 18 Jan 2022 12:16:56 +0530
Message-ID: <CAFA6WYNr5L+=Hz8JGztLH5AZs3+5BwtN4rTF=CmyRdi0CjkRqA@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     Yael Tiomkin <yaelt@google.com>
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

On Fri, 14 Jan 2022 at 00:45, Yael Tiomkin <yaelt@google.com> wrote:
>
> On Fri, Jan 7, 2022 at 8:32 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Fri, 7 Jan 2022 at 18:23, Yael Tiomkin <yaelt@google.com> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Fri, Jan 7, 2022 at 12:15 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Hi Yael,
> > > >
> > > > On Thu, 6 Jan 2022 at 01:48, Yael Tiomkin <yaelt@google.com> wrote:
> > > > >
> > > > > Hi Sumit,
> > > > >
> > > > > On Mon, Jan 3, 2022 at 1:51 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > >
> > > > > > Hi Mimi,
> > > > > >
> > > > > > Apologies for the delayed reply as I was on leave for a long new year weekend.
> > > > > >
> > > > > > On Thu, 30 Dec 2021 at 18:59, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > >
> > > > > > > Hi Sumit,
> > > > > > >
> > > > > > > On Thu, 2021-12-30 at 15:37 +0530, Sumit Garg wrote:
> > > > > > > > + Jan, Ahmad
> > > > > > > >
> > > > > > > > On Thu, 30 Dec 2021 at 03:24, Yael Tiomkin <yaelt@google.com> wrote:
> > > > > > > > >
> > > > > > > > > The encrypted.c class supports instantiation of encrypted keys with
> > > > > > > > > either an already-encrypted key material, or by generating new key
> > > > > > > > > material based on random numbers. This patch defines a new datablob
> > > > > > > > > format: [<format>] <master-key name> <decrypted data length>
> > > > > > > > > <decrypted data> that allows to instantiate encrypted keys using
> > > > > > > > > user-provided decrypted data, and therefore allows to perform key
> > > > > > > > > encryption from userspace. The decrypted key material will be
> > > > > > > > > inaccessible from userspace.
> > > > > > > >
> > > > > > > > This type of user-space key import feature has already been discussed
> > > > > > > > at large in the context of trusted keys here [1]. So what makes it
> > > > > > > > special in case of encrypted keys such that it isn't a "UNSAFE_IMPORT"
> > > > > > > > or "DEBUGGING_IMPORT" or "DEVELOPMENT_IMPORT", ...?
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/linux-integrity/74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de/
> > > > > > > >
> > > > > > > > -Sumit
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > > > > > Signed-off-by: Yael Tiomkin <yaelt@google.com>
> > > > > > >
> > > > > > > There is a difference between trusted and encrypted keys.
> > > > > >
> > > > > > Yeah I understand the implementation differences.
> > > > > >
> > > > > > >  So in
> > > > > > > addition to pointing to the rather long discussion thread, please
> > > > > > > summarize the conclusion and, assuming you agree, include why in once
> > > > > > > case it was acceptable and in the other it wasn't to provide userspace
> > > > > > > key data.
> > > > > >
> > > > > > My major concern with importing user-space key data in *plain* format
> > > > > > is that if import is *not* done in a safe (manufacturing or
> > > > > > production) environment then the plain key data is susceptible to
> > > > > > user-space compromises when the device is in the field.
> > > > >
> > > > > I agree this can happen. Key distribution in any scenario needs to be
> > > > > secure and this could also potentially be an issue if the key is first
> > > > > encrypted and then imported.
> > > >
> > > > Currently its not the case with encrypted keys. These are random keys
> > > > generated within the kernel and encrypted with master key within the
> > > > kernel and then exposed to user-space as encrypted blob only.
> > >
> > >
> > > There are two different ways to create encrypted keys. One is to have
> > > them generated within the kernel using random numbers, and the other
> > > is by importing them in their encrypted form from user-space.
> > > I was referring to the latter in my previous statement.
> > >
> >
> > So, from a key distribution security point of view, encrypted key
> > user-space import is **not equal to** plain key user-space import.
> > That's why we need to have a separate compile time option as every
> > device may come with its own threat model and may choose to enable or
> > disable this user-space plain key import feature.
> >
> > -Sumit
> >
> > > >
> > > > > We can make sure the documentation
> > > > > highlights the safety requirement.
> > > > >
> > > >
> > > > IMO, you should enable this feature as a compile time option. The help
> > > > text for that config option should highlight the use-case along with a
> > > > safety warning.
> > > >
> > > > -Sumit
> > > >
> > > > > >
> > > > > > And it sounds like we are diverting from basic definition [1] of encrypted keys:
> > > > > >
> > > > > > "Trusted and Encrypted Keys are two new key types added to the
> > > > > > existing kernel key ring service. Both of these new types are variable
> > > > > > length symmetric keys, and in both cases all keys are created in the
> > > > > > kernel, and **user space sees, stores, and loads** only encrypted
> > > > > > blobs."
> > > > > >
> > > > > > Also, as Jarrko mentioned earlier the use-case is still not clear to
> > > > > > me as well. Isn't user logon keys an alternative option for
> > > > > > non-readable user-space keys?
> > > > >
> > > > > The goal in this change is to allow key encryption from userspace,
> > > > > using user-provided decrypted data. This cannot be achieved in logon
> > > > > keys, which as you mentioned, are simply non-readable user type keys.
> > > > >
> > > > >
> > > > > >
> > > > > > [1] https://www.kernel.org/doc/html/v4.13/security/keys/trusted-encrypted.html
> > > > > >
> > > > > > -Sumit
> > > > > >
> > > > > > >
> > > > > > > thanks,
> > > > > > >
> > > > > > > Mimi
> > > > > > >
> > > > >
> > > > > Yael
>
> Hi Sumit,
> The encrypted-keys module is already controlled by the
> CONFIG_ENCRYPTED_KEYS option, which I think might give sufficient
> granularity to control the behavior. Do you still think a feature
> dedicated option is needed?
>

Since this feature will change security properties for encrypted keys
which can be considered as a regression for existing users during
uprev. So it needs to be an optional key import feature with a clear
user visible warning. Thinking more about this, you can even have a
module param to turn it on with a runtime warning as well.

-Sumit

> Yael
