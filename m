Return-Path: <linux-integrity+bounces-9320-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEHKKlBv62mFMwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9320-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 15:25:36 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD7845EF9E
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E9D63005179
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43571366558;
	Fri, 24 Apr 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="D65PBNvL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A86388377;
	Fri, 24 Apr 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037063; cv=none; b=cREd5BXqWFrn0o9l16KiPW9F7wPUA6wv7t0BA1Q901dkExT+D2vvcqcM6S63SNED0vGI5LbTtRbCE80rN6mmOsap+7I6ayLG5/73IzHJFSRf5NSunngslM+PP6Rk1eWFE97jlmRHcrmosRogN5jBG8QHFno4nJuYocFGsr13Mu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037063; c=relaxed/simple;
	bh=Hx+ZZbfg1MQJpxlxs4j26r0D+rgjSaAkmyqhG04LFHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRMzW979p3kqvx4GwoE8DWRGnWK5roU4ngq8rGtQaKh+qI21Y81cTORU7YulrQB/v2cOnmYrQweCcaxcKt+usDWJJ3UMOpRbiz4VlEysYm80URSD6qoFL5KD17DZtg3YjAKuKaklQflxVjxWQ622bw0q/1VoaBceXpxwCfHPaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=D65PBNvL; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6Nvn3ObXRz2uv8aCo2R7yd1QBj2duvA02yL4dEAZ49E=; b=D65PBNvL/oV2YtmLCo24PHKwMt
	pAvDYiUfVRne77poAKmrnN+3sUyOMP7zuzpv7XW+FlDtQQUjC7gLAabPh6+QnGz28X20qT80Mngwg
	/BXSW5rQmOg2sja/Uy1tvD1rTH9o4WjMkyq1zye0Cu8hpkNRk7W0DKfHJxclV0+LVGsoWvVUjzJjf
	o4q7e7MDKoktcrX57IXBhVUfPhYR+5x+ibIE6X/VeqFZZkRbKnFy60kOBG0SOiRDKnTw3VMKkiTKo
	P3ArzeZ7w7RnhsAP0T0+xIM+uEF9qzawEMnnyaEADOV0vIW225h1925kJyL8T2p+EI/LGVrHWRACQ
	L+jjsZfQ==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1wGGW3-0000000554Y-09YU;
	Fri, 24 Apr 2026 14:24:19 +0100
Date: Fri, 24 Apr 2026 14:24:19 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH v3 2/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
Message-ID: <5552c20c6d6d2ae3bbb6b35124af5d98d2f79163.1777036497.git.noodles@meta.com>
References: <cover.1777036497.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1777036497.git.noodles@meta.com>
X-Rspamd-Queue-Id: 2FD7845EF9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9320-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[earth.li];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[earth.li:-];
	NEURAL_HAM(-0.00)[-0.985];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Jonathan McDowell <noodles@meta.com>

The Linux IMA (Integrity Measurement Architecture) subsystem used for
secure boot, file integrity, or remote attestation cannot be a loadable
module for few reasons listed below:

 o Boot-Time Integrity: IMA’s main role is to measure and appraise files
   before they are used. This includes measuring critical system files
   during early boot (e.g., init, init scripts, login binaries). If IMA
   were a module, it would be loaded too late to cover those.

 o TPM Dependency: IMA integrates tightly with the TPM to record
   measurements into PCRs. The TPM must be initialized early (ideally
   before init_ima()), which aligns with IMA being built-in.

 o Security Model: IMA is part of a Trusted Computing Base (TCB). Making
   it a module would weaken the security model, as a potentially
   compromised system could delay or tamper with its initialization.

IMA must be built-in to ensure it starts measuring from the earliest
possible point in boot which inturn implies TPM must be initialised and
ready to use before IMA.

Unfortunately some TPM drivers (such as Arm FF-A, or SPI attached TPM
devices) are not reliably available during the initcall_late stage,
resulting in a log error:

  ima: No TPM chip found, activating TPM-bypass!

and no measurements into the TPM by IMA. We can avoid this by doing IMA
init in the initcall_late_sync stage, after the drivers have completed
their init + registration.

Rather than do this everywhere, and needlessly delay the initialisation
of IMA when there is no need to do so, we continue to try to initialise
at the earlier stage, only deferring to the later point if the TPM is
not available yet.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 security/integrity/ima/ima.h              |  3 +-
 security/integrity/ima/ima_init.c         | 25 ++++++++-------
 security/integrity/ima/ima_main.c         | 37 ++++++++++++++++++++---
 security/integrity/ima/ima_template_lib.c |  3 +-
 4 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 89ebe98ffc5e..b3677b403a5a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -65,6 +65,7 @@ extern struct ima_algo_desc *ima_algo_array __ro_after_init;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
+extern const char boot_aggregate_late_name[];
 
 /* IMA event related data */
 struct ima_event_data {
@@ -257,7 +258,7 @@ static inline void ima_measure_kexec_event(const char *event_name) {}
 extern bool ima_canonical_fmt;
 
 /* Internal IMA function definitions */
-int ima_init(void);
+int ima_init_core(bool late);
 int ima_fs_init(void);
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a2f34f2d8ad7..5f335834a9bb 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -22,6 +22,7 @@
 
 /* name for boot aggregate entry */
 const char boot_aggregate_name[] = "boot_aggregate";
+const char boot_aggregate_late_name[] = "boot_aggregate_late";
 struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
@@ -39,17 +40,17 @@ struct tpm_chip *ima_tpm_chip;
  * a different value.) Violations add a zero entry to the measurement
  * list and extend the aggregate PCR value with ff...ff's.
  */
-static int __init ima_add_boot_aggregate(void)
+static int __init ima_add_boot_aggregate(bool late)
 {
 	static const char op[] = "add_boot_aggregate";
 	const char *audit_cause = "ENOMEM";
 	struct ima_template_entry *entry;
 	struct ima_iint_cache tmp_iint, *iint = &tmp_iint;
-	struct ima_event_data event_data = { .iint = iint,
-					     .filename = boot_aggregate_name };
+	struct ima_event_data event_data = { .iint = iint };
 	struct ima_max_digest_data hash;
 	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
 						struct ima_digest_data, hdr);
+	const char *filename;
 	int result = -ENOMEM;
 	int violation = 0;
 
@@ -59,6 +60,12 @@ static int __init ima_add_boot_aggregate(void)
 	iint->ima_hash->algo = ima_hash_algo;
 	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
 
+	if (late)
+		filename = boot_aggregate_late_name;
+	else
+		filename = boot_aggregate_name;
+	event_data.filename = filename;
+
 	/*
 	 * With TPM 2.0 hash agility, TPM chips could support multiple TPM
 	 * PCR banks, allowing firmware to configure and enable different
@@ -86,7 +93,7 @@ static int __init ima_add_boot_aggregate(void)
 	}
 
 	result = ima_store_template(entry, violation, NULL,
-				    boot_aggregate_name,
+				    filename,
 				    CONFIG_IMA_MEASURE_PCR_IDX);
 	if (result < 0) {
 		ima_free_template_entry(entry);
@@ -95,7 +102,7 @@ static int __init ima_add_boot_aggregate(void)
 	}
 	return 0;
 err_out:
-	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, boot_aggregate_name, op,
+	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, filename, op,
 			    audit_cause, result, 0);
 	return result;
 }
@@ -115,14 +122,10 @@ void __init ima_load_x509(void)
 }
 #endif
 
-int __init ima_init(void)
+int __init ima_init_core(bool late)
 {
 	int rc;
 
-	ima_tpm_chip = tpm_default_chip();
-	if (!ima_tpm_chip)
-		pr_info("No TPM chip found, activating TPM-bypass!\n");
-
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
 	if (rc)
 		return rc;
@@ -140,7 +143,7 @@ int __init ima_init(void)
 	rc = ima_init_digests();
 	if (rc != 0)
 		return rc;
-	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
+	rc = ima_add_boot_aggregate(late);	/* boot aggregate must be first entry */
 	if (rc != 0)
 		return rc;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1d6229b156fb..0b93a286c0d3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1237,7 +1237,7 @@ static int ima_kernel_module_request(char *kmod_name)
 
 #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
 
-static int __init init_ima(void)
+static int __init init_ima(bool late)
 {
 	int error;
 
@@ -1247,10 +1247,26 @@ static int __init init_ima(void)
 		return 0;
 	}
 
+	/*
+	 * If we found the TPM during our first attempt, or we know there's no
+	 * TPM, nothing further to do
+	 */
+	if (late && (ima_tpm_chip || !IS_ENABLED(CONFIG_TCG_TPM)))
+		return 0;
+
+	ima_tpm_chip = tpm_default_chip();
+	if (!ima_tpm_chip && !late && IS_ENABLED(CONFIG_TCG_TPM)) {
+		pr_debug("TPM not available, will try later\n");
+		return -EPROBE_DEFER;
+	}
+
+	if (!ima_tpm_chip)
+		pr_info("No TPM chip found, activating TPM-bypass!\n");
+
 	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
-	error = ima_init();
+	error = ima_init_core(late);
 
 	if (error && strcmp(hash_algo_name[ima_hash_algo],
 			    CONFIG_IMA_DEFAULT_HASH) != 0) {
@@ -1258,7 +1274,7 @@ static int __init init_ima(void)
 			hash_algo_name[ima_hash_algo], CONFIG_IMA_DEFAULT_HASH);
 		hash_setup_done = 0;
 		hash_setup(CONFIG_IMA_DEFAULT_HASH);
-		error = ima_init();
+		error = ima_init_core(late);
 	}
 
 	if (error)
@@ -1274,6 +1290,16 @@ static int __init init_ima(void)
 	return error;
 }
 
+static int __init init_ima_late(void)
+{
+	return init_ima(false);
+}
+
+static int __init init_ima_late_sync(void)
+{
+	return init_ima(true);
+}
+
 static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
 	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
@@ -1319,6 +1345,7 @@ DEFINE_LSM(ima) = {
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
-	/* Start IMA after the TPM is available */
-	.initcall_late = init_ima,
+	/* Ensure we start IMA after the TPM is available */
+	.initcall_late = init_ima_late,
+	.initcall_late_sync = init_ima_late_sync,
 };
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 0e627eac9c33..8a89236f926c 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -363,7 +363,8 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 		goto out;
 	}
 
-	if ((const char *)event_data->filename == boot_aggregate_name) {
+	if ((const char *)event_data->filename == boot_aggregate_name ||
+	    (const char *)event_data->filename == boot_aggregate_late_name) {
 		if (ima_tpm_chip) {
 			hash.hdr.algo = HASH_ALGO_SHA1;
 			result = ima_calc_boot_aggregate(hash_hdr);
-- 
2.53.0


