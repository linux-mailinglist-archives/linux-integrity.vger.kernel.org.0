Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99E7508A48
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379426AbiDTOLK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379364AbiDTOKL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AE543AE3;
        Wed, 20 Apr 2022 07:07:16 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KC1XV7024563;
        Wed, 20 Apr 2022 14:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UZPbI7+80vDlttPuKRfNCpfqlL2354lHMc5P/90wIFg=;
 b=MpZpuRUHq8fTusdBgxMopByLlFGDXyPAVaAzCbKb5dLG60aNVlzbYjEgjhD9A+zlJ4P9
 bmHXe1Zsn77nDlkzTk8TGCm0LcoXF2SNJV9aC+i0haal0plavPqrvphf6LHuuivwt9Du
 wE/1iFHOEToOu5XgGK+0XVWY/eDro2lJrTkeLhDv3ADIzXje5+1cfvrx0iPGwOn8b2Cf
 3xUY1MvVOnbnmjYZKj8iM6NTTg2hAgV5N1YhrnMj/S8eUSa4+QBfA+4IOpngp1uAdfuV
 qjn2kMezCqZ/8k5LduT81AOf4fYfNcVfv1i0mQyAZkOQw2jTMI+Ko6YgMqJ2GOt1G8M/ tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjff2wtmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:45 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KCpM7E017891;
        Wed, 20 Apr 2022 14:06:45 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjff2wtm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:45 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE3AAs025357;
        Wed, 20 Apr 2022 14:06:43 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 3ffnea4sh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:43 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6hU360162496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:43 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22A26AE060;
        Wed, 20 Apr 2022 14:06:43 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D677AE05C;
        Wed, 20 Apr 2022 14:06:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 14:06:43 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v12 16/26] ima: Add functions for creating and freeing of an ima_namespace
Date:   Wed, 20 Apr 2022 10:06:23 -0400
Message-Id: <20220420140633.753772-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bPu9qil39HwH72sJtrpI-hRTaE-odRRH
X-Proofpoint-ORIG-GUID: BcvrHPSNbrry4WNVFL6iTQJfkHs2R3uB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement create_ima_ns() to create an empty ima_namespace. Defer its
initialization to a later point outside this function. Implement
free_ima_ns() to free it.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

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
index fcb60a44e05f..76d19995ab89 100644
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
index 054b8f67be04..3e77738aec2c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -171,6 +171,7 @@ extern bool ima_canonical_fmt;
 int ima_init(void);
 int ima_fs_init(void);
 int ima_ns_init(void);
+int ima_init_namespace(struct ima_namespace *ns);
 int ima_add_template_entry(struct ima_namespace *ns,
 			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
@@ -506,4 +507,18 @@ static inline struct ima_namespace
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
index c4fe8f3e9a73..b497062090cf 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -8,7 +8,7 @@
 
 #include "ima.h"
 
-static int ima_init_namespace(struct ima_namespace *ns)
+int ima_init_namespace(struct ima_namespace *ns)
 {
 	int ret;
 
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
2.34.1

