Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0252131BA17
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 14:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBONOn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 08:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhBONOd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 08:14:33 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1646C061786
        for <linux-integrity@vger.kernel.org>; Mon, 15 Feb 2021 05:13:51 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q186so3724997oig.12
        for <linux-integrity@vger.kernel.org>; Mon, 15 Feb 2021 05:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBo9Cxl28dznBT/RVTl7eLvHKAuuMYlBGnpoCff7L8Y=;
        b=fkXrq16otCg7CtmUV5/xiYD6mXBBZnIb74x+m8o+1UjBzCRuJFmJGyhbNomrm6UG5q
         Ke8tfq59IVrwbY5TZP67NEulRsBgGfHjAtJS7aPL9MDiBLLoZylXsZ5Cst79V2HjUhEA
         yQhbEgs8DrovJ01hiMNE8jD05TXGsdKYPqhRcoe6gjM+oMJR0B545Jx327v+IYKDiffW
         30r4U3/bsrFNkjYDRGKgdSLXdcp6rywPllpre6KdvHqijcKfmpOJrGht8H+VWA+evgDv
         OdBsOGO63KSM0+uP3HUC0gbBClpSC0xTr6Mkx8qFQAO0ivGeNtm8Hy+X9OAOp9hRNJXo
         FJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBo9Cxl28dznBT/RVTl7eLvHKAuuMYlBGnpoCff7L8Y=;
        b=r4opJAIq5WNqYi1l+6/tjL7Q0qRQzk+LGW+NFeoLhrDpOAgZX34I1z/7WzeNjJM9ZO
         7ox6XRI2oKkL+weAwePMEuNF/u3EwMRya0W3Z6PlCIyZ9oK80C+4JLsEoY4v2gn9afLS
         F7wFCF8xZK8t4eZQCH8tdA8jdnvwtHfagcHLORBjJqME0XsVmUnMTyyWBqpZCT0GEGpi
         Fpx2VGid31X7v7SMupII3v/sMdF/M5bNcsBe5nikwkRUBpURQnEFQgi+/6isnZXcBd5/
         ExNBzbgqP2nWdh2TO5Y+wmgQj1MmJYjHf4I2xbMT7iwDH+CaWmM7ZUowgknIs0B2cmvp
         lXbA==
X-Gm-Message-State: AOAM5307zLvuPawwBcW3cCPb67tJHY3wRssiWGM7nq5ISOTEQkte236u
        060txb0EcQ1+DFY1QQAvX8LU6zSVGn/d4iOpvc0B6A==
X-Google-Smtp-Source: ABdhPJwqF3WWwkXXKWDnlkb3X45bA4WU3EZsd9yX0xTEEFaKwuCpTyWlYmZcTUiHg7vu5+qAk+q72Ay73GSLyByieY4=
X-Received: by 2002:aca:75d5:: with SMTP id q204mr8313357oic.152.1613394830673;
 Mon, 15 Feb 2021 05:13:50 -0800 (PST)
MIME-Version: 1.0
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-2-git-send-email-sumit.garg@linaro.org> <20201124034241.GA40379@kernel.org>
In-Reply-To: <20201124034241.GA40379@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 15 Feb 2021 18:43:39 +0530
Message-ID: <CAFA6WYMt2nyNwAWijb__7DPDpqY8xHH5PFHog87B=N+L_uDnKQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 24 Nov 2020 at 09:12, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device as
> > an underlying implementation which makes it difficult for implementations
> > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > support in case platform doesn't posses a TPM device.
> >
> > Add a generic trusted keys framework where underlying implementations
> > can be easily plugged in. Create struct trusted_key_ops to achieve this,
> > which contains necessary functions of a backend.
> >
> > Also, define a module parameter in order to select a particular trust
> > source in case a platform support multiple trust sources. In case its
> > not specified then implementation itetrates through trust sources list
> > starting with TPM and assign the first trust source as a backend which
> > has initiazed successfully during iteration.
> >
> > Note that current implementation only supports a single trust source at
> > runtime which is either selectable at compile time or during boot via
> > aforementioned module parameter.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  12 +
> >  include/keys/trusted-type.h                     |  47 ++++
>
>
>
> >  include/keys/trusted_tpm.h                      |  17 +-
> >  security/keys/trusted-keys/Makefile             |   1 +
> >  security/keys/trusted-keys/trusted_core.c       | 350 ++++++++++++++++++++++++
> >  security/keys/trusted-keys/trusted_tpm1.c       | 336 ++++-------------------
> >  6 files changed, 468 insertions(+), 295 deletions(-)
> >  create mode 100644 security/keys/trusted-keys/trusted_core.c
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 526d65d..df9b9fe 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5392,6 +5392,18 @@
> >                       See Documentation/admin-guide/mm/transhuge.rst
> >                       for more details.
> >
> > +     trusted.source= [KEYS]
> > +                     Format: <string>
> > +                     This parameter identifies the trust source as a backend
> > +                     for trusted keys implementation. Supported trust
> > +                     sources:
> > +                     - "tpm"
> > +                     - "tee"
> > +                     If not specified then it defaults to iterating through
> > +                     the trust source list starting with TPM and assigns the
> > +                     first trust source as a backend which is initialized
> > +                     successfully during iteration.
> > +
> >       tsc=            Disable clocksource stability checks for TSC.
> >                       Format: <string>
> >                       [x86] reliable: mark tsc clocksource as reliable, this
> > diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> > index a94c03a..a566451 100644
> > --- a/include/keys/trusted-type.h
> > +++ b/include/keys/trusted-type.h
> > @@ -40,6 +40,53 @@ struct trusted_key_options {
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
> > +     /* Initialize key interface. */
> > +     int (*init)(void);
> > +
> > +     /* Seal a key. */
> > +     int (*seal)(struct trusted_key_payload *p, char *datablob);
> > +
> > +     /* Unseal a key. */
> > +     int (*unseal)(struct trusted_key_payload *p, char *datablob);
> > +
> > +     /* Get a randomized key. */
> > +     int (*get_random)(unsigned char *key, size_t key_len);
> > +
> > +     /* Exit key interface. */
> > +     void (*exit)(void);
> > +};
> > +
> > +struct trusted_key_source {
> > +     char *name;
> > +     struct trusted_key_ops *ops;
> > +};
> > +
> >  extern struct key_type key_type_trusted;
> >
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
> > +
> >  #endif /* _KEYS_TRUSTED_TYPE_H */
> > diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> > index a56d8e1..fb3280a 100644
> > --- a/include/keys/trusted_tpm.h
> > +++ b/include/keys/trusted_tpm.h
> > @@ -16,6 +16,8 @@
> >  #define LOAD32N(buffer, offset)      (*(uint32_t *)&buffer[offset])
> >  #define LOAD16(buffer, offset)       (ntohs(*(uint16_t *)&buffer[offset]))
> >
> > +extern struct trusted_key_ops tpm_trusted_key_ops;
> > +
> >  struct osapsess {
> >       uint32_t handle;
> >       unsigned char secret[SHA1_DIGEST_SIZE];
> > @@ -60,17 +62,6 @@ static inline void dump_options(struct trusted_key_options *o)
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
> > @@ -96,10 +87,6 @@ static inline void dump_options(struct trusted_key_options *o)
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
> > index 7b73ceb..49e3bcf 100644
> > --- a/security/keys/trusted-keys/Makefile
> > +++ b/security/keys/trusted-keys/Makefile
> > @@ -4,5 +4,6 @@
> >  #
> >
> >  obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
> > +trusted-y += trusted_core.o
> >  trusted-y += trusted_tpm1.o
> >  trusted-y += trusted_tpm2.o
> > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > new file mode 100644
> > index 0000000..aa4f2a0
> > --- /dev/null
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -0,0 +1,350 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2010 IBM Corporation
> > + * Copyright (c) 2019-2020, Linaro Limited
> > + *
> > + * See Documentation/security/keys/trusted-encrypted.rst
> > + */
> > +
> > +#include <keys/user-type.h>
> > +#include <keys/trusted-type.h>
> > +#include <keys/trusted_tpm.h>
> > +#include <linux/capability.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/key-type.h>
> > +#include <linux/module.h>
> > +#include <linux/parser.h>
> > +#include <linux/rcupdate.h>
> > +#include <linux/slab.h>
> > +#include <linux/static_call.h>
> > +#include <linux/string.h>
> > +#include <linux/uaccess.h>
> > +
> > +static char *trusted_key_source;
> > +module_param_named(source, trusted_key_source, charp, 0);
> > +MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
> > +
> > +static const struct trusted_key_source trusted_key_sources[] = {
> > +#if defined(CONFIG_TCG_TPM)
> > +     { "tpm", &tpm_trusted_key_ops },
> > +#endif
> > +};
> > +
> > +DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
> > +DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
> > +DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
> > +                     *trusted_key_sources[0].ops->unseal);
> > +DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
> > +                     *trusted_key_sources[0].ops->get_random);
> > +DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
> > +static unsigned char migratable;
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
> > +     p->migratable = migratable;
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
> > +             ret = static_call(trusted_key_unseal)(payload, datablob);
> > +             dump_payload(payload);
> > +             if (ret < 0)
> > +                     pr_info("trusted_key: key_unseal failed (%d)\n", ret);
> > +             break;
> > +     case Opt_new:
> > +             key_len = payload->key_len;
> > +             ret = static_call(trusted_key_get_random)(payload->key,
> > +                                                       key_len);
> > +             if (ret != key_len) {
> > +                     pr_info("trusted_key: key_create failed (%d)\n", ret);
> > +                     goto out;
> > +             }
> > +
> > +             ret = static_call(trusted_key_seal)(payload, datablob);
> > +             if (ret < 0)
> > +                     pr_info("trusted_key: key_seal failed (%d)\n", ret);
> > +             break;
> > +     default:
> > +             ret = -EINVAL;
> > +     }
> > +out:
> > +     kfree_sensitive(datablob);
> > +     if (!ret)
> > +             rcu_assign_keypointer(key, payload);
> > +     else
> > +             kfree_sensitive(payload);
> > +     return ret;
> > +}
> > +
> > +static void trusted_rcu_free(struct rcu_head *rcu)
> > +{
> > +     struct trusted_key_payload *p;
> > +
> > +     p = container_of(rcu, struct trusted_key_payload, rcu);
> > +     kfree_sensitive(p);
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
> > +             kfree_sensitive(new_p);
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
> > +     ret = static_call(trusted_key_seal)(new_p, datablob);
> > +     if (ret < 0) {
> > +             pr_info("trusted_key: key_seal failed (%d)\n", ret);
> > +             kfree_sensitive(new_p);
> > +             goto out;
> > +     }
> > +
> > +     rcu_assign_keypointer(key, new_p);
> > +     call_rcu(&p->rcu, trusted_rcu_free);
> > +out:
> > +     kfree_sensitive(datablob);
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
> > +     kfree_sensitive(key->payload.data[0]);
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
> > +     for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > +             if (trusted_key_source &&
> > +                 strncmp(trusted_key_source, trusted_key_sources[i].name,
> > +                         strlen(trusted_key_sources[i].name)))
> > +                     continue;
> > +
> > +             static_call_update(trusted_key_init,
> > +                                trusted_key_sources[i].ops->init);
> > +             static_call_update(trusted_key_seal,
> > +                                trusted_key_sources[i].ops->seal);
> > +             static_call_update(trusted_key_unseal,
> > +                                trusted_key_sources[i].ops->unseal);
> > +             static_call_update(trusted_key_get_random,
> > +                                trusted_key_sources[i].ops->get_random);
> > +             static_call_update(trusted_key_exit,
> > +                                trusted_key_sources[i].ops->exit);
> > +             migratable = trusted_key_sources[i].ops->migratable;
> > +
> > +             ret = static_call(trusted_key_init)();
> > +             if (!ret)
> > +                     break;
> > +     }
> > +
> > +     /*
> > +      * encrypted_keys.ko depends on successful load of this module even if
> > +      * trusted key implementation is not found.
> > +      */
> > +     if (ret == -ENODEV)
> > +             return 0;
> > +
> > +     return ret;
> > +}
> > +
> > +static void __exit cleanup_trusted(void)
> > +{
> > +     static_call(trusted_key_exit)();
> > +}
> > +
> > +late_initcall(init_trusted);
> > +module_exit(cleanup_trusted);
> > +
> > +MODULE_LICENSE("GPL");
> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > index b9fe02e..bd03914 100644
> > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > @@ -1,29 +1,22 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * Copyright (C) 2010 IBM Corporation
> > - *
> > - * Author:
> > - * David Safford <safford@us.ibm.com>
> > + * Copyright (c) 2019-2020, Linaro Limited
> >   *
> >   * See Documentation/security/keys/trusted-encrypted.rst
> >   */
> >
> >  #include <crypto/hash_info.h>
> > -#include <linux/uaccess.h>
> > -#include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/slab.h>
> >  #include <linux/parser.h>
> >  #include <linux/string.h>
> >  #include <linux/err.h>
> > -#include <keys/user-type.h>
> >  #include <keys/trusted-type.h>
> >  #include <linux/key-type.h>
> > -#include <linux/rcupdate.h>
> >  #include <linux/crypto.h>
> >  #include <crypto/hash.h>
> >  #include <crypto/sha.h>
> > -#include <linux/capability.h>
> >  #include <linux/tpm.h>
> >  #include <linux/tpm_command.h>
> >
> > @@ -703,7 +696,6 @@ static int key_unseal(struct trusted_key_payload *p,
> >
> >  enum {
> >       Opt_err,
> > -     Opt_new, Opt_load, Opt_update,
> >       Opt_keyhandle, Opt_keyauth, Opt_blobauth,
> >       Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
> >       Opt_hash,
> > @@ -712,9 +704,6 @@ enum {
> >  };
> >
> >  static const match_table_t key_tokens = {
> > -     {Opt_new, "new"},
> > -     {Opt_load, "load"},
> > -     {Opt_update, "update"},
> >       {Opt_keyhandle, "keyhandle=%s"},
> >       {Opt_keyauth, "keyauth=%s"},
> >       {Opt_blobauth, "blobauth=%s"},
> > @@ -841,71 +830,6 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
> >       return 0;
> >  }
> >
> > -/*
> > - * datablob_parse - parse the keyctl data and fill in the
> > - *               payload and options structures
> > - *
> > - * On success returns 0, otherwise -EINVAL.
> > - */
> > -static int datablob_parse(char *datablob, struct trusted_key_payload *p,
> > -                       struct trusted_key_options *o)
> > -{
> > -     substring_t args[MAX_OPT_ARGS];
> > -     long keylen;
> > -     int ret = -EINVAL;
> > -     int key_cmd;
> > -     char *c;
> > -
> > -     /* main command */
> > -     c = strsep(&datablob, " \t");
> > -     if (!c)
> > -             return -EINVAL;
> > -     key_cmd = match_token(c, key_tokens, args);
> > -     switch (key_cmd) {
> > -     case Opt_new:
> > -             /* first argument is key size */
> > -             c = strsep(&datablob, " \t");
> > -             if (!c)
> > -                     return -EINVAL;
> > -             ret = kstrtol(c, 10, &keylen);
> > -             if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
> > -                     return -EINVAL;
> > -             p->key_len = keylen;
> > -             ret = getoptions(datablob, p, o);
> > -             if (ret < 0)
> > -                     return ret;
> > -             ret = Opt_new;
> > -             break;
> > -     case Opt_load:
> > -             /* first argument is sealed blob */
> > -             c = strsep(&datablob, " \t");
> > -             if (!c)
> > -                     return -EINVAL;
> > -             p->blob_len = strlen(c) / 2;
> > -             if (p->blob_len > MAX_BLOB_SIZE)
> > -                     return -EINVAL;
> > -             ret = hex2bin(p->blob, c, p->blob_len);
> > -             if (ret < 0)
> > -                     return -EINVAL;
> > -             ret = getoptions(datablob, p, o);
> > -             if (ret < 0)
> > -                     return ret;
> > -             ret = Opt_load;
> > -             break;
> > -     case Opt_update:
> > -             /* all arguments are options */
> > -             ret = getoptions(datablob, p, o);
> > -             if (ret < 0)
> > -                     return ret;
> > -             ret = Opt_update;
> > -             break;
> > -     case Opt_err:
> > -             return -EINVAL;
> > -             break;
> > -     }
> > -     return ret;
> > -}
> > -
> >  static struct trusted_key_options *trusted_options_alloc(void)
> >  {
> >       struct trusted_key_options *options;
> > @@ -926,248 +850,99 @@ static struct trusted_key_options *trusted_options_alloc(void)
> >       return options;
> >  }
> >
> > -static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
> > +static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
> >  {
> > -     struct trusted_key_payload *p = NULL;
> > -     int ret;
> > -
> > -     ret = key_payload_reserve(key, sizeof *p);
> > -     if (ret < 0)
> > -             return p;
> > -     p = kzalloc(sizeof *p, GFP_KERNEL);
> > -     if (p)
> > -             p->migratable = 1; /* migratable by default */
> > -     return p;
> > -}
> > -
> > -/*
> > - * trusted_instantiate - create a new trusted key
> > - *
> > - * Unseal an existing trusted blob or, for a new key, get a
> > - * random key, then seal and create a trusted key-type key,
> > - * adding it to the specified keyring.
> > - *
> > - * On success, return 0. Otherwise return errno.
> > - */
> > -static int trusted_instantiate(struct key *key,
> > -                            struct key_preparsed_payload *prep)
> > -{
> > -     struct trusted_key_payload *payload = NULL;
> >       struct trusted_key_options *options = NULL;
> > -     size_t datalen = prep->datalen;
> > -     char *datablob;
> >       int ret = 0;
> > -     int key_cmd;
> > -     size_t key_len;
> >       int tpm2;
> >
> >       tpm2 = tpm_is_tpm2(chip);
> >       if (tpm2 < 0)
> >               return tpm2;
> >
> > -     if (datalen <= 0 || datalen > 32767 || !prep->data)
> > -             return -EINVAL;
> > -
> > -     datablob = kmalloc(datalen + 1, GFP_KERNEL);
> > -     if (!datablob)
> > -             return -ENOMEM;
> > -     memcpy(datablob, prep->data, datalen);
> > -     datablob[datalen] = '\0';
> > -
> >       options = trusted_options_alloc();
> > -     if (!options) {
> > -             ret = -ENOMEM;
> > -             goto out;
> > -     }
> > -     payload = trusted_payload_alloc(key);
> > -     if (!payload) {
> > -             ret = -ENOMEM;
> > -             goto out;
> > -     }
> > +     if (!options)
> > +             return -ENOMEM;
> >
> > -     key_cmd = datablob_parse(datablob, payload, options);
> > -     if (key_cmd < 0) {
> > -             ret = key_cmd;
> > +     ret = getoptions(datablob, p, options);
> > +     if (ret < 0)
> >               goto out;
> > -     }
> > +     dump_options(options);
> >
> >       if (!options->keyhandle) {
> >               ret = -EINVAL;
> >               goto out;
> >       }
> >
> > -     dump_payload(payload);
> > -     dump_options(options);
> > +     if (tpm2)
> > +             ret = tpm2_seal_trusted(chip, p, options);
> > +     else
> > +             ret = key_seal(p, options);
> > +     if (ret < 0) {
> > +             pr_info("tpm_trusted_key: key_seal failed (%d)\n", ret);
> > +             goto out;
> > +     }
> >
> > -     switch (key_cmd) {
> > -     case Opt_load:
> > -             if (tpm2)
> > -                     ret = tpm2_unseal_trusted(chip, payload, options);
> > -             else
> > -                     ret = key_unseal(payload, options);
> > -             dump_payload(payload);
> > -             dump_options(options);
> > -             if (ret < 0)
> > -                     pr_info("trusted_key: key_unseal failed (%d)\n", ret);
> > -             break;
> > -     case Opt_new:
> > -             key_len = payload->key_len;
> > -             ret = tpm_get_random(chip, payload->key, key_len);
> > -             if (ret != key_len) {
> > -                     pr_info("trusted_key: key_create failed (%d)\n", ret);
> > +     if (options->pcrlock) {
> > +             ret = pcrlock(options->pcrlock);
> > +             if (ret < 0) {
> > +                     pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
> >                       goto out;
> >               }
> > -             if (tpm2)
> > -                     ret = tpm2_seal_trusted(chip, payload, options);
> > -             else
> > -                     ret = key_seal(payload, options);
> > -             if (ret < 0)
> > -                     pr_info("trusted_key: key_seal failed (%d)\n", ret);
> > -             break;
> > -     default:
> > -             ret = -EINVAL;
> > -             goto out;
> >       }
> > -     if (!ret && options->pcrlock)
> > -             ret = pcrlock(options->pcrlock);
> >  out:
> > -     kfree_sensitive(datablob);
> >       kfree_sensitive(options);
> > -     if (!ret)
> > -             rcu_assign_keypointer(key, payload);
> > -     else
> > -             kfree_sensitive(payload);
> >       return ret;
> >  }
> >
> > -static void trusted_rcu_free(struct rcu_head *rcu)
> > -{
> > -     struct trusted_key_payload *p;
> > -
> > -     p = container_of(rcu, struct trusted_key_payload, rcu);
> > -     kfree_sensitive(p);
> > -}
> > -
> > -/*
> > - * trusted_update - reseal an existing key with new PCR values
> > - */
> > -static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
> > +static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
> >  {
> > -     struct trusted_key_payload *p;
> > -     struct trusted_key_payload *new_p;
> > -     struct trusted_key_options *new_o;
> > -     size_t datalen = prep->datalen;
> > -     char *datablob;
> > +     struct trusted_key_options *options = NULL;
> >       int ret = 0;
> > +     int tpm2;
> >
> > -     if (key_is_negative(key))
> > -             return -ENOKEY;
> > -     p = key->payload.data[0];
> > -     if (!p->migratable)
> > -             return -EPERM;
> > -     if (datalen <= 0 || datalen > 32767 || !prep->data)
> > -             return -EINVAL;
> > +     tpm2 = tpm_is_tpm2(chip);
> > +     if (tpm2 < 0)
> > +             return tpm2;
> >
> > -     datablob = kmalloc(datalen + 1, GFP_KERNEL);
> > -     if (!datablob)
> > +     options = trusted_options_alloc();
> > +     if (!options)
> >               return -ENOMEM;
> > -     new_o = trusted_options_alloc();
> > -     if (!new_o) {
> > -             ret = -ENOMEM;
> > -             goto out;
> > -     }
> > -     new_p = trusted_payload_alloc(key);
> > -     if (!new_p) {
> > -             ret = -ENOMEM;
> > -             goto out;
> > -     }
> >
> > -     memcpy(datablob, prep->data, datalen);
> > -     datablob[datalen] = '\0';
> > -     ret = datablob_parse(datablob, new_p, new_o);
> > -     if (ret != Opt_update) {
> > -             ret = -EINVAL;
> > -             kfree_sensitive(new_p);
> > +     ret = getoptions(datablob, p, options);
> > +     if (ret < 0)
> >               goto out;
> > -     }
> > +     dump_options(options);
> >
> > -     if (!new_o->keyhandle) {
> > +     if (!options->keyhandle) {
> >               ret = -EINVAL;
> > -             kfree_sensitive(new_p);
> >               goto out;
> >       }
> >
> > -     /* copy old key values, and reseal with new pcrs */
> > -     new_p->migratable = p->migratable;
> > -     new_p->key_len = p->key_len;
> > -     memcpy(new_p->key, p->key, p->key_len);
> > -     dump_payload(p);
> > -     dump_payload(new_p);
> > +     if (tpm2)
> > +             ret = tpm2_unseal_trusted(chip, p, options);
> > +     else
> > +             ret = key_unseal(p, options);
> > +     if (ret < 0)
> > +             pr_info("tpm_trusted_key: key_unseal failed (%d)\n", ret);
> >
> > -     ret = key_seal(new_p, new_o);
> > -     if (ret < 0) {
> > -             pr_info("trusted_key: key_seal failed (%d)\n", ret);
> > -             kfree_sensitive(new_p);
> > -             goto out;
> > -     }
> > -     if (new_o->pcrlock) {
> > -             ret = pcrlock(new_o->pcrlock);
> > +     if (options->pcrlock) {
> > +             ret = pcrlock(options->pcrlock);
> >               if (ret < 0) {
> > -                     pr_info("trusted_key: pcrlock failed (%d)\n", ret);
> > -                     kfree_sensitive(new_p);
> > +                     pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
> >                       goto out;
> >               }
> >       }
> > -     rcu_assign_keypointer(key, new_p);
> > -     call_rcu(&p->rcu, trusted_rcu_free);
> >  out:
> > -     kfree_sensitive(datablob);
> > -     kfree_sensitive(new_o);
> > +     kfree_sensitive(options);
> >       return ret;
> >  }
> >
> > -/*
> > - * trusted_read - copy the sealed blob data to userspace in hex.
> > - * On success, return to userspace the trusted key datablob size.
> > - */
> > -static long trusted_read(const struct key *key, char *buffer,
> > -                      size_t buflen)
> > -{
> > -     const struct trusted_key_payload *p;
> > -     char *bufp;
> > -     int i;
> > -
> > -     p = dereference_key_locked(key);
> > -     if (!p)
> > -             return -EINVAL;
> > -
> > -     if (buffer && buflen >= 2 * p->blob_len) {
> > -             bufp = buffer;
> > -             for (i = 0; i < p->blob_len; i++)
> > -                     bufp = hex_byte_pack(bufp, p->blob[i]);
> > -     }
> > -     return 2 * p->blob_len;
> > -}
> > -
> > -/*
> > - * trusted_destroy - clear and free the key's payload
> > - */
> > -static void trusted_destroy(struct key *key)
> > +static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
> >  {
> > -     kfree_sensitive(key->payload.data[0]);
> > +     return tpm_get_random(chip, key, key_len);
> >  }
> >
> > -struct key_type key_type_trusted = {
> > -     .name = "trusted",
> > -     .instantiate = trusted_instantiate,
> > -     .update = trusted_update,
> > -     .destroy = trusted_destroy,
> > -     .describe = user_describe,
> > -     .read = trusted_read,
> > -};
> > -
> > -EXPORT_SYMBOL_GPL(key_type_trusted);
> > -
> >  static void trusted_shash_release(void)
> >  {
> >       if (hashalg)
> > @@ -1182,14 +957,14 @@ static int __init trusted_shash_alloc(void)
> >
> >       hmacalg = crypto_alloc_shash(hmac_alg, 0, 0);
> >       if (IS_ERR(hmacalg)) {
> > -             pr_info("trusted_key: could not allocate crypto %s\n",
> > +             pr_info("tpm_trusted_key: could not allocate crypto %s\n",
> >                       hmac_alg);
> >               return PTR_ERR(hmacalg);
> >       }
> >
> >       hashalg = crypto_alloc_shash(hash_alg, 0, 0);
> >       if (IS_ERR(hashalg)) {
> > -             pr_info("trusted_key: could not allocate crypto %s\n",
> > +             pr_info("tpm_trusted_key: could not allocate crypto %s\n",
>
> Let's just add interal trusted.h file with:
>
> #undef pr_fmt
> #define pr_fmt(fmt) "trusted_key: " fmt
>
> and remove tags from these. Does not add value to have separate tags
> for backends. Makes the klog only a bit messier I think.
>

Okay makes sense, will do this in the next version.

-Sumit

>
> >                       hash_alg);
> >               ret = PTR_ERR(hashalg);
> >               goto hashalg_fail;
> > @@ -1217,16 +992,13 @@ static int __init init_digests(void)
> >       return 0;
> >  }
> >
> > -static int __init init_trusted(void)
> > +static int trusted_tpm_init(void)
> >  {
> >       int ret;
> >
> > -     /* encrypted_keys.ko depends on successful load of this module even if
> > -      * TPM is not used.
> > -      */
> >       chip = tpm_default_chip();
> >       if (!chip)
> > -             return 0;
> > +             return -ENODEV;
> >
> >       ret = init_digests();
> >       if (ret < 0)
> > @@ -1247,7 +1019,7 @@ static int __init init_trusted(void)
> >       return ret;
> >  }
> >
> > -static void __exit cleanup_trusted(void)
> > +static void trusted_tpm_exit(void)
> >  {
> >       if (chip) {
> >               put_device(&chip->dev);
> > @@ -1257,7 +1029,11 @@ static void __exit cleanup_trusted(void)
> >       }
> >  }
> >
> > -late_initcall(init_trusted);
> > -module_exit(cleanup_trusted);
> > -
> > -MODULE_LICENSE("GPL");
> > +struct trusted_key_ops tpm_trusted_key_ops = {
> > +     .migratable = 1, /* migratable by default */
> > +     .init = trusted_tpm_init,
> > +     .seal = trusted_tpm_seal,
> > +     .unseal = trusted_tpm_unseal,
> > +     .get_random = trusted_tpm_get_random,
> > +     .exit = trusted_tpm_exit,
> > +};
> > --
> > 2.7.4
> >
> >
>
> /Jarkko
