Return-Path: <linux-integrity+bounces-9369-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCG2Mqct8mlvogEAu9opvQ
	(envelope-from <linux-integrity+bounces-9369-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:11:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58108497864
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3096830F9733
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E733876C3;
	Wed, 29 Apr 2026 16:06:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5A3859F9;
	Wed, 29 Apr 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478779; cv=none; b=dNy6/yffeFjg9aEB7E77crtolduqg+1J+scPsRV5Fbrv83rZhzfwjHS3xNKI8u6b22MYlyd4J7YxxFEWtLRaGGSCgNStAtcErLVRJcKu0ylpbzWGwNdyneYwriVv7jSfGrZNQ6vwXoDgcza/MO6uRO+7UXTyOoazXiBknBaTpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478779; c=relaxed/simple;
	bh=gfs60nu77haj0uHnBta0PUQkspPBlJkNZsDH5x8r6t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTJQJPk12aU9xBrR5Cwmj6nH9bDZyg0PAWOWcp0WJJqiR2rlgrlu3RWDNM7OYLpiWNbYwsprWyCRqDzEi99Bv1q2jkqQlzGFLKlOqDhhn4UbyZPnCTjsheZ6eiZI749DowLqoZzTv3/PccnJJbFSOYPfehQBhcjIQ5aaQsgBW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4g5MVs1SyTzpSwl;
	Thu, 30 Apr 2026 00:01:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 67E7D40560;
	Thu, 30 Apr 2026 00:06:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3rWlpLPJp2RNBAA--.11842S2;
	Wed, 29 Apr 2026 17:06:10 +0100 (CET)
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
Subject: [PATCH v5 10/13] ima: Add support for flushing the hash table when staging measurements
Date: Wed, 29 Apr 2026 18:03:16 +0200
Message-ID: <20260429160319.4162918-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC3rWlpLPJp2RNBAA--.11842S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1xtFyruFWrJw4UXFWDArb_yoWrAFWUpa
	yDWry8KrZ5JF1Igry8ArZayFya9397WF1UG3yrG3s5AF15Xr4jgr1akryS9Fn5uryrtF1f
	trsIqr4Yya1ftrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBGnx6jEGHgAAsP
X-Rspamd-Queue-Id: 58108497864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9369-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.889];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]

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
index 4d0f545fb3ec..56efb8bfcc4e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2343,6 +2343,10 @@ Kernel parameters
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
index ca8fa43ec72b..4af66c1de4dc 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -341,6 +341,7 @@ extern atomic_long_t ima_num_entries[BINARY__LAST];
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


