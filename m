Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9A4769DE
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 06:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhLPFpT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 00:45:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231634AbhLPFpP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 00:45:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG5eIb1009912;
        Thu, 16 Dec 2021 05:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8/0HghlPRa6AYw4QVBzebzq9CEPEm+5oLetbrWEZ0k8=;
 b=bZ6J4RNzK0+9yViu+znBLy6Qx9SkxdLl8qGbBb8saTlopYJevUUb7PkKlFwLtD/Vrr82
 Y1ulIB4NJEyrhR8ECftqMSuEGrsqujdFJkMxiBkG3vXa0lK4tmGt0JZzEiC1LXvSjmAY
 rrwi75AIdXPgmVrcesAGZzQauMwU2Yq0eL4VR13Lk8z6/zt4i9sBvIKxH8Lz0GkLgKvL
 bkGvEsAa+qQwdJzCpRH+FLIOyl8550q45SDRueAcyMIPhhT+NiW4t1+te9J/fnu6VZbV
 hovI1q9PB7R4W0QcL/9Sok33fWmcJuJUnzOp/m+X2tEVUIgnhf45c2uelK++wkfK11Mu mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jm96g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:30 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG5UM2Y000783;
        Thu, 16 Dec 2021 05:43:30 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jm967-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:30 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG5hM0p010923;
        Thu, 16 Dec 2021 05:43:29 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 3cy7712a9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:29 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG5hRTf30015794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 05:43:27 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD6AE6E053;
        Thu, 16 Dec 2021 05:43:27 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 861D46E050;
        Thu, 16 Dec 2021 05:43:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 05:43:26 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v7 01/14] ima: Add IMA namespace support
Date:   Thu, 16 Dec 2021 00:43:10 -0500
Message-Id: <20211216054323.1707384-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ml8-wb0m2-C8cwnrRyc9dvl7dYdpBWG2
X-Proofpoint-GUID: sFc4hN183Q11eHtNLdC-Dfs0RMyIfmV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160033
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement an IMA namespace data structure that gets created alongside a
user namespace with CLONE_NEWUSER. This lays down the foundation for
namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
IMA-appraisal).

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/ima.h                      | 33 ++++++++++++
 include/linux/user_namespace.h           |  4 ++
 init/Kconfig                             | 10 ++++
 kernel/user.c                            |  7 +++
 kernel/user_namespace.c                  |  8 +++
 security/integrity/ima/Makefile          |  3 +-
 security/integrity/ima/ima.h             |  8 +++
 security/integrity/ima/ima_init.c        |  4 ++
 security/integrity/ima/ima_init_ima_ns.c | 28 ++++++++++
 security/integrity/ima/ima_ns.c          | 65 ++++++++++++++++++++++++
 10 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b6ab66a546ae..61461ee5b208 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/user_namespace.h>
 #include <crypto/hash_info.h>
 struct linux_binprm;
 
@@ -210,6 +211,38 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 }
 #endif /* CONFIG_IMA_APPRAISE */
 
+extern struct ima_namespace init_ima_ns;
+
+#ifdef CONFIG_IMA_NS
+
+void free_ima_ns(struct user_namespace *ns);
+int create_ima_ns(struct user_namespace *user_ns);
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return current_user_ns()->ima_ns;
+}
+
+#else
+
+static inline void free_ima_ns(struct user_namespace *user_ns)
+{
+}
+
+static inline int create_ima_ns(struct user_namespace *user_ns)
+{
+#ifdef CONFIG_IMA
+	user_ns->ima_ns = &init_ima_ns;
+#endif
+	return 0;
+}
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return &init_ima_ns;
+}
+#endif /* CONFIG_IMA_NS */
+
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
 extern bool ima_appraise_signature(enum kernel_read_file_id func);
 #else
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..5249db04d62b 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
 #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
 
 struct ucounts;
+struct ima_namespace;
 
 enum ucount_type {
 	UCOUNT_USER_NAMESPACES,
@@ -99,6 +100,9 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+#ifdef CONFIG_IMA
+	struct ima_namespace	*ima_ns;
+#endif
 } __randomize_layout;
 
 struct ucounts {
diff --git a/init/Kconfig b/init/Kconfig
index 11f8a845f259..27890607e8cb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1242,6 +1242,16 @@ config NET_NS
 	  Allow user space to create what appear to be multiple instances
 	  of the network stack.
 
+config IMA_NS
+	bool "IMA namespace"
+	depends on USER_NS
+	depends on IMA
+	default y
+	help
+	  Allow the creation of IMA namespaces for each user namespace.
+	  Namespaced IMA enables having IMA features work separately
+	  in each IMA namespace.
+
 endif # NAMESPACES
 
 config CHECKPOINT_RESTORE
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539..287751d89b44 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -20,6 +20,10 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 
+#ifdef CONFIG_IMA
+extern struct ima_namespace init_ima_ns;
+#endif
+
 /*
  * userns count is 1 for root user, 1 for init_uts_ns,
  * and 1 for... ?
@@ -67,6 +71,9 @@ struct user_namespace init_user_ns = {
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
 #endif
+#ifdef CONFIG_IMA
+	.ima_ns = &init_ima_ns,
+#endif
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..6fa01323aac9 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/fs_struct.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/ima.h>
 
 static struct kmem_cache *user_ns_cachep __read_mostly;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -141,8 +142,14 @@ int create_user_ns(struct cred *new)
 	if (!setup_userns_sysctls(ns))
 		goto fail_keyring;
 
+	ret = create_ima_ns(ns);
+	if (ret)
+		goto fail_sysctls;
+
 	set_cred_user_ns(new, ns);
 	return 0;
+fail_sysctls:
+	retire_userns_sysctls(ns);
 fail_keyring:
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	key_put(ns->persistent_keyring_register);
@@ -196,6 +203,7 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
+		free_ima_ns(ns);
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 2499f2485c04..b86a35fbed60 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -7,13 +7,14 @@
 obj-$(CONFIG_IMA) += ima.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_init_ima_ns.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_NS) += ima_ns.o
 
 ifeq ($(CONFIG_EFI),y)
 ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..4606d3b1493f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -119,6 +119,10 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+struct ima_namespace {
+	int avoid_zero_size;
+} __randomize_layout;
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
@@ -418,6 +422,10 @@ static inline void ima_free_modsig(struct modsig *modsig)
 }
 #endif /* CONFIG_IMA_APPRAISE_MODSIG */
 
+int ima_ns_init(void);
+struct ima_namespace;
+int ima_init_namespace(struct ima_namespace *ns);
+
 /* LSM based policy rules require audit */
 #ifdef CONFIG_IMA_LSM_RULES
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index b26fa67476b4..f6ae4557a0da 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -120,6 +120,10 @@ int __init ima_init(void)
 {
 	int rc;
 
+	rc = ima_ns_init();
+	if (rc)
+		return rc;
+
 	ima_tpm_chip = tpm_default_chip();
 	if (!ima_tpm_chip)
 		pr_info("No TPM chip found, activating TPM-bypass!\n");
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
new file mode 100644
index 000000000000..46d8cb2113a1
--- /dev/null
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 IBM Corporation
+ * Author:
+ *   Yuqiong Sun <suny@us.ibm.com>
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ */
+
+#include <linux/export.h>
+#include <linux/user_namespace.h>
+#include <linux/proc_ns.h>
+#include <linux/ima.h>
+
+#include "ima.h"
+
+int ima_init_namespace(struct ima_namespace *ns)
+{
+	return 0;
+}
+
+int __init ima_ns_init(void)
+{
+	return ima_init_namespace(&init_ima_ns);
+}
+
+struct ima_namespace init_ima_ns = {
+};
+EXPORT_SYMBOL(init_ima_ns);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
new file mode 100644
index 000000000000..bc9a2c11d70a
--- /dev/null
+++ b/security/integrity/ima/ima_ns.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 IBM Corporation
+ * Author:
+ *  Yuqiong Sun <suny@us.ibm.com>
+ *  Stefan Berger <stefanb@linux.vnet.ibm.com>
+ */
+
+#include <linux/kref.h>
+#include <linux/slab.h>
+#include <linux/ima.h>
+#include <linux/mount.h>
+#include <linux/proc_ns.h>
+#include <linux/lsm_hooks.h>
+
+#include "ima.h"
+
+static struct kmem_cache *imans_cachep;
+
+int create_ima_ns(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns;
+	int err;
+
+	ns = kmem_cache_zalloc(imans_cachep, GFP_KERNEL);
+	if (!ns)
+		return -ENOMEM;
+	pr_debug("NEW     ima_ns: 0x%p\n", ns);
+
+	err = ima_init_namespace(ns);
+	if (err)
+		goto fail_free;
+
+	user_ns->ima_ns = ns;
+
+	return 0;
+
+fail_free:
+	kmem_cache_free(imans_cachep, ns);
+
+	return err;
+}
+
+static void destroy_ima_ns(struct ima_namespace *ns)
+{
+	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
+	kmem_cache_free(imans_cachep, ns);
+}
+
+void free_ima_ns(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns = user_ns->ima_ns;
+
+	if (WARN_ON(ns == &init_ima_ns))
+		return;
+
+	destroy_ima_ns(ns);
+}
+
+static int __init imans_cache_init(void)
+{
+	imans_cachep = KMEM_CACHE(ima_namespace, SLAB_PANIC);
+	return 0;
+}
+subsys_initcall(imans_cache_init)
-- 
2.31.1

