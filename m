Return-Path: <linux-integrity+bounces-1204-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D9854D07
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B80281CBC
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C85D726;
	Wed, 14 Feb 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Se9qOXVf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286805D471
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925118; cv=none; b=QjfM0WpbQgLdSRkU1vXwSSwN+1cUjeOUWMY42GIWPvTL4TGH2PBoQ6DDmHrjVqp3LVvBVCUQ0VQZyF+uALeRvrGK6zlVk1/Aqjl7wLnnAnmq9XX8XFGG8IGdLXwgz6tgoI4IqPjvM5D9Tt7gLDvLYugWkyThpngwycKzDyGGUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925118; c=relaxed/simple;
	bh=jIHknSlxs+BUMwIIgb4jM+RIhY4agxYER8tHl42HWjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNk6HjDY0TeSvMx1gwxqVE71/ewN6D8MCASerFDcJ57Wq8TmKQn1AhXXTTA82gfp0d66ZmwX9u5UEkBU8jLc2yP//mYfWsixtgDyDxCFOyQfY4mWOSbg+L6sF9/6U8/6JdBE+QHSAIY3yEhdi0aB4LJ2naMD7PULBZbkoWBHhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Se9qOXVf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 03D1A20B2006;
	Wed, 14 Feb 2024 07:38:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 03D1A20B2006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925116;
	bh=nv8cVzvekpqI1MThlLDGdnsjUpyj1mzzoaYEfh3bbqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Se9qOXVfkBNkCkLEVMaWKuVYz0npEpoYTgPdPGBLvZAVYE2D94cUzsfGfUTqKmu8e
	 kaLZoxKGkLDmz3fjrriIIVjr2H2VsweKvJu1qoW53r2ocIiQdhbMPb/qzI9e2hOOOi
	 KXYG6HLfpJQam/aDf5BdBbEyrkqXKsz7EZ2SQISI=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	stefanb@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v5 6/8] ima: suspend measurements during buffer copy at kexec execute
Date: Wed, 14 Feb 2024 07:38:25 -0800
Message-Id: <20240214153827.1087657-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New measurements added to the IMA log while the log is being copied
during the kexec 'execute' may not get copied over.  This can cause the
measurement log to be out of sync with the TPM PCRs that IMA extends,
which could result in breaking the integrity of the measurements after
kexec soft reboot.

Implement and call the functions ima_measurements_suspend() and 
ima_measurements_resume() from ima_update_kexec_buffer().

Add a check in the ima_add_template_entry() function not to measure
events when 'suspend_ima_measurements' flag is set.

This ensures the integrity of the IMA log while it is being copied over
to the new Kernel during kexec 'execute'.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_kexec.c |  7 +++++++
 security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..49a6047dd8eb 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -161,6 +161,8 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
+void ima_measurements_suspend(void);
+void ima_measurements_resume(void);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 98fc9b9782a2..dbeeb7f1355e 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -184,6 +184,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 	void *buf = NULL;
 	size_t buf_size;
 	int ret = NOTIFY_OK;
+	bool resume = false;
 
 	if (!kexec_in_progress) {
 		pr_info("%s: No kexec in progress.\n", __func__);
@@ -195,12 +196,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	ima_measurements_suspend();
+
 	ret = ima_dump_measurement_list(&buf_size, &buf,
 					kexec_segment_size);
 
 	if (!buf) {
 		pr_err("%s: Dump measurements failed. Error:%d\n",
 		       __func__, ret);
+		resume = true;
 		goto out;
 	}
 	memcpy(ima_kexec_buffer, buf, buf_size);
@@ -208,6 +212,9 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 	kimage_unmap_segment(ima_kexec_buffer);
 	ima_kexec_buffer = NULL;
 
+	if (resume)
+		ima_measurements_resume();
+
 	return ret;
 }
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..5946a26a2849 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -44,6 +44,11 @@ struct ima_h_table ima_htable = {
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+/*
+ * Used internally by the kernel to suspend-resume ima measurements.
+ */
+static atomic_t suspend_ima_measurements;
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -148,6 +153,20 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 	return result;
 }
 
+void ima_measurements_suspend(void)
+{
+	mutex_lock(&ima_extend_list_mutex);
+	atomic_set(&suspend_ima_measurements, 1);
+	mutex_unlock(&ima_extend_list_mutex);
+}
+
+void ima_measurements_resume(void)
+{
+	mutex_lock(&ima_extend_list_mutex);
+	atomic_set(&suspend_ima_measurements, 0);
+	mutex_unlock(&ima_extend_list_mutex);
+}
+
 /*
  * Add template entry to the measurement list and hash table, and
  * extend the pcr.
@@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		}
 	}
 
+	/*
+	 * suspend_ima_measurements will be set if the system is
+	 * undergoing kexec soft boot to a new kernel.
+	 * suspending measurements in this short window ensures the
+	 * consistency of the IMA measurement list during copying
+	 * of the kexec buffer.
+	 */
+	if (atomic_read(&suspend_ima_measurements)) {
+		audit_cause = "measurements_suspended";
+		audit_info = 0;
+		goto out;
+	}
+
 	result = ima_add_digest_entry(entry,
 				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
 	if (result < 0) {
-- 
2.25.1


