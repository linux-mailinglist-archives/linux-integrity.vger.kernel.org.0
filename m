Return-Path: <linux-integrity+bounces-9095-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIR1J6RuxWl1+AQAu9opvQ
	(envelope-from <linux-integrity+bounces-9095-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:36:36 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 587433393A6
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B6DD308E13A
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8471425CCD;
	Thu, 26 Mar 2026 17:31:32 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCA426EB2;
	Thu, 26 Mar 2026 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546292; cv=none; b=EB21+pNvbLumbg/Ysa8FYsol3RC4mnUQFZFAtcddNJ8Ya9OgPaHx1/hjsoT1vE2tAVYt+gxQCTI4uNXkDmEEUekGO3CMzUHBJ1ubeI3XPGbgmijdVt8BEz+yWhA3eG4QX3QYY6dUGkRHPGBt3pD8UGuh2M7WJ8bgYGZ7hjQd2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546292; c=relaxed/simple;
	bh=3ASW5h9Qjj/PBWMoihRtUZCUgJ9yLdTRrgCN/5L4wck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2QCmZ8qvRjn519D2Hvvh9OFchnnlxc/H0y7r5CmzF0lcBBG1gPuVrpTF7ZJmONq1wbzIZGJubT/DmN/ddR6qiUJqM6P0I0HSP0BxwC0N+jdGwnl4vAKQ2onlf8HTIx9qiUqOn091NuwdgRX/09pNo7z5l1S6GBqc2Ic5CIT26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fhW1h5Kqdz1HBts;
	Fri, 27 Mar 2026 01:27:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 07B9340560;
	Fri, 27 Mar 2026 01:31:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3Yu84bcVppGUvAQ--.1881S7;
	Thu, 26 Mar 2026 18:31:23 +0100 (CET)
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
Subject: [PATCH v4 05/13] ima: Introduce _ima_measurements_start() and _ima_measurements_next()
Date: Thu, 26 Mar 2026 18:30:03 +0100
Message-ID: <20260326173011.1191815-6-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwB3Yu84bcVppGUvAQ--.1881S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry8Jw4fAryrGFWxZw1xGrg_yoW5JFyxpa
	sxua4rCF4kJ3yxWF1xGrWDWr4ru3sag3WDWrWUJ34vvF1UJr1v9r43Aw12vrn0y348Xr1v
	vr90gr45Cw4FyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBGnEnS4T6AAAsn
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9095-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 587433393A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce _ima_measurements_start() and _ima_measurements_next(), renamed
from ima_measurements_start() and ima_measurements_next(), to include the
list head as an additional parameter, so that iteration on different lists
can be implemented by calling those functions.

No functional change: ima_measurements_start() and ima_measurements_next()
pass the ima_measurements list head, used before.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 79b0f287c668..9a8dba14d82a 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -72,14 +72,15 @@ static const struct file_operations ima_measurements_count_ops = {
 };
 
 /* returns pointer to hlist_node */
-static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
+static void *_ima_measurements_start(struct seq_file *m, loff_t *pos,
+				     struct list_head *head)
 {
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
 	/* we need a lock since pos could point beyond last element */
 	rcu_read_lock();
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	list_for_each_entry_rcu(qe, head, later) {
 		if (!l--) {
 			rcu_read_unlock();
 			return qe;
@@ -89,7 +90,13 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 	return NULL;
 }
 
-static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
+{
+	return _ima_measurements_start(m, pos, &ima_measurements);
+}
+
+static void *_ima_measurements_next(struct seq_file *m, void *v, loff_t *pos,
+				    struct list_head *head)
 {
 	struct ima_queue_entry *qe = v;
 
@@ -101,7 +108,12 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&qe->later == &ima_measurements) ? NULL : qe;
+	return (&qe->later == head) ? NULL : qe;
+}
+
+static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return _ima_measurements_next(m, v, pos, &ima_measurements);
 }
 
 static void ima_measurements_stop(struct seq_file *m, void *v)
-- 
2.43.0


