Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68D48466F
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiADRFF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235656AbiADRE6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204F6Q2T018196;
        Tue, 4 Jan 2022 17:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3pzCTgNwIiQpmMK6BwIgsCv4/OvRwAObMwcDcO7Pgso=;
 b=pCIBsAwJv0LN4+bDAhwg/JatJe4AmyT79AnhoZTwuHoDHWruIa7ONX65D1LU5CYXF6PL
 fePmtSY+8G4/PkKHqW3wpfhrh45umN71NSj8nMkXsPy0pZXhlic6IOCLfFkqYfAs+miO
 qloFeDFXgz0yrQSdSAa0HIUl7bm/YAncSWbiMKTATUKI+wNVZ5aW9ZU982n7MxAjLyzC
 qhOx6nPB059Qnghnri5j0uSVw56r5URPhcFMho2NHpzIpBCKRjETGXusxX/Wf1E0sXeP
 OojSoXiBdtrpdHfC+gapCuUmXZp1rWKJbnmoPA1Tx3FRyaFAR0qSYZB8okkWMQ2KRWV6 Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcp4swedx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:32 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204Gx7X5030296;
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcp4swedh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:31 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H2e4C019360;
        Tue, 4 Jan 2022 17:04:30 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3daekbaexh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:30 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4ToD30540248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48B57AC05B;
        Tue,  4 Jan 2022 17:04:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BCF2AC064;
        Tue,  4 Jan 2022 17:04:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:29 +0000 (GMT)
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
Subject: [PATCH v8 02/19] ima: Define ima_namespace structure and implement basic functions
Date:   Tue,  4 Jan 2022 12:03:59 -0500
Message-Id: <20220104170416.1923685-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZvdG91Pyy4iyWu44vyZesZy9jX_uDp8Z
X-Proofpoint-GUID: 6nlEFXCLT8c0NzCU92XsP3HFryZD-NfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Define the initial ima_namespace structure and the ima_namespace
variable init_ima_ns for the host's IMA namespace. Implement basic
functions for namespacing support.

For now let get_current_ns() always returns a pointer to init_ima_ns.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/Makefile          |  2 +-
 security/integrity/ima/ima.h             | 10 ++++++++++
 security/integrity/ima/ima_init.c        |  4 ++++
 security/integrity/ima/ima_init_ima_ns.c | 23 +++++++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 2499f2485c04..f8a5e5f3975d 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -7,7 +7,7 @@
 obj-$(CONFIG_IMA) += ima.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_init_ima_ns.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..c4af3275f015 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -119,6 +119,10 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+struct ima_namespace {
+} __randomize_layout;
+extern struct ima_namespace init_ima_ns;
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
@@ -136,6 +140,7 @@ extern bool ima_canonical_fmt;
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
+int ima_ns_init(void);
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename);
@@ -450,4 +455,9 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #define	POLICY_FILE_FLAGS	S_IWUSR
 #endif /* CONFIG_IMA_READ_POLICY */
 
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return &init_ima_ns;
+}
+
 #endif /* __LINUX_IMA_H */
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
index 000000000000..daa609892849
--- /dev/null
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 IBM Corporation
+ * Author:
+ *   Yuqiong Sun <suny@us.ibm.com>
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ */
+
+#include "ima.h"
+
+static int ima_init_namespace(struct ima_namespace *ns)
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
-- 
2.31.1

