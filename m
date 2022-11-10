Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02962382F
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 01:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKJAbg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Nov 2022 19:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKJAbY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Nov 2022 19:31:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12D2A249
        for <linux-integrity@vger.kernel.org>; Wed,  9 Nov 2022 16:31:10 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so1056158ejb.13
        for <linux-integrity@vger.kernel.org>; Wed, 09 Nov 2022 16:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/a0Y1PzPHK5lglbzGXwet9czSRIDakfOXe004kRMBhc=;
        b=f/MMX38JG041+PK29JPLsroZLyZltlw88olsa6UAdoX/JQNLFoeo2dw1rMhQUropif
         kbYbaGTvqoIzCVrPaM8lJxU4rDB+TwS6w2b5ZkwnZWiHvefTLJw2idJAiaWUjqvSjBNl
         cmPA6Zz8zngD/30X8LfyXJWKjfmmHyI7FDzgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/a0Y1PzPHK5lglbzGXwet9czSRIDakfOXe004kRMBhc=;
        b=3rmYBgfHzbagdzQHeAIztlBL6nU87JkEWRDMeCHolkSDGq8zcbl7Oyrwijbeki333r
         Mj+qqHgUOKSR8R3vSzE5LENKdDZaJicFQqtyAF/lFQg6hw2mlCrkfhdgrPeqasVqTJna
         ctk0jj8rADCmp3l+ChBSSkTjKNitTKU292oCQfx23zYYYyY5k07cer+go0X1Hu04MCYp
         ngI9HWEIhkpEC7ejpw5DDuhBRUI1i+l7AEf7RZ7imZgYxi0yd7FoRkA9Pjn0DRxpoNP4
         lYoTCTXuoLIOI7nCR27mtmPk7jlBFqIHW895eifgxEPBB/DYcsZwmkIbqRCD55Vcwzej
         Hpsw==
X-Gm-Message-State: ACrzQf3cvuGO21qbDVR5Pw7e4KcAD6a0scjmMI3H8wFNAgjyjPnX2OGH
        8sv88C17ftVnBGwVLc+i9Sprw9ioin38yQ==
X-Google-Smtp-Source: AMsMyM6+hRBw07SIUqitO4f4mhCGNfnXX+4wRMd0Uk23iaFyOg72yyYICSW4u4gFt7hQsex6rwGIyA==
X-Received: by 2002:a17:906:a17:b0:78d:9d06:c7cc with SMTP id w23-20020a1709060a1700b0078d9d06c7ccmr2016991ejf.154.1668040269101;
        Wed, 09 Nov 2022 16:31:09 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b0073d7bef38e3sm1340233ejf.45.2022.11.09.16.31.07
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 16:31:07 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id a14so146455wru.5
        for <linux-integrity@vger.kernel.org>; Wed, 09 Nov 2022 16:31:07 -0800 (PST)
X-Received: by 2002:a05:6000:5c4:b0:236:cbbb:5576 with SMTP id
 bh4-20020a05600005c400b00236cbbb5576mr36808772wrb.591.1668040266953; Wed, 09
 Nov 2022 16:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.10.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
 <202211041156.3D184961EE@keescook>
In-Reply-To: <202211041156.3D184961EE@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Nov 2022 16:30:30 -0800
X-Gmail-Original-Message-ID: <CAE=gft7=fUJGHQF6WNYzi_mwnTr-xpjanfwpPdyYQrBtdxX9wA@mail.gmail.com>
Message-ID: <CAE=gft7=fUJGHQF6WNYzi_mwnTr-xpjanfwpPdyYQrBtdxX9wA@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] PM: hibernate: Verify the digest encryption key
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 4, 2022 at 12:00 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 03, 2022 at 11:01:18AM -0700, Evan Green wrote:
> > We want to ensure that the key used to encrypt the digest was created by
> > the kernel during hibernation. To do this we request that the TPM
> > include information about the value of PCR 23 at the time of key
> > creation in the sealed blob. On resume, we can make sure that the PCR
> > information in the creation data blob (already certified by the TPM to
> > be accurate) corresponds to the expected value. Since only
> > the kernel can touch PCR 23, if an attacker generates a key themselves
> > the value of PCR 23 will have been different, allowing us to reject the
> > key and boot normally instead of resuming.
> >
> > Co-developed-by: Matthew Garrett <mjg59@google.com>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > ---
> > Matthew's original version of this patch is here:
> > https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/
> >
> > I moved the TPM2_CC_CERTIFYCREATION code into a separate change in the
> > trusted key code because the blob_handle was being flushed and was no
> > longer valid for use in CC_CERTIFYCREATION after the key was loaded. As
> > an added benefit of moving the certification into the trusted keys code,
> > we can drop the other patch from the original series that squirrelled
> > the blob_handle away.
> >
> > Changes in v4:
> >  - Local variable reordering (Jarkko)
> >
> > Changes in v3:
> >  - Changed funky tag to Co-developed-by (Kees). Matthew, holler if you
> >    want something different.
> >
> > Changes in v2:
> >  - Fixed some sparse warnings
> >  - Use CRYPTO_LIB_SHA256 to get rid of sha256_data() (Eric)
> >  - Adjusted offsets due to new ASN.1 format, and added a creation data
> >    length check.
> >
> >  kernel/power/snapenc.c | 67 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 65 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
> > index 50167a37c5bf23..2f421061498246 100644
> > --- a/kernel/power/snapenc.c
> > +++ b/kernel/power/snapenc.c
> > @@ -22,6 +22,12 @@ static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
> >                  0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
> >                  0x5f, 0x49}};
> >
> > +/* sha256(sha256(empty_pcr | known_digest)) */
> > +static const char expected_digest[] = {0x2f, 0x96, 0xf2, 0x1b, 0x70, 0xa9, 0xe8,
> > +     0x42, 0x25, 0x8e, 0x66, 0x07, 0xbe, 0xbc, 0xe3, 0x1f, 0x2c, 0x84, 0x4a,
> > +     0x3f, 0x85, 0x17, 0x31, 0x47, 0x9a, 0xa5, 0x53, 0xbb, 0x23, 0x0c, 0x32,
> > +     0xf3};
> > +
> >  /* Derive a key from the kernel and user keys for data encryption. */
> >  static int snapshot_use_user_key(struct snapshot_data *data)
> >  {
> > @@ -486,7 +492,7 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
> >  static int snapshot_create_kernel_key(struct snapshot_data *data)
> >  {
> >       /* Create a key sealed by the SRK. */
> > -     char *keyinfo = "new\t32\tkeyhandle=0x81000000";
> > +     char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
> >       const struct cred *cred = current_cred();
> >       struct tpm_digest *digests = NULL;
> >       struct key *key = NULL;
> > @@ -613,6 +619,8 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
> >
> >       char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
> >       const struct cred *cred = current_cred();
> > +     struct trusted_key_payload *payload;
> > +     char certhash[SHA256_DIGEST_SIZE];
> >       struct tpm_digest *digests = NULL;
> >       char *blobstring = NULL;
> >       struct key *key = NULL;
> > @@ -635,8 +643,10 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
> >
> >       digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
> >                         GFP_KERNEL);
> > -     if (!digests)
> > +     if (!digests) {
> > +             ret = -ENOMEM;
> >               goto out;
> > +     }
> >
> >       for (i = 0; i < chip->nr_allocated_banks; i++) {
> >               digests[i].alg_id = chip->allocated_banks[i].alg_id;
> > @@ -676,6 +686,59 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
> >       if (ret != 0)
> >               goto out;
> >
> > +     /* Verify the creation hash matches the creation data. */
> > +     payload = key->payload.data[0];
> > +     if (!payload->creation || !payload->creation_hash ||
> > +         (payload->creation_len < 3) ||
>
> Later accesses are reaching into indexes, 6, 8, 12, 14, etc. Shouldn't
> this test be:
>
>             (payload->creation_len < 14 + SHA256_DIGEST_SIZE) ||
>
Yikes, you're right.

>
> > +         (payload->creation_hash_len < SHA256_DIGEST_SIZE)) {
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     sha256(payload->creation + 2, payload->creation_len - 2, certhash);
>
> Why +2 offset?

The first two bytes are a __be16 size that isn't part of what the TPM hashes.

>
> > +     if (memcmp(payload->creation_hash + 2, certhash, SHA256_DIGEST_SIZE) != 0) {
>
> And if this is +2 also, shouldn't the earlier test be:
>
>         (payload->creation_hash_len - 2 != SHA256_DIGEST_SIZE)) {

Oops, yes.

>
> ?
>
> > +     if (be32_to_cpu(*(__be32 *)&payload->creation[2]) != 1) {
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     if (be16_to_cpu(*(__be16 *)&payload->creation[6]) != TPM_ALG_SHA256) {
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     if (*(char *)&payload->creation[8] != 3) {
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     /* PCR 23 selected */
> > +     if (be32_to_cpu(*(__be32 *)&payload->creation[8]) != 0x03000080) {
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     if (be16_to_cpu(*(__be16 *)&payload->creation[12]) !=
> > +         SHA256_DIGEST_SIZE) {
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     /* Verify PCR 23 contained the expected value when the key was created. */
> > +     if (memcmp(&payload->creation[14], expected_digest,
> > +                SHA256_DIGEST_SIZE) != 0) {
>
> These various literals (2, 6, 8, 3, 8, 0x03000080, 12, 14) should be
> explicit #defines so their purpose/meaning is more clear.
>
> I can guess at it, but better to avoid the guessing. :)

Ok, agreed it's a bit too hairy to manage this way. I can define a
struct specific to this form of the response I'm expecting, then use
struct fields like a proper C developer.




>
> > +
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> >       data->key = key;
> >       key = NULL;
> >
> > --
> > 2.38.1.431.g37b22c650d-goog
> >
>
> --
> Kees Cook
