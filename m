Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501F15BF0C8
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiITXEe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Sep 2022 19:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiITXEc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Sep 2022 19:04:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8BF4621F
        for <linux-integrity@vger.kernel.org>; Tue, 20 Sep 2022 16:04:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so6902334pjo.2
        for <linux-integrity@vger.kernel.org>; Tue, 20 Sep 2022 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LyrJKunt6Bv95Zben2BBaqPexfz0fVUlC+ujvmVQHyI=;
        b=NArXo2QMx4TXiiCrgwuPPdakfQgOVr4aL6SFd1TqZQFtDqr2871hq0U00cz2C5cYmy
         m7j//s0OdF1fkZc43YSPg8i4TgsZdoglKhC3IRqiAX41DU9GnEygwYYA075SA8wW4pRQ
         R0goHeVnhAUDQVY8bANL7I29S5kOGZwKvm2Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LyrJKunt6Bv95Zben2BBaqPexfz0fVUlC+ujvmVQHyI=;
        b=mmLrQjkcGdJl7iAktrLad7i48vPX38PlZJmgRm2qoEyPJQ27VJwM8VTQqs+U/MQ1bU
         dFRmpzlZYweKBreLMdQBQ+emPtKPqseJCiN2qQ4D52LVdtDKTWOSfJdnf/jPSEahmWji
         QJjKucZ8BqCHvspGB1QiZ+yC9eosOOQncWPOkjePz4uYX/XWtfkdl1R04Qjss+1/PG5N
         XzryngU12NapXs/3S3RlPmsHZVmZj6atNCFdaEV/xe1hWjn1rug3fSoGef0jY6d159Tr
         K1+PxU0A0gngfLy9jQYd6OY6BBKdYbGs6iQUpRANvtDFLXO1VgS1oGV56+CCv2QJBUVf
         D5qw==
X-Gm-Message-State: ACrzQf2tiYG2Q4vbykshdIgtUS2cYoLfGZfK14i+wVgAChwGh9eebhT6
        gaj0twjH58tZTJkzlDL2N3O4rw==
X-Google-Smtp-Source: AMsMyM4A4G2t2nwn3Gic6sgWIvEWBMwsw4D6wb3WzEtXD+3H5ZsbXoR4z32bXCFHZs9hTAyOl9EKZg==
X-Received: by 2002:a17:90b:1d87:b0:200:b6e1:7e9f with SMTP id pf7-20020a17090b1d8700b00200b6e17e9fmr6296859pjb.235.1663715067465;
        Tue, 20 Sep 2022 16:04:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001753654d9c5sm447991plg.95.2022.09.20.16.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 16:04:26 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:04:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 03/10] security: keys: trusted: Include TPM2 creation
 data
Message-ID: <202209201552.DF8C511D23@keescook>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.3.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823152108.v2.3.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 23, 2022 at 03:25:19PM -0700, Evan Green wrote:
> In addition to the private key and public key, the TPM2_Create
> command may also return creation data, a creation hash, and a creation
> ticket. These fields allow the TPM to attest to the contents of a
> specified set of PCRs at the time the trusted key was created. Encrypted
> hibernation will use this to ensure that PCRs settable only by the
> kernel were set properly at the time of creation, indicating this is an
> authentic hibernate key.
> 
> Encode these additional parameters into the ASN.1 created to represent
> the key blob. The new fields are made optional so that they don't bloat
> key blobs which don't need them, and to ensure interoperability with
> old blobs.
> 
> ---
> 
> (no changes since v1)
> 
> This is a replacement for Matthew's original patch here:
> https://patchwork.kernel.org/patch/12096489/
> 
> That patch was written before the exported key format was switched to
> ASN.1. This patch accomplishes the same thing (saving, loading, and
> getting pointers to the creation data) while utilizing the new ASN.1
> format.

This part (between your S-o-b and the "---") should got below the "---"
after your S-o-b, otherwise tooling will include it in the commit log
(or lose your S-o-b).

> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>  include/keys/trusted-type.h               |   8 +
>  security/keys/trusted-keys/tpm2key.asn1   |   5 +-
>  security/keys/trusted-keys/trusted_tpm2.c | 202 +++++++++++++++++++---
>  3 files changed, 190 insertions(+), 25 deletions(-)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 4eb64548a74f1a..209086fed240a5 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -22,15 +22,23 @@
>  #define MAX_BLOB_SIZE			512
>  #define MAX_PCRINFO_SIZE		64
>  #define MAX_DIGEST_SIZE			64
> +#define MAX_CREATION_DATA		412
> +#define MAX_TK				76
>  
>  struct trusted_key_payload {
>  	struct rcu_head rcu;
>  	unsigned int key_len;
>  	unsigned int blob_len;
> +	unsigned int creation_len;
> +	unsigned int creation_hash_len;
> +	unsigned int tk_len;
>  	unsigned char migratable;
>  	unsigned char old_format;
>  	unsigned char key[MAX_KEY_SIZE + 1];
>  	unsigned char blob[MAX_BLOB_SIZE];
> +	unsigned char *creation;
> +	unsigned char *creation_hash;
> +	unsigned char *tk;
>  };
>  
>  struct trusted_key_options {
> diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
> index f57f869ad60068..1bfbf290e523a3 100644
> --- a/security/keys/trusted-keys/tpm2key.asn1
> +++ b/security/keys/trusted-keys/tpm2key.asn1
> @@ -7,5 +7,8 @@ TPMKey ::= SEQUENCE {
>  	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
>  	parent		INTEGER ({tpm2_key_parent}),
>  	pubkey		OCTET STRING ({tpm2_key_pub}),
> -	privkey		OCTET STRING ({tpm2_key_priv})
> +	privkey		OCTET STRING ({tpm2_key_priv}),
> +	creationData	[1] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_data}),
> +	creationHash	[2] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_hash}),
> +	creationTk	[3] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_tk})
>  	}

Maybe include a link (or named reference) to these fields from the TPM
spec?

> [...]
> @@ -46,6 +49,26 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  
>  	pub_len = get_unaligned_be16(src) + 2;
>  	pub = src;
> +	src += pub_len;
> +
> +	creation_data_len = get_unaligned_be16(src);
> +	if (creation_data_len) {
> +		creation_data_len += 2;
> +		creation_data = src;
> +		src += creation_data_len;
> +
> +		creation_hash_len = get_unaligned_be16(src) + 2;
> +		creation_hash = src;
> +		src += creation_hash_len;
> +
> +		/*
> +		 * The creation ticket (TPMT_TK_CREATION) consists of a 2 byte
> +		 * tag, 4 byte handle, and then a TPM2B_DIGEST, which is a 2
> +		 * byte length followed by data.
> +		 */
> +		creation_tk_len = get_unaligned_be16(src + 6) + 8;
> +		creation_tk = src;
> +	}
>  
>  	if (!scratch)
>  		return -ENOMEM;

I don't see anything in this code (even before your patch) actually
checking length against the "len" argument to tpm2_key_encode(). I think
that needs to be fixed so proper bounds checking can be done here.
Otherwise how do we know if we're running off the end of "src"?

Yes, I realize if we have a malicious TPM everything goes out the
window, but TPMs don't always behave -- this code should likely be more
defensive. Or, I've misunderstood where "src" is coming from.
Regardless, my question stands: what is checking "len"?

> @@ -63,26 +86,81 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	}
>  
>  	/*
> -	 * Assume both octet strings will encode to a 2 byte definite length
> +	 * Assume each octet string will encode to a 2 byte definite length.
> +	 * Each optional octet string consumes one extra byte.
>  	 *
> -	 * Note: For a well behaved TPM, this warning should never
> -	 * trigger, so if it does there's something nefarious going on
> +	 * Note: For a well behaved TPM, this warning should never trigger, so
> +	 * if it does there's something nefarious going on
>  	 */
> -	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> -		 "BUG: scratch buffer is too small"))
> -		return -EINVAL;
> +	if (WARN(work - scratch + pub_len + priv_len + creation_data_len +
> +		 creation_hash_len + creation_tk_len + (7 * 5) + 3 >
> +		 SCRATCH_SIZE,
> +		 "BUG: scratch buffer is too small")) {
> +		rc = -EINVAL;
> +		goto err;
> +	}
>  
>  	work = asn1_encode_integer(work, end_work, options->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
>  	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
> +	if (creation_data_len) {
> +		u8 *scratch2 = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> +		u8 *work2;
> +		u8 *end_work2 = scratch2 + SCRATCH_SIZE;
> +
> +		if (!scratch2) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +
> +		work2 = asn1_encode_octet_string(scratch2,
> +						 end_work2,
> +						 creation_data,
> +						 creation_data_len);
> +
> +		work = asn1_encode_tag(work,
> +				       end_work,
> +				       1,
> +				       scratch2,
> +				       work2 - scratch2);
> +
> +		work2 = asn1_encode_octet_string(scratch2,
> +						 end_work2,
> +						 creation_hash,
> +						 creation_hash_len);
> +
> +		work = asn1_encode_tag(work,
> +				       end_work,
> +				       2,
> +				       scratch2,
> +				       work2 - scratch2);
> +
> +		work2 = asn1_encode_octet_string(scratch2,
> +						 end_work2,
> +						 creation_tk,
> +						 creation_tk_len);
> +
> +		work = asn1_encode_tag(work,
> +				       end_work,
> +				       3,
> +				       scratch2,
> +				       work2 - scratch2);
> +
> +		kfree(scratch2);
> +	}
>  
>  	work1 = payload->blob;
>  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
>  				     scratch, work - scratch);
> -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> -		return PTR_ERR(work1);
> +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> +		rc = PTR_ERR(work1);
> +		goto err;

I find the addition of the word "BUG" in a WARN() to be confusing. :) I
realize this is just copying the existing style, though.

> +	}
>  
>  	return work1 - payload->blob;
> +err:
> +	kfree(scratch);
> +	return rc;
>  }
>  
>  struct tpm2_key_context {
> @@ -91,15 +169,21 @@ struct tpm2_key_context {
>  	u32 pub_len;
>  	const u8 *priv;
>  	u32 priv_len;
> +	const u8 *creation_data;
> +	u32 creation_data_len;
> +	const u8 *creation_hash;
> +	u32 creation_hash_len;
> +	const u8 *creation_tk;
> +	u32 creation_tk_len;
>  };
>  
>  static int tpm2_key_decode(struct trusted_key_payload *payload,
> -			   struct trusted_key_options *options,
> -			   u8 **buf)
> +			   struct trusted_key_options *options)
>  {
> +	u64 data_len;
>  	int ret;
>  	struct tpm2_key_context ctx;
> -	u8 *blob;
> +	u8 *blob, *buf;
>  
>  	memset(&ctx, 0, sizeof(ctx));
>  
> @@ -108,21 +192,57 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> +	data_len = ctx.priv_len + ctx.pub_len + ctx.creation_data_len +
> +		   ctx.creation_hash_len + ctx.creation_tk_len;
> +
> +	if (data_len > MAX_BLOB_SIZE)
>  		return -EINVAL;
>  
> -	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> -	if (!blob)
> +	buf = kmalloc(data_len + 4, GFP_KERNEL);
> +	if (!buf)
>  		return -ENOMEM;
>  
> -	*buf = blob;
> +	blob = buf;
>  	options->keyhandle = ctx.parent;
>  
>  	memcpy(blob, ctx.priv, ctx.priv_len);
>  	blob += ctx.priv_len;
>  
>  	memcpy(blob, ctx.pub, ctx.pub_len);
> +	blob += ctx.pub_len;
> +	if (ctx.creation_data_len) {
> +		memcpy(blob, ctx.creation_data, ctx.creation_data_len);
> +		blob += ctx.creation_data_len;
> +	}
> +
> +	if (ctx.creation_hash_len) {
> +		memcpy(blob, ctx.creation_hash, ctx.creation_hash_len);
> +		blob += ctx.creation_hash_len;
> +	}
>  
> +	if (ctx.creation_tk_len) {
> +		memcpy(blob, ctx.creation_tk, ctx.creation_tk_len);
> +		blob += ctx.creation_tk_len;
> +	}
> +
> +	/*
> +	 * Copy the buffer back into the payload blob since the creation
> +	 * info will be used after loading.
> +	 */
> +	payload->blob_len = blob - buf;
> +	memcpy(payload->blob, buf, payload->blob_len);
> +	if (ctx.creation_data_len) {
> +		payload->creation = payload->blob + ctx.priv_len + ctx.pub_len;
> +		payload->creation_len = ctx.creation_data_len;
> +		payload->creation_hash = payload->creation + ctx.creation_data_len;
> +		payload->creation_hash_len = ctx.creation_hash_len;
> +		payload->tk = payload->creation_hash +
> +			      payload->creation_hash_len;
> +
> +		payload->tk_len = ctx.creation_tk_len;
> +	}
> +
> +	kfree(buf);
>  	return 0;
>  }
>  
> @@ -185,6 +305,42 @@ int tpm2_key_priv(void *context, size_t hdrlen,
>  	return 0;
>  }
>  
> +int tpm2_key_creation_data(void *context, size_t hdrlen,
> +			   unsigned char tag,
> +			   const void *value, size_t vlen)
> +{
> +	struct tpm2_key_context *ctx = context;
> +
> +	ctx->creation_data = value;
> +	ctx->creation_data_len = vlen;
> +
> +	return 0;
> +}

What is hdrlen here? Or rather, what kinds of bounds checking is needed
here?

> +
> +int tpm2_key_creation_hash(void *context, size_t hdrlen,
> +			   unsigned char tag,
> +			   const void *value, size_t vlen)
> +{
> +	struct tpm2_key_context *ctx = context;
> +
> +	ctx->creation_hash = value;
> +	ctx->creation_hash_len = vlen;
> +
> +	return 0;
> +}
> +
> +int tpm2_key_creation_tk(void *context, size_t hdrlen,
> +			 unsigned char tag,
> +			 const void *value, size_t vlen)
> +{
> +	struct tpm2_key_context *ctx = context;
> +
> +	ctx->creation_tk = value;
> +	ctx->creation_tk_len = vlen;
> +
> +	return 0;
> +}
> +
>  /**
>   * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
>   *
> @@ -229,6 +385,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		      struct trusted_key_options *options)
>  {
>  	int blob_len = 0;
> +	unsigned int offset;
>  	struct tpm_buf buf;
>  	u32 hash;
>  	u32 flags;
> @@ -317,13 +474,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		rc = -E2BIG;
>  		goto out;
>  	}
> -	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
> +	offset = TPM_HEADER_SIZE + 4;
> +	if (tpm_buf_length(&buf) < offset + blob_len) {
>  		rc = -EFAULT;
>  		goto out;
>  	}
>  
>  	blob_len = tpm2_key_encode(payload, options,
> -				   &buf.data[TPM_HEADER_SIZE + 4],
> +				   &buf.data[offset],
>  				   blob_len);
>  
>  out:
> @@ -370,13 +528,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	int rc;
>  	u32 attrs;
>  
> -	rc = tpm2_key_decode(payload, options, &blob);
> -	if (rc) {
> -		/* old form */
> -		blob = payload->blob;
> +	rc = tpm2_key_decode(payload, options);
> +	if (rc)
>  		payload->old_format = 1;
> -	}
>  
> +	blob = payload->blob;
>  	/* new format carries keyhandle but old format doesn't */
>  	if (!options->keyhandle)
>  		return -EINVAL;
> @@ -433,8 +589,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
>  
>  out:
> -	if (blob != payload->blob)
> -		kfree(blob);
>  	tpm_buf_destroy(&buf);
>  
>  	if (rc > 0)
> -- 
> 2.31.0
> 

Otherwise looks good!

-Kees

-- 
Kees Cook
