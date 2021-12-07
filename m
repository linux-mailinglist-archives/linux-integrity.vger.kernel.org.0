Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD3046C463
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 21:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbhLGUZw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 15:25:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241258AbhLGUZq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 15:25:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7JkVBD010942;
        Tue, 7 Dec 2021 20:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FA5hc9mFxUCdIswCdoqkb9HaFkBCiBkRjsGgHw1Z1sI=;
 b=o3B1NJ7A6G2uzAe5v5aUW752iT3X0VssbCrzWhlIZXhKMCP/hA5HqUyavP9tU1fwv5a4
 TJ/vtPAw16RqBi6lV4rhZwISJzO8QSnu6F3kgO4R38kNrK3AeY1LXYJXhAaNmJ9EPV4V
 na1kupcV2QoYkAnQR7Wc2k5Qm3aTsgDAjWkKVF04saMPtrgaByVdIU6dWmTSlramjtkr
 G4GbpdH2VMRTT+GHeQFriWaNAaXjrbwBHxaOaIsI3VVQjoJewL/JhZd5dKl1OOGg/QiU
 3OymkV1FN8+/8VXxrZnLOIhiO5/yBrAUOBaN6rx52Rn1YAY676/8VC8z6a5yyfaC2efI Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctcavu0tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:05 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7KM05T031366;
        Tue, 7 Dec 2021 20:22:05 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctcavu0tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:05 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7K79iC028339;
        Tue, 7 Dec 2021 20:22:04 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3cqyyb2df2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:03 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7KM2xf49742130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 20:22:02 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69E8F136055;
        Tue,  7 Dec 2021 20:22:02 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C32EF136051;
        Tue,  7 Dec 2021 20:21:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 20:21:59 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 04/16] ima: Move delayed work queue and variables into ima_namespace
Date:   Tue,  7 Dec 2021 15:21:15 -0500
Message-Id: <20211207202127.1508689-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211207202127.1508689-1-stefanb@linux.ibm.com>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0cYP4XU71MBVCSYPsGIjaS-sbVhwg61C
X-Proofpoint-ORIG-GUID: J0hGmed_kRKTA_wR3APEn4E3SRloX_1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_08,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the delayed work queue and associated variables to the
ima_namespace and initialize them.

Since keys queued up for measurement currently are only relevant in the
init_ima_ns, call ima_init_key_queue() only when the init_ima_ns is
initialized.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                      | 11 ++++++++
 security/integrity/ima/ima.h             | 12 +++++----
 security/integrity/ima/ima_fs.c          |  4 ++-
 security/integrity/ima/ima_init.c        |  2 --
 security/integrity/ima/ima_init_ima_ns.c |  8 ++++++
 security/integrity/ima/ima_policy.c      |  4 +--
 security/integrity/ima/ima_queue_keys.c  | 34 ++++++++++--------------
 7 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index cc0e8c509fa2..4b5dada581e4 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -217,6 +217,17 @@ struct ima_namespace {
 	struct rb_root ns_status_tree;
 	rwlock_t ns_status_lock;
 	struct kmem_cache *ns_status_cache;
+
+#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+	/*
+	 * If custom IMA policy is not loaded then keys queued up
+	 * for measurement should be freed. This worker is used
+	 * for handling this scenario.
+	 */
+	struct delayed_work ima_keys_delayed_work;
+	long ima_key_queue_timeout;
+	bool timer_expired;
+#endif
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index dd06e16c4e1c..9edab9050dc7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -77,6 +77,8 @@ struct ima_field_data {
 	u32 len;
 };
 
+struct ima_namespace;
+
 /* IMA template field definition */
 struct ima_template_field {
 	const char field_id[IMA_TEMPLATE_FIELD_ID_MAX_LEN];
@@ -247,18 +249,18 @@ struct ima_key_entry {
 	size_t payload_len;
 	char *keyring_name;
 };
-void ima_init_key_queue(void);
+void ima_init_key_queue(struct ima_namespace *ns);
 bool ima_should_queue_key(void);
 bool ima_queue_key(struct key *keyring, const void *payload,
 		   size_t payload_len);
-void ima_process_queued_keys(void);
+void ima_process_queued_keys(struct ima_namespace *ns);
+void ima_keys_handler(struct work_struct *work);
 #else
-static inline void ima_init_key_queue(void) {}
 static inline bool ima_should_queue_key(void) { return false; }
 static inline bool ima_queue_key(struct key *keyring,
 				 const void *payload,
 				 size_t payload_len) { return false; }
-static inline void ima_process_queued_keys(void) {}
+static inline void ima_process_queued_keys(struct ima_namespace *ns) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
@@ -300,7 +302,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos);
 void ima_init_policy(void);
-void ima_update_policy(void);
+void ima_update_policy(struct ima_namespace *ns);
 void ima_update_policy_flags(void);
 ssize_t ima_parse_add_rule(char *);
 void ima_delete_rules(void);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3d8e9d5db5aa..5cff3d6c3dc7 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/ima.h>
 
 #include "ima.h"
 
@@ -410,6 +411,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
 	const char *cause = valid_policy ? "completed" : "failed";
+	struct ima_namespace *ns = get_current_ns();
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
@@ -430,7 +432,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 		return 0;
 	}
 
-	ima_update_policy();
+	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index f6ae4557a0da..24848373a061 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -155,8 +155,6 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
-	ima_init_key_queue();
-
 	ima_measure_critical_data("kernel_info", "kernel_version",
 				  UTS_RELEASE, strlen(UTS_RELEASE), false,
 				  NULL, 0);
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 1a44963e8ba9..3bc2d3611739 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -26,6 +26,14 @@ int ima_init_namespace(struct ima_namespace *ns)
 	if (!ns->ns_status_cache)
 		return -ENOMEM;
 
+#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+	INIT_DELAYED_WORK(&ns->ima_keys_delayed_work, ima_keys_handler);
+	ns->ima_key_queue_timeout = 300000;
+	ns->timer_expired = false;
+	if (ns == &init_ima_ns)
+		ima_init_key_queue(ns);
+#endif
+
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 320ca80aacab..e5aef287d14d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -986,7 +986,7 @@ int ima_check_policy(void)
  * Policy rules are never deleted so ima_policy_flag gets zeroed only once when
  * we switch from the default policy to user defined.
  */
-void ima_update_policy(void)
+void ima_update_policy(struct ima_namespace *ns)
 {
 	struct list_head *policy = &ima_policy_rules;
 
@@ -1007,7 +1007,7 @@ void ima_update_policy(void)
 	ima_update_policy_flags();
 
 	/* Custom IMA policy has been loaded */
-	ima_process_queued_keys();
+	ima_process_queued_keys(ns);
 }
 
 /* Keep the enumeration in sync with the policy_tokens! */
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 93056c03bf5a..fcaa1645dba3 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -10,6 +10,7 @@
 
 #include <linux/user_namespace.h>
 #include <linux/workqueue.h>
+#include <linux/ima.h>
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
@@ -25,34 +26,27 @@ static bool ima_process_keys;
 static DEFINE_MUTEX(ima_keys_lock);
 static LIST_HEAD(ima_keys);
 
-/*
- * If custom IMA policy is not loaded then keys queued up
- * for measurement should be freed. This worker is used
- * for handling this scenario.
- */
-static long ima_key_queue_timeout = 300000; /* 5 Minutes */
-static void ima_keys_handler(struct work_struct *work);
-static DECLARE_DELAYED_WORK(ima_keys_delayed_work, ima_keys_handler);
-static bool timer_expired;
-
 /*
  * This worker function frees keys that may still be
  * queued up in case custom IMA policy was not loaded.
  */
-static void ima_keys_handler(struct work_struct *work)
+void ima_keys_handler(struct work_struct *work)
 {
-	timer_expired = true;
-	ima_process_queued_keys();
+	struct ima_namespace *ns;
+
+	ns = container_of(work, struct ima_namespace, ima_keys_delayed_work.work);
+	ns->timer_expired = true;
+	ima_process_queued_keys(ns);
 }
 
 /*
  * This function sets up a worker to free queued keys in case
  * custom IMA policy was never loaded.
  */
-void ima_init_key_queue(void)
+void ima_init_key_queue(struct ima_namespace *ns)
 {
-	schedule_delayed_work(&ima_keys_delayed_work,
-			      msecs_to_jiffies(ima_key_queue_timeout));
+	schedule_delayed_work(&ns->ima_keys_delayed_work,
+			      msecs_to_jiffies(ns->ima_key_queue_timeout));
 }
 
 static void ima_free_key_entry(struct ima_key_entry *entry)
@@ -130,7 +124,7 @@ bool ima_queue_key(struct key *keyring, const void *payload,
  * This function sets ima_process_keys to true and processes queued keys.
  * From here on keys will be processed right away (not queued).
  */
-void ima_process_queued_keys(void)
+void ima_process_queued_keys(struct ima_namespace *ns)
 {
 	struct ima_key_entry *entry, *tmp;
 	bool process = false;
@@ -154,11 +148,11 @@ void ima_process_queued_keys(void)
 	if (!process)
 		return;
 
-	if (!timer_expired)
-		cancel_delayed_work_sync(&ima_keys_delayed_work);
+	if (!ns->timer_expired)
+		cancel_delayed_work_sync(&ns->ima_keys_delayed_work);
 
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
-		if (!timer_expired)
+		if (!ns->timer_expired)
 			process_buffer_measurement(&init_user_ns, NULL,
 						   entry->payload,
 						   entry->payload_len,
-- 
2.31.1

