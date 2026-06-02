Return-Path: <linux-integrity+bounces-9733-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLfcKiK+Hmr1KAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9733-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 13:27:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B462D7B9
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 13:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7185F3064EE4
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EF9339844;
	Tue,  2 Jun 2026 11:17:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58235AC20;
	Tue,  2 Jun 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399050; cv=none; b=g1lRj3D/T/Ore/0R2lr9s6BSw14wjwNZQsQ2xTmRI2Z8Nu2vvVWdsOltHF4xLTNJ78aLuKbPHEREmnnVFQ7607cY5OCenUCFthw0U7JHWHc3giMw0iP02dpqd5pLv/XYNuLzuJ2XYqh9aeBbpVbU8Q/Z1B8j9LN3GYSE/8dS78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399050; c=relaxed/simple;
	bh=yQYmB8f858yvYhsGYdhDzn9gVNG4QoVYLB+drXbWNUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kb92swtUkJ6xdbiXbNd32mP9dwqm0CIZVLqK6d/sXZlej2QX1jSkipZCrHubbHsbZ6Djnkn26mVxD14ul3uWCisw9h0eMurrtZ8ziADhK7sXGY4alv32f5dSYkAMWspGvNAqBKvKLrGPv8pNK4N3keY/+X73nJ2prpfcdzF5mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gV7T011xGz1HCZw;
	Tue,  2 Jun 2026 19:12:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B993240560;
	Tue,  2 Jun 2026 19:17:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnk860ux5qDyEzAA--.30490S2;
	Tue, 02 Jun 2026 12:17:18 +0100 (CET)
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
Subject: [PATCH v6 10/12] ima: Add support for flushing the hash table when staging measurements
Date: Tue,  2 Jun 2026 13:13:59 +0200
Message-ID: <20260602111401.1706052-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
References: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAnk860ux5qDyEzAA--.30490S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gryxtr4rZFyUAF4xtFW7CFg_yoW7CF1rpa
	4kWry7Krn5JF92g34kJ397CFW3u3ykGF1UGr4rG3s5J3W5Xr1j9r1akryS9FsYgr95tF1r
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGoeRsQErgACsX
X-Rspamd-Queue-Id: 373B462D7B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9733-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huaweicloud.com:mid,huawei.com:email]
X-Rspamd-Action: no action

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
 security/integrity/ima/ima.h                  |  1 +
 security/integrity/ima/ima_queue.c            | 41 ++++++++++++++++---
 3 files changed, 42 insertions(+), 6 deletions(-)

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
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a05db5b18982..d2e740c8ff75 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -343,6 +343,7 @@ extern atomic_long_t ima_num_records[BINARY__LAST];
 extern atomic_long_t ima_num_violations;
 extern struct hlist_head __rcu *ima_htable;
 extern struct mutex ima_extend_list_mutex;
+extern bool ima_flush_htable;
 
 static inline unsigned int ima_hash_key(u8 *digest)
 {
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a1aa141756e1..af0502f27d57 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -22,6 +22,20 @@
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
+bool ima_flush_htable;
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


