Return-Path: <linux-integrity+bounces-9748-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RhECDPTiImpGewEAu9opvQ
	(envelope-from <linux-integrity+bounces-9748-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 16:53:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4C64904A
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 16:53:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=h2BsyMvR;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9748-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9748-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9C13046D76
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D113DA5BF;
	Fri,  5 Jun 2026 14:43:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8693D301D;
	Fri,  5 Jun 2026 14:43:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670630; cv=none; b=sDoyZmT9Ub1JeKcnYs/8wsdOBZ2yGrhNJRSzwvKqb+pnjcUQb9yzyNH9HtdMWP5KdFJj5rUvT8KaWFdZVChxxpTk/I5RSK0cCPvIpwsr02YfNRur5ewfQV/F4iWi+rLXC5CVq/WTBLWJ0FmWNHoDnanQUfTr6ID2cQ1vQA+nroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670630; c=relaxed/simple;
	bh=0e1tArr4D65iO+TSEhMNej6FQnO7u5ews7Lm9qq1iZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXclFsuJnBc/ZUH/zvect9CZ83BttAMA7cjWM5bvQPHJ+kZY7HIEJ6Q59c9mNnxsTCrngVN0jXPh1/CxymVqSrQHVcJzUmoUT4xrhPqZ5vrVqmCntB7bGLp5A6Ze98jDZ1pXycoOUmmMq0K324qZgjbWs6YGw3UROeTbALN6T8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h2BsyMvR; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F26182C34;
	Fri,  5 Jun 2026 07:43:40 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98E463F7D8;
	Fri,  5 Jun 2026 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780670625; bh=0e1tArr4D65iO+TSEhMNej6FQnO7u5ews7Lm9qq1iZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2BsyMvRR7CIgjpf3cnGnQzbSgtJWtLA3QvMuxVXcGdBBcqLgn5voAXXN3PtxvQ6t
	 +zidQ07W6H03SyGl+31Tbzjp7Q25NI05Y4WH3bzHEdickSAwagCxlMPMHSqtGXrdYz
	 aaArlK2oFJqjCmXpMnlCz0vNgAqBEA0S0Ie/Cy+8=
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
	Jonathan McDowell <noodles@meta.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v6 3/4] security: ima: rename boot_aggregate when ima is initialised at late_sync
Date: Fri,  5 Jun 2026 15:43:24 +0100
Message-Id: <20260605144325.434436-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605144325.434436-1-yeoreum.yun@arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,meta.com,arm.com];
	TAGGED_FROM(0.00)[bounces-9748-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:zohar@linux.ibm.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:noodles@meta.com,m:yeoreum.yun@arm.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FB4C64904A

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
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
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


