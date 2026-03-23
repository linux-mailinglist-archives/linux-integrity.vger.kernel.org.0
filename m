Return-Path: <linux-integrity+bounces-9035-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGB5EEHSwGkVMAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9035-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:40:17 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983DD2ECB4B
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46891300BDA6
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD929DB9A;
	Mon, 23 Mar 2026 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsleZf/2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648D1FCFFC;
	Mon, 23 Mar 2026 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244394; cv=none; b=Xsds21T+182OtIoPbsLn09pLt39yxJlPWK07YohR9GoU1JS4w/IGoAQPfxTM0DI7ftl6Avxt0YYG3+VpUB+MlLcTDQoe3LI3BEfXXXweN6bB8aqw4+PatpDIHzTGKwFCsPDWu6XZtR+FmjUuB/9rkKzBUSv/Lha8u1ISrLou0vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244394; c=relaxed/simple;
	bh=YvjcpHiOPtBHwRrAKy2sbdK4aooY1+6TxS1vhREA6KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8dnDTUR7ibByaZBkrjOH89GJRuB3A6lNW/i7Li0j5QOvvEPX8jmB7HAW/kKFvekqEWP7EYFb4eCECc2XSXiXuwf1tgrSCUQVua/tZIe2PQHKdDmAwXwo7gH34s9j+0TGMS+QGMg9RQrtuKl71HIWNd3hApYcBPM7f5KoeYSaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsleZf/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E150C4CEF7;
	Mon, 23 Mar 2026 05:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774244394;
	bh=YvjcpHiOPtBHwRrAKy2sbdK4aooY1+6TxS1vhREA6KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsleZf/2LTZ7zgxHPZHXhttSclahSG1++c/uHzU8K2r4M8McEBxUNiSUtymVcoioX
	 3j5xxXY84F8j6JRyj28SBzgo0C4VzMRg5ctxO+Bz6tqQVT5beTAOmjFCZCnDcUE80e
	 67dOTJa0m+kakjm6ytROPj0Y2HE4VKC7OVmL3HerWc/YOTnFZzaj1JaJLIGHTOqNZE
	 8Np+4AtbI+sdu5DHYHMC51MYUqbgh8t70N3XP5IKcdK7B9w2sTjtBVWuUVBtoEiHBd
	 W51fqRK+00/jx3pvYFGaIljQncYNjw+H7Om2mtFT0Hs7JppZW+fTGeup7WmAiy0SsC
	 ebuY5xERJqNUA==
Date: Mon, 23 Mar 2026 07:39:49 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alec Brown <alec.r.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, jarkko.sakkinen@iki.fi, jgg@ziepe.ca,
	ross.philipson@oracle.com, dpsmith@apertussolutions.com,
	daniel.kiper@oracle.com, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com, ardb@kernel.org
Subject: Re: [PATCH 1/4] tpm: Initial step to reorganize TPM public headers
Message-ID: <acDSJcwlQZS2mpsg@kernel.org>
References: <20260317160613.2899129-1-alec.r.brown@oracle.com>
 <20260317160613.2899129-2-alec.r.brown@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317160613.2899129-2-alec.r.brown@oracle.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,iki.fi,ziepe.ca,oracle.com,apertussolutions.com,googlegroups.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-9035-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustedcomputinggroup.org:url,apertussolutions.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 983DD2ECB4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:03:32PM +0000, Alec Brown wrote:
> From: Ross Philipson <ross.philipson@oracle.com>
> 
> From: Ross Philipson <ross.philipson@oracle.com>

nit: just fix this glitch please :-)

> 
> Consolidate TPM1 constants in tpm_command.h and remove duplicate
> constants from tpm1-cmd.c.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
> ---
>  drivers/char/tpm/tpm-buf.c                |  1 -
>  drivers/char/tpm/tpm1-cmd.c               | 14 +-------
>  include/keys/trusted_tpm.h                |  1 -
>  include/linux/tpm.h                       |  2 ++
>  include/linux/tpm_command.h               | 43 ++++++++++++++++-------
>  security/keys/trusted-keys/trusted_tpm1.c |  1 -
>  security/keys/trusted-keys/trusted_tpm2.c |  1 -
>  7 files changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index dc882fc9fa9e..4c4f450630df 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -3,7 +3,6 @@
>   * Handling of TPM command and other buffers.
>   */
>  
> -#include <linux/tpm_command.h>
>  #include <linux/module.h>
>  #include <linux/tpm.h>
>  
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index b49a790f1bd5..664ca1fff2e8 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -22,8 +22,6 @@
>  
>  #include "tpm.h"
>  
> -#define TPM_MAX_ORDINAL 243
> -
>  /*
>   * Array with one entry per ordinal defining the maximum amount
>   * of time the chip could take to return the result.  The ordinal
> @@ -308,9 +306,6 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  		return duration;
>  }
>  
> -#define TPM_ORD_STARTUP 153
> -#define TPM_ST_CLEAR 1
> -
>  /**
>   * tpm1_startup() - turn on the TPM
>   * @chip: TPM chip to use
> @@ -459,7 +454,6 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
>  	return 0;
>  }
>  
> -#define TPM_ORD_PCR_EXTEND 20
>  int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
>  		    const char *log_msg)
>  {
> @@ -478,7 +472,6 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
>  	return rc;
>  }
>  
> -#define TPM_ORD_GET_CAP 101
>  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  		    const char *desc, size_t min_cap_length)
>  {
> @@ -511,7 +504,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  }
>  EXPORT_SYMBOL_GPL(tpm1_getcap);
>  
> -#define TPM_ORD_GET_RANDOM 70
>  struct tpm1_get_random_out {
>  	__be32 rng_data_len;
>  	u8 rng_data[TPM_MAX_RNG_DATA];
> @@ -580,13 +572,12 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  	return rc;
>  }
>  
> -#define TPM_ORD_PCRREAD 21
>  int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>  {
>  	struct tpm_buf buf;
>  	int rc;
>  
> -	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
> +	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_READ);
>  	if (rc)
>  		return rc;
>  
> @@ -609,7 +600,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
>  	return rc;
>  }
>  
> -#define TPM_ORD_CONTINUE_SELFTEST 83
>  /**
>   * tpm1_continue_selftest() - run TPM's selftest
>   * @chip: TPM chip to use
> @@ -726,8 +716,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  	return rc;
>  }
>  
> -#define TPM_ORD_SAVESTATE 152
> -
>  /**
>   * tpm1_pm_suspend() - pm suspend handler
>   * @chip: TPM chip to use.
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index 0fadc6a4f166..3a0fa3bc8454 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -3,7 +3,6 @@
>  #define __TRUSTED_TPM_H
>  
>  #include <keys/trusted-type.h>
> -#include <linux/tpm_command.h>
>  
>  extern struct trusted_key_ops trusted_key_tpm_ops;
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 202da079d500..18dcf0ef46f6 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -25,6 +25,8 @@
>  #include <crypto/hash_info.h>
>  #include <crypto/aes.h>
>  
> +#include "tpm_command.h"
> +
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
>  
>  #define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> index f5c03e9c3913..9a8991b8801d 100644
> --- a/include/linux/tpm_command.h
> +++ b/include/linux/tpm_command.h
> @@ -2,28 +2,45 @@
>  #ifndef __LINUX_TPM_COMMAND_H__
>  #define __LINUX_TPM_COMMAND_H__
>  
> +/************************************************/
> +/* TPM 1 Family Chips                           */
> +/************************************************/
> +
>  /*
> - * TPM Command constants from specifications at
> - * http://www.trustedcomputinggroup.org
> + * TPM 1.2 Main Specification
> + * https://trustedcomputinggroup.org/resource/tpm-main-specification/
>   */
>  
> +#define TPM_MAX_ORDINAL	243
> +
>  /* Command TAGS */
> -#define TPM_TAG_RQU_COMMAND             193
> -#define TPM_TAG_RQU_AUTH1_COMMAND       194
> -#define TPM_TAG_RQU_AUTH2_COMMAND       195
> -#define TPM_TAG_RSP_COMMAND             196
> -#define TPM_TAG_RSP_AUTH1_COMMAND       197
> -#define TPM_TAG_RSP_AUTH2_COMMAND       198
> +enum tpm_command_tags {
> +	TPM_TAG_RQU_COMMAND		= 193,
> +	TPM_TAG_RQU_AUTH1_COMMAND	= 194,
> +	TPM_TAG_RQU_AUTH2_COMMAND	= 195,
> +	TPM_TAG_RSP_COMMAND		= 196,
> +	TPM_TAG_RSP_AUTH1_COMMAND	= 197,
> +	TPM_TAG_RSP_AUTH2_COMMAND	= 198,
> +};
>  
>  /* Command Ordinals */
> -#define TPM_ORD_GETRANDOM               70
> -#define TPM_ORD_OSAP                    11
> -#define TPM_ORD_OIAP                    10
> -#define TPM_ORD_SEAL                    23
> -#define TPM_ORD_UNSEAL                  24
> +enum tpm_command_ordinals {
> +	TPM_ORD_CONTINUE_SELFTEST	= 83,
> +	TPM_ORD_GET_CAP			= 101,
> +	TPM_ORD_GET_RANDOM		= 70,
> +	TPM_ORD_PCR_EXTEND		= 20,
> +	TPM_ORD_PCR_READ		= 21,
> +	TPM_ORD_OSAP			= 11,
> +	TPM_ORD_OIAP			= 10,
> +	TPM_ORD_SAVESTATE		= 152,
> +	TPM_ORD_SEAL			= 23,
> +	TPM_ORD_STARTUP			= 153,
> +	TPM_ORD_UNSEAL			= 24,
> +};
>  
>  /* Other constants */
>  #define SRKHANDLE                       0x40000000
>  #define TPM_NONCE_SIZE                  20
> +#define TPM_ST_CLEAR			1
>  
>  #endif
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 636acb66a4f6..10f79a8c2d35 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -17,7 +17,6 @@
>  #include <keys/trusted-type.h>
>  #include <linux/key-type.h>
>  #include <linux/tpm.h>
> -#include <linux/tpm_command.h>
>  
>  #include <keys/trusted_tpm.h>
>  
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index a7ea4a1c3bed..56eb8e20780a 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -9,7 +9,6 @@
>  #include <linux/string.h>
>  #include <linux/err.h>
>  #include <linux/tpm.h>
> -#include <linux/tpm_command.h>
>  
>  #include <keys/trusted-type.h>
>  #include <keys/trusted_tpm.h>
> -- 
> 2.47.3
> 

I need to compile and test these but yes agree with the idea.

BR, Jarkko

