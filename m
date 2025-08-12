Return-Path: <linux-integrity+bounces-6802-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A08B22D90
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B46188A81A
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE612F90E7;
	Tue, 12 Aug 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVaBBEQ5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143A2F8BF1;
	Tue, 12 Aug 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015888; cv=none; b=hgrUzyuFV5jquRPWTGovo1NNAUJn6FzHjLPQYAi6bXKmE/7tY5vpjn1iQffV3k5FYYwkGakQPruARHiM9Mzqj8IvRNg3qfhR0pK2z4SHBqVZVziZF1FIf36xpkJpn1FipKB5x4qnf7Y2fLT8T9HY2jmNJO4vwpaZtL1r2DLSYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015888; c=relaxed/simple;
	bh=aZf6SP2fk9Djm2JEb1vAUDTmysjNgRoO5cPDEc6gIhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDP7oKvmpVhX6nl1DG4323V+TDx5m4tDOfvA5W5wknlFYisui/XlTkOV4iqAeXqEA2A0jJ/7Mw89aS9Xz113LccqS1ICjC5g3IOqDp8Fwu275Qj/rO9NvOa8X88HlxDX8pGKeaFFdaOFW7/hX2T3VZ+wJKHW88P/ldqCqagRAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVaBBEQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F0CC4CEF0;
	Tue, 12 Aug 2025 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015888;
	bh=aZf6SP2fk9Djm2JEb1vAUDTmysjNgRoO5cPDEc6gIhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVaBBEQ54NxI83W8wN4P4JMJvaHj6wRBM027q0s1VMCycp+POTlYqLc7lQxE7U1yx
	 oOGBdyfc+p8GVlitSJhayra05ja8advCgNEM6R+5vhVrRQgyp572KywP07Js98Emjy
	 h03xZHtgB4QszRf8Rp2Fd5/n62kEXrh3DIlsvz9wau6TsSINhJz5Cx/i3njx/fUtby
	 kdTxygLtHwuj6A2DzB4BXajhbm6qE4HybpprrfINJrxhUBVaY6/PqALmJsx9k4Jn/6
	 lpqePaVamIjjQn35lXbYw/gBsqOBUZ6sagWrqrpkTFz9EnVkImFwOZnwuVOxvvpPn9
	 ky8dW6srw0wUw==
Date: Tue, 12 Aug 2025 19:24:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KEYS: trusted_tpm1: Move private functionality
 out of public header
Message-ID: <aJtqzCubWsVXqWgS@kernel.org>
References: <20250809171941.5497-1-ebiggers@kernel.org>
 <20250809171941.5497-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809171941.5497-4-ebiggers@kernel.org>

On Sat, Aug 09, 2025 at 10:19:41AM -0700, Eric Biggers wrote:
> Move functionality used only by trusted_tpm1.c out of the public header
> <keys/trusted_tpm.h>.  Specifically, change the exported functions into
> static functions, since they are not used outside trusted_tpm1.c, and
> move various other definitions and inline functions to trusted_tpm1.c.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  include/keys/trusted_tpm.h                | 79 ----------------------
>  security/keys/trusted-keys/trusted_tpm1.c | 80 ++++++++++++++++++++---
>  2 files changed, 72 insertions(+), 87 deletions(-)
> 
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index a088b33fd0e3b..0fadc6a4f1663 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -3,94 +3,15 @@
>  #define __TRUSTED_TPM_H
>  
>  #include <keys/trusted-type.h>
>  #include <linux/tpm_command.h>
>  
> -/* implementation specific TPM constants */
> -#define TPM_SIZE_OFFSET			2
> -#define TPM_RETURN_OFFSET		6
> -#define TPM_DATA_OFFSET			10
> -
> -#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
> -#define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
> -#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
> -
>  extern struct trusted_key_ops trusted_key_tpm_ops;
>  
> -struct osapsess {
> -	uint32_t handle;
> -	unsigned char secret[SHA1_DIGEST_SIZE];
> -	unsigned char enonce[TPM_NONCE_SIZE];
> -};
> -
> -/* discrete values, but have to store in uint16_t for TPM use */
> -enum {
> -	SEAL_keytype = 1,
> -	SRK_keytype = 4
> -};
> -
> -int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> -			unsigned int keylen, unsigned char *h1,
> -			unsigned char *h2, unsigned int h3, ...);
> -int TSS_checkhmac1(unsigned char *buffer,
> -			  const uint32_t command,
> -			  const unsigned char *ononce,
> -			  const unsigned char *key,
> -			  unsigned int keylen, ...);
> -
> -int trusted_tpm_send(unsigned char *cmd, size_t buflen);
> -int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
> -
>  int tpm2_seal_trusted(struct tpm_chip *chip,
>  		      struct trusted_key_payload *payload,
>  		      struct trusted_key_options *options);
>  int tpm2_unseal_trusted(struct tpm_chip *chip,
>  			struct trusted_key_payload *payload,
>  			struct trusted_key_options *options);
>  
> -#define TPM_DEBUG 0
> -
> -#if TPM_DEBUG
> -static inline void dump_options(struct trusted_key_options *o)
> -{
> -	pr_info("sealing key type %d\n", o->keytype);
> -	pr_info("sealing key handle %0X\n", o->keyhandle);
> -	pr_info("pcrlock %d\n", o->pcrlock);
> -	pr_info("pcrinfo %d\n", o->pcrinfo_len);
> -	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
> -		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> -}
> -
> -static inline void dump_sess(struct osapsess *s)
> -{
> -	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
> -		       16, 1, &s->handle, 4, 0);
> -	pr_info("secret:\n");
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> -		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
> -	pr_info("trusted-key: enonce:\n");
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> -		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
> -}
> -
> -static inline void dump_tpm_buf(unsigned char *buf)
> -{
> -	int len;
> -
> -	pr_info("\ntpm buffer\n");
> -	len = LOAD32(buf, TPM_SIZE_OFFSET);
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
> -}
> -#else
> -static inline void dump_options(struct trusted_key_options *o)
> -{
> -}
> -
> -static inline void dump_sess(struct osapsess *s)
> -{
> -}
> -
> -static inline void dump_tpm_buf(unsigned char *buf)
> -{
> -}
> -#endif
>  #endif
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 126437459a74d..636acb66a4f69 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -22,10 +22,78 @@
>  #include <keys/trusted_tpm.h>
>  
>  static struct tpm_chip *chip;
>  static struct tpm_digest *digests;
>  
> +/* implementation specific TPM constants */
> +#define TPM_SIZE_OFFSET			2
> +#define TPM_RETURN_OFFSET		6
> +#define TPM_DATA_OFFSET			10
> +
> +#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
> +#define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
> +#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
> +
> +struct osapsess {
> +	uint32_t handle;
> +	unsigned char secret[SHA1_DIGEST_SIZE];
> +	unsigned char enonce[TPM_NONCE_SIZE];
> +};
> +
> +/* discrete values, but have to store in uint16_t for TPM use */
> +enum {
> +	SEAL_keytype = 1,
> +	SRK_keytype = 4
> +};
> +
> +#define TPM_DEBUG 0
> +
> +#if TPM_DEBUG
> +static inline void dump_options(struct trusted_key_options *o)
> +{
> +	pr_info("sealing key type %d\n", o->keytype);
> +	pr_info("sealing key handle %0X\n", o->keyhandle);
> +	pr_info("pcrlock %d\n", o->pcrlock);
> +	pr_info("pcrinfo %d\n", o->pcrinfo_len);
> +	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
> +		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> +}
> +
> +static inline void dump_sess(struct osapsess *s)
> +{
> +	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
> +		       16, 1, &s->handle, 4, 0);
> +	pr_info("secret:\n");
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> +		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
> +	pr_info("trusted-key: enonce:\n");
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
> +		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
> +}
> +
> +static inline void dump_tpm_buf(unsigned char *buf)
> +{
> +	int len;
> +
> +	pr_info("\ntpm buffer\n");
> +	len = LOAD32(buf, TPM_SIZE_OFFSET);
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
> +}
> +#else
> +static inline void dump_options(struct trusted_key_options *o)
> +{
> +}
> +
> +static inline void dump_sess(struct osapsess *s)
> +{
> +}
> +
> +static inline void dump_tpm_buf(unsigned char *buf)
> +{
> +}
> +#endif
> +
>  static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>  		       unsigned int keylen, ...)
>  {
>  	struct hmac_sha1_ctx hmac_ctx;
>  	va_list argp;
> @@ -54,11 +122,11 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>  }
>  
>  /*
>   * calculate authorization info fields to send to TPM
>   */
> -int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> +static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  			unsigned int keylen, unsigned char *h1,
>  			unsigned char *h2, unsigned int h3, ...)
>  {
>  	unsigned char paramdigest[SHA1_DIGEST_SIZE];
>  	struct sha1_ctx sha_ctx;
> @@ -92,16 +160,15 @@ int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
>  				  paramdigest, TPM_NONCE_SIZE, h1,
>  				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(TSS_authhmac);
>  
>  /*
>   * verify the AUTH1_COMMAND (Seal) result from TPM
>   */
> -int TSS_checkhmac1(unsigned char *buffer,
> +static int TSS_checkhmac1(unsigned char *buffer,
>  			  const uint32_t command,
>  			  const unsigned char *ononce,
>  			  const unsigned char *key,
>  			  unsigned int keylen, ...)
>  {
> @@ -157,11 +224,10 @@ int TSS_checkhmac1(unsigned char *buffer,
>  
>  	if (crypto_memneq(testhmac, authdata, SHA1_DIGEST_SIZE))
>  		return -EINVAL;
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(TSS_checkhmac1);
>  
>  /*
>   * verify the AUTH2_COMMAND (unseal) result from TPM
>   */
>  static int TSS_checkhmac2(unsigned char *buffer,
> @@ -242,11 +308,11 @@ static int TSS_checkhmac2(unsigned char *buffer,
>  
>  /*
>   * For key specific tpm requests, we will generate and send our
>   * own TPM command packets using the drivers send function.
>   */
> -int trusted_tpm_send(unsigned char *cmd, size_t buflen)
> +static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>  {
>  	struct tpm_buf buf;
>  	int rc;
>  
>  	if (!chip)
> @@ -268,11 +334,10 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>  		rc = -EPERM;
>  
>  	tpm_put_ops(chip);
>  	return rc;
>  }
> -EXPORT_SYMBOL_GPL(trusted_tpm_send);
>  
>  /*
>   * Lock a trusted key, by extending a selected PCR.
>   *
>   * Prevents a trusted key that is sealed to PCRs from being accessed.
> @@ -322,11 +387,11 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
>  }
>  
>  /*
>   * Create an object independent authorisation protocol (oiap) session
>   */
> -int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
> +static int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
>  {
>  	int ret;
>  
>  	if (!chip)
>  		return -ENODEV;
> @@ -339,11 +404,10 @@ int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
>  	*handle = LOAD32(tb->data, TPM_DATA_OFFSET);
>  	memcpy(nonce, &tb->data[TPM_DATA_OFFSET + sizeof(uint32_t)],
>  	       TPM_NONCE_SIZE);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(oiap);
>  
>  struct tpm_digests {
>  	unsigned char encauth[SHA1_DIGEST_SIZE];
>  	unsigned char pubauth[SHA1_DIGEST_SIZE];
>  	unsigned char xorwork[SHA1_DIGEST_SIZE * 2];
> -- 
> 2.50.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

