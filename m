Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE93D49BEED
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 23:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiAYWrk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 17:47:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234205AbiAYWr1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:27 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PLfgMb031686;
        Tue, 25 Jan 2022 22:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uITBW42IUuMk1nOtRjPFqgtTB/+zDZIMPjuNWrUHhXo=;
 b=J/zBUnZy1JCYRU886ua5fwgLOg6c0j0YgsWd01mzDK0R2XW8wkUCp6jKT641jTL3h3u9
 kDOcE5Q/eKswc1uh7yCh8wkfP8a0Tu4jxzM8MhI0wHL5MJjyaYa3ZzTb2mE0aiG8tA9D
 ApUMHL5dNIhGDDJDyq5mup1M0uNZta3HTRr98XYczyUT6Xg9+C9yuIAA9+0YR5lhjWV+
 um8E3jm7hTDNTjMTZYcuXvvbbbdc+cPOr6l0FeD2TMr/25fecf5Hnkx8TYYn8h5+UGkc
 TMMOtWFEiuTmC79keVZvWOdyVjO+pqXdtq+/6bcUZ12jcRFyyEFd6D1plSaYHpjQJqm5 gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtsbch54f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:04 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMVdZ4032206;
        Tue, 25 Jan 2022 22:47:03 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtsbch53x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:03 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PMhqFK025192;
        Tue, 25 Jan 2022 22:47:02 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3dr9ja7356-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:02 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMkxS232571836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:46:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9C59AC059;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBDB6AC068;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v9 17/23] ima: Add functions for creating and freeing of an ima_namespace
Date:   Tue, 25 Jan 2022 17:46:39 -0500
Message-Id: <20220125224645.79319-18-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jhP1ID4ZZOoIJ4aqT77bMcFYxpYGf5Vv
X-Proofpoint-ORIG-GUID: BWgcqPuSKFis9qy0Eda-pPFanpxoN72V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement create_ima_ns() to create an empty ima_namespace. Defer its
initialization to a later point outside this function. Implement
free_ima_ns() to free it.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v9:
 - Set user_ns->ims_ns = NULL in free_ima_ns()
 - Refactored create_ima_ns() to defer initialization
 - Removed pr_debug functions
---
 include/linux/ima.h                      | 13 ++++++
 security/integrity/ima/Makefile          |  1 +
 security/integrity/ima/ima.h             | 15 +++++++
 security/integrity/ima/ima_init_ima_ns.c |  2 +-
 security/integrity/ima/ima_ns.c          | 53 ++++++++++++++++++++++++
 5 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_ns.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0cf2a80c8b35..964a08702573 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -220,4 +220,17 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
 	return false;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
+
+#ifdef CONFIG_IMA_NS
+
+void free_ima_ns(struct user_namespace *ns);
+
+#else
+
+static inline void free_ima_ns(struct user_namespace *user_ns)
+{
+}
+
+#endif /* CONFIG_IMA_NS */
+
 #endif /* _LINUX_IMA_H */
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index f8a5e5f3975d..b86a35fbed60 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,6 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_NS) += ima_ns.o
 
 ifeq ($(CONFIG_EFI),y)
 ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 8c757223d549..751e936a6311 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -167,6 +167,7 @@ extern bool ima_canonical_fmt;
 int ima_init(void);
 int ima_fs_init(void);
 int ima_ns_init(void);
+int ima_init_namespace(struct ima_namespace *ns);
 int ima_add_template_entry(struct ima_namespace *ns,
 			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
@@ -502,4 +503,18 @@ static inline struct ima_namespace
 	return NULL;
 }
 
+#ifdef CONFIG_IMA_NS
+
+struct ima_namespace *create_ima_ns(void);
+
+#else
+
+static inline struct ima_namespace *create_ima_ns(void)
+{
+	WARN(1, "Cannot create an IMA namespace\n");
+	return ERR_PTR(-EFAULT);
+}
+
+#endif /* CONFIG_IMA_NS */
+
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 1cba545ae477..166dab4a3126 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -8,7 +8,7 @@
 
 #include "ima.h"
 
-static int ima_init_namespace(struct ima_namespace *ns)
+int ima_init_namespace(struct ima_namespace *ns)
 {
 	int rc;
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
new file mode 100644
index 000000000000..b3b81a1e313e
--- /dev/null
+++ b/security/integrity/ima/ima_ns.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 IBM Corporation
+ * Author:
+ *  Yuqiong Sun <suny@us.ibm.com>
+ *  Stefan Berger <stefanb@linux.vnet.ibm.com>
+ */
+
+#include <linux/ima.h>
+
+#include "ima.h"
+
+static struct kmem_cache *imans_cachep;
+
+struct ima_namespace *create_ima_ns(void)
+{
+	struct ima_namespace *ns;
+
+	ns = kmem_cache_zalloc(imans_cachep, GFP_KERNEL);
+	if (!ns)
+		return ERR_PTR(-ENOMEM);
+
+	return ns;
+}
+
+/* destroy_ima_ns() must only be called after ima_init_namespace() was called */
+static void destroy_ima_ns(struct ima_namespace *ns)
+{
+	unregister_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
+	kfree(ns->arch_policy_entry);
+	ima_free_policy_rules(ns);
+}
+
+void free_ima_ns(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns = user_ns->ima_ns;
+
+	if (!ns || WARN_ON(ns == &init_ima_ns))
+		return;
+
+	destroy_ima_ns(ns);
+
+	kmem_cache_free(imans_cachep, ns);
+
+	user_ns->ima_ns = NULL;
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

