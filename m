Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF941E2C
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407566AbfFLHqc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 03:46:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45802 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406508AbfFLHqc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 03:46:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so11271771lfm.12;
        Wed, 12 Jun 2019 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k/75443RIH4N68NV3wz0Tggf6JBCvKFnd3cqnx5023g=;
        b=Dt1Kj1e3lMyZ7Q4Kn3jXG5kfxI8QJ8V7Uy4XFio62y2W1zdpBh6QRAp94M+Mn+4uZR
         lW81587wWD4gdKj3977fGFmjHYxEUmxlcdKxGu96ya90afjTSPDrqnMvzjldLQVoxy45
         IANcOZkrHuM3LdM6xTDWtLVOjT1QUOe3JD1P2CpIcwUI22F/O+60lNRPNmZQdSwGFzdU
         HCJE4nvEtP5QvuogQNUI3Ll8zGjob1rbn6PTQCpsLRNSYOczuKufu69XJ4wfxJ7r9Crr
         LdOftOZf08WbXhuzICp+3ZbNMUCHyPeyk1UDT7gmM11xnj7p23uscaHJi45v1WZcO4bv
         CQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k/75443RIH4N68NV3wz0Tggf6JBCvKFnd3cqnx5023g=;
        b=NGs11/VR6HsV6aU0tz+v/ZI+uOJ82srcWWVDYrMcmxyDTJl6+aiVgYxzFRGBQArasy
         6pQZl/j6fHvfjbid6BVWtv3O15JRaMiSnhxZqcre35I4hI2E6fXbkPXZ7z7bx+v+nIAX
         xDkBxiaflDVkk2ahNJAjJk+gQFTkmqvLVqSQLFikDIgPSI/wzvKfiVkoLRlv/3z5JTwj
         oW7rY1KbEaFZFr12XL8ImTo3ex6FuIPGEpRUDe8GTI0jWBv3rWH/a09dHDyONr3EgLHM
         21Wcs1v9UoVQTalIAMBWRBAT9og1T6l48W6inFYZEp+R1skINjd/34Mz+KdYzHwNuvOY
         2oKQ==
X-Gm-Message-State: APjAAAUcwYeT4UUhvep+4LayqF/iY0VLqU+uKs5gJkFFus3bo18X3YPG
        svi3YUNKHfHzufRGHMnk+Zji/okOBIVkPw==
X-Google-Smtp-Source: APXvYqzxu9EFMioaIzryx2eHt2jIPf5aGPHHqDNWWPs15tQOounQwbIatFB1mGL7RnsJyRzpOMjb7A==
X-Received: by 2002:ac2:54ae:: with SMTP id w14mr7171978lfk.124.1560325589033;
        Wed, 12 Jun 2019 00:46:29 -0700 (PDT)
Received: from localhost.localdomain ([193.211.7.147])
        by smtp.gmail.com with ESMTPSA id h11sm2961610lfm.14.2019.06.12.00.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 00:46:28 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     sds@tycho.nsa.gov, paul@paul-moore.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH v2 1/2] LSM: switch to blocking policy update notifiers
Date:   Wed, 12 Jun 2019 10:44:55 +0300
Message-Id: <20190612074456.2504-1-janne.karhunen@gmail.com>
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

Changelog v2
- Rebase to 'next-queued-testing'

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
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
index 613a5c00e602..47e5849d7557 100644
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

