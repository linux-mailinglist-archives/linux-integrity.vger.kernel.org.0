Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96F86FED6C
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjEKIFZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEKIFY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 04:05:24 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733EE2703
        for <linux-integrity@vger.kernel.org>; Thu, 11 May 2023 01:05:23 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-44ff6a049a7so2932890e0c.2
        for <linux-integrity@vger.kernel.org>; Thu, 11 May 2023 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683792322; x=1686384322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c2Hx6awfc5MHptX6uHlihrtsALsu2niBMQyHzZj45y0=;
        b=Exx6N/pn9pj3gmIFHpCqq+HVALDIRTLDG29GrWw5k3KZxR2jN+sHHebuxlSgG8xMkt
         hIgOwNaIdo5ld0GvNUcbhip2bKHJGNoCnSApnIQomSiRBARyBSYhctWlbGcw8ZOQTQJQ
         qY8kl5IlFARaVufQ57Gn0ShJ8w4JfZUMPWTWQzQP8yN700jt6GLaif1knndpcomrUbGb
         bqjJrOnuFjs2j5osT0qoRdEwwQkDZtLd7I9pyu+fNyS7jYP4JmwQ7Bo13qwzUVhx4hdq
         J8VsbPdNkOouOwYeJ3pEAYPAVVHOcD1pslg5O02gK7d0kI/+SD8E9QSc3aXQIL4yeSba
         rjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683792322; x=1686384322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2Hx6awfc5MHptX6uHlihrtsALsu2niBMQyHzZj45y0=;
        b=eglyRclJUIv536h9F0GjOOWAUgKZOXHKRBA4jx5wBlxLgARaTf3o0NNI6CSmcCXIdj
         2CMc7ViUD0/EbHIg5AK8LpZvtsA5uKq6hRYZDFz2oK3vGo1ViurYvgbEp58bC6FB93q+
         6HYVgQ/0x9mqbP/gxBAHUbVk9M8RQXsp7rhj0d/Tlj3+yR3CgMkfPtg0f8EyaIWTnlqa
         6OT0CSct5iJ+T9E5dhepzZTDi2JzAwznC6VDhSu/FLDcPV0d6/5S+vQIuBmSeusc4cMS
         2w+0W7JZ7F+8laNxvFBbko4Io5D8EQnAxko09sK8RhokZwyaUfSoXqX/ugPYkEd5APB+
         XaHg==
X-Gm-Message-State: AC+VfDwPvgc7FI4ISxVScQWmyzWiEA4QayfLwrbp6RRUPpt0PTqZe3Uz
        lQGMrZsPHXrJR0LuP0CVlK4bbWIPiyPFKQkt7DRd3/hCewhcf6fmQJs=
X-Google-Smtp-Source: ACHHUZ54L76ReoTPsGdCYMtFuhdN625UNpJ4CmyO10D1mASDAp9lkP4z/QeEWYbtbVcYuD1DxtoErxWXsvKQwm+wU+M=
X-Received: by 2002:a1f:e601:0:b0:440:4058:936e with SMTP id
 d1-20020a1fe601000000b004404058936emr5343297vkh.12.1683792322505; Thu, 11 May
 2023 01:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230505184318.1355446-1-etienne.carriere@linaro.org>
 <CAFA6WYOfFm9R2GynH0bN7hQ4t81T3hkJX5JurCUDG8oOU-RZ4w@mail.gmail.com> <CAN5uoS8QCL+s2Kt0QSBAz4B84KWPKFhVYNG=+3T=rtdvK-jwEw@mail.gmail.com>
In-Reply-To: <CAN5uoS8QCL+s2Kt0QSBAz4B84KWPKFhVYNG=+3T=rtdvK-jwEw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 11 May 2023 13:35:11 +0530
Message-ID: <CAFA6WYNEmAdYZ6KpKYrFUuVPjHm=L7dF74d7tWE45DVZrJXqnA@mail.gmail.com>
Subject: Re: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+ Thirupathaiah (TEE fTPM driver author)

On Wed, 10 May 2023 at 20:28, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hello Sumit,
>
> On Wed, 10 May 2023 at 12:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Etienne,
> >
> > On Sat, 6 May 2023 at 00:14, Etienne Carriere
> > <etienne.carriere@linaro.org> wrote:
> > >
> > > Changes fTPM TEE driver to open the TEE session with REE kernel login
> > > identifier rather than public login. This is needed in case fTPM service
> > > it denied to user land application and restricted to kernel operating
> > > system services only.
> >
> > This is a valid restriction to avoid any unintended use of fTPM by
> > user-space. But has the corresponding patch landed in fTPM TA which
> > would enforce this restriction?
>
> Not yet. Actually, I've posted some other change requests in the repo
> [1]  but got no feedback. Not nice from me but I didn't post any other
> changes since.

Hi Thirupathaiah,

Is there any plan to maintain fTPM OP-TEE TA going forward? As
otherwise users have to maintain downstream patches or forks.

> In the mean time, I think Linux kernel should be ready for this before
> fTPM implementation is fixed.
> Note that U-Boot already integrate this login identifier change, see [2].

Yeah you are right but without a corresponding reference fTPM TA, it
won't be possible to test this capability.

-Sumit

>
> [1] https://github.com/microsoft/ms-tpm-20-ref/pull/83
> [2] https://source.denx.de/u-boot/u-boot/-/commit/33ba80303e93869c439828dd289fb8ef64ed3bfc
>
> Best regards,
> Etienne
>
> >
> > -Sumit
> >
> > >
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > ---
> > >  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > > index 528f35b14fb6..6d32e260af43 100644
> > > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > > @@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
> > >         /* Open a session with fTPM TA */
> > >         memset(&sess_arg, 0, sizeof(sess_arg));
> > >         export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
> > > -       sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> > > +       sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> > >         sess_arg.num_params = 0;
> > >
> > >         rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> > > --
> > > 2.25.1
> > >
