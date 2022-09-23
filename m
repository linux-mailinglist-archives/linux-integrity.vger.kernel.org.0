Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975485E85E5
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Sep 2022 00:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIWWaX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Sep 2022 18:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWWaW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Sep 2022 18:30:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99886704
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 15:30:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z2so2020031edi.1
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4oqyTkBBDw3LTmTITK5vyNnI1QkI4Y5DdLpXejtCHoY=;
        b=bhDnbELAevvPVnhReDF/VQ1fkqPSkrWfUHJ7AefH7oNQZeJGyiIjM/rldTaMG7QWtw
         kf43gw25L4/r1LH8DT3ukacprjz6fYGnpWTn1oB9Rw3NAuD3cbr8h4h4C9NVvsYoobL0
         yPFfbQfjket+9sK2EgAcIj2bcXDD+sWXu+LsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4oqyTkBBDw3LTmTITK5vyNnI1QkI4Y5DdLpXejtCHoY=;
        b=AwvHOKwHRHBRPhdE2878mViWHXBVOg1Kvs25k3GW4OZczgZHurxyPbwgTOIH2dacrP
         3lfATatcqSP9DVDtitNHL/jaMuSvmmuDavaPhjLU3U5Ix/0ZqCuYnJRWBs16Ty3y3lKD
         QoHthGKBLfzRCJGxYC7B0Xi7USkhwwl66EVcxLmcwjCwCF508ZAFuSTd+FjrceO8H+k3
         vpOaTWkVgl0n/3UAvWYPtEh/G06ekWa9D+6pZYH73+Pl7gE5yh2PV32ux9ju0IToEJSd
         8sS0oqfbLG1hVoidCLrtbqYJ0zx6vk/T9FQUEbTzZTwXRMzLo2e8bkw/jxdR1rszE//H
         +yTw==
X-Gm-Message-State: ACrzQf2fc55qR5iEBBeDtiTDFidHm2U0WpmrBBZrW0mYRNTr39nNvE6e
        +uUArmqqD3VrjehYd+wRut+rdTwl9M64ce1WwSQ=
X-Google-Smtp-Source: AMsMyM4Mfq2cruXeTjn3w/hEbE19+1kQfOt0rSkyRVelvxQUahKSof+acnzVlVe2/ROnAk5uIzkFUQ==
X-Received: by 2002:aa7:cad5:0:b0:454:88dc:2c22 with SMTP id l21-20020aa7cad5000000b0045488dc2c22mr10766203edt.352.1663972218715;
        Fri, 23 Sep 2022 15:30:18 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id hk14-20020a170906c9ce00b0073d87068042sm4491476ejb.110.2022.09.23.15.30.18
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 15:30:18 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id e18so1068959wmq.3
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 15:30:18 -0700 (PDT)
X-Received: by 2002:a7b:c389:0:b0:3b4:a67a:2ef7 with SMTP id
 s9-20020a7bc389000000b003b4a67a2ef7mr14181065wmj.180.1663971779214; Fri, 23
 Sep 2022 15:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.3.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid> <202209201552.DF8C511D23@keescook>
In-Reply-To: <202209201552.DF8C511D23@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 23 Sep 2022 15:22:21 -0700
X-Gmail-Original-Message-ID: <CAE=gft6AEKiYUf9yZ1Z6F0w+=S2KJvZ6HVK+eVsQ3fF1u+HaVQ@mail.gmail.com>
Message-ID: <CAE=gft6AEKiYUf9yZ1Z6F0w+=S2KJvZ6HVK+eVsQ3fF1u+HaVQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] security: keys: trusted: Include TPM2 creation data
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
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

On Tue, Sep 20, 2022 at 4:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Aug 23, 2022 at 03:25:19PM -0700, Evan Green wrote:
> > In addition to the private key and public key, the TPM2_Create
> > command may also return creation data, a creation hash, and a creation
> > ticket. These fields allow the TPM to attest to the contents of a
> > specified set of PCRs at the time the trusted key was created. Encrypted
> > hibernation will use this to ensure that PCRs settable only by the
> > kernel were set properly at the time of creation, indicating this is an
> > authentic hibernate key.
> >
> > Encode these additional parameters into the ASN.1 created to represent
> > the key blob. The new fields are made optional so that they don't bloat
> > key blobs which don't need them, and to ensure interoperability with
> > old blobs.
> >
> > ---
> >
> > (no changes since v1)
> >
> > This is a replacement for Matthew's original patch here:
> > https://patchwork.kernel.org/patch/12096489/
> >
> > That patch was written before the exported key format was switched to
> > ASN.1. This patch accomplishes the same thing (saving, loading, and
> > getting pointers to the creation data) while utilizing the new ASN.1
> > format.
>
> This part (between your S-o-b and the "---") should got below the "---"
> after your S-o-b, otherwise tooling will include it in the commit log
> (or lose your S-o-b).

Will fix.

>
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >  include/keys/trusted-type.h               |   8 +
> >  security/keys/trusted-keys/tpm2key.asn1   |   5 +-
> >  security/keys/trusted-keys/trusted_tpm2.c | 202 +++++++++++++++++++---
> >  3 files changed, 190 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> > index 4eb64548a74f1a..209086fed240a5 100644
> > --- a/include/keys/trusted-type.h
> > +++ b/include/keys/trusted-type.h
> > @@ -22,15 +22,23 @@
> >  #define MAX_BLOB_SIZE                        512
> >  #define MAX_PCRINFO_SIZE             64
> >  #define MAX_DIGEST_SIZE                      64
> > +#define MAX_CREATION_DATA            412
> > +#define MAX_TK                               76
> >
> >  struct trusted_key_payload {
> >       struct rcu_head rcu;
> >       unsigned int key_len;
> >       unsigned int blob_len;
> > +     unsigned int creation_len;
> > +     unsigned int creation_hash_len;
> > +     unsigned int tk_len;
> >       unsigned char migratable;
> >       unsigned char old_format;
> >       unsigned char key[MAX_KEY_SIZE + 1];
> >       unsigned char blob[MAX_BLOB_SIZE];
> > +     unsigned char *creation;
> > +     unsigned char *creation_hash;
> > +     unsigned char *tk;
> >  };
> >
> >  struct trusted_key_options {
> > diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
> > index f57f869ad60068..1bfbf290e523a3 100644
> > --- a/security/keys/trusted-keys/tpm2key.asn1
> > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > @@ -7,5 +7,8 @@ TPMKey ::= SEQUENCE {
> >       emptyAuth       [0] EXPLICIT BOOLEAN OPTIONAL,
> >       parent          INTEGER ({tpm2_key_parent}),
> >       pubkey          OCTET STRING ({tpm2_key_pub}),
> > -     privkey         OCTET STRING ({tpm2_key_priv})
> > +     privkey         OCTET STRING ({tpm2_key_priv}),
> > +     creationData    [1] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_data}),
> > +     creationHash    [2] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_hash}),
> > +     creationTk      [3] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_tk})
> >       }
>
> Maybe include a link (or named reference) to these fields from the TPM
> spec?

Sure. The TPM spec names their structure types (TPM2B_CREATION_DATA,
TPM2B_DIGEST, etc), so I'll add comments with the names of the types
as well as the command they came out of.

>
> > [...]
> > @@ -46,6 +49,26 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >
> >       pub_len = get_unaligned_be16(src) + 2;
> >       pub = src;
> > +     src += pub_len;
> > +
> > +     creation_data_len = get_unaligned_be16(src);
> > +     if (creation_data_len) {
> > +             creation_data_len += 2;
> > +             creation_data = src;
> > +             src += creation_data_len;
> > +
> > +             creation_hash_len = get_unaligned_be16(src) + 2;
> > +             creation_hash = src;
> > +             src += creation_hash_len;
> > +
> > +             /*
> > +              * The creation ticket (TPMT_TK_CREATION) consists of a 2 byte
> > +              * tag, 4 byte handle, and then a TPM2B_DIGEST, which is a 2
> > +              * byte length followed by data.
> > +              */
> > +             creation_tk_len = get_unaligned_be16(src + 6) + 8;
> > +             creation_tk = src;
> > +     }
> >
> >       if (!scratch)
> >               return -ENOMEM;
>
> I don't see anything in this code (even before your patch) actually
> checking length against the "len" argument to tpm2_key_encode(). I think
> that needs to be fixed so proper bounds checking can be done here.
> Otherwise how do we know if we're running off the end of "src"?
>
> Yes, I realize if we have a malicious TPM everything goes out the
> window, but TPMs don't always behave -- this code should likely be more
> defensive. Or, I've misunderstood where "src" is coming from.
> Regardless, my question stands: what is checking "len"?

Sure, will add checks of len to my hunk and the bit above.

>
> > @@ -63,26 +86,81 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >       }
> >
> >       /*
> > -      * Assume both octet strings will encode to a 2 byte definite length
> > +      * Assume each octet string will encode to a 2 byte definite length.
> > +      * Each optional octet string consumes one extra byte.
> >        *
> > -      * Note: For a well behaved TPM, this warning should never
> > -      * trigger, so if it does there's something nefarious going on
> > +      * Note: For a well behaved TPM, this warning should never trigger, so
> > +      * if it does there's something nefarious going on
> >        */
> > -     if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> > -              "BUG: scratch buffer is too small"))
> > -             return -EINVAL;
> > +     if (WARN(work - scratch + pub_len + priv_len + creation_data_len +
> > +              creation_hash_len + creation_tk_len + (7 * 5) + 3 >
> > +              SCRATCH_SIZE,
> > +              "BUG: scratch buffer is too small")) {
> > +             rc = -EINVAL;
> > +             goto err;
> > +     }
> >
> >       work = asn1_encode_integer(work, end_work, options->keyhandle);
> >       work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> >       work = asn1_encode_octet_string(work, end_work, priv, priv_len);
> > +     if (creation_data_len) {
> > +             u8 *scratch2 = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> > +             u8 *work2;
> > +             u8 *end_work2 = scratch2 + SCRATCH_SIZE;
> > +
> > +             if (!scratch2) {
> > +                     rc = -ENOMEM;
> > +                     goto err;
> > +             }
> > +
> > +             work2 = asn1_encode_octet_string(scratch2,
> > +                                              end_work2,
> > +                                              creation_data,
> > +                                              creation_data_len);
> > +
> > +             work = asn1_encode_tag(work,
> > +                                    end_work,
> > +                                    1,
> > +                                    scratch2,
> > +                                    work2 - scratch2);
> > +
> > +             work2 = asn1_encode_octet_string(scratch2,
> > +                                              end_work2,
> > +                                              creation_hash,
> > +                                              creation_hash_len);
> > +
> > +             work = asn1_encode_tag(work,
> > +                                    end_work,
> > +                                    2,
> > +                                    scratch2,
> > +                                    work2 - scratch2);
> > +
> > +             work2 = asn1_encode_octet_string(scratch2,
> > +                                              end_work2,
> > +                                              creation_tk,
> > +                                              creation_tk_len);
> > +
> > +             work = asn1_encode_tag(work,
> > +                                    end_work,
> > +                                    3,
> > +                                    scratch2,
> > +                                    work2 - scratch2);
> > +
> > +             kfree(scratch2);
> > +     }
> >
> >       work1 = payload->blob;
> >       work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
> >                                    scratch, work - scratch);
> > -     if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> > -             return PTR_ERR(work1);
> > +     if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> > +             rc = PTR_ERR(work1);
> > +             goto err;
>
> I find the addition of the word "BUG" in a WARN() to be confusing. :) I
> realize this is just copying the existing style, though.

It wasn't my favorite either, but I felt an urge to be consistent. So
far I've lft this as-is, holler if I should change it.

>
> > +     }
> >
> >       return work1 - payload->blob;
> > +err:
> > +     kfree(scratch);
> > +     return rc;
> >  }
> >
> >  struct tpm2_key_context {
> > @@ -91,15 +169,21 @@ struct tpm2_key_context {
> >       u32 pub_len;
> >       const u8 *priv;
> >       u32 priv_len;
> > +     const u8 *creation_data;
> > +     u32 creation_data_len;
> > +     const u8 *creation_hash;
> > +     u32 creation_hash_len;
> > +     const u8 *creation_tk;
> > +     u32 creation_tk_len;
> >  };
> >
> >  static int tpm2_key_decode(struct trusted_key_payload *payload,
> > -                        struct trusted_key_options *options,
> > -                        u8 **buf)
> > +                        struct trusted_key_options *options)
> >  {
> > +     u64 data_len;
> >       int ret;
> >       struct tpm2_key_context ctx;
> > -     u8 *blob;
> > +     u8 *blob, *buf;
> >
> >       memset(&ctx, 0, sizeof(ctx));
> >
> > @@ -108,21 +192,57 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
> >       if (ret < 0)
> >               return ret;
> >
> > -     if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> > +     data_len = ctx.priv_len + ctx.pub_len + ctx.creation_data_len +
> > +                ctx.creation_hash_len + ctx.creation_tk_len;
> > +
> > +     if (data_len > MAX_BLOB_SIZE)
> >               return -EINVAL;
> >
> > -     blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> > -     if (!blob)
> > +     buf = kmalloc(data_len + 4, GFP_KERNEL);
> > +     if (!buf)
> >               return -ENOMEM;
> >
> > -     *buf = blob;
> > +     blob = buf;
> >       options->keyhandle = ctx.parent;
> >
> >       memcpy(blob, ctx.priv, ctx.priv_len);
> >       blob += ctx.priv_len;
> >
> >       memcpy(blob, ctx.pub, ctx.pub_len);
> > +     blob += ctx.pub_len;
> > +     if (ctx.creation_data_len) {
> > +             memcpy(blob, ctx.creation_data, ctx.creation_data_len);
> > +             blob += ctx.creation_data_len;
> > +     }
> > +
> > +     if (ctx.creation_hash_len) {
> > +             memcpy(blob, ctx.creation_hash, ctx.creation_hash_len);
> > +             blob += ctx.creation_hash_len;
> > +     }
> >
> > +     if (ctx.creation_tk_len) {
> > +             memcpy(blob, ctx.creation_tk, ctx.creation_tk_len);
> > +             blob += ctx.creation_tk_len;
> > +     }
> > +
> > +     /*
> > +      * Copy the buffer back into the payload blob since the creation
> > +      * info will be used after loading.
> > +      */
> > +     payload->blob_len = blob - buf;
> > +     memcpy(payload->blob, buf, payload->blob_len);
> > +     if (ctx.creation_data_len) {
> > +             payload->creation = payload->blob + ctx.priv_len + ctx.pub_len;
> > +             payload->creation_len = ctx.creation_data_len;
> > +             payload->creation_hash = payload->creation + ctx.creation_data_len;
> > +             payload->creation_hash_len = ctx.creation_hash_len;
> > +             payload->tk = payload->creation_hash +
> > +                           payload->creation_hash_len;
> > +
> > +             payload->tk_len = ctx.creation_tk_len;
> > +     }
> > +
> > +     kfree(buf);
> >       return 0;
> >  }
> >
> > @@ -185,6 +305,42 @@ int tpm2_key_priv(void *context, size_t hdrlen,
> >       return 0;
> >  }
> >
> > +int tpm2_key_creation_data(void *context, size_t hdrlen,
> > +                        unsigned char tag,
> > +                        const void *value, size_t vlen)
> > +{
> > +     struct tpm2_key_context *ctx = context;
> > +
> > +     ctx->creation_data = value;
> > +     ctx->creation_data_len = vlen;
> > +
> > +     return 0;
> > +}
>
> What is hdrlen here? Or rather, what kinds of bounds checking is needed
> here?

The prototype of asn1_action_t looks like this:

typedef int (*asn1_action_t)(void *context,
     size_t hdrlen, /* In case of ANY type */
     unsigned char tag, /* In case of ANY type */
     const void *value, size_t vlen);

I'm not an ASN.1 expert, but from studying asn1_ber_decoder(), it
looks like the core unit of an ASN.1 thing is a TLV, and hdrlen
represents the number of bytes in the datastream that make up the {TL}
portion. Based on the ANY comment above this seems to maybe be useful
for certain generic/undefined object types, but I think it's not
relevant to the types we're using. The vlen arg is the L value of the
TLV, which is what we save away in tpm2_key_context. In
asn1_ber_decoder(), I do see checks that what they pass for vlen stays
within the bounds of the source data buffer (since I knew you'd ask
:)).


>
> > +
> > +int tpm2_key_creation_hash(void *context, size_t hdrlen,
> > +                        unsigned char tag,
> > +                        const void *value, size_t vlen)
> > +{
> > +     struct tpm2_key_context *ctx = context;
> > +
> > +     ctx->creation_hash = value;
> > +     ctx->creation_hash_len = vlen;
> > +
> > +     return 0;
> > +}
> > +
> > +int tpm2_key_creation_tk(void *context, size_t hdrlen,
> > +                      unsigned char tag,
> > +                      const void *value, size_t vlen)
> > +{
> > +     struct tpm2_key_context *ctx = context;
> > +
> > +     ctx->creation_tk = value;
> > +     ctx->creation_tk_len = vlen;
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
> >   *
> > @@ -229,6 +385,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >                     struct trusted_key_options *options)
> >  {
> >       int blob_len = 0;
> > +     unsigned int offset;
> >       struct tpm_buf buf;
> >       u32 hash;
> >       u32 flags;
> > @@ -317,13 +474,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >               rc = -E2BIG;
> >               goto out;
> >       }
> > -     if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
> > +     offset = TPM_HEADER_SIZE + 4;
> > +     if (tpm_buf_length(&buf) < offset + blob_len) {
> >               rc = -EFAULT;
> >               goto out;
> >       }
> >
> >       blob_len = tpm2_key_encode(payload, options,
> > -                                &buf.data[TPM_HEADER_SIZE + 4],
> > +                                &buf.data[offset],
> >                                  blob_len);
> >
> >  out:
> > @@ -370,13 +528,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> >       int rc;
> >       u32 attrs;
> >
> > -     rc = tpm2_key_decode(payload, options, &blob);
> > -     if (rc) {
> > -             /* old form */
> > -             blob = payload->blob;
> > +     rc = tpm2_key_decode(payload, options);
> > +     if (rc)
> >               payload->old_format = 1;
> > -     }
> >
> > +     blob = payload->blob;
> >       /* new format carries keyhandle but old format doesn't */
> >       if (!options->keyhandle)
> >               return -EINVAL;
> > @@ -433,8 +589,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> >                       (__be32 *) &buf.data[TPM_HEADER_SIZE]);
> >
> >  out:
> > -     if (blob != payload->blob)
> > -             kfree(blob);
> >       tpm_buf_destroy(&buf);
> >
> >       if (rc > 0)
> > --
> > 2.31.0
> >
>
> Otherwise looks good!

Thank you for reviewing it!
-Evan
