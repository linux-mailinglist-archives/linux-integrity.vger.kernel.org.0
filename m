Return-Path: <linux-integrity+bounces-9037-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHb5BsrSwGkVMAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9037-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:42:34 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 759372ECB71
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A45A300A3B9
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4872C15AA;
	Mon, 23 Mar 2026 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnHMigGE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4162BD00C;
	Mon, 23 Mar 2026 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244550; cv=none; b=GcC2MySLWB9GSMOHFv2NQPAKvPTRHSAmQ2ft3GlP2+5qSFKI2SR1Xu9y3CQi181VwCGxhw0rnX0aavBWU5Uv5EGzfjPqid7jKQf+Wp1t41d49USo0ZLvsOEJqvhelJqYycT70HEnyGp4nnXNbLiClZFiONULb2FOkKKq1OQljcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244550; c=relaxed/simple;
	bh=MlsQtQZ5aD3N8muY7PWVHs60KXYbmw1+1UI9YtoMDuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7M6gPq7tm8dkgA9MQ7WRpi99g1qHKsez9wKN5/ZEB0F/iz6z5tP0VBcUPvhgkgVnUWPQZ4PP2TnkyT9dLY009QKN6dMH9XkTjiuDWvt/SUxmMN3HGj0VkK8x2zWCwxjJy7o3ELESNRknMbzXtb+aVsf/U9Smum/W9CYJoEY1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnHMigGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39FDC4CEF7;
	Mon, 23 Mar 2026 05:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774244550;
	bh=MlsQtQZ5aD3N8muY7PWVHs60KXYbmw1+1UI9YtoMDuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnHMigGEEQoLQOzrW1EwAjmoDAxNr6VsrmEXn/Ki3WNsWW3tea5cCsBr77SVTvXaE
	 Umz+CcCxkxig2GYpgnzhpJPl8B6WwLkOqUMXnRxkkZTycZQbuzATSs4ql2Mkj0eBz7
	 aZjW1sMkQtarZzfSGYssLNg7dFbvWnLfYMXyFbJcTi4W4Mk9y1JPPlcGyzOKO/iXKH
	 v/6CXTG+Sg0nYfzjtXuYQHkXRo2e/TXrCtlEZ+Cw5i5JetTPQA4cDBkhAOMibgLIRb
	 3Do7jtNKxzKcHuGdnC7ruwPDPLrrVDW2hWQRJ9lN6enBJ/AJjp8SleixZXkuReU3et
	 SY+ymtykFAQ1w==
Date: Mon, 23 Mar 2026 07:42:25 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alec Brown <alec.r.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, jarkko.sakkinen@iki.fi, jgg@ziepe.ca,
	ross.philipson@oracle.com, dpsmith@apertussolutions.com,
	daniel.kiper@oracle.com, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com, ardb@kernel.org
Subject: Re: [PATCH 4/4] tpm: Move TPM common base definitions to the command
 header
Message-ID: <acDSwWnogOE31B76@kernel.org>
References: <20260317160613.2899129-1-alec.r.brown@oracle.com>
 <20260317160613.2899129-5-alec.r.brown@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317160613.2899129-5-alec.r.brown@oracle.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,iki.fi,ziepe.ca,oracle.com,apertussolutions.com,googlegroups.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-9037-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 759372ECB71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:03:35PM +0000, Alec Brown wrote:
> From: Ross Philipson <ross.philipson@oracle.com>
> 
> From: Ross Philipson <ross.philipson@oracle.com>
> 
> These are top level definitions shared by both TPM 1 and 2
> family chips. This includes core definitions like TPM localities,
> common crypto algorithm IDs, and the base TPM command header.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
> ---
>  include/linux/tpm.h         | 50 +--------------------
>  include/linux/tpm_command.h | 89 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 49 deletions(-)
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 92957452f7a7..a282b7045a24 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -27,49 +27,12 @@
>  
>  #include "tpm_command.h"
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
> index ee76fcd5ecef..25a247254140 100644
> --- a/include/linux/tpm_command.h
> +++ b/include/linux/tpm_command.h
> @@ -431,4 +431,93 @@ struct tpm2_context {
>  	__be16 blob_size;
>  } __packed;
>  
> +/************************************************/
> +/* TPM Common Defs                              */
> +/************************************************/
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

Yep, all looks great and clean to me but exactly for that reason
this needs to the truth serum :-)

BR, Jarkko

