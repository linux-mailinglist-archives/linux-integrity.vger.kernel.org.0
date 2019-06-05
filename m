Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C5358A7
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 10:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFEIgv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 04:36:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36021 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFEIgv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 04:36:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so18460767lfc.3;
        Wed, 05 Jun 2019 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s+A0sbKZJ3KcXdis/xqInAFtidsfuGoO0fwS3mwy0nA=;
        b=uJjN4XQHxxhYkefzHBSji11Zsv98LqF3E7AMoA5VZ3saiCQDUJiIu2bhavyRmUIiVd
         Mox4yD6qSRX5Q80dq1aUjZYjT+RWRAkO9Jdjj19690ZdM+KOdFLyEdrYqOsm04eOM1P6
         HY9QpKcla5bqj2xKDLwsbXoiWazsbn1qTOjkT73Ty7Z/OOO7Mzq0IgYgndk2wuznkS8y
         kLXDPGKpWDEz3uHPeEWUlrmhIbu8Sum0e7soTcz/T6NBlAOX+kVzvRRM8IOoXlGRWGnN
         yACyfPCqjBHcLipMhGzLHiM5t+4ElXv+yRMaXGYcgA2e5LTIpCVQMf3xvZr5p9edYSnP
         T7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s+A0sbKZJ3KcXdis/xqInAFtidsfuGoO0fwS3mwy0nA=;
        b=e2y6X/Jv1pFaN7BCWOT+GEU0iLWr1i9rF9fjTsokKIC3n1WQhD8Hj4UF99JJRVQPUb
         AxrlkTMS4Oc+sImX7mdAsdVgeRJqMoLe7IXOrWLYoB/Rg1V7cW6+ucEp4ZRo3u79Xr5x
         +ZqcZIAHM4j8pt67xFCdfrFxH36ZjOknfCCcqCfu/vHAIdCAZ2oXG8iF74UrjpOJXZYx
         7dxyT4zIP0Fh3IBLp9JNKVU5WYID4SG3vhuhRATcT7NUNVI7SE5O3BPBBYb0Abylb1LQ
         I/mzWiLe4LNH6eadhaMrup6+u7E8mUyLa4GPBUtwurMoyFzToPEixtculbvetROWTvFQ
         FspQ==
X-Gm-Message-State: APjAAAXA9whRN9kTM56h6HEplGfj5ZF7jYlwsKNAGkh226Ts9fr0I0F/
        iwXPR1aW9gcF9neVnfudm4NEsguhA9w=
X-Google-Smtp-Source: APXvYqyFd+3XnBSO/C5j1KVnDVuNT68whUzKmWquZkJEBFMb3f1DrSRme4XgbMhYxbs0OCVXTcOp9A==
X-Received: by 2002:a19:6a01:: with SMTP id u1mr17775000lfu.141.1559723808115;
        Wed, 05 Jun 2019 01:36:48 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-c1d2e6-229.dhcp.inet.fi. [193.210.230.229])
        by smtp.gmail.com with ESMTPSA id t21sm1392637ljg.60.2019.06.05.01.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 01:36:47 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     sds@tycho.nsa.gov, zohar@linux.ibm.com, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH 1/2] LSM: switch to blocking policy update notifiers
Date:   Wed,  5 Jun 2019 11:36:05 +0300
Message-Id: <20190605083606.4209-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Atomic policy updaters are not very useful as they cannot
usually perform the policy updates on their own. Since it
seems that there is no strict need for the atomicity,
switch to the blocking variant. While doing so, rename
the functions accordingly.

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
---
 drivers/infiniband/core/device.c |  6 +++---
 include/linux/security.h         |  6 +++---
 security/security.c              | 23 +++++++++++++----------
 security/selinux/hooks.c         |  2 +-
 security/selinux/selinuxfs.c     |  2 +-
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 78dc07c6ac4b..61c0c93a2e73 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2499,7 +2499,7 @@ static int __init ib_core_init(void)
 		goto err_mad;
 	}
 
-	ret = register_lsm_notifier(&ibdev_lsm_nb);
+	ret = register_blocking_lsm_notifier(&ibdev_lsm_nb);
 	if (ret) {
 		pr_warn("Couldn't register LSM notifier. ret %d\n", ret);
 		goto err_sa;
@@ -2518,7 +2518,7 @@ static int __init ib_core_init(void)
 	return 0;
 
 err_compat:
-	unregister_lsm_notifier(&ibdev_lsm_nb);
+	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
 err_sa:
 	ib_sa_cleanup();
 err_mad:
@@ -2544,7 +2544,7 @@ static void __exit ib_core_cleanup(void)
 	nldev_exit();
 	rdma_nl_unregister(RDMA_NL_LS);
 	unregister_pernet_device(&rdma_dev_net_ops);
-	unregister_lsm_notifier(&ibdev_lsm_nb);
+	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
 	ib_sa_cleanup();
 	ib_mad_cleanup();
 	addr_cleanup();
diff --git a/include/linux/security.h b/include/linux/security.h
index 659071c2e57c..fc655fbe44ad 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -189,9 +189,9 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
 
 #ifdef CONFIG_SECURITY
 
-int call_lsm_notifier(enum lsm_event event, void *data);
-int register_lsm_notifier(struct notifier_block *nb);
-int unregister_lsm_notifier(struct notifier_block *nb);
+int call_blocking_lsm_notifier(enum lsm_event event, void *data);
+int register_blocking_lsm_notifier(struct notifier_block *nb);
+int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 
 /* prototypes */
 extern int security_init(void);
diff --git a/security/security.c b/security/security.c
index c01a88f65ad8..6bfc7636ddb7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -39,7 +39,7 @@
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
-static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
@@ -430,23 +430,26 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		panic("%s - Cannot get early memory.\n", __func__);
 }
 
-int call_lsm_notifier(enum lsm_event event, void *data)
+int call_blocking_lsm_notifier(enum lsm_event event, void *data)
 {
-	return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
+	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
+					    event, data);
 }
-EXPORT_SYMBOL(call_lsm_notifier);
+EXPORT_SYMBOL(call_blocking_lsm_notifier);
 
-int register_lsm_notifier(struct notifier_block *nb)
+int register_blocking_lsm_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&lsm_notifier_chain, nb);
+	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
+						nb);
 }
-EXPORT_SYMBOL(register_lsm_notifier);
+EXPORT_SYMBOL(register_blocking_lsm_notifier);
 
-int unregister_lsm_notifier(struct notifier_block *nb)
+int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&lsm_notifier_chain, nb);
+	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
+						  nb);
 }
-EXPORT_SYMBOL(unregister_lsm_notifier);
+EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
 
 /**
  * lsm_cred_alloc - allocate a composite cred blob
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c61787b15f27..c1e37018c8eb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -197,7 +197,7 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
 {
 	if (event == AVC_CALLBACK_RESET) {
 		sel_ib_pkey_flush();
-		call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+		call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
 	}
 
 	return 0;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 145ee62f205a..1e2e3e4b5fdb 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -180,7 +180,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		selnl_notify_setenforce(new_value);
 		selinux_status_update_setenforce(state, new_value);
 		if (!new_value)
-			call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+			call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
 	}
 	length = count;
 out:
-- 
2.17.1

