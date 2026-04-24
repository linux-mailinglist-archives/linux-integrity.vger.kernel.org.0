Return-Path: <linux-integrity+bounces-9325-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNEUDKuk62nIPgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9325-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 19:13:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C80461AF7
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCCF314DBAC
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FDE33C198;
	Fri, 24 Apr 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="L7lsYPaG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6F30C34A;
	Fri, 24 Apr 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049751; cv=none; b=hf2N1MUj5zLoYBWd7O3zYZ4+0Y4SMegJUuaPs5vUbIDbIZWOPPTdLHaHQgnjDu07dqWb1P8Om8qqDVMKv4r5gTb7oAnQK+8J0SN3pd4XK2ITmOfKGhKF2JPs3jICXAP1BaWmaX1ArutTqQwaq+qzVA8PJRu4FZTtBPXBp5tDaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049751; c=relaxed/simple;
	bh=zEcxzMcgMn89IJk+qVytUJpH1pbaIV64uI2bPOhptqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iThvj9ufuSvUCjPFUOCB/ycWIdqVtgID+QgtA8mYfv5pU2fD9HiAZXhd4OQjlrLOyef3+/RwnaPQiXJiFv+dKDTujcBqnkSlPc37PEyQNWp23w0VK4q6PbvrmJwLOV/wJ9IvvUlEqIKnNNVp0VwZvxBEpb33cqEh3g04WMupD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L7lsYPaG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E29F91BB2;
	Fri, 24 Apr 2026 09:55:42 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D68743FAA1;
	Fri, 24 Apr 2026 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777049748; bh=zEcxzMcgMn89IJk+qVytUJpH1pbaIV64uI2bPOhptqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7lsYPaGt/MYLypilx7KBbCsSo/imoWFFxSZCoUYR90FA47PAoKT+rcMmpKYmRToH
	 UFMlir8JyHOrgOlKNaE3TLVXUcEYmWzcDoApQJlkKsP/Urpvote7g8Vf7pWXw23mgy
	 C3dkGS7rKLvV2CxIvzR7qd3mYStmE5lOVoWj8V20=
Date: Fri, 24 Apr 2026 17:55:42 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [RFC PATCH v3 2/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
Message-ID: <aeugjuJwhv6Dr3fm@e129823.arm.com>
References: <cover.1777036497.git.noodles@meta.com>
 <5552c20c6d6d2ae3bbb6b35124af5d98d2f79163.1777036497.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5552c20c6d6d2ae3bbb6b35124af5d98d2f79163.1777036497.git.noodles@meta.com>
X-Rspamd-Queue-Id: 87C80461AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_FROM(0.00)[bounces-9325-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

> From: Jonathan McDowell <noodles@meta.com>
>
> The Linux IMA (Integrity Measurement Architecture) subsystem used for
> secure boot, file integrity, or remote attestation cannot be a loadable
> module for few reasons listed below:
>
>  o Boot-Time Integrity: IMA’s main role is to measure and appraise files
>    before they are used. This includes measuring critical system files
>    during early boot (e.g., init, init scripts, login binaries). If IMA
>    were a module, it would be loaded too late to cover those.
>
>  o TPM Dependency: IMA integrates tightly with the TPM to record
>    measurements into PCRs. The TPM must be initialized early (ideally
>    before init_ima()), which aligns with IMA being built-in.
>
>  o Security Model: IMA is part of a Trusted Computing Base (TCB). Making
>    it a module would weaken the security model, as a potentially
>    compromised system could delay or tamper with its initialization.
>
> IMA must be built-in to ensure it starts measuring from the earliest
> possible point in boot which inturn implies TPM must be initialised and
> ready to use before IMA.
>
> Unfortunately some TPM drivers (such as Arm FF-A, or SPI attached TPM
> devices) are not reliably available during the initcall_late stage,
> resulting in a log error:
>
>   ima: No TPM chip found, activating TPM-bypass!
>
> and no measurements into the TPM by IMA. We can avoid this by doing IMA
> init in the initcall_late_sync stage, after the drivers have completed
> their init + registration.
>
> Rather than do this everywhere, and needlessly delay the initialisation
> of IMA when there is no need to do so, we continue to try to initialise
> at the earlier stage, only deferring to the later point if the TPM is
> not available yet.
>
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>  security/integrity/ima/ima.h              |  3 +-
>  security/integrity/ima/ima_init.c         | 25 ++++++++-------
>  security/integrity/ima/ima_main.c         | 37 ++++++++++++++++++++---
>  security/integrity/ima/ima_template_lib.c |  3 +-
>  4 files changed, 50 insertions(+), 18 deletions(-)
>
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 89ebe98ffc5e..b3677b403a5a 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -65,6 +65,7 @@ extern struct ima_algo_desc *ima_algo_array __ro_after_init;
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
>  extern const char boot_aggregate_name[];
> +extern const char boot_aggregate_late_name[];
>
>  /* IMA event related data */
>  struct ima_event_data {
> @@ -257,7 +258,7 @@ static inline void ima_measure_kexec_event(const char *event_name) {}
>  extern bool ima_canonical_fmt;
>
>  /* Internal IMA function definitions */
> -int ima_init(void);
> +int ima_init_core(bool late);
>  int ima_fs_init(void);
>  int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index a2f34f2d8ad7..5f335834a9bb 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -22,6 +22,7 @@
>
>  /* name for boot aggregate entry */
>  const char boot_aggregate_name[] = "boot_aggregate";
> +const char boot_aggregate_late_name[] = "boot_aggregate_late";
>  struct tpm_chip *ima_tpm_chip;
>
>  /* Add the boot aggregate to the IMA measurement list and extend
> @@ -39,17 +40,17 @@ struct tpm_chip *ima_tpm_chip;
>   * a different value.) Violations add a zero entry to the measurement
>   * list and extend the aggregate PCR value with ff...ff's.
>   */
> -static int __init ima_add_boot_aggregate(void)
> +static int __init ima_add_boot_aggregate(bool late)
>  {
>  	static const char op[] = "add_boot_aggregate";
>  	const char *audit_cause = "ENOMEM";
>  	struct ima_template_entry *entry;
>  	struct ima_iint_cache tmp_iint, *iint = &tmp_iint;
> -	struct ima_event_data event_data = { .iint = iint,
> -					     .filename = boot_aggregate_name };
> +	struct ima_event_data event_data = { .iint = iint };
>  	struct ima_max_digest_data hash;
>  	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
>  						struct ima_digest_data, hdr);
> +	const char *filename;
>  	int result = -ENOMEM;
>  	int violation = 0;
>
> @@ -59,6 +60,12 @@ static int __init ima_add_boot_aggregate(void)
>  	iint->ima_hash->algo = ima_hash_algo;
>  	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
>
> +	if (late)
> +		filename = boot_aggregate_late_name;
> +	else
> +		filename = boot_aggregate_name;
> +	event_data.filename = filename;
> +
>  	/*
>  	 * With TPM 2.0 hash agility, TPM chips could support multiple TPM
>  	 * PCR banks, allowing firmware to configure and enable different
> @@ -86,7 +93,7 @@ static int __init ima_add_boot_aggregate(void)
>  	}
>
>  	result = ima_store_template(entry, violation, NULL,
> -				    boot_aggregate_name,
> +				    filename,
>  				    CONFIG_IMA_MEASURE_PCR_IDX);
>  	if (result < 0) {
>  		ima_free_template_entry(entry);
> @@ -95,7 +102,7 @@ static int __init ima_add_boot_aggregate(void)
>  	}
>  	return 0;
>  err_out:
> -	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, boot_aggregate_name, op,
> +	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, filename, op,
>  			    audit_cause, result, 0);
>  	return result;
>  }
> @@ -115,14 +122,10 @@ void __init ima_load_x509(void)
>  }
>  #endif
>
> -int __init ima_init(void)
> +int __init ima_init_core(bool late)
>  {
>  	int rc;
>
> -	ima_tpm_chip = tpm_default_chip();
> -	if (!ima_tpm_chip)
> -		pr_info("No TPM chip found, activating TPM-bypass!\n");
> -
>  	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
>  	if (rc)
>  		return rc;
> @@ -140,7 +143,7 @@ int __init ima_init(void)
>  	rc = ima_init_digests();
>  	if (rc != 0)
>  		return rc;
> -	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
> +	rc = ima_add_boot_aggregate(late);	/* boot aggregate must be first entry */
>  	if (rc != 0)
>  		return rc;
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 1d6229b156fb..0b93a286c0d3 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1237,7 +1237,7 @@ static int ima_kernel_module_request(char *kmod_name)
>
>  #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
>
> -static int __init init_ima(void)
> +static int __init init_ima(bool late)
>  {
>  	int error;
>
> @@ -1247,10 +1247,26 @@ static int __init init_ima(void)
>  		return 0;
>  	}
>
> +	/*
> +	 * If we found the TPM during our first attempt, or we know there's no
> +	 * TPM, nothing further to do
> +	 */
> +	if (late && (ima_tpm_chip || !IS_ENABLED(CONFIG_TCG_TPM)))
> +		return 0;
> +
> +	ima_tpm_chip = tpm_default_chip();
> +	if (!ima_tpm_chip && !late && IS_ENABLED(CONFIG_TCG_TPM)) {
> +		pr_debug("TPM not available, will try later\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	if (!ima_tpm_chip)
> +		pr_info("No TPM chip found, activating TPM-bypass!\n");
> +
>  	ima_appraise_parse_cmdline();
>  	ima_init_template_list();
>  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> -	error = ima_init();
> +	error = ima_init_core(late);
>
>  	if (error && strcmp(hash_algo_name[ima_hash_algo],
>  			    CONFIG_IMA_DEFAULT_HASH) != 0) {
> @@ -1258,7 +1274,7 @@ static int __init init_ima(void)
>  			hash_algo_name[ima_hash_algo], CONFIG_IMA_DEFAULT_HASH);
>  		hash_setup_done = 0;
>  		hash_setup(CONFIG_IMA_DEFAULT_HASH);
> -		error = ima_init();
> +		error = ima_init_core(late);
>  	}
>
>  	if (error)
> @@ -1274,6 +1290,16 @@ static int __init init_ima(void)
>  	return error;
>  }
>
> +static int __init init_ima_late(void)
> +{
> +	return init_ima(false);
> +}
> +
> +static int __init init_ima_late_sync(void)
> +{
> +	return init_ima(true);
> +}
> +
>  static struct security_hook_list ima_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
>  	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
> @@ -1319,6 +1345,7 @@ DEFINE_LSM(ima) = {
>  	.init = init_ima_lsm,
>  	.order = LSM_ORDER_LAST,
>  	.blobs = &ima_blob_sizes,
> -	/* Start IMA after the TPM is available */
> -	.initcall_late = init_ima,
> +	/* Ensure we start IMA after the TPM is available */
> +	.initcall_late = init_ima_late,
> +	.initcall_late_sync = init_ima_late_sync,
>  };
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 0e627eac9c33..8a89236f926c 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -363,7 +363,8 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
>  		goto out;
>  	}
>
> -	if ((const char *)event_data->filename == boot_aggregate_name) {
> +	if ((const char *)event_data->filename == boot_aggregate_name ||
> +	    (const char *)event_data->filename == boot_aggregate_late_name) {
>  		if (ima_tpm_chip) {
>  			hash.hdr.algo = HASH_ALGO_SHA1;
>  			result = ima_calc_boot_aggregate(hash_hdr);
> --
> 2.53.0
>

This looks good to me. Feel free to add:
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

Thanks!

--
Sincerely,
Yeoreum Yun

