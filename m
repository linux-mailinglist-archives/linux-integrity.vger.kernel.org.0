Return-Path: <linux-integrity+bounces-9372-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GfyEcos8mlvogEAu9opvQ
	(envelope-from <linux-integrity+bounces-9372-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:07:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E104977A1
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BD4F3007A59
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F93A380B;
	Wed, 29 Apr 2026 16:06:45 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3E3859F9;
	Wed, 29 Apr 2026 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478804; cv=none; b=JRkkJZSfVivPw27Ehbdi3XghPPNnJL4oWKm0kYiu/oaMO8wSNezx5aropNmHgdCnrF+00MNtjIqrUQzQ+N+DPvXaLpXFpTPLjE4f//aGUHGD6UAnd4NreCmYHh+VC8dWdWkSFH1Th8GVa1zzzaDY8t+XkNA7Ijxgtooi8PrCor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478804; c=relaxed/simple;
	bh=XpSOz3g/ZHv1XrTBg+oShdF7wJ4s6tJ9FLb9BqKftGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qni8hrpUDnEMqxEL6D0SnyGeBJgEHoVc3LpVRDosWwoiA2r0mDkWeQuYZ9G1MobOGEOSeu9J9ZpoHTenFFzXJvtjSN5E0eG9ey2D6NffKPkbpPm7uTxOzdVKPhaA5knfMsaatA6fPXcuhesREvrS4513TdUPmRMNVLMMlSyxUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g5MW76K8Lz1HCGR;
	Thu, 30 Apr 2026 00:01:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B893A4056A;
	Thu, 30 Apr 2026 00:06:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3rWlpLPJp2RNBAA--.11842S4;
	Wed, 29 Apr 2026 17:06:26 +0100 (CET)
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
Subject: [PATCH v5 12/13] ima: Return error on deleting measurements already copied during kexec
Date: Wed, 29 Apr 2026 18:03:18 +0200
Message-ID: <20260429160319.4162918-13-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwC3rWlpLPJp2RNBAA--.11842S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fXrW3Jr1DGr45GFW3ZFb_yoW5tw4kpa
	sI9Fy7GryUJFyI9r97AF9xC3yfu3yrWF4UGw43C3WvkFyrXF1j9rn3Cw12kFn5GrZ5JFyx
	tw4Yqrs8Ca1DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07Ud5rcUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGnx6jgGJAABs+
X-Rspamd-Queue-Id: 46E104977A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9372-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_SPAM(0.00)[0.879];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Roberto Sassu <roberto.sassu@huawei.com>

Refuse to delete staged or active list measurements, if a kexec racing with
the deletion already copied those measurements in the kexec buffer. In this
way, user space becomes aware that those measurements are going to appear
in the secondary kernel, and thus they don't have to be saved twice.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h       |  5 +++++
 security/integrity/ima/ima_kexec.c |  6 ++++++
 security/integrity/ima/ima_queue.c | 17 +++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 9a741b33d524..9be4c35d7ec1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -344,6 +344,11 @@ extern struct hlist_head __rcu *ima_htable;
 extern struct mutex ima_extend_list_mutex;
 extern bool ima_flush_htable;
 
+#define IMA_MEASUREMENTS_STAGED_COPIED 1
+#define IMA_MEASUREMENTS_COPIED 2
+
+extern u8 ima_copied_flags;
+
 static inline unsigned int ima_hash_key(u8 *digest)
 {
 	/* there is no point in taking a hash of part of a digest */
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index e7bde3d917b2..5c7abde114f2 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -119,6 +119,9 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 			break;
 	}
 
+	if (!list_empty(&ima_measurements_staged))
+		ima_copied_flags |= IMA_MEASUREMENTS_STAGED_COPIED;
+
 	list_for_each_entry_rcu(qe, &ima_measurements, later,
 				lockdep_is_held(&ima_extend_list_mutex)) {
 		if (!ret)
@@ -127,6 +130,9 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 			break;
 	}
 
+	if (!list_empty(&ima_measurements))
+		ima_copied_flags |= IMA_MEASUREMENTS_COPIED;
+
 	mutex_unlock(&ima_extend_list_mutex);
 
 	/*
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 64c4fe73dd5f..7f09cce53772 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -72,6 +72,13 @@ DEFINE_MUTEX(ima_extend_list_mutex);
  */
 static bool ima_measurements_suspended;
 
+/*
+ * Used to determine if staged or active list measurements were copied during
+ * kexec, so that an error can be sent to user space during deletion, and they
+ * don't store those measurements twice.
+ */
+u8 ima_copied_flags;
+
 /* Callers must call synchronize_rcu() and free the hash table. */
 static struct hlist_head *ima_alloc_replace_htable(void)
 {
@@ -344,6 +351,11 @@ int ima_queue_staged_delete_all(void)
 		return -ENOENT;
 	}
 
+	if (ima_copied_flags & IMA_MEASUREMENTS_STAGED_COPIED) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ESTALE;
+	}
+
 	list_replace(&ima_measurements_staged, &ima_measurements_trim);
 	INIT_LIST_HEAD(&ima_measurements_staged);
 
@@ -397,6 +409,11 @@ int ima_queue_delete_partial(unsigned long req_value)
 		return -ENOENT;
 
 	mutex_lock(&ima_extend_list_mutex);
+	if (ima_copied_flags & IMA_MEASUREMENTS_COPIED) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ESTALE;
+	}
+
 	/*
 	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
 	 */
-- 
2.43.0


