Return-Path: <linux-integrity+bounces-9303-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNWiDFol6mnwvAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9303-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 15:57:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 988AC4535CF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E0C1305241A
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCBB29D264;
	Thu, 23 Apr 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HoFfquLk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C82BFC8F;
	Thu, 23 Apr 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776952521; cv=none; b=X0+PAcpoWkVGR3TdDuHYMT9CvmtiwhTLVjpKoHA9Ro9rZB5g+/holemgD2IGdJ8YqAcfNmAxehYFqza6zmSZg2JkVlbjB0upUbwmfc5U03/tjRsVQGmvKNhyJT3LoqGsMOUQv4PewBsexcR+qz2HjfLTERNL0fqnHWOOw5WZCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776952521; c=relaxed/simple;
	bh=quGwF0POZZMWSw3MtDXTCOpYSCku5HoAlCX2fTkXUug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Zxh8keAK+NYtz95TRP0mGvTtRFlIi3peyFbkRI/ubS9HV42s1NaMxVGHowHsfzhafZODnoN+Io0sztJ5mD3C5nMnFk07por4o0EfnF6+tFJkjxRSoscT5ADZQdsqaGm1vGy9+Yh8zNQdZ5NhsnMOSJL2cySb5e2LPtotKlZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HoFfquLk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D1181BF7;
	Thu, 23 Apr 2026 06:55:13 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C49CF3F641;
	Thu, 23 Apr 2026 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776952518; bh=quGwF0POZZMWSw3MtDXTCOpYSCku5HoAlCX2fTkXUug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HoFfquLkrAjIHbreqmD/vsngA9Jq51G8D1ZktxBkXr0+1Imrp0R2GMKqVly52pOE4
	 DNTOm6Jzb+i35WhTDOyqbHHIC1TtsngxZ5SzoCAW3QiufJValXXzCb6AYutmOGG+tC
	 eiLybmpLA+D6Nuhs4c63SyPB9GaptFUCKVn5h12w=
Date: Thu, 23 Apr 2026 14:55:14 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jonathan McDowell <noodles@earth.li>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <aeokwrC86WI7uT+K@e129823.arm.com>
References: <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
 <aekXaU52fzvNYaUF@e129823.arm.com>
 <aekkVQwueKbFtG7C@e129823.arm.com>
 <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
 <aem0SSQuE1e3pGOS@e129823.arm.com>
 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
 <aeoAlVEwzRUPrlVe@e129823.arm.com>
 <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li>
 <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9303-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim,arm.com:email]
X-Rspamd-Queue-Id: 988AC4535CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Thu, 2026-04-23 at 13:53 +0100, Jonathan McDowell wrote:
> > On Thu, Apr 23, 2026 at 01:34:13PM +0100, Yeoreum Yun wrote:
> > > > > On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
> > > > > > > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
> > > > > > > > > Hi Mimi,
> > > > > > > > >
> > > > > > > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> > > > > > > > > > > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
> > > > > > > > > > > the TPM driver must be built as built-in and
> > > > > > > > > > > must be probed before the IMA subsystem is initialized.
> > > > > > > > > > >
> > > > > > > > > > > However, when the TPM device operates over the FF-A protocol using
> > > > > > > > > > > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > > > > > > > > > > the tpm_crb_ffa device — an FF-A device that provides the communication
> > > > > > > > > > > interface to the tpm_crb driver — has not yet been probed.
> > > > > > > > > > >
> > > > > > > > > > > To ensure the TPM device operating over the FF-A protocol with
> > > > > > > > > > > the CRB interface is probed before IMA initialization,
> > > > > > > > > > > the following conditions must be met:
> > > > > > > > > > >
> > > > > > > > > > >    1. The corresponding ffa_device must be registered,
> > > > > > > > > > >       which is done via ffa_init().
> > > > > > > > > > >
> > > > > > > > > > >    2. The tpm_crb_driver must successfully probe this device via
> > > > > > > > > > >       tpm_crb_ffa_init().
> > > > > > > > > > >
> > > > > > > > > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > > > > > > > > >       be probed successfully. (See crb_acpi_add() and
> > > > > > > > > > >       tpm_crb_ffa_init() for reference.)
> > > > > > > > > > >
> > > > > > > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > > > > > > > > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > > > > > > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > > > > > > > > > >
> > > > > > > > > > > When this occurs, probing the TPM device is deferred.
> > > > > > > > > > > However, the deferred probe can happen after the IMA subsystem
> > > > > > > > > > > has already been initialized, since IMA initialization is performed
> > > > > > > > > > > during late_initcall, and deferred_probe_initcall() is performed
> > > > > > > > > > > at the same level.
> > > > > > > > > > >
> > > > > > > > > > > To resolve this, call ima_init() again at late_inicall_sync level
> > > > > > > > > > > so that let IMA not miss TPM PCR value when generating boot_aggregate
> > > > > > > > > > > log though TPM device presents in the system.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > > > > > > >
> > > > > > > > > > A lot of change for just detecting whether ima_init() is being called on
> > > > > > > > > > late_initcall or late_initcall_sync(), without any explanation for all the other
> > > > > > > > > > changes (e.g. ima_init_core).
> > > > > > > > > >
> > > > > > > > > > Please just limit the change to just calling ima_init() twice.
> > > > > > > > >
> > > > > > > > > My concern is that ima_update_policy_flags() will be called
> > > > > > > > > when ima_init() is deferred -- not initialised anything.
> > > > > > > > > though functionally, it might be okay however,
> > > > > > > > > I think ima_update_policy_flags() and notifier should work after ima_init()
> > > > > > > > > works logically.
> > > > > > > > >
> > > > > > > > > This change I think not much quite a lot. just wrapper ima_init() with
> > > > > > > > > ima_init_core() with some error handling.
> > > > > > > > >
> > > > > > > > > Am I missing something?
> > > > > > > >
> > > > > > > > Also, if we handle in ima_init() only, but it failed with other reason,
> > > > > > > > we shouldn't call again ima_init() in the late_initcall_sync.
> > > > > > > >
> > > > > > > > To handle this, It wouldn't do in the ima_init() but we need to handle
> > > > > > > > it by caller of ima_init().
> > > > > > >
> > > > > > > Only tpm_default_chip() is being called to set the ima_tpm_chip.  On failure,
> > > > > > > instead of going into TPM-bypass mode, return immediately.  There are no calls
> > > > > > > to anything else.  Just call ima_init() a second time.
> > > > > >
> > > > > > I’m not fully convinced this is sufficient.
> > > > > >
> > > > > > What I meant is the case where ima_init() fails due to other
> > > > > > initialisation steps, not only tpm_default_chip() (e.g. ima_fs_init()).
> > > > >
> > > > > The purpose of THIS patch is to add late_initcall_sync, when the TPM is not
> > > > > available at late_initcall.  This would be classified as a bug fix and would be
> > > > > backported.  No other changes should be included in this patch.
> > > >
> > > > Okay.
> > > >
> > > > > >
> > > > > > I’d also like to ask again whether it is fine to call
> > > > > > ima_update_policy_flags() and keep the notifier registered in the
> > > > > > deferred TPM case. While this may be functionally acceptable, it seems
> > > > > > logically questionable to do so when ima_init() has not completed.
> > > > >
> > > > > Other than extending the TPM, IMA should behave exactly the same whether there
> > > > > is a TPM or goes into TPM-bypass mode.
> > > > >
> > > > > >
> > > > > > There is also a possibility that a deferred case ultimately fails (e.g.
> > > > > > deferred at late_initcall, but then failing at late_initcall_sync
> > > > > > for another reason, even while entering TPM bypass mode). In that case,
> > > > > > it seems more appropriate to handle this state in the caller of
> > > > > > ima_init(), rather than inside ima_init() itself.
> > > > >
> > > > > If the TPM isn't found at late_initcall_sync(), then IMA should go into TPM-
> > > > > bypass mode.  Please don't make any other changes to the existing IMA behavior
> > > > > and hide it here behind the late_initcall_sync change.
> > > >
> > > > Okay. you're talking called ima_update_policy_flags() at late_initcall
> > > > wouldn't be not a problem even in case of late_initcall_sync's ima_init()
> > > > get failed with "TPM-bypass mode".
> > > >
> > > > I see then, I'll make a patch simpler then.
> > >
> > > But I think in case of below situation:
> > >  - late_initcall's first ima_init() is deferred.
> > >  - late_initcall_sync try again but failed and try again with
> > >    CONFIG_IMA_DEFAULT_HASH.
> > >
> > > I would like to sustain init_ima_core to reduce the same code repeat
> > > in late_initcall_sync.
> >
> > I think what Mimi's proposing is:
> >
> > If we're in late_initcall, and the TPM isn't available, return
> > immediately with an error (the EPROBE_DEFER?), don't do any init.
> >
> > If we're in late_initcall_sync, either we're already initialised, so do
> > return and nothing, or run through the entire flow, even if the TPM
> > isn't unavailable.
> >
> > So ima_init() just needs to know a) if it's in the sync or non-sync mode
> > and b) for the sync mode, if we've already done the init at
> > non-sync.
>
> Thanks, Jonathan.  That is exactly what I'm suggesting.  Any other changes
> should not be included in this patch.  Since Yeoreum is not hearing me, feel
> free to post a patch.

I see. so what you need to is this only
If it looks good to you. I'll send it at v3.

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d48bf0ad26f4..88fe105b7f00 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -166,6 +166,7 @@ enum lsm_order {
  * @initcall_fs: LSM callback for fs_initcall setup, optional
  * @initcall_device: LSM callback for device_initcall() setup, optional
  * @initcall_late: LSM callback for late_initcall() setup, optional
+ * @initcall_late_sync: LSM callback for late_initcall_sync() setup, optional
  */
 struct lsm_info {
        const struct lsm_id *id;
@@ -181,6 +182,7 @@ struct lsm_info {
        int (*initcall_fs)(void);
        int (*initcall_device)(void);
        int (*initcall_late)(void);
+       int (*initcall_late_sync)(void);
 };

 #define DEFINE_LSM(lsm)                                                        \
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a2f34f2d8ad7..334fa8927c45 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -118,10 +118,22 @@ void __init ima_load_x509(void)
 int __init ima_init(void)
 {
        int rc;
+       static bool deferred = false;
+       static bool initialised = false;
+
+       if (initialised)
+               return 0;

        ima_tpm_chip = tpm_default_chip();
-       if (!ima_tpm_chip)
+       if (!ima_tpm_chip) {
+               if (!deferred) {
+                       pr_info("Defer initialisation to the late_initcall_sync stage.\n");
+                       deferred = true;
+                       return 0;
+               }
+
                pr_info("No TPM chip found, activating TPM-bypass!\n");
+       }

        rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
        if (rc)
@@ -158,5 +170,7 @@ int __init ima_init(void)
                                  UTS_RELEASE, strlen(UTS_RELEASE), false,
                                  NULL, 0);

+       initialised = true;
+
        return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1d6229b156fb..847ec74a183d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1274,6 +1274,11 @@ static int __init init_ima(void)
        return error;
 }

+static int __init late_init_ima(void)
+{
+       return ima_init();
+}
+
 static struct security_hook_list ima_hooks[] __ro_after_init = {
        LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
        LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
@@ -1321,4 +1326,6 @@ DEFINE_LSM(ima) = {
        .blobs = &ima_blob_sizes,
        /* Start IMA after the TPM is available */
        .initcall_late = init_ima,
+       /* Start IMA late in case of probing TPM is deferred. */
+       .initcall_late_sync = late_init_ima,
 };
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 573e2a7250c4..4e5c59beb82a 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -547,13 +547,22 @@ device_initcall(security_initcall_device);
  * security_initcall_late - Run the LSM late initcalls
  */
 static int __init security_initcall_late(void)
+{
+       return lsm_initcall(late);
+}
+late_initcall(security_initcall_late);
+
+/**
+ * security_initcall_late_sync - Run the LSM late initcalls sync
+ */
+static int __init security_initcall_late_sync(void)
 {
        int rc;

-       rc = lsm_initcall(late);
+       rc = lsm_initcall(late_sync);
        lsm_pr_dbg("all enabled LSMs fully activated\n");
        call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);

        return rc;
 }
-late_initcall(security_initcall_late);
+late_initcall_sync(security_initcall_late_sync);
...skipping...
+
                pr_info("No TPM chip found, activating TPM-bypass!\n");
+       }

        rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
        if (rc)
@@ -158,5 +170,7 @@ int __init ima_init(void)
                                  UTS_RELEASE, strlen(UTS_RELEASE), false,
                                  NULL, 0);

+       initialised = true;
+
        return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1d6229b156fb..847ec74a183d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1274,6 +1274,11 @@ static int __init init_ima(void)
        return error;
 }

+static int __init late_init_ima(void)
+{
+       return ima_init();
+}
+
 static struct security_hook_list ima_hooks[] __ro_after_init = {
        LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
        LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
@@ -1321,4 +1326,6 @@ DEFINE_LSM(ima) = {
        .blobs = &ima_blob_sizes,
        /* Start IMA after the TPM is available */
        .initcall_late = init_ima,
+       /* Start IMA late in case of probing TPM is deferred. */
+       .initcall_late_sync = late_init_ima,
 };
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 573e2a7250c4..4e5c59beb82a 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -547,13 +547,22 @@ device_initcall(security_initcall_device);
  * security_initcall_late - Run the LSM late initcalls
  */
 static int __init security_initcall_late(void)
+{
+       return lsm_initcall(late);
+}
+late_initcall(security_initcall_late);
+
+/**
+ * security_initcall_late_sync - Run the LSM late initcalls sync
+ */
+static int __init security_initcall_late_sync(void)
 {
        int rc;

-       rc = lsm_initcall(late);
+       rc = lsm_initcall(late_sync);
        lsm_pr_dbg("all enabled LSMs fully activated\n");
        call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);

        return rc;
 }
-late_initcall(security_initcall_late);
+late_initcall_sync(security_initcall_late_sync);


--
Sincerely,
Yeoreum Yun

