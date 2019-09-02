Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14ADFA5350
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfIBJt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 05:49:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45394 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbfIBJt3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 05:49:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so9064108lff.12;
        Mon, 02 Sep 2019 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QJuAQt/XUMIom/d81kq3bcx8r6RamswX/ci8IkeZCJw=;
        b=iOOIHbKmD+IliVaZSmQgss+nNXec88E4aI/HwGeKXVCt6kgQ2cqPo2CMfKjdwoLEjf
         FKGuHX009GGKpay8ofYPKd5GVsKjkyMthdiqz9ZNxuRy8KRpKR7Ns2BiaM/J9NF9o29B
         Mhwsb4OTWVN0tSM/BMae16HxEWywenMObNJmscB3VbqnAXD4zo+3IqZUGv7mIQ9rZjT+
         Wtt7ltLtdqz0oXoMYIHaTRVuWu30mwwqLpN6pCam9lquTkBKcr3yYgdSQ2EUTFuTRvbQ
         M+Tcmtt6FfMuvWQzuupDxtdv5UEd29mN3fqwhxkcExJ85M5ExoaLTS+sN1MhN2i8IOyK
         8YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QJuAQt/XUMIom/d81kq3bcx8r6RamswX/ci8IkeZCJw=;
        b=WN026AF2F+b418LqdUhj3cXVylTXqFZxcmM5CLzSxfn4PSMibdZLpzIEAMsUN+Uyhp
         QexCi3tmvTuniGpiKCqpTQ5gHeI4B0209Y4AO3dRZPgxTUjka8LRrCuwy/N1hfxlAHK+
         C0UXU+whSGrYL24YnuzGqJcDjWgzwISZyBelEXIAnU7lFkjR6cNu9nbWbWY8WKoBosHW
         p7GPEmCwh6lFCdNsZrXjbEWPeMg6gZNuE3zO0oh+c4900DjwoEAkny4q527Bu+/i+Ho9
         z90f4mOuPOtBd/IVoDPVcUL5gV+paZ6KQks3TjcKGQdKrP6g/AUARALWOucGPVutsE2j
         XWSQ==
X-Gm-Message-State: APjAAAXLWl1bsQSD5F95pJyIvySfIaXX1pkPOK63jC+nKeaHfjFtaapo
        8BBZEUMchWT8+iMYY3jh+8kjBK6b
X-Google-Smtp-Source: APXvYqx8LOOWlNASKilY50R8Lt91xLH0u9Ggaw5V9x+24+s+tpXpNr4Xi/MoK3HLZ0ekIbd9wDMRSQ==
X-Received: by 2002:ac2:5181:: with SMTP id u1mr4539430lfi.114.1567417765798;
        Mon, 02 Sep 2019 02:49:25 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-175.dhcp.inet.fi. [46.132.186.175])
        by smtp.gmail.com with ESMTPSA id h1sm771635lja.18.2019.09.02.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 02:49:24 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH 1/3] ima: keep the integrity state of open files up to date
Date:   Mon,  2 Sep 2019 12:45:38 +0300
Message-Id: <20190902094540.12786-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When a file is open for writing, kernel crash or power outage
is guaranteed to corrupt the inode integrity state leading to
file appraisal failure on the subsequent boot. Add some basic
infrastructure to keep the integrity measurements up to date
as the files are written to.

Core file operations (open, close, sync, msync, truncate) are
now allowed to update the measurement immediately. In order
to maintain sufficient write performance for writes, add a
latency tunable delayed work workqueue for computing the
measurements.

Changelog v2:
- Make write measurements optional
- Add support for MMIO measurements
- Handle all writes via page flush
- Add work cancellation support, files are properly closed
  after last_writer checks out. This fixes a userspace break
  where the file was still open for writing after closing it.
- Fix/unify IMA_UPDATE_XATTR usage

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 include/linux/ima.h                   |  14 +++
 security/integrity/ima/Kconfig        |  30 ++++++
 security/integrity/ima/ima.h          |  13 +++
 security/integrity/ima/ima_appraise.c |  13 ++-
 security/integrity/ima/ima_main.c     | 128 +++++++++++++++++++++++++-
 security/integrity/integrity.h        |  18 ++++
 6 files changed, 213 insertions(+), 3 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index a20ad398d260..6736844e90d3 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -93,6 +93,20 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
+#if ((defined CONFIG_IMA) && defined(CONFIG_IMA_MEASURE_WRITES))
+void ima_file_update(struct file *file);
+void ima_file_delayed_update(struct file *file);
+#else
+static inline void ima_file_update(struct file *file)
+{
+	return;
+}
+static inline void ima_file_delayed_update(struct file *file)
+{
+	return;
+}
+#endif
+
 #ifndef CONFIG_IMA_KEXEC
 struct kimage;
 
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 897bafc59a33..df1cf684a442 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -310,3 +310,33 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_MEASURE_WRITES
+	bool "Measure file writes (EXPERIMENTAL)"
+	depends on IMA
+	depends on EVM
+	default n
+	help
+	   By default IMA measures files only when they close or sync.
+	   Choose this option if you want the integrity measurements on
+	   the disk to update when the files are still open for writing.
+
+config IMA_MEASUREMENT_LATENCY
+	int
+	depends on IMA
+	range 0 60000
+	default 50
+	help
+	   This value defines the measurement interval when files are
+	   being written. Value is in milliseconds.
+
+config IMA_MEASUREMENT_LATENCY_CEILING
+	int
+	depends on IMA
+	range 100 60000
+	default 5000
+	help
+	   In order to maintain high write performance for large files,
+	   IMA increases the measurement interval as the file size grows.
+	   This value defines the ceiling for the measurement delay in
+	   milliseconds.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 19769bf5f6ab..195e67631f70 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -160,6 +160,19 @@ void ima_init_template_list(void);
 int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
+#if ((defined CONFIG_IMA) && defined(CONFIG_IMA_MEASURE_WRITES))
+void ima_cancel_measurement(struct integrity_iint_cache *iint);
+#else
+static inline void ima_cancel_measurement(struct integrity_iint_cache *iint)
+{
+	return;
+}
+static inline void ima_init_measurement(struct integrity_iint_cache *iint,
+					struct dentry *dentry)
+{
+	return;
+}
+#endif
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 136ae4e0ee92..6c137fb5289b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -78,6 +78,15 @@ static int ima_fix_xattr(struct dentry *dentry,
 	return rc;
 }
 
+#ifdef CONFIG_IMA_MEASURE_WRITES
+inline void ima_init_measurement(struct integrity_iint_cache *iint,
+				 struct dentry *dentry)
+{
+	if (test_bit(IMA_UPDATE_XATTR, &iint->atomic_flags))
+		ima_fix_xattr(dentry, iint);
+}
+#endif
+
 /* Return specific func appraised cached result */
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 					   enum ima_hooks func)
@@ -341,8 +350,10 @@ int ima_appraise_measurement(enum ima_hooks func,
 			iint->flags |= IMA_NEW_FILE;
 		if ((iint->flags & IMA_NEW_FILE) &&
 		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
-		     (inode->i_size == 0)))
+		    (inode->i_size == 0))) {
+			ima_init_measurement(iint, dentry);
 			status = INTEGRITY_PASS;
+		}
 		goto out;
 	}
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 79c01516211b..46d28cdb6466 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -12,7 +12,7 @@
  *
  * File: ima_main.c
  *	implements the IMA hooks: ima_bprm_check, ima_file_mmap,
- *	and ima_file_check.
+ *	ima_file_delayed_update, ima_file_update and ima_file_check.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -26,6 +26,8 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/iversion.h>
+#include <linux/workqueue.h>
+#include <linux/sizes.h>
 #include <linux/fs.h>
 
 #include "ima.h"
@@ -42,6 +44,7 @@ static int hash_setup_done;
 static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
 };
+static struct workqueue_struct *ima_update_wq;
 
 static int __init hash_setup(char *str)
 {
@@ -151,6 +154,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 
 	if (!(mode & FMODE_WRITE))
 		return;
+	ima_cancel_measurement(iint);
 
 	mutex_lock(&iint->mutex);
 	if (atomic_read(&inode->i_writecount) == 1) {
@@ -420,6 +424,117 @@ int ima_bprm_check(struct linux_binprm *bprm)
 				   MAY_EXEC, CREDS_CHECK);
 }
 
+#ifdef CONFIG_IMA_MEASURE_WRITES
+static unsigned long ima_inode_update_delay(struct inode *inode)
+{
+	unsigned long blocks, msecs;
+
+	blocks = i_size_read(inode) / SZ_1M + 1;
+	msecs = blocks * IMA_LATENCY_INCREMENT;
+	if (msecs > CONFIG_IMA_MEASUREMENT_LATENCY_CEILING)
+		msecs = CONFIG_IMA_MEASUREMENT_LATENCY_CEILING;
+
+	return msecs;
+}
+
+static void ima_delayed_update_handler(struct work_struct *work)
+{
+	struct ima_work_entry *entry;
+
+	entry = container_of(work, typeof(*entry), work.work);
+
+	ima_file_update(entry->file);
+	entry->file = NULL;
+	entry->state = IMA_WORK_INACTIVE;
+}
+
+void ima_cancel_measurement(struct integrity_iint_cache *iint)
+{
+	if (iint->ima_work.state != IMA_WORK_ACTIVE)
+		return;
+
+	cancel_delayed_work_sync(&iint->ima_work.work);
+	iint->ima_work.state = IMA_WORK_CANCELLED;
+}
+
+/**
+ * ima_file_delayed_update
+ * @file: pointer to file structure being updated
+ */
+void ima_file_delayed_update(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct integrity_iint_cache *iint;
+	unsigned long msecs;
+	bool creq;
+
+	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+		return;
+
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return;
+
+	if (!test_bit(IMA_UPDATE_XATTR, &iint->atomic_flags))
+		return;
+
+	mutex_lock(&iint->mutex);
+	if (iint->ima_work.state == IMA_WORK_ACTIVE)
+		goto out;
+
+	msecs = ima_inode_update_delay(inode);
+	iint->ima_work.file = file;
+	iint->ima_work.state = IMA_WORK_ACTIVE;
+	INIT_DELAYED_WORK(&iint->ima_work.work, ima_delayed_update_handler);
+
+	creq = queue_delayed_work(ima_update_wq,
+				  &iint->ima_work.work,
+				  msecs_to_jiffies(msecs));
+	if (creq == false) {
+		iint->ima_work.file = NULL;
+		iint->ima_work.state = IMA_WORK_INACTIVE;
+	}
+out:
+	mutex_unlock(&iint->mutex);
+}
+EXPORT_SYMBOL_GPL(ima_file_delayed_update);
+
+/**
+ * ima_file_update - update the file measurement
+ * @file: pointer to file structure being updated
+ */
+void ima_file_update(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct integrity_iint_cache *iint;
+	bool should_measure = true;
+	u64 i_version;
+
+	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+		return;
+
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return;
+
+	if (!test_bit(IMA_UPDATE_XATTR, &iint->atomic_flags))
+		return;
+
+	mutex_lock(&iint->mutex);
+	if (IS_I_VERSION(inode)) {
+		i_version = inode_query_iversion(inode);
+		if (i_version == iint->version)
+			should_measure = false;
+	}
+	if (should_measure) {
+		iint->flags &= ~IMA_COLLECTED;
+		ima_update_xattr(iint, file);
+	}
+	mutex_unlock(&iint->mutex);
+}
+EXPORT_SYMBOL_GPL(ima_file_update);
+#endif /* CONFIG_IMA_MEASURE_WRITES */
+
 /**
  * ima_path_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
@@ -716,9 +831,18 @@ static int __init init_ima(void)
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
-	if (!error)
+	if (!error) {
 		ima_update_policy_flag();
 
+		ima_update_wq = alloc_workqueue("ima-update-wq",
+						WQ_MEM_RECLAIM |
+						WQ_CPU_INTENSIVE,
+						0);
+		if (!ima_update_wq) {
+			pr_err("Failed to allocate write measurement workqueue\n");
+			error = -ENOMEM;
+		}
+	}
 	return error;
 }
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index d9323d31a3a8..0f80c3d2e079 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -64,6 +64,11 @@
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
 
+/* delayed measurement job state */
+#define IMA_WORK_INACTIVE	0
+#define IMA_WORK_ACTIVE		1
+#define IMA_WORK_CANCELLED	2
+
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
 	EVM_XATTR_HMAC,
@@ -115,6 +120,18 @@ struct signature_v2_hdr {
 	uint8_t sig[0];		/* signature payload */
 } __packed;
 
+#if CONFIG_IMA_MEASUREMENT_LATENCY == 0
+#define IMA_LATENCY_INCREMENT	100
+#else
+#define IMA_LATENCY_INCREMENT	CONFIG_IMA_MEASUREMENT_LATENCY
+#endif
+
+struct ima_work_entry {
+	struct delayed_work work;
+	struct file *file;
+	uint8_t state;
+};
+
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
 	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
@@ -131,6 +148,7 @@ struct integrity_iint_cache {
 	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
+	struct ima_work_entry ima_work;
 };
 
 /* rbtree tree calls to lookup, insert, delete
-- 
2.17.1

