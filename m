Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37E51EA050
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725290AbgFAIum (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAIul (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 04:50:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB503C08C5C0
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 01:50:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so7146337ljp.3
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7pGICOFTESCzt7M2jJ2kwIhnCwRxuqpJj6rDXIDuhU=;
        b=FdFe3E7fGfUDCcAGdtYUPQMWJoh7zsYhOOiEiZhs9nEeQnIOUUcEGvjugInrHtUhye
         VX9Q6P8tph+xWV0jYLdJ3BnDNq5EzOJ9fPLC+ke8Y+dFzljv2S/WCqz2QvvFp0pypUax
         gecJyElCrYx2Kz/vrYDszv8bsbzYLvTRn2B0OfBS+fQas7ZqH46E3aUa8/NgnCtH+hSE
         95c0S8qcWwiQm/lDoweD5mvIWIKshZlffO1kCFUQwzAR8ZISZ3W4GMFSTid3PjluwMfY
         CWSMxKojbZy8ywD04qHlw6FUjzJ8sTvdBCJY9dhE12vMh2/+UGDtgWmAPuSSLca/VqSp
         t9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7pGICOFTESCzt7M2jJ2kwIhnCwRxuqpJj6rDXIDuhU=;
        b=U8YWkl8HGZ8AzJ523wZIYmTG94pOGYRO04hccigyTkaDJpelkXd6KC7oW3Lkb0svIR
         M3+xi/g4JzfwWRVgaP43s65tIBrsibOgpIIwS9uGuWI3+rs8AOlPsud1aSXkO/jEjgXz
         zjCz/HkrX7J9b37IrKmanVE8aHTtZJ2RD2v0RDoSLhSRWDdq1Ruklq04dA+ffFnY1aFa
         8AL7P8g+wLlJ5q1gQqoeCFH2GT2xCtPY55g9z4nSxIvkwX9mzd3w5iWDiYlg5DTj8v+F
         MvZBww9ekQbH2bOi+os2zaIW1yiWt3fYe6jC45Py//gmX1uV2+B+tp2N+fil2PODdxb5
         NsfQ==
X-Gm-Message-State: AOAM530xeKQx3gRCTTGj9Evg74IozsnAI63Pd+wcmOMadqcpmX1RKgB/
        abRxyZVBv5CII1NjDHrhsqzDu+qAbOUG5AMcFbOncg==
X-Google-Smtp-Source: ABdhPJxbJjm5r8WaqkCnk5G084xi++1rZtbiGIwtueKfLTPz76YZpxi5dwzNk51P6R5SGpphlZ3taBXJ0hRJKJRQHUM=
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr9640285ljk.4.1591001438692;
 Mon, 01 Jun 2020 01:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-2-git-send-email-sumit.garg@linaro.org> <20200601020048.GC794847@linux.intel.com>
In-Reply-To: <20200601020048.GC794847@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Jun 2020 14:20:26 +0530
Message-ID: <CAFA6WYMN01WSsMhvqmtzG+hmnQ9+_MfobaH9c_LZ1wj9Z_xDjw@mail.gmail.com>
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

On Mon, 1 Jun 2020 at 07:30, Jarkko Sakkinen
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
>
> I think trusted_core.c would be a better name (less ambiguous).
>

Okay.

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
>
> /* Init a key. */
>

This API isn't initializing a key but rather the underlying interface
(see init_tpm_trusted()). So how about:

/* Initialize key interface */

> > +
> > +     /* seal a trusted key */
> > +     int (*seal)(struct trusted_key_payload *p, char *datablob);
>
> /* Seal a key. */
>

Ack.

> > +
> > +     /* unseal a trusted key */
> > +     int (*unseal)(struct trusted_key_payload *p, char *datablob);
>
> /* Unseal a key. */
>

Ack.

> > +
> > +     /* get random trusted key */
> > +     int (*get_random)(unsigned char *key, size_t key_len);
>
> /* Get a randomized key. */
>

Ack.

> > +
> > +     /* trusted key cleanup */
> > +     void (*cleanup)(void);
>
> Please remove this from this commit since it is not in use in the scope
> of this commit. You should instead make a separate commit just for this
> callback, which explains what it is and how it will be used in the
> follow up commits.
>

This API is pretty much relevant to TPM as well (see:
cleanup_tpm_trusted()) but I guess "cleanup()" terminology is bringing
up some confusion, so how about to call it "exit()" instead?

>
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
> > +
> > +             ret = tk_ops->init();
> > +             if (ret) {
> > +                     if (tk_ops->cleanup)
> > +                             tk_ops->cleanup();
> > +             } else {
> > +                     break;
> > +             }
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
> > +     if (tk_ops->cleanup)
> > +             tk_ops->cleanup();
> > +}
> > +
> > +late_initcall(init_trusted);
> > +module_exit(cleanup_trusted);
> > +
> > +MODULE_LICENSE("GPL");
> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > index 8001ab0..32fd1ea 100644
> > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > @@ -1,29 +1,26 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * Copyright (C) 2010 IBM Corporation
> > + * Copyright (c) 2019, Linaro Limited
> >   *
> >   * Author:
> >   * David Safford <safford@us.ibm.com>
> > + * Switch to generic trusted key framework: Sumit Garg <sumit.garg@linaro.org>
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
> > @@ -703,7 +700,6 @@ static int key_unseal(struct trusted_key_payload *p,
> >
> >  enum {
> >       Opt_err,
> > -     Opt_new, Opt_load, Opt_update,
> >       Opt_keyhandle, Opt_keyauth, Opt_blobauth,
> >       Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
> >       Opt_hash,
> > @@ -712,9 +708,6 @@ enum {
> >  };
> >
> >  static const match_table_t key_tokens = {
> > -     {Opt_new, "new"},
> > -     {Opt_load, "load"},
> > -     {Opt_update, "update"},
> >       {Opt_keyhandle, "keyhandle=%s"},
> >       {Opt_keyauth, "keyauth=%s"},
> >       {Opt_blobauth, "blobauth=%s"},
> > @@ -841,71 +834,6 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
> > @@ -926,248 +854,99 @@ static struct trusted_key_options *trusted_options_alloc(void)
> >       return options;
> >  }
> >
> > -static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
> > +static int tpm_tk_seal(struct trusted_key_payload *p, char *datablob)
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
> > -     kzfree(datablob);
> >       kzfree(options);
> > -     if (!ret)
> > -             rcu_assign_keypointer(key, payload);
> > -     else
> > -             kzfree(payload);
> >       return ret;
> >  }
> >
> > -static void trusted_rcu_free(struct rcu_head *rcu)
> > +static int tpm_tk_unseal(struct trusted_key_payload *p, char *datablob)
> >  {
> > -     struct trusted_key_payload *p;
> > -
> > -     p = container_of(rcu, struct trusted_key_payload, rcu);
> > -     kzfree(p);
> > -}
> > -
> > -/*
> > - * trusted_update - reseal an existing key with new PCR values
> > - */
> > -static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
> > -{
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
> > -             kzfree(new_p);
> > +     ret = getoptions(datablob, p, options);
> > +     if (ret < 0)
> >               goto out;
> > -     }
> > +     dump_options(options);
> >
> > -     if (!new_o->keyhandle) {
> > +     if (!options->keyhandle) {
> >               ret = -EINVAL;
> > -             kzfree(new_p);
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
> > -             kzfree(new_p);
> > -             goto out;
> > -     }
> > -     if (new_o->pcrlock) {
> > -             ret = pcrlock(new_o->pcrlock);
> > +     if (options->pcrlock) {
> > +             ret = pcrlock(options->pcrlock);
> >               if (ret < 0) {
> > -                     pr_info("trusted_key: pcrlock failed (%d)\n", ret);
> > -                     kzfree(new_p);
> > +                     pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
> >                       goto out;
> >               }
> >       }
> > -     rcu_assign_keypointer(key, new_p);
> > -     call_rcu(&p->rcu, trusted_rcu_free);
> >  out:
> > -     kzfree(datablob);
> > -     kzfree(new_o);
> > +     kzfree(options);
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
> > +int tpm_tk_get_random(unsigned char *key, size_t key_len)
> >  {
> > -     kzfree(key->payload.data[0]);
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
> > @@ -1182,14 +961,14 @@ static int __init trusted_shash_alloc(void)
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
> >                       hash_alg);
> >               ret = PTR_ERR(hashalg);
> >               goto hashalg_fail;
> > @@ -1217,16 +996,13 @@ static int __init init_digests(void)
> >       return 0;
> >  }
> >
> > -static int __init init_trusted(void)
> > +static int __init init_tpm_trusted(void)
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
> > @@ -1247,7 +1023,7 @@ static int __init init_trusted(void)
> >       return ret;
> >  }
> >
> > -static void __exit cleanup_trusted(void)
> > +static void __exit cleanup_tpm_trusted(void)
> >  {
> >       if (chip) {
> >               put_device(&chip->dev);
> > @@ -1257,7 +1033,12 @@ static void __exit cleanup_trusted(void)
> >       }
> >  }
> >
> > -late_initcall(init_trusted);
> > -module_exit(cleanup_trusted);
> > -
> > -MODULE_LICENSE("GPL");
> > +struct trusted_key_ops tpm_trusted_key_ops = {
> > +     .migratable = 1, /* migratable by default */
> > +     .init = init_tpm_trusted,
> > +     .seal = tpm_tk_seal,
> > +     .unseal = tpm_tk_unseal,
> > +     .get_random = tpm_tk_get_random,
> > +     .cleanup = cleanup_tpm_trusted,
> > +};
> > +EXPORT_SYMBOL_GPL(tpm_trusted_key_ops);
>
> Everywhere: do not use 'tk'. Use 'trusted' in those places. We do not
> want a new acronym.

Okay.

-Sumit

>
> /Jarkko
