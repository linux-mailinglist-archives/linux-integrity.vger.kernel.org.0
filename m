Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF74769C8
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 06:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhLPFoF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 00:44:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233790AbhLPFn7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 00:43:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG4Usro018769;
        Thu, 16 Dec 2021 05:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QEneWk3bHEnDYO8F4fu12sOeaVroO5uULgi6kdKGJWs=;
 b=NZb0g+bAnBhl9FeOU36WTzyThad/eXMO4Af5/qXp3qZKXgv9dVTDTgdaC1dAPFIjmjtH
 bIFcpRXvV+049rJRpuOEREL/ex9WcC8F+dER566HNaaaCeKqFFOjr2lPFNBnQ5CMqExF
 NGbgFl+0eHfTamq3oB4UysVmGv07GQpBK6FomrgoFu/Ox36O4sixPgQ9yma21B6SKZDn
 6qgEWhHbQ9SvAdo1JT6chiIQ55JzMjk5q912P4yOE0Lzh2hwadcHr3Ye6xqTtU2ggDfg
 AkZaAq/Ubyb3INRY1NrmaU0NFsC/vR+WVRmDDWfBHVqYs9QUtuIS7wYPUnxg7KwwQYqf OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jm96x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:32 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG5dUwi007017;
        Thu, 16 Dec 2021 05:43:31 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jm96n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:31 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG5fuMK032263;
        Thu, 16 Dec 2021 05:43:30 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3cy7hf9bpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:30 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG5hTFe20119902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 05:43:29 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 001C66E054;
        Thu, 16 Dec 2021 05:43:29 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4EA76E050;
        Thu, 16 Dec 2021 05:43:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 05:43:27 +0000 (GMT)
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
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 02/14] ima: Define ns_status for storing namespaced iint data
Date:   Thu, 16 Dec 2021 00:43:11 -0500
Message-Id: <20211216054323.1707384-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NCQDWA-cjUn2wVcWvf5Be2GHlQJHa-hx
X-Proofpoint-GUID: Nr6R8RdlwqgiJkxcIK_c7v0jdcBVd0IP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160033
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

This patch adds an rbtree to the IMA namespace structure that stores a
namespaced version of iint->flags in ns_status struct. Similar to the
integrity_iint_cache, both the iint ns_struct are looked up using the
inode pointer value. The lookup, allocate, and insertion code is also
similar, except ns_struct is not free'd when the inode is free'd.
Instead, the lookup verifies the i_ino and i_generation fields are also a
match.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Changelog:
v2:
 * fixed tree traversal in __ima_ns_status_find()
---
 security/integrity/ima/Makefile          |   1 +
 security/integrity/ima/ima.h             |  28 +++++
 security/integrity/ima/ima_init_ima_ns.c |   6 ++
 security/integrity/ima/ima_ns.c          |   1 +
 security/integrity/ima/ima_ns_status.c   | 127 +++++++++++++++++++++++
 5 files changed, 163 insertions(+)
 create mode 100644 security/integrity/ima/ima_ns_status.c

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b86a35fbed60..78c84214e109 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -10,6 +10,7 @@ ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 	 ima_policy.o ima_template.o ima_template_lib.o ima_init_ima_ns.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
+ima-$(CONFIG_IMA_NS) += ima_ns.o ima_ns_status.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4606d3b1493f..cd73e4092037 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -121,6 +121,10 @@ struct ima_kexec_hdr {
 
 struct ima_namespace {
 	int avoid_zero_size;
+
+	struct rb_root ns_status_tree;
+	rwlock_t ns_status_lock;
+	struct kmem_cache *ns_status_cache;
 } __randomize_layout;
 
 extern const int read_idmap[];
@@ -137,6 +141,14 @@ static inline void ima_load_kexec_buffer(void) {}
  */
 extern bool ima_canonical_fmt;
 
+struct ns_status {
+	struct rb_node rb_node;
+	struct inode *inode;
+	ino_t i_ino;
+	u32 i_generation;
+	unsigned long flags;
+};
+
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
@@ -426,6 +438,22 @@ int ima_ns_init(void);
 struct ima_namespace;
 int ima_init_namespace(struct ima_namespace *ns);
 
+#ifdef CONFIG_IMA_NS
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode);
+
+void free_ns_status_cache(struct ima_namespace *ns);
+
+#else
+
+static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+						  struct inode *inode)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_IMA_NS */
+
 /* LSM based policy rules require audit */
 #ifdef CONFIG_IMA_LSM_RULES
 
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 46d8cb2113a1..446beea36cd3 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -10,11 +10,17 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/ima.h>
+#include <linux/slab.h>
 
 #include "ima.h"
 
 int ima_init_namespace(struct ima_namespace *ns)
 {
+	ns->ns_status_tree = RB_ROOT;
+	rwlock_init(&ns->ns_status_lock);
+	/* Use KMEM_CACHE for simplicity ? */
+	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
+
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index bc9a2c11d70a..92f9424ba1b0 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -44,6 +44,7 @@ int create_ima_ns(struct user_namespace *user_ns)
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
 	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
+	free_ns_status_cache(ns);
 	kmem_cache_free(imans_cachep, ns);
 }
 
diff --git a/security/integrity/ima/ima_ns_status.c b/security/integrity/ima/ima_ns_status.c
new file mode 100644
index 000000000000..f5b183b62894
--- /dev/null
+++ b/security/integrity/ima/ima_ns_status.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 IBM Corporation
+ * Author:
+ *  Yuqiong Sun <suny@us.ibm.com>
+ *  Stefan Berger <stefanb@linux.vnet.ibm.com>
+ */
+
+#include <linux/user_namespace.h>
+#include <linux/proc_ns.h>
+
+#include "ima.h"
+
+void free_ns_status_cache(struct ima_namespace *ns)
+{
+	struct ns_status *status, *next;
+
+	write_lock(&ns->ns_status_lock);
+	rbtree_postorder_for_each_entry_safe(status, next,
+					     &ns->ns_status_tree, rb_node)
+		kmem_cache_free(ns->ns_status_cache, status);
+	ns->ns_status_tree = RB_ROOT;
+	write_unlock(&ns->ns_status_lock);
+	kmem_cache_destroy(ns->ns_status_cache);
+}
+
+/*
+ * __ima_ns_status_find - return the ns_status associated with an inode
+ */
+static struct ns_status *__ima_ns_status_find(struct ima_namespace *ns,
+					      struct inode *inode)
+{
+	struct ns_status *status;
+	struct rb_node *n = ns->ns_status_tree.rb_node;
+
+	while (n) {
+		status = rb_entry(n, struct ns_status, rb_node);
+
+		if (inode < status->inode)
+			n = n->rb_left;
+		else if (inode > status->inode)
+			n = n->rb_right;
+		else
+			break;
+	}
+	if (!n)
+		return NULL;
+
+	return status;
+}
+
+/*
+ * ima_ns_status_find - return the ns_status associated with an inode
+ */
+static struct ns_status *ima_ns_status_find(struct ima_namespace *ns,
+					    struct inode *inode)
+{
+	struct ns_status *status;
+
+	read_lock(&ns->ns_status_lock);
+	status = __ima_ns_status_find(ns, inode);
+	read_unlock(&ns->ns_status_lock);
+
+	return status;
+}
+
+static void insert_ns_status(struct ima_namespace *ns, struct inode *inode,
+			     struct ns_status *status)
+{
+	struct rb_node **p;
+	struct rb_node *node, *parent = NULL;
+	struct ns_status *test_status;
+
+	p = &ns->ns_status_tree.rb_node;
+	while (*p) {
+		parent = *p;
+		test_status = rb_entry(parent, struct ns_status, rb_node);
+		if (inode < test_status->inode)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	node = &status->rb_node;
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, &ns->ns_status_tree);
+}
+
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode)
+{
+	struct ns_status *status;
+	int skip_insert = 0;
+
+	status = ima_ns_status_find(ns, inode);
+	if (status) {
+		/*
+		 * Unlike integrity_iint_cache we are not free'ing the
+		 * ns_status data when the inode is free'd. So, in addition to
+		 * checking the inode pointer, we need to make sure the
+		 * (i_generation, i_ino) pair matches as well.
+		 */
+		if (inode->i_ino == status->i_ino &&
+		    inode->i_generation == status->i_generation)
+			return status;
+
+		/* Same inode number is reused, overwrite the ns_status */
+		skip_insert = 1;
+	} else {
+		status = kmem_cache_alloc(ns->ns_status_cache, GFP_NOFS);
+		if (!status)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	write_lock(&ns->ns_status_lock);
+
+	if (!skip_insert)
+		insert_ns_status(ns, inode, status);
+
+	status->inode = inode;
+	status->i_ino = inode->i_ino;
+	status->i_generation = inode->i_generation;
+	status->flags = 0UL;
+
+	write_unlock(&ns->ns_status_lock);
+
+	return status;
+}
-- 
2.31.1

