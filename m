Return-Path: <linux-integrity+bounces-9363-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH2WDOMs8mlvogEAu9opvQ
	(envelope-from <linux-integrity+bounces-9363-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:08:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C14977AA
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEAB8303AA98
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56E382F18;
	Wed, 29 Apr 2026 16:04:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FA40DFD7;
	Wed, 29 Apr 2026 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478664; cv=none; b=touoYz+n1lTgsV3Yq+ONCWow+apecUQuCE+XK6+vIgOJSZa+VPiHWhuQv96037XjtWjp0hr6djw/zHUVn1zIfy/H69/O2XSbOPXwxQX2ta2VyaF6RBZbbdjV5tSTp/zzBaN1X/Rcvx/INFDX78xI7Kf6tQd7GZpU1jz4mRKJET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478664; c=relaxed/simple;
	bh=mI8e3kANvrWe3Uy1cnVbu2cjSNYlTRHBfbdsDNXcYyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6zFNnxjpf0AXlrX/GGxPvN802ESYWwCTkbVxoRhg911ieQwNrP+kFheivHv7oivO8KqMt5fHA5Yo2YIS6BULnukr3I6vSKFLwJid7b6E7j8Zfutag2bIPsxg579BWIeIyHLBepUW4wJJru6oH8q4oJN8bAb50espnhS0pZ1sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4g5MSj6v6tzpV1W;
	Wed, 29 Apr 2026 23:59:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2D62640569;
	Thu, 30 Apr 2026 00:04:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHPmrYK_JpRQ1BAA--.12298S6;
	Wed, 29 Apr 2026 17:04:19 +0100 (CET)
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
Subject: [PATCH v5 04/13] ima: Introduce per binary measurements list type binary_runtime_size value
Date: Wed, 29 Apr 2026 18:03:10 +0200
Message-ID: <20260429160319.4162918-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBHPmrYK_JpRQ1BAA--.12298S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw15Xr1ftr4kGF1kGrWxWFg_yoW7CrWUpa
	nxZF18tr4kXay7KFZ5GF97ZFWrW3yrXry7Jas8W3WI9Fs7Ar1jqF15tryjkFW5G3s8t3W7
	JrWqqr4fAanrt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGnx6jgGGwABsB
X-Rspamd-Queue-Id: B10C14977AA
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
	TAGGED_FROM(0.00)[bounces-9363-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.878];
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

Make binary_runtime_size as an array, to have separate counters per binary
measurements list type. Currently, define the BINARY type for the existing
binary measurements list.

Introduce ima_update_binary_runtime_size() to facilitate updating a
binary_runtime_size value with a given binary measurement list type.

Also add the binary measurements list type parameter to
ima_get_binary_runtime_size(), to retrieve the desired value. Retrieving
the value is now done under the ima_extend_list_mutex, since there can be
concurrent updates.

No functional change (except for the mutex usage, that fixes the
concurrency issue): the BINARY array element is equivalent to the old
binary_runtime_size.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h       |  2 +-
 security/integrity/ima/ima_kexec.c |  5 ++--
 security/integrity/ima/ima_queue.c | 40 +++++++++++++++++++++---------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b417c9d792d8..f8ab6b604c0d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -319,7 +319,7 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
 int __init ima_init_htable(void);
-unsigned long ima_get_binary_runtime_size(void);
+unsigned long ima_get_binary_runtime_size(enum binary_lists binary_list);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 40962dc0ca86..44ebefbdcab0 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -42,7 +42,7 @@ void ima_measure_kexec_event(const char *event_name)
 	long len;
 	int n;
 
-	buf_size = ima_get_binary_runtime_size();
+	buf_size = ima_get_binary_runtime_size(BINARY);
 	len = atomic_long_read(&ima_num_entries[BINARY]);
 
 	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
@@ -159,7 +159,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	else
 		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
 
-	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
+	binary_runtime_size = ima_get_binary_runtime_size(BINARY) +
+			      extra_memory;
 
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
 		kexec_segment_size = ULONG_MAX;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 952172a4905d..b6d10dceb669 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -27,9 +27,11 @@ static struct tpm_digest *digests;
 
 LIST_HEAD(ima_measurements);	/* list of all measurements */
 #ifdef CONFIG_IMA_KEXEC
-static unsigned long binary_runtime_size;
+static unsigned long binary_runtime_size[BINARY__LAST];
 #else
-static unsigned long binary_runtime_size = ULONG_MAX;
+static unsigned long binary_runtime_size[BINARY__LAST] = {
+	[0 ... BINARY__LAST - 1] = ULONG_MAX
+};
 #endif
 
 /* num of stored measurements in the list */
@@ -131,6 +133,20 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
 	return size;
 }
 
+static void ima_update_binary_runtime_size(struct ima_template_entry *entry,
+					   enum binary_lists binary_list)
+{
+	int size;
+
+	if (binary_runtime_size[binary_list] == ULONG_MAX)
+		return;
+
+	size = get_binary_runtime_size(entry);
+	binary_runtime_size[binary_list] =
+		(binary_runtime_size[binary_list] < ULONG_MAX - size) ?
+		binary_runtime_size[binary_list] + size : ULONG_MAX;
+}
+
 /* ima_add_template_entry helper function:
  * - Add template entry to the measurement list and hash table, for
  *   all entries except those carried across kexec.
@@ -163,13 +179,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 		hlist_add_head_rcu(&qe->hnext, &htable[key]);
 	}
 
-	if (binary_runtime_size != ULONG_MAX) {
-		int size;
-
-		size = get_binary_runtime_size(entry);
-		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
-		     binary_runtime_size + size : ULONG_MAX;
-	}
+	ima_update_binary_runtime_size(entry, BINARY);
 	return 0;
 }
 
@@ -178,12 +188,18 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
  * entire binary_runtime_measurement list, including the ima_kexec_hdr
  * structure.
  */
-unsigned long ima_get_binary_runtime_size(void)
+unsigned long ima_get_binary_runtime_size(enum binary_lists binary_list)
 {
-	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
+	unsigned long val;
+
+	mutex_lock(&ima_extend_list_mutex);
+	val = binary_runtime_size[binary_list];
+	mutex_unlock(&ima_extend_list_mutex);
+
+	if (val >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
 		return ULONG_MAX;
 	else
-		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
+		return val + sizeof(struct ima_kexec_hdr);
 }
 
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
-- 
2.43.0


