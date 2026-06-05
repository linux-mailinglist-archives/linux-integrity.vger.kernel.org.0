Return-Path: <linux-integrity+bounces-9757-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDEWL20KI2rggwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9757-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 19:42:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F164A448
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 19:42:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9757-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9757-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DEE83046218
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1737D11A;
	Fri,  5 Jun 2026 17:23:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13543A5E9B;
	Fri,  5 Jun 2026 17:23:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680219; cv=none; b=huuLFecRjbrHH5bPxMTgWzdWSDlGtAH3VUs18lDOXg8hC3bg8uk9z5hvuoxHDu3RuDBXj5FzRrr4UZ8mTj5y0CM8MBfSxs0TzQEIZLz3aseCRam4IoTNBORSEU8Tt/dmoKqsJAuh1pBBg7QGK0kysVzg3E66anBS+AbaXKbjkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680219; c=relaxed/simple;
	bh=DIs/jdZzYcfBb8Pj3iCU+Q6jz5RIeRsCVygvgL1gNjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2O+9eA+Q4AfIe0drG0e5M90LeeLyluTamt88SDIwryV8t9AIZV/7iFK+M+CSBpAEY4W/g2jTQ6wtfJvBUsliOs6hmePv859wD75a0s7TKxFTUAVRZXGXC6ckAWR+eGUYzfEHDNlX61Cs6eX7ng+Zg6624h7SV+W+wSeOE1pneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gX7S645M8z1HCnG;
	Sat,  6 Jun 2026 01:18:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 6DB044056F;
	Sat,  6 Jun 2026 01:23:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHV43pBSNqZAhlAA--.46721S6;
	Fri, 05 Jun 2026 18:23:32 +0100 (CET)
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
Subject: [PATCH v7 04/12] ima: Introduce per binary measurements list type binary_runtime_size value
Date: Fri,  5 Jun 2026 19:22:28 +0200
Message-ID: <20260605172236.2042045-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBHV43pBSNqZAhlAA--.46721S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw15Xr1ftr4kGF1kJryftFb_yoW7CrWDpa
	nxZF18tr4kXay7KFZ5GF97ZFWrW3yrXr9rJ3s8W3Wv9Fs7Ar1jqF15tryjkFW5G3s8t3W7
	JrWqqr4fAan7t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBGoiO0QKbQAAsa
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
	TAGGED_FROM(0.00)[bounces-9757-lists,linux-integrity=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huaweicloud.com:from_mime,huaweicloud.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B6F164A448
X-Spam: Yes

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
index 8f457f2c7b79..c00c133a140f 100644
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
index 1a0211a12ea4..8dc9459622b3 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -42,7 +42,7 @@ void ima_measure_kexec_event(const char *event_name)
 	long len;
 	int n;
 
-	buf_size = ima_get_binary_runtime_size();
+	buf_size = ima_get_binary_runtime_size(BINARY);
 	len = atomic_long_read(&ima_num_records[BINARY]);
 
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
index 012e725ed4fc..618694d5c082 100644
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
 
 atomic_long_t ima_num_records[BINARY__LAST] = {
@@ -128,6 +130,20 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
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
@@ -160,13 +176,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
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
 
@@ -175,12 +185,18 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
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


