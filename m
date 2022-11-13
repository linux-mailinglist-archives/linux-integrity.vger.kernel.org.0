Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708A6272AC
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Nov 2022 22:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiKMVUQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 16:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiKMVUM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 16:20:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BF7FD1C;
        Sun, 13 Nov 2022 13:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C17360C55;
        Sun, 13 Nov 2022 21:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02104C433C1;
        Sun, 13 Nov 2022 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668374408;
        bh=e4x8dm158+t01HeZwuDAJkMqiJRA7iQ9G4cpg0AnyJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDN1NhCaF35rwiGhPls7DeRrVTe5FprK11yZl19ww0Qw5uVbl1tsPLzATms6kxcCD
         IUrgSL8aw0iGLA8UBkkIuDPzJLz6/V6PwO/Q9zZNW59RzxTe3jizt9zU/1NyxA0Uig
         HifF3t4PGRKvCNFxFs078dnuguUeQ9x/KPsfSAlz2cFYn6a/eJjmb0pA58MQzRxvdp
         YpTPvv1K8zPIB4EFpFqO+Dzt5ycO40z6qpBokTstfa/7QEw2GwZ2RiacgaTj3bVeqK
         3Z7z7fwz1Mzcn9ypcL2bJfVfb+9cHsWvi+z0tOEz2maE02kSAh+ngYlAxzCANCtCMd
         /NADXDVw8ghow==
Date:   Sun, 13 Nov 2022 13:20:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 04/11] security: keys: trusted: Include TPM2 creation
 data
Message-ID: <Y3FfhrgvBNey6T7V@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:29PM -0800, Evan Green wrote:
> diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
> index f57f869ad60068..608f8d9ca95fa8 100644
> --- a/security/keys/trusted-keys/tpm2key.asn1
> +++ b/security/keys/trusted-keys/tpm2key.asn1
> @@ -7,5 +7,18 @@ TPMKey ::= SEQUENCE {
>  	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
>  	parent		INTEGER ({tpm2_key_parent}),
>  	pubkey		OCTET STRING ({tpm2_key_pub}),
> -	privkey		OCTET STRING ({tpm2_key_priv})
> +	privkey		OCTET STRING ({tpm2_key_priv}),
> +	---
> +	--- A TPM2B_CREATION_DATA struct as returned from the TPM2_Create command.
> +	---
> +	creationData	[1] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_data}),
> +	---
> +	--- A TPM2B_DIGEST of the creationHash as returned from the TPM2_Create
> +	--- command.
> +	---
> +	creationHash	[2] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_hash}),
> +	---
> +	--- A TPMT_TK_CREATION ticket as returned from the TPM2_Create command.
> +	---
> +	creationTk	[3] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_tk})
>  	}

The commit that added this file claimed:

	"The benefit of the ASN.1 format is that it's a standard and thus the
	exported key can be used by userspace tools (openssl_tpm2_engine,
	openconnect and tpm2-tss-engine"

Are these new fields in compliance with whatever standard that was referring to?

Or was that just referring to ASN.1 itself?

> +/* Helper function to advance past a __be16 length + buffer safely */
> +static const u8 *get_sized_section(const u8 *src, const u8 *end, u16 *len)
> +{
> +	u32 length;
> +
> +	if (src + sizeof(u16) > end)
> +		return NULL;

'end - src < sizeof(u16)', so the pointer isn't advanced past the end.

> +
> +	/* Include the size field in the returned section length. */
> +	length = get_unaligned_be16(src) + sizeof(u16);
> +	*len = length;
> +	if (*len != length)
> +		return NULL;
> +
> +	src += *len;
> +	if (src > end)
> +		return NULL;
> +
> +	return src;

Similarly:

	if (end - src < *len)
		return NULL;

	return src + *len;

> +		/*
> +		 * The creation ticket (TPMT_TK_CREATION) consists of a 2 byte
> +		 * tag, 4 byte handle, and then a TPM2B_DIGEST, which is a 2
> +		 * byte length followed by data.
> +		 */
> +		if (src + 8 > end)

end - src < 8

And actually it really should be 6 instead of 8, to match the code below.
get_sized_section() already validates that there are at least 2 more bytes.

> +			return -EINVAL;
> +
> +		creation_tk = src;
> +		src = get_sized_section(src + 6, end, &creation_tk_len);
> +		if (!src)
> +			return -EINVAL;
> +
> +		creation_tk_len += 6;
> +
> +	} else {
> +		creation_data_len = 0;
> +		creation_data = NULL;
> +	}
>  
>  	if (!scratch)
>  		return -ENOMEM;
> @@ -63,26 +125,81 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
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

This appears to be fixing a memory leak in the error case.

The same memory leak also still appears above in:

	if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
		return PTR_ERR(w);

Maybe both should be fixed in a separate patch.

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

There's no helper function to do these two steps together?

> +
> -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> -		return PTR_ERR(work1);
> +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> +		rc = PTR_ERR(work1);
> +		goto err;
> +	}
>  
>  	return work1 - payload->blob;
> +err:
> +	kfree(scratch);
> +	return rc;

Is this another memory leak fix that is unrelated to the functionality added by
this patch?

Also, isn't 'scratch' still being leaked in the success case?

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
> @@ -108,21 +231,57 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> +	data_len = ctx.priv_len + ctx.pub_len + ctx.creation_data_len +
> +		   ctx.creation_hash_len + ctx.creation_tk_len;

It's unclear why 'data_len' is a u64, given that the value assigned to it always
fits in a u32.  Perhaps you intended to do the additions with 64-bit numbers so
that they can't overflow.

But shouldn't the lengths already be bounded by size of the ASN.1 blob before
even reaching here, anyway?

> +
> +	if (data_len > MAX_BLOB_SIZE)
>  		return -EINVAL;
>  
> -	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> -	if (!blob)
> +	buf = kmalloc(data_len + 4, GFP_KERNEL);
> +	if (!buf)
>  		return -ENOMEM;

It's unclear what the '+ 4' is for.

> @@ -229,6 +424,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		      struct trusted_key_options *options)
>  {
>  	int blob_len = 0;
> +	unsigned int offset;
>  	struct tpm_buf buf;
>  	u32 hash;
>  	u32 flags;
> @@ -317,13 +513,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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

This hunk of the patch doesn't seem to serve any purpose.

- Eric
