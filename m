Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A3607F5A
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 21:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJUT5d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 15:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJUT5c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 15:57:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A1029CB82
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 12:57:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m16so9734903edc.4
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=83yew4h3EczEpqTQpVrOzoHIxYSse7MFO/5DXXJ/mCU=;
        b=aIFNnV3TWMGHSleRWHCCi5mY8T81euFzFYCxcb60gXsXGBgVZsihBEIEiL7T6OJZmH
         eJA4hPoYKXiWEWTodkpoyOR6WIS1qq21bnsrJEYfk7JTtH+Sb+lEdMd/ObdO1Dnf1nZF
         HHvaErEKkRQI/Oiwtg2DJz5u+nLkxCsy5oCiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83yew4h3EczEpqTQpVrOzoHIxYSse7MFO/5DXXJ/mCU=;
        b=jlcmlUxO6DTf1rwvh3ofZ+1A+Xf40sSBWBt4WlNVrWxNsNQ9Ok9i66iWsHXnzVSJhE
         bWB2fPt42mOyzxvvKECWCL6vdfMpnt0oq84j0UXTK/Bd45WDcz/hANNTgdlrU8xNLtut
         U5/1xeARkNe82jSPyB9onPbc6MI3Q2S87ybAgml/C84yxYh5BWKjm5E4Kcm/GpHrTnt3
         MhY+hx4rDGLevKYUuKtV4BTO8V0NxpT2AquMFuW2fSQmqJ0oKS4GkCXngXC+vwJ1GsBO
         D1XKIshrD2ID3RXJ6B0du6AfwQgankChZIso0w2393O6CYPrpvD+6QLjiv/0P2BFcFYH
         O0oQ==
X-Gm-Message-State: ACrzQf0C8xX/aEj+rhD5+4oXqoX8CumeFMUUZVpVHc5MxmgYalMMBAXT
        QKwFPf9Z5+PhM+tPnrUJWDwJqafzHl1TbQ==
X-Google-Smtp-Source: AMsMyM4QP/RnxU9tnwD0WOal5t1h8wVYiQLWB7Q4RDszfPYpdS+Tje28eRXsfqABhnSc1BiQXU0bKA==
X-Received: by 2002:a17:907:320c:b0:77b:6f08:9870 with SMTP id xg12-20020a170907320c00b0077b6f089870mr17176180ejb.249.1666382248591;
        Fri, 21 Oct 2022 12:57:28 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id p6-20020a05640243c600b0045b4b67156fsm14048552edc.45.2022.10.21.12.57.27
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 12:57:27 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id y10so2998291wma.0
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 12:57:27 -0700 (PDT)
X-Received: by 2002:a1c:e90b:0:b0:3b4:fb6c:7654 with SMTP id
 q11-20020a1ce90b000000b003b4fb6c7654mr14163557wmc.98.1666382246970; Fri, 21
 Oct 2022 12:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220927164922.3383711-1-evgreen@chromium.org>
 <20220927094559.v3.8.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid> <YzdhMW6VqoT0EkGI@kernel.org>
In-Reply-To: <YzdhMW6VqoT0EkGI@kernel.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 21 Oct 2022 12:56:50 -0700
X-Gmail-Original-Message-ID: <CAE=gft45p4QFqe0E0X_1XGeRB2kLgH3p9ZfNNTvMk2H9GwbhMw@mail.gmail.com>
Message-ID: <CAE=gft45p4QFqe0E0X_1XGeRB2kLgH3p9ZfNNTvMk2H9GwbhMw@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] PM: hibernate: Use TPM-backed keys to encrypt image
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        apronin@chromium.org, dlunev@google.com,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, corbet@lwn.net, linux-pm@vger.kernel.org,
        zohar@linux.ibm.com, Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 30, 2022 at 2:35 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Sep 27, 2022 at 09:49:19AM -0700, Evan Green wrote:
> > When using encrypted hibernate images, have the TPM create a key for us
> > and seal it. By handing back a sealed blob instead of the raw key, we
> > prevent usermode from being able to decrypt and tamper with the
> > hibernate image on a different machine.
> >
> > We'll also go through the motions of having PCR23 set to a known value at
> > the time of key creation and unsealing. Currently there's nothing that
> > enforces the contents of PCR23 as a condition to unseal the key blob,
> > that will come in a later change.
> >
> > Sourced-from: Matthew Garrett <mjg59@google.com>
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > ---
> > Matthew's incarnation of this patch is at:
> > https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/
> >
> > Changes in v3:
> >  - ENCRYPTED_HIBERNATION needs TRUSTED_KEYS builtin for
> >    key_type_trusted.
> >  - Remove KEYS dependency since it's covered by TRUSTED_KEYS (Kees)
> >
> > Changes in v2:
> >  - Rework load/create_kernel_key() to eliminate a label (Andrey)
> >  - Call put_device() needed from calling tpm_default_chip().
> >
> >  kernel/power/Kconfig   |   1 +
> >  kernel/power/snapenc.c | 207 +++++++++++++++++++++++++++++++++++++++--
> >  kernel/power/user.h    |   1 +
> >  3 files changed, 200 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index cd574af0b43379..2f8acbd87b34dc 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -96,6 +96,7 @@ config ENCRYPTED_HIBERNATION
> >       bool "Encryption support for userspace snapshots"
> >       depends on HIBERNATION_SNAPSHOT_DEV
> >       depends on CRYPTO_AEAD2=y
> > +     depends on TRUSTED_KEYS=y
> >       default n
> >       help
> >         Enable support for kernel-based encryption of hibernation snapshots
> > diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
> > index cb90692d6ab83a..90079f6d4f184b 100644
> > --- a/kernel/power/snapenc.c
> > +++ b/kernel/power/snapenc.c
> > @@ -4,13 +4,23 @@
> >  #include <linux/crypto.h>
> >  #include <crypto/aead.h>
> >  #include <crypto/gcm.h>
> > +#include <keys/trusted-type.h>
> > +#include <linux/key-type.h>
> >  #include <linux/random.h>
> >  #include <linux/mm.h>
> > +#include <linux/tpm.h>
> >  #include <linux/uaccess.h>
> >
> >  #include "power.h"
> >  #include "user.h"
> >
> > +/* sha256("To sleep, perchance to dream") */
> > +static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
> > +     .digest = {0x92, 0x78, 0x3d, 0x79, 0x2d, 0x00, 0x31, 0xb0, 0x55, 0xf9,
> > +                0x1e, 0x0d, 0xce, 0x83, 0xde, 0x1d, 0xc4, 0xc5, 0x8e, 0x8c,
> > +                0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
> > +                0x5f, 0x49}};
> > +
> >  /* Encrypt more data from the snapshot into the staging area. */
> >  static int snapshot_encrypt_refill(struct snapshot_data *data)
> >  {
> > @@ -313,6 +323,12 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
> >  {
> >       int i;
> >
> > +     if (data->key) {
>
> Would be a helpful to have perhaps inline comment before the check.
>
> Just stating this because I did not exactly follow why the null
> check was needed (but do believe that there are good reasons to
> do it).
>
> > +             key_revoke(data->key);
> > +             key_put(data->key);
> > +             data->key = NULL;
> > +     }
> > +
> >       if (data->aead_req) {
> >               aead_request_free(data->aead_req);
> >               data->aead_req = NULL;
> > @@ -381,11 +397,83 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
> >       return rc;
> >  }
> >
> > +static int snapshot_create_kernel_key(struct snapshot_data *data)
> > +{
> > +     const struct cred *cred = current_cred();
> > +     struct tpm_digest *digests = NULL;
> > +     struct tpm_chip *chip;
> > +     struct key *key = NULL;
> > +     int ret, i;
> > +     /* Create a key sealed by the SRK. */
> > +     char *keyinfo = "new\t32\tkeyhandle=0x81000000";
>
> Again, I'd consider put this declaration as first.
>
> > +
> > +     chip = tpm_default_chip();
> > +     if (!chip)
> > +             return -ENODEV;
> > +
> > +     if (!(tpm_is_tpm2(chip))) {
> > +             ret = -ENODEV;
> > +             goto out_dev;
> > +     }
> > +
> > +     ret = tpm_pcr_reset(chip, 23);
> > +     if (ret)
> > +             goto out;
> > +
> > +     digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
> > +                       GFP_KERNEL);
> > +     if (!digests) {
> > +             ret = -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     for (i = 0; i <= chip->nr_allocated_banks; i++) {
> > +             digests[i].alg_id = chip->allocated_banks[i].alg_id;
> > +             if (digests[i].alg_id == known_digest.alg_id)
> > +                     memcpy(&digests[i], &known_digest, sizeof(known_digest));
> > +     }
> > +
> > +     ret = tpm_pcr_extend(chip, 23, digests);
> > +     if (ret != 0)
> > +             goto out;
> > +
> > +     key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
> > +                     GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
> > +                     NULL);
> > +
> > +     if (IS_ERR(key)) {
> > +             ret = PTR_ERR(key);
> > +             key = NULL;
> > +             goto out;
> > +     }
> > +
> > +     ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
> > +                                    NULL);
>
> Generally speaking, even if it somehow would be "safe", not strlen()
> thank you.
>
> AFAIK, keyinfo is a constant so you could just as well use sizeof().
> And then you would not need "+ 1".

Ack, I'm changing this one to sizeof(keyinfo), but...

>
> > +     if (ret != 0)
> > +             goto out;
> > +
> > +     data->key = key;
> > +     key = NULL;
> > +
> > +out:
> > +     if (key) {
> > +             key_revoke(key);
> > +             key_put(key);
> > +     }
> > +
> > +     kfree(digests);
> > +     tpm_pcr_reset(chip, 23);
> > +
> > +out_dev:
> > +     put_device(&chip->dev);
> > +     return ret;
> > +}
> > +
> >  int snapshot_get_encryption_key(struct snapshot_data *data,
> >       struct uswsusp_key_blob __user *key)
> >  {
> > -     u8 aead_key[SNAPSHOT_ENCRYPTION_KEY_SIZE];
> >       u8 nonce[USWSUSP_KEY_NONCE_SIZE];
> > +     struct trusted_key_payload *payload;
> >       int rc;
> >       /* Don't pull a random key from a world that can be reset. */
> >       if (data->ready)
> > @@ -399,21 +487,28 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
> >       get_random_bytes(nonce, sizeof(nonce));
> >       memcpy(&data->nonce_low, &nonce[0], sizeof(data->nonce_low));
> >       memcpy(&data->nonce_high, &nonce[8], sizeof(data->nonce_high));
> > -     /* Build a random key */
> > -     get_random_bytes(aead_key, sizeof(aead_key));
> > -     rc = crypto_aead_setkey(data->aead_tfm, aead_key, sizeof(aead_key));
> > +
> > +     /* Create a kernel key, and set it. */
> > +     rc = snapshot_create_kernel_key(data);
> > +     if (rc)
> > +             goto fail;
> > +
> > +     payload = data->key->payload.data[0];
> > +     /* Install the key */
> > +     rc = crypto_aead_setkey(data->aead_tfm, payload->key, SNAPSHOT_ENCRYPTION_KEY_SIZE);
> >       if (rc)
> >               goto fail;
> >
> > -     /* Hand the key back to user mode (to be changed!) */
> > -     rc = put_user(sizeof(struct uswsusp_key_blob), &key->blob_len);
> > +     /* Hand the key back to user mode in sealed form. */
> > +     rc = put_user(payload->blob_len, &key->blob_len);
> >       if (rc)
> >               goto fail;
> >
> > -     rc = copy_to_user(&key->blob, &aead_key, sizeof(aead_key));
> > +     rc = copy_to_user(&key->blob, &payload->blob, payload->blob_len);
> >       if (rc)
> >               goto fail;
> >
> > +     /* The nonce just gets handed back in the clear. */
> >       rc = copy_to_user(&key->nonce, &nonce, sizeof(nonce));
> >       if (rc)
> >               goto fail;
> > @@ -425,10 +520,99 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
> >       return rc;
> >  }
> >
> > +static int snapshot_load_kernel_key(struct snapshot_data *data,
> > +     struct uswsusp_key_blob *blob)
>
> Bad alignment.
>
> > +{
> > +
> > +     const struct cred *cred = current_cred();
> > +     char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
>
> Ditto.
>
> > +     struct tpm_digest *digests = NULL;
> > +     char *blobstring = NULL;
> > +     char *keyinfo = NULL;
> > +     struct tpm_chip *chip;
> > +     struct key *key = NULL;
> > +     int i, ret;
> > +
> > +     chip = tpm_default_chip();
> > +     if (!chip)
> > +             return -ENODEV;
> > +
> > +     if (!(tpm_is_tpm2(chip))) {
> > +             ret = -ENODEV;
> > +             goto out_dev;
> > +     }
> > +
> > +     ret = tpm_pcr_reset(chip, 23);
> > +     if (ret)
> > +             goto out;
> > +
> > +     digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
> > +                       GFP_KERNEL);
> > +     if (!digests)
> > +             goto out;
> > +
> > +     for (i = 0; i <= chip->nr_allocated_banks; i++) {
> > +             digests[i].alg_id = chip->allocated_banks[i].alg_id;
> > +             if (digests[i].alg_id == known_digest.alg_id)
> > +                     memcpy(&digests[i], &known_digest, sizeof(known_digest));
> > +     }
> > +
> > +     ret = tpm_pcr_extend(chip, 23, digests);
> > +     if (ret != 0)
> > +             goto out;
> > +
> > +     blobstring = kmalloc(blob->blob_len * 2, GFP_KERNEL);
> > +     if (!blobstring) {
> > +             ret = -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     bin2hex(blobstring, blob->blob, blob->blob_len);
> > +     keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring);
> > +     if (!keyinfo) {
> > +             ret = -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     key = key_alloc(&key_type_trusted, "swsusp", GLOBAL_ROOT_UID,
> > +                     GLOBAL_ROOT_GID, cred, 0, KEY_ALLOC_NOT_IN_QUOTA,
> > +                     NULL);
> > +
> > +     if (IS_ERR(key)) {
> > +             ret = PTR_ERR(key);
> > +             key = NULL;
> > +             goto out;
> > +     }
> > +
> > +     ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
> > +                                    NULL);
>
> Ditto.

... I can't change this one to sizeof. Since this came out of
kasprintf() and we already checked against null, strlen() seemed safe
here. Is there a different pattern I should be following?

-Evan
