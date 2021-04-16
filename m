Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC036200F
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Apr 2021 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbhDPMqg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Apr 2021 08:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbhDPMqf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Apr 2021 08:46:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383DEC061574
        for <linux-integrity@vger.kernel.org>; Fri, 16 Apr 2021 05:46:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c1so22642097ljd.7
        for <linux-integrity@vger.kernel.org>; Fri, 16 Apr 2021 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1ILH0EQwixpDyrhSlLZ6fxjrxGNn/4KKgof6LPr/2A=;
        b=mkcKo2EcZ+zVQrlLi4WlxNYyQ4F3cyHCBvkDdxSOO0OsO1wUwIsjvcQM97RbbKtII+
         4R9Zgq9jWLrkq1K85F3bRPdjQ7gqV7gygsHbLqXfXUyUReMDsyje0dTJcDEE4+cxIx6J
         sTrssdWuuD295YT6XWdGWjq7T7HJVx5wuNEJ9eqMvVKT1Y4uh6Ank1wcTj+/NwkARvRY
         8WC7bnLjZXOuddw/7KQY30Agt4hETYCxpJOkC9FFxtonykNVay5yl/CZBhHp+xo3rwbT
         71Eao/iPmttAmm5YFLNpuAvHfPiJyUi02MyG/rU7RBPdEaTWAB/3Uug/EbXz/nsvMm4W
         0uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1ILH0EQwixpDyrhSlLZ6fxjrxGNn/4KKgof6LPr/2A=;
        b=FexjQ6AJ2nKMzoN2wS7+VbLRgjLO5iqa9qO6kxbKY8dKTJOfOZdDEjP20X2GEme+xe
         4/P3WZZpGr7IxfEaWt5ghEVbG4taqrW6dQrjMZAgpIcuN9N8ddTDTEvmvQBFtk6DumYw
         U1B9Ei1CuXT+XndGB9Xf0nAVlP8SQUGYUs277nHQEaJZnhG8Au8jTPzLroAWw3qr1vRg
         WZbyEX/1cuqFsmQgKcHxCYq6dJTvGHkMLpC7mlXVgW5fyk1jjVRQR0Cje0waTLcA/miy
         GJOmRG0xhwLOH/6f0wqWteCN2cDcoMXcNj2kskLeOV3mbcdFecnMC/CLWwsZxzvAPXvj
         P8zQ==
X-Gm-Message-State: AOAM533CFeZb/cqEMvKgq7f2gSuweTxnm6ulm1rfvuFC55s3haTiJCfH
        nInZPnZETMpozIfeOhWWKto7SmOy7FYXUv2MMI00Ug==
X-Google-Smtp-Source: ABdhPJwvxTmx+RZ95oZQ5Ss68cB8z9iruQ6vT/rNP8UJfp6aX31mSeN1ZdwbAEEc53BZ2wPgS8+ytMY3YXdAsq/AB+U=
X-Received: by 2002:a2e:557:: with SMTP id 84mr2551645ljf.480.1618577169690;
 Fri, 16 Apr 2021 05:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <YHaG+p5nlOXQFp1n@mwanda> <20210414140734.GB11180@mail.hallyn.com>
In-Reply-To: <20210414140734.GB11180@mail.hallyn.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 16 Apr 2021 18:15:58 +0530
Message-ID: <CAFA6WYOfy0mtM071GoSjeARRNWJ7ozJdZNsNa4v0ba=TxFnE8g@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix a couple error pointer dereferences
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Serge,

On Wed, 14 Apr 2021 at 19:37, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Wed, Apr 14, 2021 at 09:08:58AM +0300, Dan Carpenter wrote:
> > If registering "reg_shm_out" fails, then it is an error pointer and the
> > error handling will call tee_shm_free(reg_shm_out) which leads to an
> > error pointer dereference and an Oops.
> >
> > I've re-arranged it so we only free things that have been allocated
> > successfully.
> >
> > Fixes: 6dd95e650c8a ("KEYS: trusted: Introduce TEE based Trusted Keys")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  security/keys/trusted-keys/trusted_tee.c | 24 ++++++++++--------------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> > index 2ce66c199e1d..45f96f6ed673 100644
> > --- a/security/keys/trusted-keys/trusted_tee.c
> > +++ b/security/keys/trusted-keys/trusted_tee.c
> > @@ -65,7 +65,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
> >       int ret;
> >       struct tee_ioctl_invoke_arg inv_arg;
> >       struct tee_param param[4];
> > -     struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> > +     struct tee_shm *reg_shm_in, *reg_shm_out;
>
> I don't have this file (trusted_tee.c) in my tree and there's no lore
> link here to previous what threads this depends on.  Based on the
> context I can't verify that reg_shm_in will always be initialized
> before you get to the free_shm_in label.
>

You can find trusted_tee.c here [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/tree/security/keys/trusted-keys/trusted_tee.c

-Sumit

> >
> >       memset(&inv_arg, 0, sizeof(inv_arg));
> >       memset(&param, 0, sizeof(param));
> > @@ -84,7 +84,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
> >       if (IS_ERR(reg_shm_out)) {
> >               dev_err(pvt_data.dev, "blob shm register failed\n");
> >               ret = PTR_ERR(reg_shm_out);
> > -             goto out;
> > +             goto free_shm_in;
> >       }
> >
> >       inv_arg.func = TA_CMD_SEAL;
> > @@ -109,11 +109,9 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
> >               p->blob_len = param[1].u.memref.size;
> >       }
> >
> > -out:
> > -     if (reg_shm_out)
> > -             tee_shm_free(reg_shm_out);
> > -     if (reg_shm_in)
> > -             tee_shm_free(reg_shm_in);
> > +     tee_shm_free(reg_shm_out);
> > +free_shm_in:
> > +     tee_shm_free(reg_shm_in);
> >
> >       return ret;
> >  }
> > @@ -126,7 +124,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
> >       int ret;
> >       struct tee_ioctl_invoke_arg inv_arg;
> >       struct tee_param param[4];
> > -     struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> > +     struct tee_shm *reg_shm_in, *reg_shm_out;
> >
> >       memset(&inv_arg, 0, sizeof(inv_arg));
> >       memset(&param, 0, sizeof(param));
> > @@ -145,7 +143,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
> >       if (IS_ERR(reg_shm_out)) {
> >               dev_err(pvt_data.dev, "key shm register failed\n");
> >               ret = PTR_ERR(reg_shm_out);
> > -             goto out;
> > +             goto free_shm_in;
> >       }
> >
> >       inv_arg.func = TA_CMD_UNSEAL;
> > @@ -170,11 +168,9 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
> >               p->key_len = param[1].u.memref.size;
> >       }
> >
> > -out:
> > -     if (reg_shm_out)
> > -             tee_shm_free(reg_shm_out);
> > -     if (reg_shm_in)
> > -             tee_shm_free(reg_shm_in);
> > +     tee_shm_free(reg_shm_out);
> > +free_shm_in:
> > +     tee_shm_free(reg_shm_in);
> >
> >       return ret;
> >  }
> > --
> > 2.30.2
