Return-Path: <linux-integrity+bounces-9763-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Au9eIwgNI2rChAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9763-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 19:53:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E564A55F
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 19:53:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9763-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9763-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A665F309024A
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6AA32E757;
	Fri,  5 Jun 2026 17:25:32 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA02E1C4E;
	Fri,  5 Jun 2026 17:25:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680332; cv=none; b=KtyVJ8Nqi2CIvK5exoGZDOrF/dse5rJFIuAVN76v0fq7DTr8+YHNvRyV8Z4duP62mqsv0ltZWaokogkYL6y3YwhVdehk7J2QgPO9z1ELdvyw0riCb0lSrElMmgKovBoA8tkDmAu/+hn8ucsj6teShK31c1/LpvutC2AGkJIeXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680332; c=relaxed/simple;
	bh=bPsLEKrxo7kb4mmKUifLcQG4QcpBQdceyt/4me/F/rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhnQTECVPnoT8uHEHVvEuT605ygJF7bTxDBxDLYAGBGm+jyvMtSWBFNFKiHHeWBuoX9po5qUsVFygwjjnP+m0JCYT9tUdlVjC54sq3eu9POUyK9W1NaZpBKmsglBR+UOZcpGMsUvpqU12RJWM0QnQ7ZlGm8UPtrwsHXo4zhlqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gX7VK4993z1HCnT;
	Sat,  6 Jun 2026 01:20:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 70ADB4056F;
	Sat,  6 Jun 2026 01:25:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCXWY9+BiNqCg9lAA--.44013S2;
	Fri, 05 Jun 2026 18:25:27 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 10/12] ima: Add support for flushing the hash table when staging measurements
Date: Fri,  5 Jun 2026 19:22:34 +0200
Message-ID: <20260605172236.2042045-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
References: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCXWY9+BiNqCg9lAA--.44013S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1kGF4DXF1fCryDCrWxJFb_yoW7Jw4Upa
	4kW34xK3s5JFn3K348J3ykCry3uw4kJF17Grs5G3s5J3W5Xr1j9r1akryfZFs5Kr95tF4r
	tr4aqr4Yya1rtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUoYFADUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBGoiOzcKkQADsV
X-Rspamd-Action: add header
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:from_mime,huaweicloud.com:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9763-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:from_mime,huaweicloud.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E51E564A55F
X-Spam: Yes

From: Roberto Sassu <roberto.sassu@huawei.com>

During staging and delete, measurements are not completely deallocated.
Their entry digest portion is kept and is still reachable with the hash
table to detect duplicate records. If the number of records is significant,
this reduces the memory saving benefit of staging.

Some users might be interested in achieving the best memory saving (the
measurements are completely deallocated) at the cost of having duplicate
records across the staged measurement lists. Duplicate records are still
avoided within the current measurement list.

Introduce the new kernel option ima_flush_htable to decide whether or not
the digests of staged measurement records are flushed from the hash table,
when they are deleted, to achieve the maximum memory saving.

When the option is enabled, replace the old hash table with a new one,
by calling ima_alloc_replace_htable(), and completely delete the
measurements records.

Note: This code derives from the Alt-IMA Huawei project, whose license is
      GPL-2.0 OR MIT.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 security/integrity/ima/ima_queue.c            | 41 ++++++++++++++++---
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..aad318803f82 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2343,6 +2343,12 @@ Kernel parameters
 			Use the canonical format for the binary runtime
 			measurements, instead of host native format.
 
+	ima_flush_htable  [IMA]
+			Flush the IMA hash table when deleting all the
+			staged measurement records, to achieve maximum
+			memory saving at the cost of having duplicate
+			records across the staged measurement lists.
+
 	ima_hash=	[IMA]
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
 				   | sha512 | ... }
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index cdc21e1b929b..df1e81ea7a36 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -22,6 +22,20 @@
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
+static bool ima_flush_htable;
+
+static int __init ima_flush_htable_setup(char *str)
+{
+	if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
+		pr_warn("Hash table not enabled, ignoring request to flush\n");
+		return 1;
+	}
+
+	ima_flush_htable = true;
+	return 1;
+}
+__setup("ima_flush_htable", ima_flush_htable_setup);
+
 /* pre-allocated array of tpm_digest structures to extend a PCR */
 static struct tpm_digest *digests;
 
@@ -332,7 +346,7 @@ int ima_queue_stage(void)
 	return ret;
 }
 
-static void ima_queue_delete(struct list_head *head);
+static void ima_queue_delete(struct list_head *head, bool flush_htable);
 
 /**
  * ima_queue_staged_delete_all - Delete staged measurements
@@ -350,6 +364,7 @@ static void ima_queue_delete(struct list_head *head);
  */
 int ima_queue_staged_delete_all(void)
 {
+	struct hlist_head *old_queue = NULL;
 	LIST_HEAD(ima_measurements_trim);
 
 	mutex_lock(&ima_extend_list_mutex);
@@ -371,21 +386,35 @@ int ima_queue_staged_delete_all(void)
 	if (IS_ENABLED(CONFIG_IMA_KEXEC))
 		binary_runtime_size[BINARY_STAGED] = 0;
 
+	if (ima_flush_htable) {
+		old_queue = ima_alloc_replace_htable();
+		if (IS_ERR(old_queue)) {
+			mutex_unlock(&ima_extend_list_mutex);
+			return PTR_ERR(old_queue);
+		}
+	}
+
 	mutex_unlock(&ima_extend_list_mutex);
 
-	ima_queue_delete(&ima_measurements_trim);
+	if (ima_flush_htable) {
+		synchronize_rcu();
+		kfree(old_queue);
+	}
+
+	ima_queue_delete(&ima_measurements_trim, ima_flush_htable);
 	return 0;
 }
 
 /**
  * ima_queue_delete - Delete measurements
  * @head: List head measurements are deleted from
+ * @flush_htable: Whether or not the hash table is being flushed
  *
  * Delete the measurements from the passed list head completely if the
- * hash table is not enabled, or partially (only the template data), if the
- * hash table is used.
+ * hash table is not enabled or is being flushed, or partially (only the
+ * template data), if the hash table is used.
  */
-static void ima_queue_delete(struct list_head *head)
+static void ima_queue_delete(struct list_head *head, bool flush_htable)
 {
 	struct ima_queue_entry *qe, *qe_tmp;
 	unsigned int i;
@@ -407,7 +436,7 @@ static void ima_queue_delete(struct list_head *head)
 		list_del(&qe->later);
 
 		/* No leak if condition is false, referenced by ima_htable. */
-		if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
+		if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE) || flush_htable) {
 			kfree(qe->entry->digests);
 			kfree(qe->entry);
 			kfree(qe);
-- 
2.43.0


