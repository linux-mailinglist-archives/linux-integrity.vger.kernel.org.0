Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8749D774B60
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjHHUp5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Aug 2023 16:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjHHUpj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Aug 2023 16:45:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB732A9B
        for <linux-integrity@vger.kernel.org>; Tue,  8 Aug 2023 09:33:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bbbbb77b38so36826595ad.3
        for <linux-integrity@vger.kernel.org>; Tue, 08 Aug 2023 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512376; x=1692117176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4QCyZoKdu40FBvi48BdsqXq5s8H3SxUopDt1IBpNKc=;
        b=iV/yKmf7sGSGkRcrH7o3he8r7GoWXL6hYvkOkaCJnSl6l4UKTqneyNoJLZSRglDbtN
         Z5sV+axIOmnEtwfuFgi9lxYIo0JYpWLQJuUfBFPH2cKmfwLhAyoepdKYdWn76XNCjddD
         L8LpxS5ibCXNVQ9dnrHRnptIfoBX4I9BUIxpyOL0TU0BFPslizBrpBIdlOeEoLxtHa0Y
         ZpfxMX20KXdKivc9vQ6TvKQ9eKotxCGbSPWMOtLkjXs+ZW8NGFp45QFzNEzWZQdsz6VC
         D8+DmxZteZV2ymqsItMGpq6UKS3d2Z3qL9EiumDddoNxQqKnhiU4D0VODwnSRLePKArh
         W1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512376; x=1692117176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4QCyZoKdu40FBvi48BdsqXq5s8H3SxUopDt1IBpNKc=;
        b=i6D2iNHeUdguoU+OjPm3RX8BXZPEcAMZ6N/OqwJ0zOTPQ2oVIUwSQTmLT/VP3WG/zd
         B7RQLLgC7aTlAlCz4fK51SUc4WeIqp4yS/E+/co4VO6Ej63hkpIY8vVVFMH9otMEioOr
         +g8p625zBwxnKYhB7MX5SWQOSdGjn0MvFmbF29cmuAHGU4iwUAziuzLt0yymS9ZyYPMd
         cOXlJb8iNxmSJFBGhJTfwKDUfi4JSY+1wjG7LWT0jZFABSyxnEoTFItERtDFkVI9XQqF
         T8n1UifvjVLze7xxlE/D9xM4ZmYeurga0lsVJyp+vglXxlx5lDraU+mHs9l6J1ZUrkXQ
         aQSQ==
X-Gm-Message-State: AOJu0YwreDw1W8bTbaniZtL09ubUDQAob78zQnGHFxvtTKV4un0trBpN
        YxGE5a56LvSqL2RJDjNxDH1rGPJreMjuJRLySvYsKDDArubDZH39i28=
X-Google-Smtp-Source: AGHT+IGNtfLXTIuMMWsLFIjckcjz0+W3BmhlMZ76WJBndpCHZ6yz0xZe8vd3WQsh7yBXJ2vHpUOh/8Bab44/TT3nh6Y=
X-Received: by 2002:a05:620a:24c2:b0:75e:bf7e:e17e with SMTP id
 m2-20020a05620a24c200b0075ebf7ee17emr15490100qkn.6.1691485652273; Tue, 08 Aug
 2023 02:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230803123515.4018838-1-jens.wiklander@linaro.org> <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
In-Reply-To: <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 8 Aug 2023 11:07:21 +0200
Message-ID: <CAHUa44ET3Oqc4Yq8E4ouAjn5dF9ygxoXyWh0sjFF_vPoooxrnA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sumit,

On Mon, Aug 7, 2023 at 9:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> Hi Jens,
>
> On Thu, 3 Aug 2023 at 18:05, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > Prior to this patch was trusted_tee_seal() and trusted_tee_get_random()
> > relying on tee_shm_register_kernel_buf() to share memory with the TEE.
> > Depending on the memory allocation pattern the pages holding the
> > registered buffers overlap with other buffers also shared with the TEE.
> >
>
> The overlap here is due to the fact that we are registering two array
> members of the same struct. This overlap can be removed by registering
> the overall structure at once. But that sounds unnecessary data
> structure type sharing with trusted keys TA.
>
> > The OP-TEE driver using the old SMC based ABI permits overlapping share=
d
> > buffers, but with the new FF-A based ABI each physical page may only
> > be registered once.
>
> Would it be possible for OP-TEE FF-A ABI to check if a page is already
> registered?

No, there's no such ABI in the FF-A specification.

> If it is then just return success with appropriate page
> offset.

It's more complicated than that. What if only there's a partial registratio=
n?

> As otherwise this sounds like an unnecessary restriction for
> users. I don't think the problem is only particular to the trusted
> keys driver but can be reproduced for user-space clients as well.

Indeed, we're dealing with it by using a temporary buffer in the client lib=
.

>
> >
> > Fix this problem by allocating a temporary page aligned shared memory
> > buffer to be used as a bounce buffer for the needed data buffers.
> >
> > Since TEE trusted keys doesn't depend on registered shared memory
> > support any longer remove that explicit dependency when opening a
> > context to the TEE.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  security/keys/trusted-keys/trusted_tee.c | 68 +++++++++++++-----------
> >  1 file changed, 36 insertions(+), 32 deletions(-)
> >
> > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/t=
rusted-keys/trusted_tee.c
> > index ac3e270ade69..3085343c489a 100644
> > --- a/security/keys/trusted-keys/trusted_tee.c
> > +++ b/security/keys/trusted-keys/trusted_tee.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/err.h>
> >  #include <linux/key-type.h>
> > +#include <linux/minmax.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > @@ -65,38 +66,37 @@ static int trusted_tee_seal(struct trusted_key_payl=
oad *p, char *datablob)
> >         int ret;
> >         struct tee_ioctl_invoke_arg inv_arg;
> >         struct tee_param param[4];
> > -       struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> > +       struct tee_shm *shm;
> > +       uint8_t *buf;
> >
> >         memset(&inv_arg, 0, sizeof(inv_arg));
> >         memset(&param, 0, sizeof(param));
> >
> > -       reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key=
,
> > -                                                p->key_len);
> > -       if (IS_ERR(reg_shm_in)) {
> > -               dev_err(pvt_data.dev, "key shm register failed\n");
> > -               return PTR_ERR(reg_shm_in);
> > +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx,
> > +                                      p->key_len + sizeof(p->blob));
> > +       if (IS_ERR(shm)) {
> > +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> > +               return PTR_ERR(shm);
> >         }
> > -
> > -       reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->bl=
ob,
> > -                                                 sizeof(p->blob));
> > -       if (IS_ERR(reg_shm_out)) {
> > -               dev_err(pvt_data.dev, "blob shm register failed\n");
> > -               ret =3D PTR_ERR(reg_shm_out);
> > +       buf =3D tee_shm_get_va(shm, 0);
> > +       if (IS_ERR(buf)) {
> > +               ret =3D PTR_ERR(buf);
> >                 goto out;
> >         }
> > +       memcpy(buf, p->key, p->key_len);
>
> These memcpy()'s here and below are undue overheads if we change to
> tee_shm_alloc_kernel_buf().

There's a bit of overhead when entering and exiting the secure world
too, just to save and restore registers. Anyway, trusted_tee_seal()
doesn't together with FF-A without this patch.

Thanks,
Jens

>
> -Sumit
>
> >
> >         inv_arg.func =3D TA_CMD_SEAL;
> >         inv_arg.session =3D pvt_data.session_id;
> >         inv_arg.num_params =3D 4;
> >
> >         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > -       param[0].u.memref.shm =3D reg_shm_in;
> > +       param[0].u.memref.shm =3D shm;
> >         param[0].u.memref.size =3D p->key_len;
> >         param[0].u.memref.shm_offs =3D 0;
> >         param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > -       param[1].u.memref.shm =3D reg_shm_out;
> > +       param[1].u.memref.shm =3D shm;
> >         param[1].u.memref.size =3D sizeof(p->blob);
> > -       param[1].u.memref.shm_offs =3D 0;
> > +       param[1].u.memref.shm_offs =3D p->key_len;
> >
> >         ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> >         if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > @@ -104,14 +104,13 @@ static int trusted_tee_seal(struct trusted_key_pa=
yload *p, char *datablob)
> >                         inv_arg.ret);
> >                 ret =3D -EFAULT;
> >         } else {
> > +               memcpy(p->blob, buf + p->key_len,
> > +                      min(param[1].u.memref.size, sizeof(p->blob)));
> >                 p->blob_len =3D param[1].u.memref.size;
> >         }
> >
> >  out:
> > -       if (reg_shm_out)
> > -               tee_shm_free(reg_shm_out);
> > -       if (reg_shm_in)
> > -               tee_shm_free(reg_shm_in);
> > +       tee_shm_free(shm);
> >
> >         return ret;
> >  }
> > @@ -166,11 +165,9 @@ static int trusted_tee_unseal(struct trusted_key_p=
ayload *p, char *datablob)
> >                 p->key_len =3D param[1].u.memref.size;
> >         }
> >
> > +       tee_shm_free(reg_shm_out);
> >  out:
> > -       if (reg_shm_out)
> > -               tee_shm_free(reg_shm_out);
> > -       if (reg_shm_in)
> > -               tee_shm_free(reg_shm_in);
> > +       tee_shm_free(reg_shm_in);
> >
> >         return ret;
> >  }
> > @@ -183,15 +180,21 @@ static int trusted_tee_get_random(unsigned char *=
key, size_t key_len)
> >         int ret;
> >         struct tee_ioctl_invoke_arg inv_arg;
> >         struct tee_param param[4];
> > -       struct tee_shm *reg_shm =3D NULL;
> > +       struct tee_shm *shm;
> > +       void *buf;
> >
> >         memset(&inv_arg, 0, sizeof(inv_arg));
> >         memset(&param, 0, sizeof(param));
> >
> > -       reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, key, key_=
len);
> > -       if (IS_ERR(reg_shm)) {
> > -               dev_err(pvt_data.dev, "key shm register failed\n");
> > -               return PTR_ERR(reg_shm);
> > +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx, key_len);
> > +       if (IS_ERR(shm)) {
> > +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> > +               return PTR_ERR(shm);
> > +       }
> > +       buf =3D tee_shm_get_va(shm, 0);
> > +       if (IS_ERR(buf)) {
> > +               ret =3D PTR_ERR(buf);
> > +               goto out;
> >         }
> >
> >         inv_arg.func =3D TA_CMD_GET_RANDOM;
> > @@ -199,7 +202,7 @@ static int trusted_tee_get_random(unsigned char *ke=
y, size_t key_len)
> >         inv_arg.num_params =3D 4;
> >
> >         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > -       param[0].u.memref.shm =3D reg_shm;
> > +       param[0].u.memref.shm =3D shm;
> >         param[0].u.memref.size =3D key_len;
> >         param[0].u.memref.shm_offs =3D 0;
> >
> > @@ -209,18 +212,19 @@ static int trusted_tee_get_random(unsigned char *=
key, size_t key_len)
> >                         inv_arg.ret);
> >                 ret =3D -EFAULT;
> >         } else {
> > +               memcpy(key, buf, min(param[0].u.memref.size, key_len));
> >                 ret =3D param[0].u.memref.size;
> >         }
> >
> > -       tee_shm_free(reg_shm);
> > +out:
> > +       tee_shm_free(shm);
> >
> >         return ret;
> >  }
> >
> >  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const v=
oid *data)
> >  {
> > -       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE &&
> > -           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
> > +       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
> >                 return 1;
> >         else
> >                 return 0;
> > --
> > 2.34.1
> >
