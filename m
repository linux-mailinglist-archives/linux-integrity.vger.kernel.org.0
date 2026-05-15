Return-Path: <linux-integrity+bounces-9583-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GChEsOqB2pSBQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9583-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:22:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD455954D
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AF8B3004DCF
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C673F6C2C;
	Fri, 15 May 2026 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2iOld4o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7B3F5BF6;
	Fri, 15 May 2026 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887360; cv=none; b=krrLtEhbghN/jHpgKSBnhrtuBMyfcBCtutwzwzuvvwiZKjf9inslC0h+/zYiOx+ZgjJW4DKjww8JAyrFT6o6JS+mTObKL//ns2YSm63IEJFqMvF9tj3ySvmf8ehgBBc77xOu0TyAIdsGgoIjpkX4LSbJGRmMV5tV2GmtR+qprlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887360; c=relaxed/simple;
	bh=JjdiscWBA7In+U808NTJOLwYQaUm2OEpp51K4Ey+p44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncR9+gWI3q+nxjGfZLXdR/XUeH6YWnIqJa2IxX+kPce+ycM+xxaBmQaLjMvkWknT4nfmVundCA0FFfLe/MgM6+wvWUMTWh//pSTw71TqdKSmklWsQ75J5G9hsbJ8LyJyBfPeLSHvuNOfGy2RJZy5PdSJOVRya1JsyHqNBRjj26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2iOld4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9971DC2BCB0;
	Fri, 15 May 2026 23:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778887360;
	bh=JjdiscWBA7In+U808NTJOLwYQaUm2OEpp51K4Ey+p44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2iOld4olFaHTJRGBeyZvyj92sWp+Y17gtpKe3TEepX4oKM34zMmuakyRbrgKE3ge
	 pvWEthzo2xMZjEAYU3OHlHlQIJ/haRJ3AYfgZ87H3I2M+tNVFEojjVNONutewDW2xb
	 DQ9+QwDjwwKw5mxnmM1lEGHXIKUsAHJHhrw0+iY05zX15wyKHzxVoiC4prXFclJpQJ
	 q37++DG72iRmFdsDAuUPvqx3YaxoJvbDbDJTAXjUOyc2YE3qRGtZcBd+jGTnlzwbDc
	 br5x1RiU59q40dnIMPyNHUKsGsuzCmE7LLTVeNj1y6MFdpNT1QeUvOFBzx6AM3pm50
	 pnbBHdbCNB5Ww==
Date: Sat, 16 May 2026 02:22:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v16 04/38] tpm: Move TPM common base definitions to the
 command header
Message-ID: <ageqvDfgVk1nh2-w@kernel.org>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-5-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515211410.31440-5-ross.philipson@gmail.com>
X-Rspamd-Queue-Id: E1AD455954D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9583-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:13:36PM -0700, Ross Philipson wrote:
> These are top level definitions shared by both TPM 1 and 2
> family chips. This includes core definitions like TPM localities,
> common crypto algorithm IDs, and the base TPM command header.
> 
> Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
> Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
> Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
> ---
>  include/linux/tpm.h         | 50 +--------------------
>  include/linux/tpm_command.h | 89 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 49 deletions(-)
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 8551b24c2bff..3630b2ea6aef 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -27,49 +27,12 @@
>  
>  #include <linux/tpm_command.h>
>  
> -#define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> -
> -#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> -#define TPM2_MAX_PCR_BANKS	8
> -
>  struct tpm_chip;
>  struct trusted_key_payload;
>  struct trusted_key_options;
>  /* opaque structure, holds auth session parameters like the session key */
>  struct tpm2_auth;
>  
> -/* if you add a new hash to this, increment TPM_MAX_HASHES below */
> -enum tpm_algorithms {
> -	TPM_ALG_ERROR		= 0x0000,
> -	TPM_ALG_SHA1		= 0x0004,
> -	TPM_ALG_AES		= 0x0006,
> -	TPM_ALG_KEYEDHASH	= 0x0008,
> -	TPM_ALG_SHA256		= 0x000B,
> -	TPM_ALG_SHA384		= 0x000C,
> -	TPM_ALG_SHA512		= 0x000D,
> -	TPM_ALG_NULL		= 0x0010,
> -	TPM_ALG_SM3_256		= 0x0012,
> -	TPM_ALG_ECC		= 0x0023,
> -	TPM_ALG_CFB		= 0x0043,
> -};
> -
> -/*
> - * maximum number of hashing algorithms a TPM can have.  This is
> - * basically a count of every hash in tpm_algorithms above
> - */
> -#define TPM_MAX_HASHES	5
> -
> -struct tpm_digest {
> -	u16 alg_id;
> -	u8 digest[TPM2_MAX_DIGEST_SIZE];
> -} __packed;
> -
> -struct tpm_bank_info {
> -	u16 alg_id;
> -	u16 digest_size;
> -	u16 crypto_id;
> -};
> -
>  enum TPM_OPS_FLAGS {
>  	TPM_OPS_AUTO_STARTUP = BIT(0),
>  };
> @@ -127,7 +90,7 @@ struct tpm_chip_seqops {
>  	const struct seq_operations *seqops;
>  };
>  
> -/* fixed define for the curve we use which is NIST_P256 */
> +/* Fixed define for the curve we use which is NIST_P256 */
>  #define EC_PT_SZ	32
>  
>  /*
> @@ -209,8 +172,6 @@ struct tpm_chip {
>  #endif
>  };
>  
> -#define TPM_HEADER_SIZE		10
> -
>  static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
>  {
>  	return handle >> 24;
> @@ -239,15 +200,6 @@ enum tpm_chip_flags {
>  
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>  
> -struct tpm_header {
> -	__be16 tag;
> -	__be32 length;
> -	union {
> -		__be32 ordinal;
> -		__be32 return_code;
> -	};
> -} __packed;
> -
>  enum tpm_buf_flags {
>  	/* the capacity exceeded: */
>  	TPM_BUF_OVERFLOW	= BIT(0),
> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> index 9dd903dd6b5c..96edebd9610f 100644
> --- a/include/linux/tpm_command.h
> +++ b/include/linux/tpm_command.h
> @@ -427,4 +427,93 @@ struct tpm2_context {
>  	__be16 blob_size;
>  } __packed;
>  
> +/*
> + * == TPM Common Defs ==
> + */
> +
> +#define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
> +#define TPM_BUFSIZE		4096
> +
> +/*
> + * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
> + */
> +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> +
> +/*
> + * A TPM name digest i.e., TPMT_HA, is a concatenation of TPM_ALG_ID of the
> + * name algorithm and hash of TPMT_PUBLIC.
> + */
> +#define TPM2_MAX_NAME_SIZE	(TPM2_MAX_DIGEST_SIZE + 2)
> +
> +/*
> + * Fixed define for the size of a name.  This is actually HASHALG size
> + * plus 2, so 32 for SHA256
> + */
> +#define TPM2_NULL_NAME_SIZE	34
> +
> +/*
> + * The maximum number of PCR banks.
> + */
> +#define TPM2_MAX_PCR_BANKS	8
> +
> +/* If you add a new hash to this, increment TPM_MAX_HASHES below */
> +enum tpm_algorithms {
> +	TPM_ALG_ERROR		= 0x0000,
> +	TPM_ALG_SHA1		= 0x0004,
> +	TPM_ALG_AES		= 0x0006,
> +	TPM_ALG_KEYEDHASH	= 0x0008,
> +	TPM_ALG_SHA256		= 0x000B,
> +	TPM_ALG_SHA384		= 0x000C,
> +	TPM_ALG_SHA512		= 0x000D,
> +	TPM_ALG_NULL		= 0x0010,
> +	TPM_ALG_SM3_256		= 0x0012,
> +	TPM_ALG_ECC		= 0x0023,
> +	TPM_ALG_CFB		= 0x0043,
> +};
> +
> +/*
> + * The locality (0 - 4) for a TPM, as defined in section 3.2 of the
> + * Client Platform Profile Specification.
> + */
> +enum tpm_localities {
> +	TPM_LOCALITY_0		= 0, /* Static RTM */
> +	TPM_LOCALITY_1		= 1, /* Dynamic OS */
> +	TPM_LOCALITY_2		= 2, /* DRTM Environment */
> +	TPM_LOCALITY_3		= 3, /* Aux Components */
> +	TPM_LOCALITY_4		= 4, /* CPU DRTM Establishment */
> +	TPM_MAX_LOCALITY	= TPM_LOCALITY_4
> +};
> +
> +/*
> + * Structure to represent active PCR algorithm banks usable by the
> + * TPM chip.
> + */
> +struct tpm_bank_info {
> +	u16 alg_id;
> +	u16 digest_size;
> +	u16 crypto_id;
> +};
> +
> +/*
> + * Maximum number of hashing algorithms a TPM can have.  This is
> + * basically a count of every hash in tpm_algorithms above
> + */
> +#define TPM_MAX_HASHES		5
> +
> +struct tpm_digest {
> +	u16 alg_id;
> +	u8 digest[TPM2_MAX_DIGEST_SIZE];
> +} __packed;
> +
> +#define TPM_HEADER_SIZE		10
> +
> +struct tpm_header {
> +	__be16 tag;
> +	__be32 length;
> +	union {
> +		__be32 ordinal;
> +		__be32 return_code;
> +	};
> +} __packed;
> +
>  #endif
> -- 
> 2.47.3
> 

LGTM

BR, Jarkko

