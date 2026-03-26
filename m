Return-Path: <linux-integrity+bounces-9102-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCswCqhwxWkU+QQAu9opvQ
	(envelope-from <linux-integrity+bounces-9102-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:45:12 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7B13395E7
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D1A8309C9BD
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FCB4266B1;
	Thu, 26 Mar 2026 17:33:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496442317D;
	Thu, 26 Mar 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546413; cv=none; b=tgz4I6WBbOgJok0fflaDyzh4qHN8vIFxjAnqfVBGPTOMEmi4YstDtPhvP3qINkXBxOu1voFnywr3IIvpkr6DhMAZWlzY53ixcdxtqaxK02BRVYT2CkeSBKwgLPddh82LFSZggkF5Y96S+miswXdohOGk0voIJdVotJg8SlSJ+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546413; c=relaxed/simple;
	bh=7tHiHmy0GI5pGAc1vhuoA//4rPoCQq7Fo3uQASBGL/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4gaXIzx10RP58ewqG8coSD/qcHgS+optjY6VI6va8Rm/ZFZxVqRJF5RtT8kfLKZMjZyCXZ7ahsEOkeQ88jLzI5Hq7HPYLwBBdFbz+Sjp7PhMxNFEVIjYwNclc8btpmn/o7v8mAWDYYMUlS6/fH488L7+988RyXQNekTJSFQ8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhW4G1S18ztKRH;
	Fri, 27 Mar 2026 01:29:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9E3A14056B;
	Fri, 27 Mar 2026 01:33:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHcu_MbcVpXmwvAQ--.1493S4;
	Thu, 26 Mar 2026 18:33:26 +0100 (CET)
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
Subject: [PATCH v4 12/13] ima: Return error on deleting staged measurements after kexec
Date: Thu, 26 Mar 2026 18:30:10 +0100
Message-ID: <20260326173011.1191815-13-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwCHcu_MbcVpXmwvAQ--.1493S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kAFy7XFy5uFWUGr18uFg_yoW5Cw1kpa
	sFgFWUCr4UJFyxKrykGa43Cr4Fk39YgF4UGwsxG3Z2yF1rWFyj9rnxAr12krn8KrW5tF1x
	twsIqr45Aa1DtaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jh6pPUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBGnEnS4T7QACsg
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9102-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB7B13395E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Refuse to delete staged measurements (both with prompt and without) if
a kexec racing with the deletion already prepended staged measurements in
the kexec buffer. In this way, user space becomes aware that staged
measurements are going to appear in the secondary kernel, and thus they
don't have to be saved twice.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_kexec.c |  3 +++
 security/integrity/ima/ima_queue.c | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index de0693fce53c..0816b69f7c39 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -342,6 +342,7 @@ extern atomic_long_t ima_num_violations;
 extern struct hlist_head __rcu *ima_htable;
 extern struct mutex ima_extend_list_mutex;
 extern bool ima_flush_htable;
+extern bool ima_staged_measurements_prepended;
 
 static inline unsigned int ima_hash_key(u8 *digest)
 {
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index d5503dd5cc9b..25c8356be22a 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -116,6 +116,9 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 			break;
 	}
 
+	if (!list_empty(&ima_measurements_staged))
+		ima_staged_measurements_prepended = true;
+
 	list_for_each_entry_rcu(qe, &ima_measurements, later,
 				lockdep_is_held(&ima_extend_list_mutex)) {
 		if (!ret)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 4fb557d61a88..1918c8ea9abb 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -72,6 +72,13 @@ DEFINE_MUTEX(ima_extend_list_mutex);
  */
 static bool ima_measurements_suspended;
 
+/*
+ * Used to determine if staged measurements were prepended during kexec,
+ * so that an error can be sent to user space during deletion, and they don't
+ * store staged measurements twice.
+ */
+bool ima_staged_measurements_prepended;
+
 /* Callers must call synchronize_rcu() and free the hash table. */
 static struct hlist_head *ima_alloc_replace_htable(void)
 {
@@ -344,6 +351,11 @@ int ima_queue_staged_delete_all(void)
 		return -ENOENT;
 	}
 
+	if (ima_staged_measurements_prepended) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ESTALE;
+	}
+
 	list_replace(&ima_measurements_staged, &ima_measurements_trim);
 	INIT_LIST_HEAD(&ima_measurements_staged);
 
@@ -408,6 +420,11 @@ int ima_queue_staged_delete_partial(unsigned long req_value)
 		return -ENOENT;
 	}
 
+	if (ima_staged_measurements_prepended) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ESTALE;
+	}
+
 	if (cut_pos != NULL)
 		/*
 		 * ima_dump_measurement_list() does not modify the list,
-- 
2.43.0


