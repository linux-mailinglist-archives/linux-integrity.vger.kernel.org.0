Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF451589377
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Aug 2022 22:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiHCUst (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Aug 2022 16:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiHCUss (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Aug 2022 16:48:48 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C23D5C94E
        for <linux-integrity@vger.kernel.org>; Wed,  3 Aug 2022 13:48:47 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10e6bdbe218so22087078fac.10
        for <linux-integrity@vger.kernel.org>; Wed, 03 Aug 2022 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybP/ElRLkO+EJL+/j9uG30N2lLShN588ns/EY1gUwXs=;
        b=Ciy86lX6LuQK0c5yd6gR52m67WVfapJjjyJqpBfkLvfZMQ/fOScolJAYm98o1FWitT
         b3bG/cJFhkjGnNpxEEwnGbCqGT/Uu9JHWs/h5krFWqmVLMiBzgt4xOX2Y03TVeB4e4Zu
         p8bCkmMuI4XQ6sMTiw+nKNv4elcQtAk7R76f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybP/ElRLkO+EJL+/j9uG30N2lLShN588ns/EY1gUwXs=;
        b=qH6g+F1KIM91gDACPBAegHQua6lhkIQIy5u4WDVDIOXB+AzIJlnsA/sn279Uiup/Aj
         tqoUYg4Yl6VLYhlwvomWNxHy+IsPOeU1okHopb/lNc+D/X2oAWG1KE2/YUfO2qALuIqt
         eEqdLC77pGrVVg1GHEww2BEb0z1X48ZrHGmFBkgzeJTB6QILyaENvO/coWKNGRthGYF4
         5gviriy1JcT1fNQyh6XPGS4F9Sgge01Drp5VuYxoMIbIS7kgmO0JBOmllGXLIyITK4/Y
         CLofU89LYNvlqhn5XRhVg1A63t8pYQ9Z/oy720bTsfdO8YYoerNhsHPNGoWJ2abdv3Gf
         cf2w==
X-Gm-Message-State: ACgBeo1cY4IdogivQGbIvQbkIZ0hzB6iN7APudQKmi9+rXS1qmddXuVi
        ZLn/D/FR5sDji8Ox+WW+cYvsoYdJjdIaew==
X-Google-Smtp-Source: AA6agR5Q4PYHTB8MLM7kqGI53XAJdsUYh0KVvXjguZUVnEI415FzFp53pqipXiPyiQCU0ZdOUZKgzg==
X-Received: by 2002:a05:6870:8984:b0:10d:d981:151f with SMTP id f4-20020a056870898400b0010dd981151fmr2556266oaq.212.1659559726265;
        Wed, 03 Aug 2022 13:48:46 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id u10-20020a056870304a00b0010d910ffc3asm4694562oau.18.2022.08.03.13.48.44
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 13:48:45 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id cm4-20020a056830650400b0063675a4dd74so3167102otb.10
        for <linux-integrity@vger.kernel.org>; Wed, 03 Aug 2022 13:48:44 -0700 (PDT)
X-Received: by 2002:a05:6830:290a:b0:618:b519:53f5 with SMTP id
 z10-20020a056830290a00b00618b51953f5mr9795274otu.237.1659559724240; Wed, 03
 Aug 2022 13:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <YumpwkIz+S+zDfol@sol.localdomain>
In-Reply-To: <YumpwkIz+S+zDfol@sol.localdomain>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 3 Aug 2022 13:48:08 -0700
X-Gmail-Original-Message-ID: <CAE=gft4_M=9TsbHFEVQO-3BRrQsDia0Mwt0C9OpA6fMcnaDsrw@mail.gmail.com>
Message-ID: <CAE=gft4_M=9TsbHFEVQO-3BRrQsDia0Mwt0C9OpA6fMcnaDsrw@mail.gmail.com>
Subject: Re: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 2, 2022 at 3:48 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, May 04, 2022 at 04:21:00PM -0700, Evan Green wrote:
> > +/*
> > + * Allow user mode to fold in key material for the data portion of the hibernate
> > + * image.
> > + */
> > +struct uswsusp_user_key {
> > +     /* Kernel returns the metadata size. */
> > +     __kernel_loff_t meta_size;
> > +     __u32 key_len;
> > +     __u8 key[16];
> > +     __u32 pad;
> > +};
>
> Shouldn't the key field be 32 bytes?
>

Short answer: yes, it should, will fix. Long answer: I had used a
hardcoded AEAD algorithm of "gcm(aes)", and was envisioning it being
AES128. But making it accommodate 32 bytes now before this gets set in
stone is a better idea.

> > +/* Derive a key from the kernel and user keys for data encryption. */
> > +static int snapshot_use_user_key(struct snapshot_data *data)
> > +{
> > +     struct shash_desc *desc;
> > +     u8 digest[SHA256_DIGEST_SIZE];
> > +     struct trusted_key_payload *payload;
> > +     struct crypto_shash *tfm;
> > +     int ret;
> > +
> > +     tfm = crypto_alloc_shash("sha256", 0, 0);
> > +     if (IS_ERR(tfm)) {
> > +             ret = -EINVAL;
> > +             goto err_rel;
> > +     }
> > +
> > +     desc = kmalloc(sizeof(struct shash_desc) +
> > +                    crypto_shash_descsize(tfm), GFP_KERNEL);
> > +     if (!desc) {
> > +             ret = -ENOMEM;
> > +             goto err_rel;
> > +     }
> > +
> > +     desc->tfm = tfm;
> > +     ret = crypto_shash_init(desc);
> > +     if (ret != 0)
> > +             goto err_free;
> > +
> > +     /*
> > +      * Hash the kernel key and the user key together. This folds in the user
> > +      * key, but not in a way that gives the user mode predictable control
> > +      * over the key bits. Hash in all 32 bytes of the key even though only 16
> > +      * are in active use as extra salt.
> > +      */
> > +     payload = data->key->payload.data[0];
> > +     crypto_shash_update(desc, payload->key, MIN_KEY_SIZE);
> > +     crypto_shash_update(desc, data->user_key, sizeof(data->user_key));
> > +     crypto_shash_final(desc, digest);
> > +     ret = crypto_aead_setkey(data->aead_tfm,
> > +                              digest,
> > +                              SNAPSHOT_ENCRYPTION_KEY_SIZE);
> > +
> > +err_free:
> > +     kfree(desc);
> > +
> > +err_rel:
> > +     crypto_free_shash(tfm);
> > +     return ret;
> > +}
>
> Just select CRYPTO_LIB_SHA256, and you can use sha256_init/update/final which
> would be much simpler.  Similarly with sha256_data() that is added by the next
> patch; you could just call sha256().

Good idea, will do. Thanks!

>
> - Eric
