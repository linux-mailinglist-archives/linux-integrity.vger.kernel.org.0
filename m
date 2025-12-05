Return-Path: <linux-integrity+bounces-7813-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1ECA5F92
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 04:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0688130CFA04
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 03:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9856D277CB8;
	Fri,  5 Dec 2025 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U34gS8Xr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693C246BD2;
	Fri,  5 Dec 2025 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904446; cv=none; b=pafuh0vx9Xx6Dt00wnw5GFQpXY5SAJdtV+sbLF6AmVdW4t1gse2oFr96O0SmvnhMSh4fsy6wD4FYxfXbeUt+x0lTZm/kNheRHXNskHblLii4MsRT2WV+Ad8dFG1FMiONGsdlXOc+YVPEXEYj2Vnw3EzDsZQI6vq2Y7zVprM03yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904446; c=relaxed/simple;
	bh=aJhCd3j/dITOCRR2Qt9SgpeP99yK+jhEPhoHNyUjU4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqOPWp+j62jTKA+PZoH9WGkYaHrXlS8/Po9DN/UdwdYyeIqP+8I9S6Rm+xQytPptAyTOG+9z5oY80bewhLfSX0xzsijV/0z0OcVlvlu9URoXnuY/MLkvabJGKXVJgtlnQpDyTWs3EAaKR+jdQMxtE9m4SGUv4IBH2roCVjhYGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U34gS8Xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E163C4CEFB;
	Fri,  5 Dec 2025 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764904446;
	bh=aJhCd3j/dITOCRR2Qt9SgpeP99yK+jhEPhoHNyUjU4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U34gS8XrT3aSTWcKcCx0jYnSRdAbZycM3YMMv6yN5Dhn/q26at2xOsHU6iEWYqasP
	 O5smc8vCtLoNdK38NgRHt4pxbh0gv8NC9IDboisn78NjOYapYZIitp/I9lEJuplLX/
	 GPy1ra10tJMf/fSOsv00/XCopsBiIJt44O0IFQb9n6MJbz84SRmXaASJSOcr4aq3mU
	 30z6HycpYWZCnCEfL8QQ16YnIIgndAPin0+2DeECO1ZYNcMAHEcb9cLGnYAFBSIvUW
	 Zk/KS0ypi7Q63yE/c8/t7cd/P1fS5YmP5DaCspGvl6pqdAjTe6zQiddr0BID2WFxHy
	 mSVJjEkM7CIHQ==
Date: Fri, 5 Dec 2025 05:14:01 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] KEYS: trusted: Store parent's name to the encoded
 keys
Message-ID: <aTJN-TClJ0kNTu-v@kernel.org>
References: <20251205030205.140842-1-jarkko@kernel.org>
 <20251205030205.140842-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205030205.140842-3-jarkko@kernel.org>

On Fri, Dec 05, 2025 at 05:02:05AM +0200, Jarkko Sakkinen wrote:
> Extend TPMKey ASN.1 speciication [1] with an optional 'parentName'
> attribute containing TPM name of the parent key (in other words, TPMT_HA
> blob).
> 
> The life-cycle for trusted keys will now proceed as follows:
> 
> 1. Encode parent's name to the 'paretName' during tpm2_key_encode().
> 2. During tpm2_unseal_trusted, read parent's name from 'parentName'. When
>    the attribute is not available, fallback on doing tpm2_read_public().
> 
> In other words, in the common (i.e., not loading a legacy key blob),
> tpm2_read_public() will now only happen at the time when a key is first
> created.
> 
> [1] https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - A new patch.
> ---
>  security/keys/trusted-keys/tpm2key.asn1   | 17 +++-
>  security/keys/trusted-keys/trusted_tpm2.c | 97 ++++++++++++++++-------
>  2 files changed, 84 insertions(+), 30 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
> index f57f869ad600..080f0e399982 100644
> --- a/security/keys/trusted-keys/tpm2key.asn1
> +++ b/security/keys/trusted-keys/tpm2key.asn1
> @@ -1,11 +1,26 @@
>  ---
>  --- ASN.1 for TPM 2.0 keys
>  ---
> +TPMPolicy ::= SEQUENCE {
> +	commandCode	[0] EXPLICIT INTEGER,
> +	commandPolicy	[1] EXPLICIT OCTET STRING
> +}
> +
> +TPMAuthPolicy ::= SEQUENCE {
> +	name		[0] EXPLICIT UTF8String OPTIONAL,
> +	policy		[1] EXPLICIT SEQUENCE OF TPMPolicy
> +}
>  
>  TPMKey ::= SEQUENCE {
>  	type		OBJECT IDENTIFIER ({tpm2_key_type}),
>  	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> +	policy		[1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL,
> +	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
> +	authPolicy	[3] EXPLICIT SEQUENCE OF TPMAuthPolicy OPTIONAL,
> +	description	[4] EXPLICIT UTF8String OPTIONAL,
> +	rsaParent	[5] EXPLICIT BOOLEAN OPTIONAL,
> +	parentName	[6] EXPLICIT OCTET STRING ({tpm2_key_parent_name}),

Another nit. Should probably be instead:

	parentName	[6] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_parent_name}),

>  	parent		INTEGER ({tpm2_key_parent}),
>  	pubkey		OCTET STRING ({tpm2_key_pub}),
>  	privkey		OCTET STRING ({tpm2_key_priv})
> -	}
> +}
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 88bafbcc011a..3608dc9f7fa4 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -20,16 +20,26 @@
>  
>  static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
>  
> +enum tpm_key_tag {
> +	TPM_KEY_TAG_EMPTY_AUTH	= 0,
> +	TPM_KEY_TAG_POLICY	= 1,
> +	TPM_KEY_TAG_SECRET	= 2,
> +	TPM_KEY_TAG_AUTH_POLICY	= 3,
> +	TPM_KEY_TAG_DESCRIPTION = 4,
> +	TPM_KEY_TAG_RSA_PARENT	= 5,
> +	TPM_KEY_TAG_PARENT_NAME	= 6,
> +};
> +
>  static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
> -			   u8 *src, u32 len)
> +			   u8 *src, u32 len, u8 *parent_name,
> +			   u16 parent_name_size)
>  {
>  	const int SCRATCH_SIZE = PAGE_SIZE;
> -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> -	u8 *work = scratch, *work1;
> -	u8 *end_work = scratch + SCRATCH_SIZE;
> -	u8 *priv, *pub;
> +	u8 *end_work, *name_end;
>  	u16 priv_len, pub_len;
> +	u8 *work, *work1;
> +	u8 *priv, *pub;
>  	int ret;
>  
>  	priv_len = get_unaligned_be16(src) + 2;
> @@ -40,23 +50,41 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	pub_len = get_unaligned_be16(src) + 2;
>  	pub = src;
>  
> +	u8 *scratch __free(kfree) = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>  	if (!scratch)
>  		return -ENOMEM;
>  
> +	work = scratch;
> +	end_work = scratch + SCRATCH_SIZE;
> +
>  	work = asn1_encode_oid(work, end_work, tpm2key_oid,
>  			       asn1_oid_len(tpm2key_oid));
>  
>  	if (options->blobauth_len == 0) {
> -		unsigned char bool[3], *w = bool;
> -		/* tag 0 is emptyAuth */
> -		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> -			ret = PTR_ERR(w);
> -			goto err;
> +		u8 *bool_end;
> +		u8 bool[3];
> +
> +		bool_end = asn1_encode_boolean(&bool[0], &bool[sizeof(bool)],
> +					       true);
> +		if (IS_ERR(bool_end)) {
> +			pr_err("BUG: Boolean failed to encode\n");
> +			return PTR_ERR(bool_end);
>  		}
> -		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> +
> +		work = asn1_encode_tag(work, end_work, TPM_KEY_TAG_EMPTY_AUTH,
> +				       bool, bool_end - bool);
>  	}
>  
> +	u8 *name_encoded __free(kfree) = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> +	if (!name_encoded)
> +		return -ENOMEM;
> +
> +	name_end = asn1_encode_octet_string(&name_encoded[0],
> +					    &name_encoded[SCRATCH_SIZE],
> +					    parent_name, parent_name_size);
> +	work = asn1_encode_tag(work, end_work, TPM_KEY_TAG_PARENT_NAME,
> +			       name_encoded, name_end - name_encoded);
> +
>  	/*
>  	 * Assume both octet strings will encode to a 2 byte definite length
>  	 *
> @@ -65,8 +93,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	 */
>  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
>  		 "BUG: scratch buffer is too small")) {
> -		ret = -EINVAL;
> -		goto err;
> +		return -EINVAL;
>  	}
>  
>  	work = asn1_encode_integer(work, end_work, options->keyhandle);
> @@ -79,15 +106,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	if (IS_ERR(work1)) {
>  		ret = PTR_ERR(work1);
>  		pr_err("BUG: ASN.1 encoder failed with %d\n", ret);
> -		goto err;
> +		return ret;
>  	}
>  
> -	kfree(scratch);
>  	return work1 - payload->blob;
> -
> -err:
> -	kfree(scratch);
> -	return ret;
>  }
>  
>  struct tpm2_key_context {
> @@ -96,11 +118,13 @@ struct tpm2_key_context {
>  	u32 pub_len;
>  	const u8 *priv;
>  	u32 priv_len;
> +	const u8 *name;
> +	u32 name_len;
>  };
>  
>  static int tpm2_key_decode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
> -			   u8 **buf)
> +			   u8 **buf, u8 *parent_name, u16 *parent_name_size)
>  {
>  	int ret;
>  	struct tpm2_key_context ctx;
> @@ -127,6 +151,8 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>  	blob += ctx.priv_len;
>  
>  	memcpy(blob, ctx.pub, ctx.pub_len);
> +	memcpy(parent_name, ctx.name, ctx.name_len);
> +	*parent_name_size = ctx.name_len;
>  
>  	return 0;
>  }
> @@ -190,6 +216,16 @@ int tpm2_key_priv(void *context, size_t hdrlen,
>  	return 0;
>  }
>  
> +int tpm2_key_parent_name(void *context, size_t hdrlen, unsigned char tag,
> +			 const void *value, size_t vlen)
> +{
> +	struct tpm2_key_context *ctx = context;
> +
> +	ctx->name = value;
> +	ctx->name_len = vlen;
> +
> +	return 0;
> +}
>  /**
>   * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
>   *
> @@ -347,7 +383,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		goto out;
>  	}
>  
> -	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
> +	blob_len = tpm2_key_encode(payload, options, &buf.data[offset],
> +				   blob_len, parent_name, parent_name_size);
>  	if (blob_len < 0)
>  		rc = blob_len;
>  
> @@ -602,7 +639,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>  	 * Try to decode the provided blob as an ASN.1 blob. Assume that the
>  	 * blob is in the legacy format if decoding does not end successfully.
>  	 */
> -	rc = tpm2_key_decode(payload, options, &blob);
> +	rc = tpm2_key_decode(payload, options, &blob, &parent_name[0], &parent_name_size);
>  	if (rc) {
>  		blob = payload->blob;
>  		payload->old_format = 1;
> @@ -613,16 +650,18 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>  	if (!options->keyhandle)
>  		return -EINVAL;
>  
> +	if (!parent_name_size) {
> +		rc = tpm2_read_public(chip, options->keyhandle, parent_name);
> +		if (rc < 0)
> +			goto out;
> +
> +		parent_name_size = rc;
> +	}
> +
>  	rc = tpm_try_get_ops(chip);
>  	if (rc)
>  		return rc;
>  
> -	rc = tpm2_read_public(chip, options->keyhandle, parent_name);
> -	if (rc < 0)
> -		goto out;
> -
> -	parent_name_size = rc;
> -
>  	rc = tpm2_load_cmd(chip, payload, options, parent_name,
>  			   parent_name_size, blob, &blob_handle);
>  	if (rc)
> -- 
> 2.52.0
> 

BR, Jarkko

