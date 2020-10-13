Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A967228CC1F
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 13:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgJMLCL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 07:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgJMLCJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 07:02:09 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4810BC0613D0
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 04:02:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so21636440lfj.3
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+F5TIpvBycYxYvhVh3hVnn+ZbSdcvydLVz/6hEafIw=;
        b=Y6h6Uijgr2v4ijkpkhMVQoLSbpCR26gaKYCeqb+KSsw9ucdgLSAHMwA4i4b/ZtAgxI
         RhGOD6MM/WnLFw3RKDdawIpXbAYG5X9L2klsC6gnCtYi2tbxb05PPurw9XOYdKgIXdj+
         SNrQp3Cs/XIVDx7q7zLcN7CY/EUaekaJXdKPP7GTdQN+cvIIrUzVsDo9sahJVOrF/GWO
         wvaAhmetMoazaFpJ1IFveB+Dibb/wvFeJALDyGQLcWL6SK4HQ/mXVC+LMjfGNqhMJrbf
         IH3NWM03q74RB5Y1lMW2sjrdfaOJR62pZ5qrdTp+ktECtOHMNnCiwC52BsIzsRDmjsmC
         LCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+F5TIpvBycYxYvhVh3hVnn+ZbSdcvydLVz/6hEafIw=;
        b=QwU0+WmNoq4iBOXbFWzCigZSHW2xaMwgWT62p56m2kdgqPa8ZliG3WYOZZ+uEFN2nm
         yyt320VqqAz/BbQrqLvLVsRXyqXu8wWle9k9xHhfA1y95b1M+U0fzY0N4lJ8dTCIkZ/v
         gBTuQ+Abj8LPIFif3N7B4Ip+OvDojPtG8Q2Ppt4mggougu1g2xMDnPuqzDi6B2yNVjle
         IWcBwc8uiCsTFwuNxprGZnIYnNxQhbfpm3mC6+k7t475LaZNeB3Y7YQ7oEWYbeo3934M
         Yja7Bjjn5SWvOgOdkc7/jfTDrakM00esK8AObZe/hMYtbXzNang7i9I4LbJodBHf/z/K
         2zxg==
X-Gm-Message-State: AOAM531SzSIIhLfiDgVvGrFKmtb81tjPCIyLdXFijsZ8Ne8g23ldGjOy
        zbtmpJiU98Fge9Y8ogn+FJ+SIVVW0FqikXKZYGNK/A==
X-Google-Smtp-Source: ABdhPJz6HrmxHG8/P4Okqhij9ZwOKw4XPANKC2O6p5RY+QZHHTpRvs/6HcY6xF0zAP4ns2TIwaZ5rZeBey1CWdRLDrw=
X-Received: by 2002:a19:5cb:: with SMTP id 194mr6949698lff.205.1602586927502;
 Tue, 13 Oct 2020 04:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-3-git-send-email-sumit.garg@linaro.org> <20201013015230.GA45644@linux.intel.com>
In-Reply-To: <20201013015230.GA45644@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Oct 2020 16:31:56 +0530
Message-ID: <CAFA6WYPx0ygSttCgDqcMUzOFH8Mmi46pykFS4ZD4xVGpCeYG8Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 13 Oct 2020 at 07:22, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Oct 07, 2020 at 03:37:46PM +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key.
> >
> > Refer to Documentation/tee.txt for detailed information about TEE.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  include/keys/trusted_tee.h                |  55 ++++++
> >  security/keys/trusted-keys/Makefile       |   1 +
> >  security/keys/trusted-keys/trusted_core.c |   4 +
> >  security/keys/trusted-keys/trusted_tee.c  | 278 ++++++++++++++++++++++++++++++
> >  4 files changed, 338 insertions(+)
> >  create mode 100644 include/keys/trusted_tee.h
> >  create mode 100644 security/keys/trusted-keys/trusted_tee.c
> >
> > diff --git a/include/keys/trusted_tee.h b/include/keys/trusted_tee.h
> > new file mode 100644
> > index 0000000..2e2bb15
> > --- /dev/null
> > +++ b/include/keys/trusted_tee.h
> > @@ -0,0 +1,55 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2019-2020 Linaro Ltd.
> > + *
> > + * Author:
> > + * Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +#ifndef __TEE_TRUSTED_KEY_H
> > +#define __TEE_TRUSTED_KEY_H
> > +
> > +#include <linux/tee_drv.h>
> > +
> > +#define DRIVER_NAME "tee-trusted-key"
> > +
> > +/*
> > + * Get random data for symmetric key
> > + *
> > + * [out]     memref[0]        Random data
> > + */
> > +#define TA_CMD_GET_RANDOM    0x0
> > +
> > +/*
> > + * Seal trusted key using hardware unique key
> > + *
> > + * [in]      memref[0]        Plain key
> > + * [out]     memref[1]        Sealed key datablob
> > + */
> > +#define TA_CMD_SEAL          0x1
> > +
> > +/*
> > + * Unseal trusted key using hardware unique key
> > + *
> > + * [in]      memref[0]        Sealed key datablob
> > + * [out]     memref[1]        Plain key
> > + */
> > +#define TA_CMD_UNSEAL                0x2
> > +
> > +/**
> > + * struct trusted_key_private - TEE Trusted key private data
> > + * @dev:             TEE based Trusted key device.
> > + * @ctx:             TEE context handler.
> > + * @session_id:              Trusted key TA session identifier.
> > + * @shm_pool:                Memory pool shared with TEE device.
> > + */
> > +struct trusted_key_private {
> > +     struct device *dev;
> > +     struct tee_context *ctx;
> > +     u32 session_id;
> > +     struct tee_shm *shm_pool;
> > +};
> > +
> > +extern struct trusted_key_ops tee_trusted_key_ops;
> > +
> > +#endif
> > diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
> > index 49e3bcf..012dd78 100644
> > --- a/security/keys/trusted-keys/Makefile
> > +++ b/security/keys/trusted-keys/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
> >  trusted-y += trusted_core.o
> >  trusted-y += trusted_tpm1.o
> >  trusted-y += trusted_tpm2.o
> > +trusted-y += trusted_tee.o
> > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > index 71a5e27..74a3d80 100644
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <keys/user-type.h>
> >  #include <keys/trusted-type.h>
> > +#include <keys/trusted_tee.h>
> >  #include <keys/trusted_tpm.h>
> >  #include <linux/capability.h>
> >  #include <linux/err.h>
> > @@ -28,6 +29,9 @@ static struct trusted_key_source trusted_key_sources[] = {
> >  #if defined(CONFIG_TCG_TPM)
> >       { "tpm", &tpm_trusted_key_ops },
> >  #endif
> > +#if defined(CONFIG_TEE)
> > +     { "tee", &tee_trusted_key_ops },
> > +#endif
> >  };
> >  static struct trusted_key_ops *trusted_key_ops;
> >
> > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> > new file mode 100644
> > index 0000000..b414d52
> > --- /dev/null
> > +++ b/security/keys/trusted-keys/trusted_tee.c
> > @@ -0,0 +1,278 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019-2020 Linaro Ltd.
> > + *
> > + * Author:
> > + * Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/key-type.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/uuid.h>
> > +
> > +#include <keys/trusted-type.h>
> > +#include <keys/trusted_tee.h>
> > +
> > +static struct trusted_key_private pvt_data;
> > +
> > +/*
> > + * Have the TEE seal(encrypt) the symmetric key
> > + */
> > +static int tee_trusted_seal(struct trusted_key_payload *p, char *datablob)
>
> Use trusted_tee_* prefix.
>

Okay, so will also switch to trusted_tpm_* prefix in patch #1 too.

> > +{
> > +     int ret = 0;
>
> "int ret;"
>
> It is never used uninitialized.
>

Ack.

> > +     struct tee_ioctl_invoke_arg inv_arg;
> > +     struct tee_param param[4];
> > +     struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> > +
> > +     memset(&inv_arg, 0, sizeof(inv_arg));
> > +     memset(&param, 0, sizeof(param));
> > +
> > +     reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
> > +                                   p->key_len, TEE_SHM_DMA_BUF |
> > +                                   TEE_SHM_KERNEL_MAPPED);
> > +     if (IS_ERR(reg_shm_in)) {
> > +             dev_err(pvt_data.dev, "key shm register failed\n");
> > +             return PTR_ERR(reg_shm_in);
> > +     }
> > +
> > +     reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
> > +                                    sizeof(p->blob), TEE_SHM_DMA_BUF |
> > +                                    TEE_SHM_KERNEL_MAPPED);
> > +     if (IS_ERR(reg_shm_out)) {
> > +             dev_err(pvt_data.dev, "blob shm register failed\n");
> > +             ret = PTR_ERR(reg_shm_out);
> > +             goto out;
> > +     }
> > +
> > +     inv_arg.func = TA_CMD_SEAL;
> > +     inv_arg.session = pvt_data.session_id;
> > +     inv_arg.num_params = 4;
> > +
> > +     param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > +     param[0].u.memref.shm = reg_shm_in;
> > +     param[0].u.memref.size = p->key_len;
> > +     param[0].u.memref.shm_offs = 0;
> > +     param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > +     param[1].u.memref.shm = reg_shm_out;
> > +     param[1].u.memref.size = sizeof(p->blob);
> > +     param[1].u.memref.shm_offs = 0;
> > +
> > +     ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> > +     if ((ret < 0) || (inv_arg.ret != 0)) {
> > +             dev_err(pvt_data.dev, "TA_CMD_SEAL invoke err: %x\n",
> > +                     inv_arg.ret);
> > +             ret = -EFAULT;
> > +     } else {
> > +             p->blob_len = param[1].u.memref.size;
> > +     }
> > +
> > +out:
> > +     if (reg_shm_out)
> > +             tee_shm_free(reg_shm_out);
> > +     if (reg_shm_in)
> > +             tee_shm_free(reg_shm_in);
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * Have the TEE unseal(decrypt) the symmetric key
> > + */
> > +static int tee_trusted_unseal(struct trusted_key_payload *p, char *datablob)
> > +{
> > +     int ret = 0;
>
> Ditto.
>

Ack.

> > +     struct tee_ioctl_invoke_arg inv_arg;
> > +     struct tee_param param[4];
> > +     struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> > +
> > +     memset(&inv_arg, 0, sizeof(inv_arg));
> > +     memset(&param, 0, sizeof(param));
> > +
> > +     reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
> > +                                   p->blob_len, TEE_SHM_DMA_BUF |
> > +                                   TEE_SHM_KERNEL_MAPPED);
> > +     if (IS_ERR(reg_shm_in)) {
> > +             dev_err(pvt_data.dev, "blob shm register failed\n");
> > +             return PTR_ERR(reg_shm_in);
> > +     }
> > +
> > +     reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
> > +                                    sizeof(p->key), TEE_SHM_DMA_BUF |
> > +                                    TEE_SHM_KERNEL_MAPPED);
> > +     if (IS_ERR(reg_shm_out)) {
> > +             dev_err(pvt_data.dev, "key shm register failed\n");
> > +             ret = PTR_ERR(reg_shm_out);
> > +             goto out;
> > +     }
> > +
> > +     inv_arg.func = TA_CMD_UNSEAL;
> > +     inv_arg.session = pvt_data.session_id;
> > +     inv_arg.num_params = 4;
> > +
> > +     param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > +     param[0].u.memref.shm = reg_shm_in;
> > +     param[0].u.memref.size = p->blob_len;
> > +     param[0].u.memref.shm_offs = 0;
> > +     param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > +     param[1].u.memref.shm = reg_shm_out;
> > +     param[1].u.memref.size = sizeof(p->key);
> > +     param[1].u.memref.shm_offs = 0;
> > +
> > +     ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> > +     if ((ret < 0) || (inv_arg.ret != 0)) {
> > +             dev_err(pvt_data.dev, "TA_CMD_UNSEAL invoke err: %x\n",
> > +                     inv_arg.ret);
> > +             ret = -EFAULT;
> > +     } else {
> > +             p->key_len = param[1].u.memref.size;
> > +     }
> > +
> > +out:
> > +     if (reg_shm_out)
> > +             tee_shm_free(reg_shm_out);
> > +     if (reg_shm_in)
> > +             tee_shm_free(reg_shm_in);
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * Have the TEE generate random symmetric key
> > + */
> > +static int tee_trusted_get_random(unsigned char *key, size_t key_len)
> > +{
> > +     int ret = 0;
>
> Ditto.
>

Ack.

> > +     struct tee_ioctl_invoke_arg inv_arg;
> > +     struct tee_param param[4];
> > +     struct tee_shm *reg_shm = NULL;
> > +
> > +     memset(&inv_arg, 0, sizeof(inv_arg));
> > +     memset(&param, 0, sizeof(param));
> > +
> > +     reg_shm = tee_shm_register(pvt_data.ctx, (unsigned long)key, key_len,
> > +                                TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> > +     if (IS_ERR(reg_shm)) {
> > +             dev_err(pvt_data.dev, "key shm register failed\n");
> > +             return PTR_ERR(reg_shm);
> > +     }
> > +
> > +     inv_arg.func = TA_CMD_GET_RANDOM;
> > +     inv_arg.session = pvt_data.session_id;
> > +     inv_arg.num_params = 4;
> > +
> > +     param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > +     param[0].u.memref.shm = reg_shm;
> > +     param[0].u.memref.size = key_len;
> > +     param[0].u.memref.shm_offs = 0;
> > +
> > +     ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> > +     if ((ret < 0) || (inv_arg.ret != 0)) {
> > +             dev_err(pvt_data.dev, "TA_CMD_GET_RANDOM invoke err: %x\n",
> > +                     inv_arg.ret);
> > +             ret = -EFAULT;
> > +     } else {
> > +             ret = param[0].u.memref.size;
> > +     }
> > +
> > +     tee_shm_free(reg_shm);
> > +
> > +     return ret;
> > +}
> > +
> > +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> > +{
> > +     if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> > +             return 1;
> > +     else
> > +             return 0;
> > +}
> > +
> > +static int trusted_key_probe(struct device *dev)
> > +{
> > +     struct tee_client_device *rng_device = to_tee_client_device(dev);
> > +     int ret = 0, err = -ENODEV;
> > +     struct tee_ioctl_open_session_arg sess_arg;
>
> Ditto. I'm not sure why you need both 'ret' and 'err'.
>

Okay, will use 'ret' only.

> > +
> > +     memset(&sess_arg, 0, sizeof(sess_arg));
> > +
> > +     pvt_data.ctx = tee_client_open_context(NULL, optee_ctx_match, NULL,
> > +                                            NULL);
> > +     if (IS_ERR(pvt_data.ctx))
> > +             return -ENODEV;
> > +
> > +     memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> > +     sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> > +     sess_arg.num_params = 0;
> > +
> > +     ret = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
> > +     if ((ret < 0) || (sess_arg.ret != 0)) {
> > +             dev_err(dev, "tee_client_open_session failed, err: %x\n",
> > +                     sess_arg.ret);
> > +             err = -EINVAL;
>
> Couldn't you just overwrite 'ret'?
>

Ack.

-Sumit

> > +             goto out_ctx;
> > +     }
> > +     pvt_data.session_id = sess_arg.session;
> > +
> > +     ret = register_key_type(&key_type_trusted);
> > +     if (ret < 0)
> > +             goto out_sess;
> > +
> > +     pvt_data.dev = dev;
> > +
> > +     return 0;
> > +
> > +out_sess:
> > +     tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> > +out_ctx:
> > +     tee_client_close_context(pvt_data.ctx);
> > +
> > +     return err;
> > +}
> > +
> > +static int trusted_key_remove(struct device *dev)
> > +{
> > +     unregister_key_type(&key_type_trusted);
> > +     tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> > +     tee_client_close_context(pvt_data.ctx);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct tee_client_device_id trusted_key_id_table[] = {
> > +     {UUID_INIT(0xf04a0fe7, 0x1f5d, 0x4b9b,
> > +                0xab, 0xf7, 0x61, 0x9b, 0x85, 0xb4, 0xce, 0x8c)},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(tee, trusted_key_id_table);
> > +
> > +static struct tee_client_driver trusted_key_driver = {
> > +     .id_table       = trusted_key_id_table,
> > +     .driver         = {
> > +             .name           = DRIVER_NAME,
> > +             .bus            = &tee_bus_type,
> > +             .probe          = trusted_key_probe,
> > +             .remove         = trusted_key_remove,
> > +     },
> > +};
> > +
> > +static int __init init_tee_trusted(void)
> > +{
> > +     return driver_register(&trusted_key_driver.driver);
> > +}
> > +
> > +static void __exit exit_tee_trusted(void)
> > +{
> > +     driver_unregister(&trusted_key_driver.driver);
> > +}
> > +
> > +struct trusted_key_ops tee_trusted_key_ops = {
> > +     .migratable = 0, /* non-migratable */
> > +     .init = init_tee_trusted,
> > +     .seal = tee_trusted_seal,
> > +     .unseal = tee_trusted_unseal,
> > +     .get_random = tee_trusted_get_random,
> > +     .exit = exit_tee_trusted,
> > +};
> > --
> > 2.7.4
> >
>
> /Jarkko
