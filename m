Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28D48467E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiADRFN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235676AbiADRFB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:05:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204FL05h019368;
        Tue, 4 Jan 2022 17:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dtafhJUsjjgqLVwA4cmyaSC+XeR+hYgZMipnIP8YNo4=;
 b=GrsS/sj5Ehr72lEE7FZPkB0YNa1e2aTCoeLf77Vns9bmug30g62JJ3kwWFBIPkhbmusi
 RibKO0aTzQfkQMxoJRnVsxrpc0o28Q4Gz31ftlrRn77nOocT3nogPbfqZl7vChZoh32/
 HwriEIAbDaOH31EI4RHLWnoWexP6lSZUZDbKy47s52eeEbMyR6NT/m4Sf4ZBnv29tzMx
 CVgPW/BTFrRpaGN4aTphYrkXYdmDko2NyEQc157LY2Wt9RaqzFlb4i37I317Dz073c0P
 qSIJsMhGS1TWA//un28dF40flN9+Ue0hg6PwBtAojxPlDpuvpp47J4MLfMDLy/6096ue YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dch82k32j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204H0VDu006919;
        Tue, 4 Jan 2022 17:04:33 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dch82k325-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H2jmR031194;
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3daekaf3mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4USX35717432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B943AC059;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 897BBAC064;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
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
Subject: [PATCH v8 13/19] ima: Add functions for creation and freeing of an ima_namespace
Date:   Tue,  4 Jan 2022 12:04:10 -0500
Message-Id: <20220104170416.1923685-14-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X6YixlZhxST5Xa7nT_nJvGlryUO5S-_9
X-Proofpoint-GUID: Y-hR78WR2Ux_0vlQR06OJ-oXLmu5ISjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement create_ima_ns() to create and initialize an ima_namespace
and implement free_ima_ns() to free it.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                      | 13 +++++
 security/integrity/ima/Makefile          |  1 +
 security/integrity/ima/ima.h             | 16 +++++++
 security/integrity/ima/ima_init_ima_ns.c |  2 +-
 security/integrity/ima/ima_ns.c          | 61 ++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_ns.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index e1d65162d1fb..06c88cb17b21 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -226,4 +226,17 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
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
index f63c6f22b853..4255301e5b96 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -163,6 +163,7 @@ extern bool ima_canonical_fmt;
 int ima_init(void);
 int ima_fs_init(void);
 int ima_ns_init(void);
+int ima_init_namespace(struct ima_namespace *ns);
 int ima_add_template_entry(struct ima_namespace *ns,
 			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
@@ -503,4 +504,19 @@ static inline struct ima_namespace *get_current_ns(void)
 	return &init_ima_ns;
 }
 
+#ifdef CONFIG_IMA_NS
+
+struct ima_namespace *create_ima_ns(struct user_namespace *user_ns);
+
+#else
+
+static inline struct ima_namespace *
+create_ima_ns(struct user_namespace *user_ns)
+{
+	WARN(1, "Cannot create an IMA namespace\n");
+	return ERR_PTR(-EFAULT);
+}
+
+#endif /* CONFIG_IMA_NS */
+
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 68671f976756..6eac998781c3 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -8,7 +8,7 @@
 
 #include "ima.h"
 
-static int ima_init_namespace(struct ima_namespace *ns)
+int ima_init_namespace(struct ima_namespace *ns)
 {
 	INIT_LIST_HEAD(&ns->ima_default_rules);
 	INIT_LIST_HEAD(&ns->ima_policy_rules);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
new file mode 100644
index 000000000000..675466d292e8
--- /dev/null
+++ b/security/integrity/ima/ima_ns.c
@@ -0,0 +1,61 @@
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
+struct ima_namespace *create_ima_ns(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns;
+	int err;
+
+	ns = kmem_cache_zalloc(imans_cachep, GFP_KERNEL);
+	if (!ns)
+		return ERR_PTR(-ENOMEM);
+	pr_debug("NEW     ima_ns: %p\n", ns);
+
+	err = ima_init_namespace(ns);
+	if (err)
+		goto fail_free;
+
+	user_ns->ima_ns = ns;
+
+	return ns;
+
+fail_free:
+	kmem_cache_free(imans_cachep, ns);
+
+	return ERR_PTR(err);
+}
+
+static void destroy_ima_ns(struct ima_namespace *ns)
+{
+	pr_debug("DESTROY ima_ns: %p\n", ns);
+	ima_free_policy_rules(ns);
+	kmem_cache_free(imans_cachep, ns);
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

