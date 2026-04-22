Return-Path: <linux-integrity+bounces-9280-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N6LAqUX6WlpUQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9280-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 20:47:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B76449D6E
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 20:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7681302CB0E
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F22DB7B9;
	Wed, 22 Apr 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ch/BFBWe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672B2DA76F;
	Wed, 22 Apr 2026 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776883571; cv=none; b=GKHLu7bpdrcraN5fomC7EN8C3fJ6OY1uObaG2nmWjgw3uWNIj/ElZ+/xNbfEd4yGPHekr05ynW3mm0SdxflzZ3q6EJQ31bPbB6VEMPsl8Y3hWZQVc3Lrp4VjSfRU0fKn+Q7pVLK2dsFq29vIiy81qsVaMsv/epV/VNmfWvOQPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776883571; c=relaxed/simple;
	bh=YL9Q/CEimzmzvwqCzwcq+9U08GB6hZYu6L+QSbxPgrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsePRc+ALM1PJuswQmQhkCf6hbP20MtLKy8NLJCS8kuVgyBuoQQkPqeatAHBiN2SG1pGJMOxv/jNnQ2i0nwzk9YpAgpnwlhZkKDF10jH74VmsnQbs10T6DgNqCU+aCUx9Mz0Bp0zvD3yMVisBV6RRyK4usLmrIo/e6c0B/A0Axg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ch/BFBWe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ACD91E8D;
	Wed, 22 Apr 2026 11:46:02 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197FD3F641;
	Wed, 22 Apr 2026 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776883568; bh=YL9Q/CEimzmzvwqCzwcq+9U08GB6hZYu6L+QSbxPgrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ch/BFBWebDovM5JHuimYfJaNKI9Po1y0ZhwIQ6leJBuyfIlDwYKANwoEMc46lZ5Ev
	 v4fZKAit7uX3nqmR4VWwqePi9+0FE6G0isDwEx4RFVkccZyVEgPvPIlGRaQtKy9SzW
	 WSMb0XZ1/GKDIraL5xbdmcKmc0+UY89GWDXJ3nyg=
Date: Wed, 22 Apr 2026 19:46:01 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
Message-ID: <aekXaU52fzvNYaUF@e129823.arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
 <20260422162449.1814615-2-yeoreum.yun@arm.com>
 <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9280-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,e129823.arm.com:mid]
X-Rspamd-Queue-Id: B1B76449D6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mimi,

> On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
> > the TPM driver must be built as built-in and
> > must be probed before the IMA subsystem is initialized.
> >
> > However, when the TPM device operates over the FF-A protocol using
> > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > the tpm_crb_ffa device — an FF-A device that provides the communication
> > interface to the tpm_crb driver — has not yet been probed.
> >
> > To ensure the TPM device operating over the FF-A protocol with
> > the CRB interface is probed before IMA initialization,
> > the following conditions must be met:
> >
> >    1. The corresponding ffa_device must be registered,
> >       which is done via ffa_init().
> >
> >    2. The tpm_crb_driver must successfully probe this device via
> >       tpm_crb_ffa_init().
> >
> >    3. The tpm_crb driver using CRB over FF-A can then
> >       be probed successfully. (See crb_acpi_add() and
> >       tpm_crb_ffa_init() for reference.)
> >
> > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > all registered with device_initcall, which means crb_acpi_driver_init() may
> > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> >
> > When this occurs, probing the TPM device is deferred.
> > However, the deferred probe can happen after the IMA subsystem
> > has already been initialized, since IMA initialization is performed
> > during late_initcall, and deferred_probe_initcall() is performed
> > at the same level.
> >
> > To resolve this, call ima_init() again at late_inicall_sync level
> > so that let IMA not miss TPM PCR value when generating boot_aggregate
> > log though TPM device presents in the system.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>
> A lot of change for just detecting whether ima_init() is being called on
> late_initcall or late_initcall_sync(), without any explanation for all the other
> changes (e.g. ima_init_core).
>
> Please just limit the change to just calling ima_init() twice.

My concern is that ima_update_policy_flags() will be called
when ima_init() is deferred -- not initialised anything.
though functionally, it might be okay however,
I think ima_update_policy_flags() and notifier should work after ima_init()
works logically.

This change I think not much quite a lot. just wrapper ima_init() with
ima_init_core() with some error handling.

Am I missing something?

>
>
> > ---
> >  include/linux/lsm_hooks.h           |  2 +
> >  security/integrity/ima/ima.h        |  4 +-
> >  security/integrity/ima/ima_init.c   | 10 +++-
> >  security/integrity/ima/ima_main.c   | 76 +++++++++++++++++++++++------
> >  security/integrity/ima/ima_policy.c |  3 ++
> >  security/lsm_init.c                 | 13 ++++-
> >  6 files changed, 87 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index d48bf0ad26f4..88fe105b7f00 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -166,6 +166,7 @@ enum lsm_order {
> >   * @initcall_fs: LSM callback for fs_initcall setup, optional
> >   * @initcall_device: LSM callback for device_initcall() setup, optional
> >   * @initcall_late: LSM callback for late_initcall() setup, optional
> > + * @initcall_late_sync: LSM callback for late_initcall_sync() setup, optional
> >   */
> >  struct lsm_info {
> >  	const struct lsm_id *id;
> > @@ -181,6 +182,7 @@ struct lsm_info {
> >  	int (*initcall_fs)(void);
> >  	int (*initcall_device)(void);
> >  	int (*initcall_late)(void);
> > +	int (*initcall_late_sync)(void);
> >  };
> >
> >  #define DEFINE_LSM(lsm)							\
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index 89ebe98ffc5e..75ee7ad184d0 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -62,6 +62,8 @@ extern int ima_hash_algo_idx __ro_after_init;
> >  extern int ima_extra_slots __ro_after_init;
> >  extern struct ima_algo_desc *ima_algo_array __ro_after_init;
> >
> > +extern bool ima_initialised __ro_after_init;
> > +
> >  extern int ima_appraise;
> >  extern struct tpm_chip *ima_tpm_chip;
> >  extern const char boot_aggregate_name[];
> > @@ -257,7 +259,7 @@ static inline void ima_measure_kexec_event(const char *event_name) {}
> >  extern bool ima_canonical_fmt;
> >
> >  /* Internal IMA function definitions */
> > -int ima_init(void);
> > +int ima_init(bool late);
> >  int ima_fs_init(void);
> >  int ima_add_template_entry(struct ima_template_entry *entry, int violation,
> >  			   const char *op, struct inode *inode,
> > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > index a2f34f2d8ad7..c28c71090ad2 100644
> > --- a/security/integrity/ima/ima_init.c
> > +++ b/security/integrity/ima/ima_init.c
> > @@ -115,13 +115,19 @@ void __init ima_load_x509(void)
> >  }
> >  #endif
> >
> > -int __init ima_init(void)
> > +int __init ima_init(bool late)
> >  {
> >  	int rc;
> >
> >  	ima_tpm_chip = tpm_default_chip();
> > -	if (!ima_tpm_chip)
> > +	if (!ima_tpm_chip) {
> > +		if (!late) {
> > +			pr_info("Defer initialisation to the late_initcall_sync stage.\n");
> > +			return -EPROBE_DEFER;
> > +		}
> > +
> >  		pr_info("No TPM chip found, activating TPM-bypass!\n");
> > +	}
> >
> >  	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
> >  	if (rc)
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 1d6229b156fb..ac444ee600e2 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -38,6 +38,7 @@ int ima_appraise;
> >  #endif
> >
> >  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
> > +bool ima_initialised __ro_after_init = false;
> >  static int hash_setup_done;
> >  static int ima_disabled __ro_after_init;
> >
> > @@ -1237,6 +1238,35 @@ static int ima_kernel_module_request(char *kmod_name)
> >
> >  #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
> >
> > +static int __init init_ima_core(bool late)
> > +{
> > +	int err;
> > +
> > +	if (ima_initialised)
> > +		return 0;
> > +
> > +	err = ima_init(late);
> > +	if (err == -EPROBE_DEFER)
> > +		return 0;
> > +
> > +	if (err && strcmp(hash_algo_name[ima_hash_algo],
> > +			  CONFIG_IMA_DEFAULT_HASH) != 0) {
> > +		pr_info("Allocating %s failed, going to use default hash algorithm %s\n",
> > +			hash_algo_name[ima_hash_algo], CONFIG_IMA_DEFAULT_HASH);
> > +		hash_setup_done = 0;
> > +		hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > +		err = ima_init(late);
> > +	}
> > +
> > +	if (!err) {
> > +		ima_update_policy_flags();
> > +		ima_initialised = true;
> > +	} else
> > +		ima_disabled = 1;
> > +
> > +	return err;
> > +}
> > +
> >  static int __init init_ima(void)
> >  {
> >  	int error;
> > @@ -1250,30 +1280,42 @@ static int __init init_ima(void)
> >  	ima_appraise_parse_cmdline();
> >  	ima_init_template_list();
> >  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > -	error = ima_init();
> > -
> > -	if (error && strcmp(hash_algo_name[ima_hash_algo],
> > -			    CONFIG_IMA_DEFAULT_HASH) != 0) {
> > -		pr_info("Allocating %s failed, going to use default hash algorithm %s\n",
> > -			hash_algo_name[ima_hash_algo], CONFIG_IMA_DEFAULT_HASH);
> > -		hash_setup_done = 0;
> > -		hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > -		error = ima_init();
> > -	}
> > -
> > -	if (error)
> > -		return error;
> >
> >  	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
> > -	if (error)
> > +	if (error) {
> >  		pr_warn("Couldn't register LSM notifier, error %d\n", error);
> > +		goto disable_ima;
> > +	}
> >
> > -	if (!error)
> > -		ima_update_policy_flags();
> > +	error = init_ima_core(false);
> > +	if (error) {
> > +		unregister_blocking_lsm_notifier(&ima_lsm_policy_notifier);
> > +		goto disable_ima;
> > +	}
> > +
> > +	return 0;
> >
> > +disable_ima:
> > +	ima_disabled = 1;
> >  	return error;
> >  }
> >
> > +static int __init late_init_ima(void)
> > +{
> > +	int err;
> > +
> > +	if (ima_disabled)
> > +		return 0;
> > +
> > +	err = init_ima_core(true);
> > +	if (err) {
> > +		unregister_blocking_lsm_notifier(&ima_lsm_policy_notifier);
> > +		ima_disabled = 1;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> >  static struct security_hook_list ima_hooks[] __ro_after_init = {
> >  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> >  	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
> > @@ -1321,4 +1363,6 @@ DEFINE_LSM(ima) = {
> >  	.blobs = &ima_blob_sizes,
> >  	/* Start IMA after the TPM is available */
> >  	.initcall_late = init_ima,
> > +	/* Start IMA late in case of probing TPM is deferred. */
> > +	.initcall_late_sync = late_init_ima,
> >  };
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index bf2d7ba4c14a..c3bcc3521c81 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -501,6 +501,9 @@ static void ima_lsm_update_rules(void)
> >  int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
> >  			  void *lsm_data)
> >  {
> > +	if (!ima_initialised)
> > +		return NOTIFY_DONE;
> > +
> >  	if (event != LSM_POLICY_CHANGE)
> >  		return NOTIFY_DONE;
> >
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 573e2a7250c4..4e5c59beb82a 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -547,13 +547,22 @@ device_initcall(security_initcall_device);
> >   * security_initcall_late - Run the LSM late initcalls
> >   */
> >  static int __init security_initcall_late(void)
> > +{
> > +	return lsm_initcall(late);
> > +}
> > +late_initcall(security_initcall_late);
> > +
> > +/**
> > + * security_initcall_late_sync - Run the LSM late initcalls sync
> > + */
> > +static int __init security_initcall_late_sync(void)
> >  {
> >  	int rc;
> >
> > -	rc = lsm_initcall(late);
> > +	rc = lsm_initcall(late_sync);
> >  	lsm_pr_dbg("all enabled LSMs fully activated\n");
> >  	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
> >
> >  	return rc;
> >  }
> > -late_initcall(security_initcall_late);
> > +late_initcall_sync(security_initcall_late_sync);
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

--
Sincerely,
Yeoreum Yun

