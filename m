Return-Path: <linux-integrity+bounces-9036-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJzhOYTSwGkVMAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9036-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:41:24 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A02D2ECB62
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE500300A393
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0232C234E;
	Mon, 23 Mar 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkMslrgX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1222C15AA;
	Mon, 23 Mar 2026 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244482; cv=none; b=aKjvXow4aWGVohuDNVOD9Uj6u9Sh2ADVfOijaAoQIGpUSKF7ZaaBsfdIbgz0iTD/7eFA488B+rfaUkkfwnl85CVlafw4O43dIqSi6X3EcJtpwRKu2yCEmLmLSZApYjtV9Kw0Z6Jot2vQbHS0N9h4o8JcBEvq2YfnPNz0gcFS5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244482; c=relaxed/simple;
	bh=kRhw9J1uUzvdr9pCJPZ9ilyTwgn65EXENSVtS+bc4q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYIT+1H4DBZzErk6bja8OO+43fgIr0cgj0FjPzdiHl3rPSIN/dNJPeeu3kXkMQbcYFkLgou4607vX6JPBCKNO9O+s6TcQ/Kki1qjmqi9Xx93KMXboEdGHt4TOZYOGfDgtq3Anw0z8jY/3k2jgkAGMsX4Q9z+ITAQZFTOnZoZlCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkMslrgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167B6C4CEF7;
	Mon, 23 Mar 2026 05:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774244481;
	bh=kRhw9J1uUzvdr9pCJPZ9ilyTwgn65EXENSVtS+bc4q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkMslrgXjNWgg4FJhloqPR3Uq6beqIoJ3PA+xTsydit98TjKeh7fdlQu3Ws+uwndA
	 tmTWiHkPA5kHN8AwatRxts6dM84qwN9avmCVNahf98+R8RNQEXb/tyEVSNEXzsYij0
	 FQscONcDHBmjQqPJezG+lJigilEj6ZgkvU9RApfyOT+EhTyWDSi89DC5j/hDzA5qVf
	 PhqQA4i6TqVpQR1KLbXh5xu2M5jklV5b6FmZQTZrSEsououpjLZRloCglYiwW0XQIa
	 ku1kjLYK90gA1sMZH6yZ0QPkWjuW9YxbMcykrqruXFO8kK/bNQJMSBRN7L6hQREjG8
	 lA5QDnOCs6Wbw==
Date: Mon, 23 Mar 2026 07:41:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alec Brown <alec.r.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, jarkko.sakkinen@iki.fi, jgg@ziepe.ca,
	ross.philipson@oracle.com, dpsmith@apertussolutions.com,
	daniel.kiper@oracle.com, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com, ardb@kernel.org
Subject: Re: [PATCH 3/4] tpm: Move TPM2 specific definitions to the command
 header
Message-ID: <acDSfYDxN2WY-fbW@kernel.org>
References: <20260317160613.2899129-1-alec.r.brown@oracle.com>
 <20260317160613.2899129-4-alec.r.brown@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317160613.2899129-4-alec.r.brown@oracle.com>
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
	TAGGED_FROM(0.00)[bounces-9036-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: 4A02D2ECB62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:03:34PM +0000, Alec Brown wrote:
> From: Ross Philipson <ross.philipson@oracle.com>
> 
> From: Ross Philipson <ross.philipson@oracle.com>

Address this for +1 version but hold on until I have time to test
this (next week latest), as that might generate some additional
feedback.

> 
> Gather all the TPM2 definitions and structures in the internal header
> file drivers/char/tpm/tpm.h into the command header, including:
>  - Command codes, return codes and definitions from the public and
> internal tpm.h files.
>  - Structures defined in numerous TPM driver C modules.
> 
> The definitions moved to these files correspond to the TCG specification
> for TPM 2 family:
> 
> TPM 2.0 Library
>  - https://trustedcomputinggroup.org/resource/tpm-library-specification/
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
> ---
>  drivers/char/tpm/tpm.h        |  77 ----------
>  drivers/char/tpm/tpm2-cmd.c   |  30 ----
>  drivers/char/tpm/tpm2-space.c |  13 --
>  include/linux/tpm.h           | 145 ------------------
>  include/linux/tpm_command.h   | 273 ++++++++++++++++++++++++++++++++++
>  5 files changed, 273 insertions(+), 265 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 1a9a46a921fe..147e57c0e7bb 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -51,83 +51,6 @@ enum tpm_addr {
>  	TPM_ADDR = 0x4E,
>  };
>  
> -/* TPM2 specific constants. */
> -#define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
> -
> -enum tpm2_pt_props {
> -	TPM2_PT_NONE = 0x00000000,
> -	TPM2_PT_GROUP = 0x00000100,
> -	TPM2_PT_FIXED = TPM2_PT_GROUP * 1,
> -	TPM2_PT_FAMILY_INDICATOR = TPM2_PT_FIXED + 0,
> -	TPM2_PT_LEVEL = TPM2_PT_FIXED + 1,
> -	TPM2_PT_REVISION = TPM2_PT_FIXED + 2,
> -	TPM2_PT_DAY_OF_YEAR = TPM2_PT_FIXED + 3,
> -	TPM2_PT_YEAR = TPM2_PT_FIXED + 4,
> -	TPM2_PT_MANUFACTURER = TPM2_PT_FIXED + 5,
> -	TPM2_PT_VENDOR_STRING_1 = TPM2_PT_FIXED + 6,
> -	TPM2_PT_VENDOR_STRING_2 = TPM2_PT_FIXED + 7,
> -	TPM2_PT_VENDOR_STRING_3 = TPM2_PT_FIXED + 8,
> -	TPM2_PT_VENDOR_STRING_4 = TPM2_PT_FIXED + 9,
> -	TPM2_PT_VENDOR_TPM_TYPE = TPM2_PT_FIXED + 10,
> -	TPM2_PT_FIRMWARE_VERSION_1 = TPM2_PT_FIXED + 11,
> -	TPM2_PT_FIRMWARE_VERSION_2 = TPM2_PT_FIXED + 12,
> -	TPM2_PT_INPUT_BUFFER = TPM2_PT_FIXED + 13,
> -	TPM2_PT_HR_TRANSIENT_MIN = TPM2_PT_FIXED + 14,
> -	TPM2_PT_HR_PERSISTENT_MIN = TPM2_PT_FIXED + 15,
> -	TPM2_PT_HR_LOADED_MIN = TPM2_PT_FIXED + 16,
> -	TPM2_PT_ACTIVE_SESSIONS_MAX = TPM2_PT_FIXED + 17,
> -	TPM2_PT_PCR_COUNT = TPM2_PT_FIXED + 18,
> -	TPM2_PT_PCR_SELECT_MIN = TPM2_PT_FIXED + 19,
> -	TPM2_PT_CONTEXT_GAP_MAX = TPM2_PT_FIXED + 20,
> -	TPM2_PT_NV_COUNTERS_MAX = TPM2_PT_FIXED + 22,
> -	TPM2_PT_NV_INDEX_MAX = TPM2_PT_FIXED + 23,
> -	TPM2_PT_MEMORY = TPM2_PT_FIXED + 24,
> -	TPM2_PT_CLOCK_UPDATE = TPM2_PT_FIXED + 25,
> -	TPM2_PT_CONTEXT_HASH = TPM2_PT_FIXED + 26,
> -	TPM2_PT_CONTEXT_SYM = TPM2_PT_FIXED + 27,
> -	TPM2_PT_CONTEXT_SYM_SIZE = TPM2_PT_FIXED + 28,
> -	TPM2_PT_ORDERLY_COUNT = TPM2_PT_FIXED + 29,
> -	TPM2_PT_MAX_COMMAND_SIZE = TPM2_PT_FIXED + 30,
> -	TPM2_PT_MAX_RESPONSE_SIZE = TPM2_PT_FIXED + 31,
> -	TPM2_PT_MAX_DIGEST = TPM2_PT_FIXED + 32,
> -	TPM2_PT_MAX_OBJECT_CONTEXT = TPM2_PT_FIXED + 33,
> -	TPM2_PT_MAX_SESSION_CONTEXT = TPM2_PT_FIXED + 34,
> -	TPM2_PT_PS_FAMILY_INDICATOR = TPM2_PT_FIXED + 35,
> -	TPM2_PT_PS_LEVEL = TPM2_PT_FIXED + 36,
> -	TPM2_PT_PS_REVISION = TPM2_PT_FIXED + 37,
> -	TPM2_PT_PS_DAY_OF_YEAR = TPM2_PT_FIXED + 38,
> -	TPM2_PT_PS_YEAR = TPM2_PT_FIXED + 39,
> -	TPM2_PT_SPLIT_MAX = TPM2_PT_FIXED + 40,
> -	TPM2_PT_TOTAL_COMMANDS = TPM2_PT_FIXED + 41,
> -	TPM2_PT_LIBRARY_COMMANDS = TPM2_PT_FIXED + 42,
> -	TPM2_PT_VENDOR_COMMANDS = TPM2_PT_FIXED + 43,
> -	TPM2_PT_NV_BUFFER_MAX = TPM2_PT_FIXED + 44,
> -	TPM2_PT_MODES = TPM2_PT_FIXED + 45,
> -	TPM2_PT_MAX_CAP_BUFFER = TPM2_PT_FIXED + 46,
> -	TPM2_PT_VAR = TPM2_PT_GROUP * 2,
> -	TPM2_PT_PERMANENT = TPM2_PT_VAR + 0,
> -	TPM2_PT_STARTUP_CLEAR = TPM2_PT_VAR + 1,
> -	TPM2_PT_HR_NV_INDEX = TPM2_PT_VAR + 2,
> -	TPM2_PT_HR_LOADED = TPM2_PT_VAR + 3,
> -	TPM2_PT_HR_LOADED_AVAIL = TPM2_PT_VAR + 4,
> -	TPM2_PT_HR_ACTIVE = TPM2_PT_VAR + 5,
> -	TPM2_PT_HR_ACTIVE_AVAIL = TPM2_PT_VAR + 6,
> -	TPM2_PT_HR_TRANSIENT_AVAIL = TPM2_PT_VAR + 7,
> -	TPM2_PT_HR_PERSISTENT = TPM2_PT_VAR + 8,
> -	TPM2_PT_HR_PERSISTENT_AVAIL = TPM2_PT_VAR + 9,
> -	TPM2_PT_NV_COUNTERS = TPM2_PT_VAR + 10,
> -	TPM2_PT_NV_COUNTERS_AVAIL = TPM2_PT_VAR + 11,
> -	TPM2_PT_ALGORITHM_SET = TPM2_PT_VAR + 12,
> -	TPM2_PT_LOADED_CURVES = TPM2_PT_VAR + 13,
> -	TPM2_PT_LOCKOUT_COUNTER = TPM2_PT_VAR + 14,
> -	TPM2_PT_MAX_AUTH_FAIL = TPM2_PT_VAR + 15,
> -	TPM2_PT_LOCKOUT_INTERVAL = TPM2_PT_VAR + 16,
> -	TPM2_PT_LOCKOUT_RECOVERY = TPM2_PT_VAR + 17,
> -	TPM2_PT_NV_WRITE_RECOVERY = TPM2_PT_VAR + 18,
> -	TPM2_PT_AUDIT_COUNTER_0 = TPM2_PT_VAR + 19,
> -	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
> -};
> -
>  extern const struct class tpm_class;
>  extern const struct class tpmrm_class;
>  extern dev_t tpm_devt;
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 3a77be7ebf4a..1fa3e8a43c79 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -94,17 +94,6 @@ unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
>  	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
>  }
>  
> -struct tpm2_pcr_read_out {
> -	__be32	update_cnt;
> -	__be32	pcr_selects_cnt;
> -	__be16	hash_alg;
> -	u8	pcr_select_size;
> -	u8	pcr_select[TPM2_PCR_SELECT_MIN];
> -	__be32	digests_cnt;
> -	__be16	digest_size;
> -	u8	digest[];
> -} __packed;
> -
>  /**
>   * tpm2_pcr_read() - read a PCR value
>   * @chip:	TPM chip to use.
> @@ -238,11 +227,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  	return rc;
>  }
>  
> -struct tpm2_get_random_out {
> -	__be16 size;
> -	u8 buffer[TPM_MAX_RNG_DATA];
> -} __packed;
> -
>  /**
>   * tpm2_get_random() - get random bytes from the TPM RNG
>   *
> @@ -366,14 +350,6 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
>  }
>  EXPORT_SYMBOL_GPL(tpm2_flush_context);
>  
> -struct tpm2_get_cap_out {
> -	u8 more_data;
> -	__be32 subcap_id;
> -	__be32 property_cnt;
> -	__be32 property_id;
> -	__be32 value;
> -} __packed;
> -
>  /**
>   * tpm2_get_tpm_pt() - get value of a TPM_CAP_TPM_PROPERTIES type property
>   * @chip:		a &tpm_chip instance
> @@ -541,12 +517,6 @@ static int tpm2_init_bank_info(struct tpm_chip *chip, u32 bank_index)
>  	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
>  }
>  
> -struct tpm2_pcr_selection {
> -	__be16  hash_alg;
> -	u8  size_of_select;
> -	u8  pcr_select[3];
> -} __packed;
> -
>  ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  {
>  	struct tpm2_pcr_selection pcr_selection;
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 60354cd53b5c..7c1c0a174a2b 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -15,19 +15,6 @@
>  #include <linux/unaligned.h>
>  #include "tpm.h"
>  
> -enum tpm2_handle_types {
> -	TPM2_HT_HMAC_SESSION	= 0x02000000,
> -	TPM2_HT_POLICY_SESSION	= 0x03000000,
> -	TPM2_HT_TRANSIENT	= 0x80000000,
> -};
> -
> -struct tpm2_context {
> -	__be64 sequence;
> -	__be32 saved_handle;
> -	__be32 hierarchy;
> -	__be16 blob_size;
> -} __packed;
> -
>  static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
>  {
>  	int i;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 18dcf0ef46f6..92957452f7a7 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -38,12 +38,6 @@ struct trusted_key_options;
>  /* opaque structure, holds auth session parameters like the session key */
>  struct tpm2_auth;
>  
> -enum tpm2_session_types {
> -	TPM2_SE_HMAC	= 0x00,
> -	TPM2_SE_POLICY	= 0x01,
> -	TPM2_SE_TRIAL	= 0x02,
> -};
> -
>  /* if you add a new hash to this, increment TPM_MAX_HASHES below */
>  enum tpm_algorithms {
>  	TPM_ALG_ERROR		= 0x0000,
> @@ -65,11 +59,6 @@ enum tpm_algorithms {
>   */
>  #define TPM_MAX_HASHES	5
>  
> -enum tpm2_curves {
> -	TPM2_ECC_NONE		= 0x0000,
> -	TPM2_ECC_NIST_P256	= 0x0003,
> -};
> -
>  struct tpm_digest {
>  	u16 alg_id;
>  	u8 digest[TPM2_MAX_DIGEST_SIZE];
> @@ -222,122 +211,11 @@ struct tpm_chip {
>  
>  #define TPM_HEADER_SIZE		10
>  
> -enum tpm2_const {
> -	TPM2_PLATFORM_PCR       =     24,
> -	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
> -};
> -
> -enum tpm2_timeouts {
> -	TPM2_TIMEOUT_A          =    750,
> -	TPM2_TIMEOUT_B          =   4000,
> -	TPM2_TIMEOUT_C          =    200,
> -	TPM2_TIMEOUT_D          =     30,
> -};
> -
> -enum tpm2_durations {
> -	TPM2_DURATION_SHORT     =     20,
> -	TPM2_DURATION_LONG      =   2000,
> -	TPM2_DURATION_DEFAULT   = 120000,
> -};
> -
> -enum tpm2_structures {
> -	TPM2_ST_NO_SESSIONS	= 0x8001,
> -	TPM2_ST_SESSIONS	= 0x8002,
> -	TPM2_ST_CREATION	= 0x8021,
> -};
> -
> -/* Indicates from what layer of the software stack the error comes from */
> -#define TSS2_RC_LAYER_SHIFT	 16
> -#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
> -
> -enum tpm2_return_codes {
> -	TPM2_RC_SUCCESS		= 0x0000,
> -	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
> -	TPM2_RC_HANDLE		= 0x008B,
> -	TPM2_RC_INTEGRITY	= 0x009F,
> -	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
> -	TPM2_RC_FAILURE		= 0x0101,
> -	TPM2_RC_DISABLED	= 0x0120,
> -	TPM2_RC_UPGRADE		= 0x012D,
> -	TPM2_RC_COMMAND_CODE    = 0x0143,
> -	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
> -	TPM2_RC_REFERENCE_H0	= 0x0910,
> -	TPM2_RC_RETRY		= 0x0922,
> -	TPM2_RC_SESSION_MEMORY	= 0x0903,
> -};
> -
> -enum tpm2_command_codes {
> -	TPM2_CC_FIRST		        = 0x011F,
> -	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
> -	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
> -	TPM2_CC_CREATE_PRIMARY          = 0x0131,
> -	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
> -	TPM2_CC_SELF_TEST	        = 0x0143,
> -	TPM2_CC_STARTUP		        = 0x0144,
> -	TPM2_CC_SHUTDOWN	        = 0x0145,
> -	TPM2_CC_NV_READ                 = 0x014E,
> -	TPM2_CC_CREATE		        = 0x0153,
> -	TPM2_CC_LOAD		        = 0x0157,
> -	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
> -	TPM2_CC_UNSEAL		        = 0x015E,
> -	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
> -	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
> -	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
> -	TPM2_CC_READ_PUBLIC		= 0x0173,
> -	TPM2_CC_START_AUTH_SESS		= 0x0176,
> -	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
> -	TPM2_CC_GET_CAPABILITY	        = 0x017A,
> -	TPM2_CC_GET_RANDOM	        = 0x017B,
> -	TPM2_CC_PCR_READ	        = 0x017E,
> -	TPM2_CC_PCR_EXTEND	        = 0x0182,
> -	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
> -	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
> -	TPM2_CC_CREATE_LOADED           = 0x0191,
> -	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
> -};
> -
> -enum tpm2_permanent_handles {
> -	TPM2_RH_NULL		= 0x40000007,
> -	TPM2_RS_PW		= 0x40000009,
> -};
> -
> -/* Most Significant Octet for key types  */
> -enum tpm2_mso_type {
> -	TPM2_MSO_NVRAM		= 0x01,
> -	TPM2_MSO_SESSION	= 0x02,
> -	TPM2_MSO_POLICY		= 0x03,
> -	TPM2_MSO_PERMANENT	= 0x40,
> -	TPM2_MSO_VOLATILE	= 0x80,
> -	TPM2_MSO_PERSISTENT	= 0x81,
> -};
> -
>  static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
>  {
>  	return handle >> 24;
>  }
>  
> -enum tpm2_capabilities {
> -	TPM2_CAP_HANDLES	= 1,
> -	TPM2_CAP_COMMANDS	= 2,
> -	TPM2_CAP_PCRS		= 5,
> -	TPM2_CAP_TPM_PROPERTIES = 6,
> -};
> -
> -enum tpm2_properties {
> -	TPM_PT_TOTAL_COMMANDS	= 0x0129,
> -};
> -
> -enum tpm2_startup_types {
> -	TPM2_SU_CLEAR	= 0x0000,
> -	TPM2_SU_STATE	= 0x0001,
> -};
> -
> -enum tpm2_cc_attrs {
> -	TPM2_CC_ATTR_CHANDLES	= 25,
> -	TPM2_CC_ATTR_RHANDLE	= 28,
> -	TPM2_CC_ATTR_VENDOR	= 29,
> -};
> -
>  #define TPM_VID_INTEL    0x8086
>  #define TPM_VID_WINBOND  0x1050
>  #define TPM_VID_STM      0x104A
> @@ -389,29 +267,6 @@ struct tpm_buf {
>  	u8 handles;
>  };
>  
> -enum tpm2_object_attributes {
> -	TPM2_OA_FIXED_TPM		= BIT(1),
> -	TPM2_OA_ST_CLEAR		= BIT(2),
> -	TPM2_OA_FIXED_PARENT		= BIT(4),
> -	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
> -	TPM2_OA_USER_WITH_AUTH		= BIT(6),
> -	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
> -	TPM2_OA_NO_DA			= BIT(10),
> -	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
> -	TPM2_OA_RESTRICTED		= BIT(16),
> -	TPM2_OA_DECRYPT			= BIT(17),
> -	TPM2_OA_SIGN			= BIT(18),
> -};
> -
> -enum tpm2_session_attributes {
> -	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> -	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
> -	TPM2_SA_AUDIT_RESET		= BIT(3),
> -	TPM2_SA_DECRYPT			= BIT(5),
> -	TPM2_SA_ENCRYPT			= BIT(6),
> -	TPM2_SA_AUDIT			= BIT(7),
> -};
> -
>  struct tpm2_hash {
>  	unsigned int crypto_id;
>  	unsigned int tpm_id;
> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> index 20b634591fb1..ee76fcd5ecef 100644
> --- a/include/linux/tpm_command.h
> +++ b/include/linux/tpm_command.h
> @@ -158,4 +158,277 @@ struct tpm1_get_random_out {
>  #define TPM_NONCE_SIZE                  20
>  #define TPM_ST_CLEAR			1
>  
> +/************************************************/
> +/* TPM 2 Family Chips                           */
> +/************************************************/
> +
> +/*
> + * TPM 2.0 Library
> + * https://trustedcomputinggroup.org/resource/tpm-library-specification/
> + */
> +
> +/* TPM2 specific constants. */
> +#define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
> +
> +enum tpm2_session_types {
> +	TPM2_SE_HMAC	= 0x00,
> +	TPM2_SE_POLICY	= 0x01,
> +	TPM2_SE_TRIAL	= 0x02,
> +};
> +
> +enum tpm2_timeouts {
> +	TPM2_TIMEOUT_A		= 750,
> +	TPM2_TIMEOUT_B		= 4000,
> +	TPM2_TIMEOUT_C		= 200,
> +	TPM2_TIMEOUT_D		= 30,
> +	TPM2_DURATION_SHORT	= 20,
> +	TPM2_DURATION_MEDIUM	= 750,
> +	TPM2_DURATION_LONG	= 2000,
> +	TPM2_DURATION_LONG_LONG	= 300000,
> +	TPM2_DURATION_DEFAULT	= 120000,
> +};
> +
> +enum tpm2_structures {
> +	TPM2_ST_NO_SESSIONS	= 0x8001,
> +	TPM2_ST_SESSIONS	= 0x8002,
> +	TPM2_ST_CREATION	= 0x8021,
> +};
> +
> +/* Indicates from what layer of the software stack the error comes from */
> +#define TSS2_RC_LAYER_SHIFT	 16
> +#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
> +
> +enum tpm2_return_codes {
> +	TPM2_RC_SUCCESS		= 0x0000,
> +	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
> +	TPM2_RC_HANDLE		= 0x008B,
> +	TPM2_RC_INTEGRITY	= 0x009F,
> +	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
> +	TPM2_RC_FAILURE		= 0x0101,
> +	TPM2_RC_DISABLED	= 0x0120,
> +	TPM2_RC_UPGRADE		= 0x012D,
> +	TPM2_RC_COMMAND_CODE	= 0x0143,
> +	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
> +	TPM2_RC_REFERENCE_H0	= 0x0910,
> +	TPM2_RC_RETRY		= 0x0922,
> +	TPM2_RC_SESSION_MEMORY	= 0x0903,
> +};
> +
> +enum tpm2_command_codes {
> +	TPM2_CC_FIRST			= 0x011F,
> +	TPM2_CC_HIERARCHY_CONTROL	= 0x0121,
> +	TPM2_CC_HIERARCHY_CHANGE_AUTH	= 0x0129,
> +	TPM2_CC_CREATE_PRIMARY		= 0x0131,
> +	TPM2_CC_SEQUENCE_COMPLETE	= 0x013E,
> +	TPM2_CC_SELF_TEST		= 0x0143,
> +	TPM2_CC_STARTUP			= 0x0144,
> +	TPM2_CC_SHUTDOWN		= 0x0145,
> +	TPM2_CC_NV_READ			= 0x014E,
> +	TPM2_CC_CREATE			= 0x0153,
> +	TPM2_CC_LOAD			= 0x0157,
> +	TPM2_CC_SEQUENCE_UPDATE		= 0x015C,
> +	TPM2_CC_UNSEAL			= 0x015E,
> +	TPM2_CC_CONTEXT_LOAD		= 0x0161,
> +	TPM2_CC_CONTEXT_SAVE		= 0x0162,
> +	TPM2_CC_FLUSH_CONTEXT		= 0x0165,
> +	TPM2_CC_READ_PUBLIC		= 0x0173,
> +	TPM2_CC_START_AUTH_SESS		= 0x0176,
> +	TPM2_CC_VERIFY_SIGNATURE	= 0x0177,
> +	TPM2_CC_GET_CAPABILITY		= 0x017A,
> +	TPM2_CC_GET_RANDOM		= 0x017B,
> +	TPM2_CC_PCR_READ		= 0x017E,
> +	TPM2_CC_PCR_EXTEND		= 0x0182,
> +	TPM2_CC_EVENT_SEQUENCE_COMPLETE	= 0x0185,
> +	TPM2_CC_HASH_SEQUENCE_START	= 0x0186,
> +	TPM2_CC_CREATE_LOADED		= 0x0191,
> +	TPM2_CC_LAST			= 0x0193, /* Spec 1.36 */
> +};
> +
> +enum tpm2_capabilities {
> +	TPM2_CAP_HANDLES	= 1,
> +	TPM2_CAP_COMMANDS	= 2,
> +	TPM2_CAP_PCRS		= 5,
> +	TPM2_CAP_TPM_PROPERTIES = 6,
> +};
> +
> +enum tpm2_properties {
> +	TPM_PT_TOTAL_COMMANDS	= 0x0129,
> +};
> +
> +enum tpm2_startup_types {
> +	TPM2_SU_CLEAR		= 0x0000,
> +	TPM2_SU_STATE		= 0x0001,
> +};
> +
> +enum tpm2_cc_attrs {
> +	TPM2_CC_ATTR_CHANDLES	= 25,
> +	TPM2_CC_ATTR_RHANDLE	= 28,
> +	TPM2_CC_ATTR_VENDOR	= 29,
> +};
> +
> +enum tpm2_permanent_handles {
> +	TPM2_RH_NULL		= 0x40000007,
> +	TPM2_RS_PW		= 0x40000009,
> +};
> +
> +/* Most Significant Octet for key types  */
> +enum tpm2_mso_type {
> +	TPM2_MSO_NVRAM		= 0x01,
> +	TPM2_MSO_SESSION	= 0x02,
> +	TPM2_MSO_POLICY		= 0x03,
> +	TPM2_MSO_PERMANENT	= 0x40,
> +	TPM2_MSO_VOLATILE	= 0x80,
> +	TPM2_MSO_PERSISTENT	= 0x81,
> +};
> +
> +enum tpm2_curves {
> +	TPM2_ECC_NONE		= 0x0000,
> +	TPM2_ECC_NIST_P256	= 0x0003,
> +};
> +
> +enum tpm2_object_attributes {
> +	TPM2_OA_FIXED_TPM		= BIT(1),
> +	TPM2_OA_ST_CLEAR		= BIT(2),
> +	TPM2_OA_FIXED_PARENT		= BIT(4),
> +	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
> +	TPM2_OA_USER_WITH_AUTH		= BIT(6),
> +	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
> +	TPM2_OA_NO_DA			= BIT(10),
> +	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
> +	TPM2_OA_RESTRICTED		= BIT(16),
> +	TPM2_OA_DECRYPT			= BIT(17),
> +	TPM2_OA_SIGN			= BIT(18),
> +};
> +
> +enum tpm2_session_attributes {
> +	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> +	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
> +	TPM2_SA_AUDIT_RESET		= BIT(3),
> +	TPM2_SA_DECRYPT			= BIT(5),
> +	TPM2_SA_ENCRYPT			= BIT(6),
> +	TPM2_SA_AUDIT			= BIT(7),
> +};
> +
> +enum tpm2_pcr_select {
> +	TPM2_PLATFORM_PCR	= 24,
> +	TPM2_PCR_SELECT_MIN	= ((TPM2_PLATFORM_PCR + 7) / 8),
> +};
> +
> +enum tpm2_handle_types {
> +	TPM2_HT_HMAC_SESSION	= 0x02000000,
> +	TPM2_HT_POLICY_SESSION	= 0x03000000,
> +	TPM2_HT_TRANSIENT	= 0x80000000,
> +};
> +
> +enum tpm2_pt_props {
> +	TPM2_PT_NONE			= 0x00000000,
> +	TPM2_PT_GROUP			= 0x00000100,
> +	TPM2_PT_FIXED			= TPM2_PT_GROUP * 1,
> +	TPM2_PT_FAMILY_INDICATOR	= TPM2_PT_FIXED + 0,
> +	TPM2_PT_LEVEL		= TPM2_PT_FIXED + 1,
> +	TPM2_PT_REVISION	= TPM2_PT_FIXED + 2,
> +	TPM2_PT_DAY_OF_YEAR	= TPM2_PT_FIXED + 3,
> +	TPM2_PT_YEAR		= TPM2_PT_FIXED + 4,
> +	TPM2_PT_MANUFACTURER	= TPM2_PT_FIXED + 5,
> +	TPM2_PT_VENDOR_STRING_1	= TPM2_PT_FIXED + 6,
> +	TPM2_PT_VENDOR_STRING_2	= TPM2_PT_FIXED + 7,
> +	TPM2_PT_VENDOR_STRING_3	= TPM2_PT_FIXED + 8,
> +	TPM2_PT_VENDOR_STRING_4	= TPM2_PT_FIXED + 9,
> +	TPM2_PT_VENDOR_TPM_TYPE	= TPM2_PT_FIXED + 10,
> +	TPM2_PT_FIRMWARE_VERSION_1	= TPM2_PT_FIXED + 11,
> +	TPM2_PT_FIRMWARE_VERSION_2	= TPM2_PT_FIXED + 12,
> +	TPM2_PT_INPUT_BUFFER		= TPM2_PT_FIXED + 13,
> +	TPM2_PT_HR_TRANSIENT_MIN	= TPM2_PT_FIXED + 14,
> +	TPM2_PT_HR_PERSISTENT_MIN	= TPM2_PT_FIXED + 15,
> +	TPM2_PT_HR_LOADED_MIN		= TPM2_PT_FIXED + 16,
> +	TPM2_PT_ACTIVE_SESSIONS_MAX	= TPM2_PT_FIXED + 17,
> +	TPM2_PT_PCR_COUNT	= TPM2_PT_FIXED + 18,
> +	TPM2_PT_PCR_SELECT_MIN	= TPM2_PT_FIXED + 19,
> +	TPM2_PT_CONTEXT_GAP_MAX	= TPM2_PT_FIXED + 20,
> +	TPM2_PT_NV_COUNTERS_MAX	= TPM2_PT_FIXED + 22,
> +	TPM2_PT_NV_INDEX_MAX	= TPM2_PT_FIXED + 23,
> +	TPM2_PT_MEMORY		= TPM2_PT_FIXED + 24,
> +	TPM2_PT_CLOCK_UPDATE	= TPM2_PT_FIXED + 25,
> +	TPM2_PT_CONTEXT_HASH	= TPM2_PT_FIXED + 26,
> +	TPM2_PT_CONTEXT_SYM	= TPM2_PT_FIXED + 27,
> +	TPM2_PT_CONTEXT_SYM_SIZE	= TPM2_PT_FIXED + 28,
> +	TPM2_PT_ORDERLY_COUNT		= TPM2_PT_FIXED + 29,
> +	TPM2_PT_MAX_COMMAND_SIZE	= TPM2_PT_FIXED + 30,
> +	TPM2_PT_MAX_RESPONSE_SIZE	= TPM2_PT_FIXED + 31,
> +	TPM2_PT_MAX_DIGEST		= TPM2_PT_FIXED + 32,
> +	TPM2_PT_MAX_OBJECT_CONTEXT	= TPM2_PT_FIXED + 33,
> +	TPM2_PT_MAX_SESSION_CONTEXT	= TPM2_PT_FIXED + 34,
> +	TPM2_PT_PS_FAMILY_INDICATOR	= TPM2_PT_FIXED + 35,
> +	TPM2_PT_PS_LEVEL	= TPM2_PT_FIXED + 36,
> +	TPM2_PT_PS_REVISION	= TPM2_PT_FIXED + 37,
> +	TPM2_PT_PS_DAY_OF_YEAR	= TPM2_PT_FIXED + 38,
> +	TPM2_PT_PS_YEAR		= TPM2_PT_FIXED + 39,
> +	TPM2_PT_SPLIT_MAX	= TPM2_PT_FIXED + 40,
> +	TPM2_PT_TOTAL_COMMANDS	= TPM2_PT_FIXED + 41,
> +	TPM2_PT_LIBRARY_COMMANDS	= TPM2_PT_FIXED + 42,
> +	TPM2_PT_VENDOR_COMMANDS		= TPM2_PT_FIXED + 43,
> +	TPM2_PT_NV_BUFFER_MAX		= TPM2_PT_FIXED + 44,
> +	TPM2_PT_MODES			= TPM2_PT_FIXED + 45,
> +	TPM2_PT_MAX_CAP_BUFFER		= TPM2_PT_FIXED + 46,
> +	TPM2_PT_VAR		= TPM2_PT_GROUP * 2,
> +	TPM2_PT_PERMANENT	= TPM2_PT_VAR + 0,
> +	TPM2_PT_STARTUP_CLEAR	= TPM2_PT_VAR + 1,
> +	TPM2_PT_HR_NV_INDEX	= TPM2_PT_VAR + 2,
> +	TPM2_PT_HR_LOADED	= TPM2_PT_VAR + 3,
> +	TPM2_PT_HR_LOADED_AVAIL	= TPM2_PT_VAR + 4,
> +	TPM2_PT_HR_ACTIVE	= TPM2_PT_VAR + 5,
> +	TPM2_PT_HR_ACTIVE_AVAIL	= TPM2_PT_VAR + 6,
> +	TPM2_PT_HR_TRANSIENT_AVAIL	= TPM2_PT_VAR + 7,
> +	TPM2_PT_HR_PERSISTENT		= TPM2_PT_VAR + 8,
> +	TPM2_PT_HR_PERSISTENT_AVAIL	= TPM2_PT_VAR + 9,
> +	TPM2_PT_NV_COUNTERS		= TPM2_PT_VAR + 10,
> +	TPM2_PT_NV_COUNTERS_AVAIL	= TPM2_PT_VAR + 11,
> +	TPM2_PT_ALGORITHM_SET		= TPM2_PT_VAR + 12,
> +	TPM2_PT_LOADED_CURVES		= TPM2_PT_VAR + 13,
> +	TPM2_PT_LOCKOUT_COUNTER		= TPM2_PT_VAR + 14,
> +	TPM2_PT_MAX_AUTH_FAIL		= TPM2_PT_VAR + 15,
> +	TPM2_PT_LOCKOUT_INTERVAL	= TPM2_PT_VAR + 16,
> +	TPM2_PT_LOCKOUT_RECOVERY	= TPM2_PT_VAR + 17,
> +	TPM2_PT_NV_WRITE_RECOVERY	= TPM2_PT_VAR + 18,
> +	TPM2_PT_AUDIT_COUNTER_0	= TPM2_PT_VAR + 19,
> +	TPM2_PT_AUDIT_COUNTER_1	= TPM2_PT_VAR + 20,
> +};
> +
> +struct tpm2_pcr_read_out {
> +	__be32 update_cnt;
> +	__be32 pcr_selects_cnt;
> +	__be16 hash_alg;
> +	u8 pcr_select_size;
> +	u8 pcr_select[TPM2_PCR_SELECT_MIN];
> +	__be32 digests_cnt;
> +	__be16 digest_size;
> +	u8 digest[];
> +} __packed;
> +
> +struct tpm2_get_random_out {
> +	__be16 size;
> +	u8 buffer[TPM_MAX_RNG_DATA];
> +} __packed;
> +
> +struct tpm2_get_cap_out {
> +	u8 more_data;
> +	__be32 subcap_id;
> +	__be32 property_cnt;
> +	__be32 property_id;
> +	__be32 value;
> +} __packed;
> +
> +struct tpm2_pcr_selection {
> +	__be16 hash_alg;
> +	u8 size_of_select;
> +	u8 pcr_select[3];
> +} __packed;
> +
> +struct tpm2_context {
> +	__be64 sequence;
> +	__be32 saved_handle;
> +	__be32 hierarchy;
> +	__be16 blob_size;
> +} __packed;
> +
>  #endif
> -- 
> 2.47.3
> 

BR, Jarkko

