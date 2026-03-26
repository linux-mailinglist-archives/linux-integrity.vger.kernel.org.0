Return-Path: <linux-integrity+bounces-9100-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SANZEGFyxWkU+QQAu9opvQ
	(envelope-from <linux-integrity+bounces-9100-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:52:33 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93B339829
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A46D130EF850
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D063BD65A;
	Thu, 26 Mar 2026 17:33:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525E425CE2;
	Thu, 26 Mar 2026 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546398; cv=none; b=uoEEg42OVvyn11Vbb7a7wZcwkobNwHZjd5oF+dGZkxxUmvVNdRM6PWvnDsrwv9jbpTTlENBbQvguxpaq2ySrrqeNTDcSP4shO68cKPxeQQisw4SMdn/Yu3uax7t2WqRCDWWyO049bKi2zzRZc2fjFG7QZREXXII63wi/KIi3vt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546398; c=relaxed/simple;
	bh=hO9i23kMovFAm1siOgUMcKT0NNztMAQggloVd/dbO68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzofP7EM3xHaLbs7twmlqvpN65bMFl1TCfglY8ZpcQumC71V9v0Emb3V1WuNLXs8EXkMpYoI0p8J/cncKl6ham/YNQt5gntEnktPxcqsFgonSBQFI8sOOeYbICd7ikeJV3IiLZ7PAw04kQTqTFrvPatjmgXYVFEdrKTu5XuahKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhW3x5hrfztKRF;
	Fri, 27 Mar 2026 01:29:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3C0D840560;
	Fri, 27 Mar 2026 01:33:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHcu_MbcVpXmwvAQ--.1493S2;
	Thu, 26 Mar 2026 18:33:09 +0100 (CET)
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
Subject: [PATCH v4 10/13] ima: Add support for flushing the hash table when staging measurements
Date: Thu, 26 Mar 2026 18:30:08 +0100
Message-ID: <20260326173011.1191815-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
References: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCHcu_MbcVpXmwvAQ--.1493S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1xtFyruFWrJw4UXFWDArb_yoWrAFWUpa
	ykWry8KrZ5JF1vgry8ArZ3AFya9397WF1UGw4rG3s5JF15Xr4jgF1akryS9Fn5uryrtF1f
	tr4aqr4Yya1rtrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUVHqcUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBGnEnS4T7QAAsi
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9100-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: CB93B339829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the new kernel option ima_flush_htable to decide whether or not
the digests of staged measurement entries are flushed from the hash table,
when they are deleted.

When the option is enabled, replace the old hash table with a new one,
by calling ima_alloc_replace_htable(), and completely delete the
measurements entries.

Note: This code derives from the Alt-IMA Huawei project, whose license is
      GPL-2.0 OR MIT.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 security/integrity/ima/ima.h                  |  1 +
 security/integrity/ima/ima_queue.c            | 36 ++++++++++++++++---
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 89670c5e7c8e..a651a3864dcf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2345,6 +2345,10 @@ Kernel parameters
 			Use the canonical format for the binary runtime
 			measurements, instead of host native format.
 
+	ima_flush_htable  [IMA]
+			Flush the IMA hash table when deleting all the
+			staged measurement entries.
+
 	ima_hash=	[IMA]
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
 				   | sha512 | ... }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 65db152a0a24..699b735dec7d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -340,6 +340,7 @@ extern atomic_long_t ima_num_entries[BINARY__LAST];
 extern atomic_long_t ima_num_violations;
 extern struct hlist_head __rcu *ima_htable;
 extern struct mutex ima_extend_list_mutex;
+extern bool ima_flush_htable;
 
 static inline unsigned int ima_hash_key(u8 *digest)
 {
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 50519ed837d4..f5c18acfbc43 100644
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
 
@@ -317,10 +331,11 @@ int ima_queue_stage(void)
 	return ret;
 }
 
-static void ima_queue_delete(struct list_head *head);
+static void ima_queue_delete(struct list_head *head, bool flush_htable);
 
 int ima_queue_staged_delete_all(void)
 {
+	struct hlist_head *old_queue = NULL;
 	LIST_HEAD(ima_measurements_trim);
 
 	mutex_lock(&ima_extend_list_mutex);
@@ -337,13 +352,26 @@ int ima_queue_staged_delete_all(void)
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
 
-static void ima_queue_delete(struct list_head *head)
+static void ima_queue_delete(struct list_head *head, bool flush_htable)
 {
 	struct ima_queue_entry *qe, *qe_tmp;
 	unsigned int i;
@@ -365,7 +393,7 @@ static void ima_queue_delete(struct list_head *head)
 		list_del(&qe->later);
 
 		/* No leak if condition is false, referenced by ima_htable. */
-		if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
+		if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE) || flush_htable) {
 			kfree(qe->entry->digests);
 			kfree(qe->entry);
 			kfree(qe);
-- 
2.43.0


