Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A342A1EA08F
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFAJMM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 05:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFAJMK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 05:12:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED365C03E96B
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 02:12:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c11so7225605ljn.2
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwsNqP++Yd0j9t4I9oB40PIam4iadToNOTNUKAoTQ1g=;
        b=hJKVyQmEF07SGCOr9O3CzEQX8qJrS0edeJBOvcLU/rW9FqxH8CrN/hgQ33p9YH4Sl1
         G89nOmE4Aqgig8d2Sz+KUM0XAzRfYIUILxO23BD+O+fU1HfbIxKXZVNgJsWBpyQlrm4O
         xyfWaxLtsax4ZF3Qlf4Yo6zpa9MK/GgnIc9P4dMReUNMqUyfH1Tq6s/TT4HjVYC62krr
         K+dAJs9vctF0mP/3bHVZN3RMCAS7fPLuta00WVWt2xPlZ0tf+kigRpYGo7ejqMDlwHds
         l+9SxjQurzyKwKhwhI2LoJMo3InwKspb3M2HGbky+LaaA8m7A4IK6jnfIBZBwpR3tp/V
         FRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwsNqP++Yd0j9t4I9oB40PIam4iadToNOTNUKAoTQ1g=;
        b=i8J7Aja2Gy3IEpK/Q4/xRYPS5oJl9Ztqv8XIiBqxgpkZPS98m7bCHnKMMqEBIWPc8f
         o3oVXuqN0OJNRg0frfmzRIAD3ka4Ji9BS5191Hpev18zuco66C0JDFs0yOx1pNIPMawZ
         0fjZJOQTkSS8mHyl7+gK76g5l8Cok1LUFq65TVRIXZQAL+uNxNb87lFsDlNgcAI87Z6g
         hor9FQFZnJoy509aZFenmdvgwee535JeAD08fNnZRWSQvWSHybwsZqfQk9zRlVHHLSEZ
         8BRKX5ddDMxtH4KTGcCAWdc6NKx66HZhf1vnNJLQklHeWp2NV64ZBFifgFtypNqwj+q1
         LZWw==
X-Gm-Message-State: AOAM533jXekTbzGHvHeAFxeg8t9OhJtgWEzQT4i9lOhcVBY89+uOYVbE
        SuVzkMWd75ziHk4miFl1osK++GJXs9ie0cFHoTc0Jw==
X-Google-Smtp-Source: ABdhPJyF3jyb0DgUyk4TAOsr8yOlh7+aM4sovihpIW+gAYZ0/X73OOz59rzsQdkysUyKCFK2Dx1kmyVyPbCuijMekSs=
X-Received: by 2002:a2e:7504:: with SMTP id q4mr9411258ljc.339.1591002728161;
 Mon, 01 Jun 2020 02:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-2-git-send-email-sumit.garg@linaro.org> <20200601021132.GA796225@linux.intel.com>
In-Reply-To: <20200601021132.GA796225@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Jun 2020 14:41:55 +0530
Message-ID: <CAFA6WYP55W2xKtjHWWwu6Pbqy2TGY=eymwAoXxQh-5mF8deR6A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>, dhowells@redhat.com,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 1 Jun 2020 at 07:41, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, May 06, 2020 at 03:10:14PM +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device as
> > an underlying implementation which makes it difficult for implementations
> > like Trusted Execution Environment (TEE) etc. to provide trusked keys
> > support in case platform doesn't posses a TPM device.
> >
> > So this patch tries to add generic trusted keys framework where underlying
> > implemtations like TPM, TEE etc. could be easily plugged-in.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  include/keys/trusted-type.h                 |  45 ++++
> >  include/keys/trusted_tpm.h                  |  15 --
> >  security/keys/trusted-keys/Makefile         |   1 +
> >  security/keys/trusted-keys/trusted_common.c | 333 +++++++++++++++++++++++++++
> >  security/keys/trusted-keys/trusted_tpm1.c   | 335 +++++-----------------------
> >  5 files changed, 437 insertions(+), 292 deletions(-)
> >  create mode 100644 security/keys/trusted-keys/trusted_common.c
> >
> > diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> > index a94c03a..5559010 100644
> > --- a/include/keys/trusted-type.h
> > +++ b/include/keys/trusted-type.h
> > @@ -40,6 +40,51 @@ struct trusted_key_options {
> >       uint32_t policyhandle;
> >  };
> >
> > +struct trusted_key_ops {
> > +     /*
> > +      * flag to indicate if trusted key implementation supports migration
> > +      * or not.
> > +      */
> > +     unsigned char migratable;
> > +
> > +     /* trusted key init */
> > +     int (*init)(void);
> > +
> > +     /* seal a trusted key */
> > +     int (*seal)(struct trusted_key_payload *p, char *datablob);
> > +
> > +     /* unseal a trusted key */
> > +     int (*unseal)(struct trusted_key_payload *p, char *datablob);
> > +
> > +     /* get random trusted key */
> > +     int (*get_random)(unsigned char *key, size_t key_len);
> > +
> > +     /* trusted key cleanup */
> > +     void (*cleanup)(void);
> > +};
> > +
> >  extern struct key_type key_type_trusted;
> > +#if defined(CONFIG_TCG_TPM)
> > +extern struct trusted_key_ops tpm_trusted_key_ops;
> > +#endif
> > +
> > +#define TRUSTED_DEBUG 0
> > +
> > +#if TRUSTED_DEBUG
> > +static inline void dump_payload(struct trusted_key_payload *p)
> > +{
> > +     pr_info("trusted_key: key_len %d\n", p->key_len);
> > +     print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> > +                    16, 1, p->key, p->key_len, 0);
> > +     pr_info("trusted_key: bloblen %d\n", p->blob_len);
> > +     print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> > +                    16, 1, p->blob, p->blob_len, 0);
> > +     pr_info("trusted_key: migratable %d\n", p->migratable);
> > +}
> > +#else
> > +static inline void dump_payload(struct trusted_key_payload *p)
> > +{
> > +}
> > +#endif
> >
> >  #endif /* _KEYS_TRUSTED_TYPE_H */
> > diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> > index a56d8e1..5753231 100644
> > --- a/include/keys/trusted_tpm.h
> > +++ b/include/keys/trusted_tpm.h
> > @@ -60,17 +60,6 @@ static inline void dump_options(struct trusted_key_options *o)
> >                      16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> >  }
> >
> > -static inline void dump_payload(struct trusted_key_payload *p)
> > -{
> > -     pr_info("trusted_key: key_len %d\n", p->key_len);
> > -     print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> > -                    16, 1, p->key, p->key_len, 0);
> > -     pr_info("trusted_key: bloblen %d\n", p->blob_len);
> > -     print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> > -                    16, 1, p->blob, p->blob_len, 0);
> > -     pr_info("trusted_key: migratable %d\n", p->migratable);
> > -}
> > -
> >  static inline void dump_sess(struct osapsess *s)
> >  {
> >       print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
> > @@ -96,10 +85,6 @@ static inline void dump_options(struct trusted_key_options *o)
> >  {
> >  }
> >
> > -static inline void dump_payload(struct trusted_key_payload *p)
> > -{
> > -}
> > -
> >  static inline void dump_sess(struct osapsess *s)
> >  {
> >  }
> > diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
> > index 7b73ceb..2b1085b 100644
> > --- a/security/keys/trusted-keys/Makefile
> > +++ b/security/keys/trusted-keys/Makefile
> > @@ -4,5 +4,6 @@
> >  #
> >
> >  obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
> > +trusted-y += trusted_common.o
> >  trusted-y += trusted_tpm1.o
> >  trusted-y += trusted_tpm2.o
> > diff --git a/security/keys/trusted-keys/trusted_common.c b/security/keys/trusted-keys/trusted_common.c
> > new file mode 100644
> > index 0000000..9bfd081
> > --- /dev/null
> > +++ b/security/keys/trusted-keys/trusted_common.c
> > @@ -0,0 +1,333 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2010 IBM Corporation
> > + * Copyright (c) 2019, Linaro Limited
> > + *
> > + * Author:
> > + * David Safford <safford@us.ibm.com>
> > + * Added generic trusted key framework: Sumit Garg <sumit.garg@linaro.org>
> > + *
> > + * See Documentation/security/keys/trusted-encrypted.rst
> > + */
> > +
> > +#include <keys/user-type.h>
> > +#include <keys/trusted-type.h>
> > +#include <linux/capability.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/key-type.h>
> > +#include <linux/module.h>
> > +#include <linux/parser.h>
> > +#include <linux/rcupdate.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/uaccess.h>
> > +
> > +static struct trusted_key_ops *available_tk_ops[] = {
> > +#if defined(CONFIG_TCG_TPM)
> > +     &tpm_trusted_key_ops,
> > +#endif
> > +};
>
> This, I think is wrong. You should have a compile time flag for TPM e.g.
> CONFIG_TRUSTED_TPM, not this dynamic mess.
>

The whole idea to have it dynamic was to have a common trusted keys
module which could support both TPM and TEE implementation depending
on hardware. I guess it may be useful in scenarios where a particular
hardware supports a TPM chip while other doesn't but both need to run
a common kernel image.

> Please make the whole choice compile time, not run-time.
>
> > +static struct trusted_key_ops *tk_ops;
> > +
> > +enum {
> > +     Opt_err,
> > +     Opt_new, Opt_load, Opt_update,
> > +};
> > +
> > +static const match_table_t key_tokens = {
> > +     {Opt_new, "new"},
> > +     {Opt_load, "load"},
> > +     {Opt_update, "update"},
> > +     {Opt_err, NULL}
> > +};
> > +
> > +/*
> > + * datablob_parse - parse the keyctl data and fill in the
> > + *                  payload structure
> > + *
> > + * On success returns 0, otherwise -EINVAL.
> > + */
> > +static int datablob_parse(char *datablob, struct trusted_key_payload *p)
> > +{
> > +     substring_t args[MAX_OPT_ARGS];
> > +     long keylen;
> > +     int ret = -EINVAL;
> > +     int key_cmd;
> > +     char *c;
> > +
> > +     /* main command */
> > +     c = strsep(&datablob, " \t");
> > +     if (!c)
> > +             return -EINVAL;
> > +     key_cmd = match_token(c, key_tokens, args);
> > +     switch (key_cmd) {
> > +     case Opt_new:
> > +             /* first argument is key size */
> > +             c = strsep(&datablob, " \t");
> > +             if (!c)
> > +                     return -EINVAL;
> > +             ret = kstrtol(c, 10, &keylen);
> > +             if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
> > +                     return -EINVAL;
> > +             p->key_len = keylen;
> > +             ret = Opt_new;
> > +             break;
> > +     case Opt_load:
> > +             /* first argument is sealed blob */
> > +             c = strsep(&datablob, " \t");
> > +             if (!c)
> > +                     return -EINVAL;
> > +             p->blob_len = strlen(c) / 2;
> > +             if (p->blob_len > MAX_BLOB_SIZE)
> > +                     return -EINVAL;
> > +             ret = hex2bin(p->blob, c, p->blob_len);
> > +             if (ret < 0)
> > +                     return -EINVAL;
> > +             ret = Opt_load;
> > +             break;
> > +     case Opt_update:
> > +             ret = Opt_update;
> > +             break;
> > +     case Opt_err:
> > +             return -EINVAL;
> > +     }
> > +     return ret;
> > +}
> > +
> > +static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
> > +{
> > +     struct trusted_key_payload *p = NULL;
> > +     int ret;
> > +
> > +     ret = key_payload_reserve(key, sizeof(*p));
> > +     if (ret < 0)
> > +             return p;
> > +     p = kzalloc(sizeof(*p), GFP_KERNEL);
> > +
> > +     p->migratable = tk_ops->migratable;
> > +
> > +     return p;
> > +}
> > +
> > +/*
> > + * trusted_instantiate - create a new trusted key
> > + *
> > + * Unseal an existing trusted blob or, for a new key, get a
> > + * random key, then seal and create a trusted key-type key,
> > + * adding it to the specified keyring.
> > + *
> > + * On success, return 0. Otherwise return errno.
> > + */
> > +static int trusted_instantiate(struct key *key,
> > +                            struct key_preparsed_payload *prep)
> > +{
> > +     struct trusted_key_payload *payload = NULL;
> > +     size_t datalen = prep->datalen;
> > +     char *datablob;
> > +     int ret = 0;
> > +     int key_cmd;
> > +     size_t key_len;
> > +
> > +     if (datalen <= 0 || datalen > 32767 || !prep->data)
> > +             return -EINVAL;
> > +
> > +     datablob = kmalloc(datalen + 1, GFP_KERNEL);
> > +     if (!datablob)
> > +             return -ENOMEM;
> > +     memcpy(datablob, prep->data, datalen);
> > +     datablob[datalen] = '\0';
> > +
> > +     payload = trusted_payload_alloc(key);
> > +     if (!payload) {
> > +             ret = -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     key_cmd = datablob_parse(datablob, payload);
> > +     if (key_cmd < 0) {
> > +             ret = key_cmd;
> > +             goto out;
> > +     }
> > +
> > +     dump_payload(payload);
> > +
> > +     switch (key_cmd) {
> > +     case Opt_load:
> > +             ret = tk_ops->unseal(payload, datablob);
> > +             dump_payload(payload);
> > +             if (ret < 0)
> > +                     pr_info("trusted_key: key_unseal failed (%d)\n", ret);
> > +             break;
> > +     case Opt_new:
> > +             key_len = payload->key_len;
> > +             ret = tk_ops->get_random(payload->key, key_len);
> > +             if (ret != key_len) {
> > +                     pr_info("trusted_key: key_create failed (%d)\n", ret);
> > +                     goto out;
> > +             }
> > +
> > +             ret = tk_ops->seal(payload, datablob);
> > +             if (ret < 0)
> > +                     pr_info("trusted_key: key_seal failed (%d)\n", ret);
> > +             break;
> > +     default:
> > +             ret = -EINVAL;
> > +     }
> > +out:
> > +     kzfree(datablob);
> > +     if (!ret)
> > +             rcu_assign_keypointer(key, payload);
> > +     else
> > +             kzfree(payload);
> > +     return ret;
> > +}
> > +
> > +static void trusted_rcu_free(struct rcu_head *rcu)
> > +{
> > +     struct trusted_key_payload *p;
> > +
> > +     p = container_of(rcu, struct trusted_key_payload, rcu);
> > +     kzfree(p);
> > +}
> > +
> > +/*
> > + * trusted_update - reseal an existing key with new PCR values
> > + */
> > +static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
> > +{
> > +     struct trusted_key_payload *p;
> > +     struct trusted_key_payload *new_p;
> > +     size_t datalen = prep->datalen;
> > +     char *datablob;
> > +     int ret = 0;
> > +
> > +     if (key_is_negative(key))
> > +             return -ENOKEY;
> > +     p = key->payload.data[0];
> > +     if (!p->migratable)
> > +             return -EPERM;
> > +     if (datalen <= 0 || datalen > 32767 || !prep->data)
> > +             return -EINVAL;
> > +
> > +     datablob = kmalloc(datalen + 1, GFP_KERNEL);
> > +     if (!datablob)
> > +             return -ENOMEM;
> > +
> > +     new_p = trusted_payload_alloc(key);
> > +     if (!new_p) {
> > +             ret = -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     memcpy(datablob, prep->data, datalen);
> > +     datablob[datalen] = '\0';
> > +     ret = datablob_parse(datablob, new_p);
> > +     if (ret != Opt_update) {
> > +             ret = -EINVAL;
> > +             kzfree(new_p);
> > +             goto out;
> > +     }
> > +
> > +     /* copy old key values, and reseal with new pcrs */
> > +     new_p->migratable = p->migratable;
> > +     new_p->key_len = p->key_len;
> > +     memcpy(new_p->key, p->key, p->key_len);
> > +     dump_payload(p);
> > +     dump_payload(new_p);
> > +
> > +     ret = tk_ops->seal(new_p, datablob);
> > +     if (ret < 0) {
> > +             pr_info("trusted_key: key_seal failed (%d)\n", ret);
> > +             kzfree(new_p);
> > +             goto out;
> > +     }
> > +
> > +     rcu_assign_keypointer(key, new_p);
> > +     call_rcu(&p->rcu, trusted_rcu_free);
> > +out:
> > +     kzfree(datablob);
> > +     return ret;
> > +}
> > +
> > +/*
> > + * trusted_read - copy the sealed blob data to userspace in hex.
> > + * On success, return to userspace the trusted key datablob size.
> > + */
> > +static long trusted_read(const struct key *key, char *buffer,
> > +                      size_t buflen)
> > +{
> > +     const struct trusted_key_payload *p;
> > +     char *bufp;
> > +     int i;
> > +
> > +     p = dereference_key_locked(key);
> > +     if (!p)
> > +             return -EINVAL;
> > +
> > +     if (buffer && buflen >= 2 * p->blob_len) {
> > +             bufp = buffer;
> > +             for (i = 0; i < p->blob_len; i++)
> > +                     bufp = hex_byte_pack(bufp, p->blob[i]);
> > +     }
> > +     return 2 * p->blob_len;
> > +}
> > +
> > +/*
> > + * trusted_destroy - clear and free the key's payload
> > + */
> > +static void trusted_destroy(struct key *key)
> > +{
> > +     kzfree(key->payload.data[0]);
> > +}
> > +
> > +struct key_type key_type_trusted = {
> > +     .name = "trusted",
> > +     .instantiate = trusted_instantiate,
> > +     .update = trusted_update,
> > +     .destroy = trusted_destroy,
> > +     .describe = user_describe,
> > +     .read = trusted_read,
> > +};
> > +EXPORT_SYMBOL_GPL(key_type_trusted);
> > +
> > +static int __init init_trusted(void)
> > +{
> > +     int i, ret = 0;
> > +
> > +     for (i = 0; i < sizeof(available_tk_ops); i++) {
> > +             tk_ops = available_tk_ops[i];
> > +
> > +             if (!(tk_ops && tk_ops->init && tk_ops->seal &&
> > +                   tk_ops->unseal && tk_ops->get_random))
> > +                     continue;
>
> This check should not exist as there is no legit case for any of these
> callbacks missing. Please remove it.

Okay.

>
> > +
> > +             ret = tk_ops->init();
> > +             if (ret) {
> > +                     if (tk_ops->cleanup)
> > +                             tk_ops->cleanup();
>
> Why is clean up called? What is "clean up"? Init should take care clean
> up its dirt if it fails. Please remove the calll to clean up from here.

Makes sense, will remove it.

-Sumit

>
> /Jarkko
