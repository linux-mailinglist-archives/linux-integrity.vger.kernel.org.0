Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E8B79C325
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Sep 2023 04:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjILClr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Sep 2023 22:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbjILCk5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Sep 2023 22:40:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E9958E9
        for <linux-integrity@vger.kernel.org>; Mon, 11 Sep 2023 16:15:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5007616b756so8249564e87.3
        for <linux-integrity@vger.kernel.org>; Mon, 11 Sep 2023 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694474025; x=1695078825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzkVzEFydtkz5bajW6TvmTAgwsFOtxXYQqSDn5oNDRM=;
        b=M2U8tjv1818AzoEQvoLs7GhdoYUX3dGxa7/p/ugPtid5NLK5gXcO2r5O69NcIFxkNY
         usJDx6BggFCRAzQ40e5/01F2xCcX06qCceg64pSBbqg75MHgZ59K2XbWe5/PsoepSMCE
         yWh0xcvVKgZPuYFTe1xiM9c4ARwj9ZBm57y7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474025; x=1695078825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SzkVzEFydtkz5bajW6TvmTAgwsFOtxXYQqSDn5oNDRM=;
        b=NUFgVTSUrYS0tRBjsAum6jyZXymA56KMfRtoaWkpjcuF+pzjyXsGFcO0MngQsFS+Jp
         sNmRrwz8F3HX0dcB9DwK5QfvNkQZfM7GJ0bEDJ1RUsA2+uG8L9x6FM/30Pr7LVI8sm4A
         C73Hskh0+rlVn+A9tNy7vTdWiWd4Ka8D4Z+7figfefqGVfNUN/+oZBXyXjWN/m9iuXB6
         7cdUAO9rjAXo62WlQ87Qp0Nl2yPzBVdW2xocVdr3KNUJhAN6HczpkMshs27OyL64zKE0
         7ciPuBEWLi0yWid0dCULaIDwK6hFM7hpwr3++be114WalGgtumA/Dejqtrri4lm9DfRO
         RudQ==
X-Gm-Message-State: AOJu0Yw6AuFDFwoQ/b7p+N38WqIXdEg8Z1YAOSkmNziej/N5z7oYq4lp
        pL+MtwX6dzBa3dvqzDSRS25dWg8nxX4r9UU6tOHC/RypxMM=
X-Google-Smtp-Source: AGHT+IG82a2gAb3lrCHJ/wcIbdBmUEauf3bztlwzlWn0dtdcrTK9x4fW5YtNGbsYiYRT8MDx4mDn4Q==
X-Received: by 2002:a17:906:31c6:b0:9a1:bd33:4389 with SMTP id f6-20020a17090631c600b009a1bd334389mr8740581ejf.74.1694471684654;
        Mon, 11 Sep 2023 15:34:44 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id kj27-20020a170907765b00b009a5f7fb51dcsm5911996ejc.42.2023.09.11.15.34.43
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 15:34:43 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9aa2468bdb4so229809066b.0
        for <linux-integrity@vger.kernel.org>; Mon, 11 Sep 2023 15:34:43 -0700 (PDT)
X-Received: by 2002:a17:906:1db2:b0:99c:85af:7aa6 with SMTP id
 u18-20020a1709061db200b0099c85af7aa6mr10588202ejh.28.1694471683161; Mon, 11
 Sep 2023 15:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230908140629.2930150-1-jforbes@fedoraproject.org> <CVGF71DQQCJ2.1XC0V5TKKRX5R@suppilovahvero>
In-Reply-To: <CVGF71DQQCJ2.1XC0V5TKKRX5R@suppilovahvero>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Mon, 11 Sep 2023 17:34:31 -0500
X-Gmail-Original-Message-ID: <CAFbkSA3gBfA8rqoyV6qqyuOLdAOReK+j+B1gZA+96DqcOrP5XQ@mail.gmail.com>
Message-ID: <CAFbkSA3gBfA8rqoyV6qqyuOLdAOReK+j+B1gZA+96DqcOrP5XQ@mail.gmail.com>
Subject: Re: [PATCH] Fix typo in tpmrm class definition
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 11, 2023 at 5:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Fri Sep 8, 2023 at 5:06 PM EEST, Justin M. Forbes wrote:
> > Commit d2e8071bed0be ("tpm: make all 'class' structures const")
> > unfortunately had a typo for the name on tpmrm.
> >
> > Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
> > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 23f6f2eda84c..42b1062e33cd 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -33,7 +33,7 @@ const struct class tpm_class =3D {
> >       .shutdown_pre =3D tpm_class_shutdown,
> >  };
> >  const struct class tpmrm_class =3D {
> > -     .name =3D "tmprm",
> > +     .name =3D "tpmrm",
> >  };
> >  dev_t tpm_devt;
> >
> > --
> > 2.41.0
>
> I have issues applying the patch:

Sorry, not sure what the issue is, but I did a git am of it myself to
a fresh checkout of linus' tree and just recreated and sent it. So,
new thread, but hopefully the patch will apply

Justin

>
> $ git am -3 20230908_jforbes_fix_typo_in_tpmrm_class_definition.mbx
> Applying: Fix typo in tpmrm class definition
> error: corrupt patch at line 18
> error: could not build fake ancestor
> Patch failed at 0001 Fix typo in tpmrm class definition
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> $ git log -2
> commit ba46245183940de39e42c8456b85ceaf3519b764 (HEAD -> master, origin/m=
aster, origin/HEAD)
> Author: Sumit Garg <sumit.garg@linaro.org>
> Date:   Tue Aug 22 16:59:33 2023 +0530
>
>     KEYS: trusted: tee: Refactor register SHM usage
>
>     The OP-TEE driver using the old SMC based ABI permits overlapping sha=
red
>     buffers, but with the new FF-A based ABI each physical page may only
>     be registered once.
>
>     As the key and blob buffer are allocated adjancently, there is no nee=
d
>     for redundant register shared memory invocation. Also, it is incompat=
ibile
>     with FF-A based ABI limitation. So refactor register shared memory
>     implementation to use only single invocation to register both key and=
 blob
>     buffers.
>
>     [jarkko: Added cc to stable.]
>     Cc: stable@vger.kernel.org # v5.16+
>     Fixes: 4615e5a34b95 ("optee: add FF-A support")
>     Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
>     Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>     Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
>     Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d (tag: v6.6-rc1, upstream/=
master, origin/next, next)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Sep 10 16:28:41 2023 -0700
>
>     Linux 6.6-rc1
>
> BR, Jarkko
>
