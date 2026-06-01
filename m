Return-Path: <linux-integrity+bounces-9712-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJk1J/GYHWpOcgkAu9opvQ
	(envelope-from <linux-integrity+bounces-9712-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 16:36:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A7620F96
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E2BE3080E73
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2026 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4923BE638;
	Mon,  1 Jun 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jLjSdTNp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C43BD63D;
	Mon,  1 Jun 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324088; cv=none; b=DfvwqYZcL5IcJ5yPMZLWlt2RMMSJPIcl0Guf+Cg2MXSHpUuk9levwBWooC3LFp8Tw0FnV9jkAaw4283aWKWKbtRcOpdFcvECPV+rPfpYJplogMIpNEMuHCVJY8P33fhcuGFAYnIJWahy7NcFpGKWDWgI6qfoz4b3B4oRrpexnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324088; c=relaxed/simple;
	bh=DqTxHaZZXQPDHfxf8GYIoeD/njIopQQ487fQrjpWMT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYTC4YR2X0KMfdY3rstwvWPuCCaPUT53yRPpoJI9TO/3rbIYhfW4wsorgWF/CgcOzfRQbeWyO/r7dyerCZIU9bumvSiido2Ye013s3dJBjx6JaFWFjjSXqhKROxcWQv06IBFWVLwIxV14FfOHeMEz0MgvHUE901F0eq97iuuLX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jLjSdTNp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27BB726A4;
	Mon,  1 Jun 2026 07:28:01 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49DB73F632;
	Mon,  1 Jun 2026 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780324086; bh=DqTxHaZZXQPDHfxf8GYIoeD/njIopQQ487fQrjpWMT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLjSdTNpMMaZMDvH4rqr9EeH0WYqxjf4wxSLQUZB3byyHb2AD7Mo7kA1vaKu/81DW
	 +dXJrfLD6EUmt0ekNehdYNjeCcNbTiHbbTp1xuc+mkAvLuPe1eXgjkQRB6tLWKHtLX
	 iUuM+1RG8AEy+YOzuYFNFW83Tj7TcuG7t8tsSJHY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com,
	zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	noodles@earth.li,
	jarkko@kernel.org,
	sudeep.holla@kernel.org,
	jmorris@namei.org,
	serge@hallyn.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	jgg@ziepe.ca,
	Jonathan McDowell <noodles@meta.com>
Subject: [PATCH v5 3/4] security: ima: rename boot_aggregate when ima is initialised at late_sync
Date: Mon,  1 Jun 2026 15:27:48 +0100
Message-Id: <20260601142749.3379697-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601142749.3379697-1-yeoreum.yun@arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,meta.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9712-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 0E1A7620F96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

To address this issue, IMA_INIT_LATE_SYNC is introduced.
However, a remote attestation service cannot determine when IMA has been
initialized because the boot_aggregate measurement name remains unchanged,
even though IMA is initialized later at late_initcall_sync when
IMA_INIT_LATE_SYNC is enabled.

Therefore, use a distinct boot_aggregate name when IMA_INIT_LATE_SYNC
is enabled, allowing the remote attestation service to identify
when IMA has been initialized.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
[yeoreum.yun@arm.com: modified to align with the IMA_INIT_LATE_SYNC change]
---
 security/integrity/ima/ima.h              |  1 +
 security/integrity/ima/ima_init.c         | 15 +++++++++++----
 security/integrity/ima/ima_template_lib.c |  3 ++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 69e9bf0b82c6..194b195cec1e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -66,6 +66,7 @@ extern struct ima_algo_desc *ima_algo_array __ro_after_init;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
+extern const char boot_aggregate_late_name[];
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a2f34f2d8ad7..4c24bd535466 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -22,6 +22,7 @@
 
 /* name for boot aggregate entry */
 const char boot_aggregate_name[] = "boot_aggregate";
+const char boot_aggregate_late_name[] = "boot_aggregate_late";
 struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
@@ -45,11 +46,11 @@ static int __init ima_add_boot_aggregate(void)
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
 
+	if (IS_ENABLED(CONFIG_IMA_INIT_LATE_SYNC))
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
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


