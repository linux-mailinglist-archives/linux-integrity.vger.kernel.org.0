Return-Path: <linux-integrity+bounces-9581-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPXbKdmoB2r7BAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9581-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:14:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E6B559445
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA45030209F0
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF43ED110;
	Fri, 15 May 2026 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3uXodXg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CA31715A;
	Fri, 15 May 2026 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886856; cv=none; b=Ko0jlNVamDvD3By49f8mGkg92r3BS5qi86mHqdO2+NakdzTeatI3U0tfrH9myigQHWAAC+KgBrTd/7ij8mZFMIG5U2qsJEum0WZs0HVWadV/g6d8+Kwrp3AWbTlxkxhvR92scwFO7eYUSNmNQe6W5UX0A20oyKPq7kkLXrsDni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886856; c=relaxed/simple;
	bh=jWgP8k6VJDRmMRCQ+gaM0XiNeuidgKjr1OVPeXStlXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK5a7gJipSBk/T/Iagn2Q54zDEcUDh6A6hSLJxH0OlkG6jPsZwzxDucbwHGdGyyE0yQ6ZbPEkVjJu8awXZR6zFO8hRT4nnsXTrdpvoiTq0AujYDN175E31EDe34EGnWvYVhLkKTDiCoUEOVyg40wPIPOPYMPm+15XZoNsrsdUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3uXodXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB11C2BCB0;
	Fri, 15 May 2026 23:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778886855;
	bh=jWgP8k6VJDRmMRCQ+gaM0XiNeuidgKjr1OVPeXStlXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3uXodXgrw7LBgKclvi+0FoyLcdDv0P5S3bKZmuRiHM9hV/6hwIDpGijHoutAcD/N
	 BzSXHYnyI7xqnPB0BMIUD/ZaN3CO/wnY3Tfw+FQ23kOkuYqrz/RdEhl4OSw1ZBJwVe
	 b9876xil7cv7qWeBvSHJosYQiJzPyk9Td0PgV36mlRYKxGrZ8DEUdrFXvpt3+rcuL5
	 UZQxNOYC3XqaqKVtcQIIEfpVXcbmkXAL84z1GVsP1xp2BCeDnXL4a5rS1DpjjzQjuS
	 6x9B+YsKSPB/Gtequ8Bi4KL/x/of6a3ptLhn7kwlmZth+2cCcLS/2FdKkwYGIXrjam
	 wuX+MIMtAQdUA==
Date: Sat, 16 May 2026 02:14:11 +0300
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
Subject: Re: [PATCH v16 02/38] tpm: Move TPM1 specific definitions to the
 command header
Message-ID: <ageow-IuSpY8O6bq@kernel.org>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-3-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515211410.31440-3-ross.philipson@gmail.com>
X-Rspamd-Queue-Id: 49E6B559445
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9581-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustedcomputinggroup.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,apertussolutions.com:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:13:34PM -0700, Ross Philipson wrote:
> Gather all the TPM1 definitions and structures in the internal header
> file drivers/char/tpm/tpm.h into the command header. In addition, bring
> in the single RNG structure from tpm-interface.c.
> 
> The definitions moved to these files correspond to the TCG specification
> for TPM 1 family:
> 
> TPM 1.2 Main Specification
>  -  https://trustedcomputinggroup.org/resource/tpm-main-specification/
> 
> Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
> Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
> Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
> ---
>  drivers/char/tpm/tpm.h      | 102 --------------------------------
>  drivers/char/tpm/tpm1-cmd.c |   5 --
>  include/linux/tpm_command.h | 115 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 87d68ddf270a..043d78a9617a 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -52,105 +52,9 @@ enum tpm_addr {
>  	TPM_ADDR = 0x4E,
>  };
>  
> -#define TPM_WARN_RETRY          0x800
> -#define TPM_WARN_DOING_SELFTEST 0x802
> -#define TPM_ERR_DEACTIVATED     0x6
> -#define TPM_ERR_DISABLED        0x7
> -#define TPM_ERR_FAILEDSELFTEST  0x1C
> -#define TPM_ERR_INVALID_POSTINIT 38
> -
> -#define TPM_TAG_RQU_COMMAND 193
> -
>  /* TPM2 specific constants. */
>  #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
>  
> -struct	stclear_flags_t {
> -	__be16	tag;
> -	u8	deactivated;
> -	u8	disableForceClear;
> -	u8	physicalPresence;
> -	u8	physicalPresenceLock;
> -	u8	bGlobalLock;
> -} __packed;
> -
> -struct tpm1_version {
> -	u8 major;
> -	u8 minor;
> -	u8 rev_major;
> -	u8 rev_minor;
> -} __packed;
> -
> -struct tpm1_version2 {
> -	__be16 tag;
> -	struct tpm1_version version;
> -} __packed;
> -
> -struct	timeout_t {
> -	__be32	a;
> -	__be32	b;
> -	__be32	c;
> -	__be32	d;
> -} __packed;
> -
> -struct duration_t {
> -	__be32	tpm_short;
> -	__be32	tpm_medium;
> -	__be32	tpm_long;
> -} __packed;
> -
> -struct permanent_flags_t {
> -	__be16	tag;
> -	u8	disable;
> -	u8	ownership;
> -	u8	deactivated;
> -	u8	readPubek;
> -	u8	disableOwnerClear;
> -	u8	allowMaintenance;
> -	u8	physicalPresenceLifetimeLock;
> -	u8	physicalPresenceHWEnable;
> -	u8	physicalPresenceCMDEnable;
> -	u8	CEKPUsed;
> -	u8	TPMpost;
> -	u8	TPMpostLock;
> -	u8	FIPS;
> -	u8	operator;
> -	u8	enableRevokeEK;
> -	u8	nvLocked;
> -	u8	readSRKPub;
> -	u8	tpmEstablished;
> -	u8	maintenanceDone;
> -	u8	disableFullDALogicInfo;
> -} __packed;
> -
> -typedef union {
> -	struct	permanent_flags_t perm_flags;
> -	struct	stclear_flags_t	stclear_flags;
> -	__u8	owned;
> -	__be32	num_pcrs;
> -	struct tpm1_version version1;
> -	struct tpm1_version2 version2;
> -	__be32	manufacturer_id;
> -	struct timeout_t  timeout;
> -	struct duration_t duration;
> -} cap_t;
> -
> -enum tpm_capabilities {
> -	TPM_CAP_FLAG = 4,
> -	TPM_CAP_PROP = 5,
> -	TPM_CAP_VERSION_1_1 = 0x06,
> -	TPM_CAP_VERSION_1_2 = 0x1A,
> -};
> -
> -enum tpm_sub_capabilities {
> -	TPM_CAP_PROP_PCR = 0x101,
> -	TPM_CAP_PROP_MANUFACTURER = 0x103,
> -	TPM_CAP_FLAG_PERM = 0x108,
> -	TPM_CAP_FLAG_VOL = 0x109,
> -	TPM_CAP_PROP_OWNER = 0x111,
> -	TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
> -	TPM_CAP_PROP_TIS_DURATION = 0x120,
> -};
> -
>  enum tpm2_pt_props {
>  	TPM2_PT_NONE = 0x00000000,
>  	TPM2_PT_GROUP = 0x00000100,
> @@ -225,12 +129,6 @@ enum tpm2_pt_props {
>  	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
>  };
>  
> -/* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
> - * bytes, but 128 is still a relatively large number of random bytes and
> - * anything much bigger causes users of struct tpm_cmd_t to start getting
> - * compiler warnings about stack frame size. */
> -#define TPM_MAX_RNG_DATA	128
> -
>  extern const struct class tpm_class;
>  extern const struct class tpmrm_class;
>  extern dev_t tpm_devt;
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 664ca1fff2e8..96f189b5fd6f 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -504,11 +504,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  }
>  EXPORT_SYMBOL_GPL(tpm1_getcap);
>  
> -struct tpm1_get_random_out {
> -	__be32 rng_data_len;
> -	u8 rng_data[TPM_MAX_RNG_DATA];
> -} __packed;
> -
>  /**
>   * tpm1_get_random() - get random bytes from the TPM's RNG
>   * @chip:	a &struct tpm_chip instance
> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> index 174b043d8bbc..30d01953a6f8 100644
> --- a/include/linux/tpm_command.h
> +++ b/include/linux/tpm_command.h
> @@ -36,6 +36,121 @@ enum tpm_command_ordinals {
>  	TPM_ORD_UNSEAL			= 24,
>  };
>  
> +enum tpm_capabilities {
> +	TPM_CAP_FLAG		= 4,
> +	TPM_CAP_PROP		= 5,
> +	TPM_CAP_VERSION_1_1	= 0x06,
> +	TPM_CAP_VERSION_1_2	= 0x1A,
> +};
> +
> +enum tpm_sub_capabilities {
> +	TPM_CAP_PROP_PCR		= 0x101,
> +	TPM_CAP_PROP_MANUFACTURER	= 0x103,
> +	TPM_CAP_FLAG_PERM		= 0x108,
> +	TPM_CAP_FLAG_VOL		= 0x109,
> +	TPM_CAP_PROP_OWNER		= 0x111,
> +	TPM_CAP_PROP_TIS_TIMEOUT	= 0x115,
> +	TPM_CAP_PROP_TIS_DURATION	= 0x120,
> +};
> +
> +/* Return Codes */
> +enum tpm_return_codes {
> +	TPM_BASE_MASK			= 0,
> +	TPM_NON_FATAL_MASK		= 0x00000800,
> +	TPM_SUCCESS			= TPM_BASE_MASK + 0,
> +	TPM_ERR_DEACTIVATED		= TPM_BASE_MASK + 6,
> +	TPM_ERR_DISABLED		= TPM_BASE_MASK + 7,
> +	TPM_ERR_FAIL			= TPM_BASE_MASK + 9,
> +	TPM_ERR_FAILEDSELFTEST		= TPM_BASE_MASK + 28,
> +	TPM_ERR_INVALID_POSTINIT	= TPM_BASE_MASK + 38,
> +	TPM_ERR_INVALID_FAMILY		= TPM_BASE_MASK + 55,
> +	TPM_WARN_RETRY			= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
> +	TPM_WARN_DOING_SELFTEST		= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
> +};
> +
> +struct	stclear_flags_t {
> +	__be16 tag;
> +	u8 deactivated;
> +	u8 disableForceClear;
> +	u8 physicalPresence;
> +	u8 physicalPresenceLock;
> +	u8 bGlobalLock;
> +} __packed;
> +
> +struct tpm1_version {
> +	u8 major;
> +	u8 minor;
> +	u8 rev_major;
> +	u8 rev_minor;
> +} __packed;
> +
> +struct tpm1_version2 {
> +	__be16 tag;
> +	struct tpm1_version version;
> +} __packed;
> +
> +struct	timeout_t {
> +	__be32 a;
> +	__be32 b;
> +	__be32 c;
> +	__be32 d;
> +} __packed;
> +
> +struct duration_t {
> +	__be32 tpm_short;
> +	__be32 tpm_medium;
> +	__be32 tpm_long;
> +} __packed;
> +
> +struct permanent_flags_t {
> +	__be16 tag;
> +	u8 disable;
> +	u8 ownership;
> +	u8 deactivated;
> +	u8 readPubek;
> +	u8 disableOwnerClear;
> +	u8 allowMaintenance;
> +	u8 physicalPresenceLifetimeLock;
> +	u8 physicalPresenceHWEnable;
> +	u8 physicalPresenceCMDEnable;
> +	u8 CEKPUsed;
> +	u8 TPMpost;
> +	u8 TPMpostLock;
> +	u8 FIPS;
> +	u8 operator;
> +	u8 enableRevokeEK;
> +	u8 nvLocked;
> +	u8 readSRKPub;
> +	u8 tpmEstablished;
> +	u8 maintenanceDone;
> +	u8 disableFullDALogicInfo;
> +} __packed;
> +
> +typedef union {
> +	struct permanent_flags_t perm_flags;
> +	struct stclear_flags_t stclear_flags;
> +	__u8 owned;
> +	__be32 num_pcrs;
> +	struct tpm1_version version1;
> +	struct tpm1_version2 version2;
> +	__be32 manufacturer_id;
> +	struct timeout_t timeout;
> +	struct duration_t duration;
> +} cap_t;
> +
> +/*
> + * 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
> + * bytes, but 128 is still a relatively large number of random bytes and
> + * anything much bigger causes users of struct tpm_cmd_t to start getting
> + * compiler warnings about stack frame size.
> + */
> +#define TPM_MAX_RNG_DATA		128
> +
> +struct tpm1_get_random_out {
> +	__be32 rng_data_len;
> +	u8 rng_data[TPM_MAX_RNG_DATA];
> +} __packed;
> +
>  /* Other constants */
>  #define SRKHANDLE                       0x40000000
>  #define TPM_NONCE_SIZE                  20
> -- 
> 2.47.3
> 

LGTM

BR, Jarkko

