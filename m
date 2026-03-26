Return-Path: <linux-integrity+bounces-9096-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Al2NI1xxWkU+QQAu9opvQ
	(envelope-from <linux-integrity+bounces-9096-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:49:01 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F93339732
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75BE7314DDC7
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF3D4279E7;
	Thu, 26 Mar 2026 17:31:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108CD4279E0;
	Thu, 26 Mar 2026 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546302; cv=none; b=rwUJcANyb3Ozym8zUfi+yIWvzclK6rbaJ4WipHvI76YsVa8muveksQY3OR4m/7eBS12OJaLh7cY3j3/ttq4QgpLA+4U7sxngNlEpE5dCEFdgTwusA2IYDP3dbrXOuOyudTj6gZxWK6NpfeiSxye9FpQ9bAkgXOCnJHZTeaqQ87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546302; c=relaxed/simple;
	bh=EOZOjyjMg6/Fn5W/fcIBelXq1e2DV8pmyX8Hk++1dSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ez6q+D6smHXCF1lZSkXsaDoKN72uabTftxVMB0ZQn75aC0qDqgemin5IJSxVjhWT8Vs5uFxtop68V86W64BIddMAIzTGJqcEMzFCKhlNXN4H8yvtfEbzdVU/vuvSjKtMRZJaQwmTdXQhgcOvVU1YiIL/ZPB75dRuzMqBVd8DKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fhW1r0TMkzpVh5;
	Fri, 27 Mar 2026 01:27:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 4DCE840560;
	Fri, 27 Mar 2026 01:31:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3Yu84bcVppGUvAQ--.1881S8;
	Thu, 26 Mar 2026 18:31:31 +0100 (CET)
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
Subject: [PATCH v4 06/13] ima: Mediate open/release method of the measurements list
Date: Thu, 26 Mar 2026 18:30:04 +0100
Message-ID: <20260326173011.1191815-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwB3Yu84bcVppGUvAQ--.1881S8
X-Coremail-Antispam: 1UD129KBjvJXoWxur1kCFW7ZFy5CFyDJryUAwb_yoWrCr43pa
	93C3yrCr1kJrWfWFn7Ga47Zr4F9a4rKa15Wr4DJa4fAF1rJr9F9F4Yyr12kFs8tryrGr18
	Xw4qqr45uas0yaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBGnEnSsT2wAAsS
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9096-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69F93339732
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the ima_measure_users counter, to implement a semaphore-like
locking scheme where the binary and ASCII measurements list interfaces can
be concurrently open by multiple readers, or alternatively by a single
writer.

A semaphore cannot be used because the kernel cannot return to user space
with a lock held.

Introduce the ima_measure_lock() and ima_measure_unlock() primitives, to
respectively lock/unlock the interfaces (safely with the ima_measure_users
counter, without holding a lock).

Finally, introduce _ima_measurements_open() to lock the interface before
seq_open(), and call it from ima_measurements_open() and
ima_ascii_measurements_open(). And, introduce ima_measurements_release(),
to unlock the interface.

Require CAP_SYS_ADMIN if the interface is opened for write (not possible
for the current measurements interfaces, since they only have read
permission).

No functional changes: multiple readers are allowed as before.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 71 +++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 9a8dba14d82a..68edea7139d5 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -25,6 +25,8 @@
 #include "ima.h"
 
 static DEFINE_MUTEX(ima_write_mutex);
+static DEFINE_MUTEX(ima_measure_mutex);
+static long ima_measure_users;
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -209,16 +211,76 @@ static const struct seq_operations ima_measurments_seqops = {
 	.show = ima_measurements_show
 };
 
+static int ima_measure_lock(bool write)
+{
+	mutex_lock(&ima_measure_mutex);
+	if ((write && ima_measure_users != 0) ||
+	    (!write && ima_measure_users < 0)) {
+		mutex_unlock(&ima_measure_mutex);
+		return -EBUSY;
+	}
+
+	if (write)
+		ima_measure_users--;
+	else
+		ima_measure_users++;
+	mutex_unlock(&ima_measure_mutex);
+	return 0;
+}
+
+static void ima_measure_unlock(bool write)
+{
+	mutex_lock(&ima_measure_mutex);
+	if (write)
+		ima_measure_users++;
+	else
+		ima_measure_users--;
+	mutex_unlock(&ima_measure_mutex);
+}
+
+static int _ima_measurements_open(struct inode *inode, struct file *file,
+				  const struct seq_operations *seq_ops)
+{
+	bool write = (file->f_mode & FMODE_WRITE);
+	int ret;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = ima_measure_lock(write);
+	if (ret < 0)
+		return ret;
+
+	ret = seq_open(file, seq_ops);
+	if (ret < 0)
+		ima_measure_unlock(write);
+
+	return ret;
+}
+
 static int ima_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_measurments_seqops);
+	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
+}
+
+static int ima_measurements_release(struct inode *inode, struct file *file)
+{
+	bool write = (file->f_mode & FMODE_WRITE);
+	int ret;
+
+	/* seq_release() always returns zero. */
+	ret = seq_release(inode, file);
+
+	ima_measure_unlock(write);
+
+	return ret;
 }
 
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ima_measurements_release,
 };
 
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
@@ -283,14 +345,15 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
 static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_ascii_measurements_seqops);
+	return _ima_measurements_open(inode, file,
+				      &ima_ascii_measurements_seqops);
 }
 
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ima_measurements_release,
 };
 
 static ssize_t ima_read_policy(char *path)
-- 
2.43.0


