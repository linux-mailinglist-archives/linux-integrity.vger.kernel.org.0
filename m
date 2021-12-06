Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A67746A2E1
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 18:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbhLFRaD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 12:30:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240064AbhLFR3z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 12:29:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6GMhb8026877;
        Mon, 6 Dec 2021 17:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kam4NmZjtyntuJGkgmwzdj/JA5LKy1TUmOTyLXzHXhc=;
 b=jsF8h8M8YBjIpogdlSNhUOn10qV0Yhhhz0QkzL2RJcDBdHFbkLAcBr9WBqOUrLRhLvEK
 gqbRPLNxeFuJn8BLQVPwE+k9xuDin6D+cBgym7icWnXwccx+8pr3TFg0rqDB3VtOr/s/
 icXZLUpbMWlsQGS7qrp142CVdY/ctKrMTW0ojD4WTC9msfHZVciMvLu9M23kZEw+9jhU
 ULMwc56NKhLmM40Wl3QK8swyZ5UX38Dl5mJaOzaL8hXyhQkwydelqMBAFvrT63ZX6PnY
 5JjWxVCkMSGWJSgh8fdy9QiixH5twAqtfDm91bbEjwRw1HDyDzc3RejJ1bult4T5csRU sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csp03h8pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:11 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6GMgpq026781;
        Mon, 6 Dec 2021 17:26:11 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csp03h8pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:11 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HD6BH000540;
        Mon, 6 Dec 2021 17:26:10 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3cqyya2mxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:09 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6HQ8cT19792610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 17:26:08 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8EF328058;
        Mon,  6 Dec 2021 17:26:07 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D437D28064;
        Mon,  6 Dec 2021 17:26:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 17:26:07 +0000 (GMT)
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
Subject: [PATCH v3 05/16] ima: Move IMA's keys queue related variables into ima_namespace
Date:   Mon,  6 Dec 2021 12:25:49 -0500
Message-Id: <20211206172600.1495968-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206172600.1495968-1-stefanb@linux.ibm.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qZeUKMyZOoSfpno9iRtm3llZarvUViE-
X-Proofpoint-ORIG-GUID: -07m1WNsPd2y5PEC-19jgiEqYakiM1pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move variables from keys queue into ima_namespace.

Some variables have to be initialized before ima_init() runs, so statically
initialize them for the init_ima_ns.

Since only init_ima_ns uses the queued keys there's no need to free the
list of queued keys when tearing down IMA namespaces.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                          | 11 ++++++
 security/integrity/ima/ima.h                 |  9 ++---
 security/integrity/ima/ima_asymmetric_keys.c |  5 +--
 security/integrity/ima/ima_init_ima_ns.c     |  5 +++
 security/integrity/ima/ima_ns.c              |  6 ++++
 security/integrity/ima/ima_queue_keys.c      | 37 +++++++-------------
 6 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 4b5dada581e4..977df9155cde 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -219,6 +219,17 @@ struct ima_namespace {
 	struct kmem_cache *ns_status_cache;
 
 #ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+	/*
+	 * Flag to indicate whether a key can be processed
+	 * right away or should be queued for processing later.
+	 */
+	bool ima_process_keys;
+
+	/*
+	 * To synchronize access to the list of keys that need to be measured
+	 */
+	struct mutex ima_keys_lock;
+	struct list_head ima_keys;
 	/*
 	 * If custom IMA policy is not loaded then keys queued up
 	 * for measurement should be freed. This worker is used
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 9edab9050dc7..97eb03376855 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -250,14 +250,15 @@ struct ima_key_entry {
 	char *keyring_name;
 };
 void ima_init_key_queue(struct ima_namespace *ns);
-bool ima_should_queue_key(void);
-bool ima_queue_key(struct key *keyring, const void *payload,
+bool ima_should_queue_key(struct ima_namespace *ns);
+bool ima_queue_key(struct ima_namespace *ns, struct key *keyring, const void *payload,
 		   size_t payload_len);
 void ima_process_queued_keys(struct ima_namespace *ns);
 void ima_keys_handler(struct work_struct *work);
 #else
-static inline bool ima_should_queue_key(void) { return false; }
-static inline bool ima_queue_key(struct key *keyring,
+static inline bool ima_should_queue_key(struct ima_namespace *ns) { return false; }
+static inline bool ima_queue_key(struct ima_namespace *ns,
+				 struct key *keyring,
 				 const void *payload,
 				 size_t payload_len) { return false; }
 static inline void ima_process_queued_keys(struct ima_namespace *ns) {}
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index f6aa0b47a772..b20e82eda8f4 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -30,6 +30,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
+	struct ima_namespace *ns = get_current_ns();
 	bool queued = false;
 
 	/* Only asymmetric keys are handled by this hook. */
@@ -39,8 +40,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	if (!payload || (payload_len == 0))
 		return;
 
-	if (ima_should_queue_key())
-		queued = ima_queue_key(keyring, payload, payload_len);
+	if (ima_should_queue_key(ns))
+		queued = ima_queue_key(ns, keyring, payload, payload_len);
 
 	if (queued)
 		return;
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 3bc2d3611739..7b66fe598789 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -45,5 +45,10 @@ int __init ima_ns_init(void)
 struct ima_namespace init_ima_ns = {
 	.kref = KREF_INIT(1),
 	.user_ns = &init_user_ns,
+#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+	.ima_process_keys = false,
+	.ima_keys_lock = __MUTEX_INITIALIZER(init_ima_ns.ima_keys_lock),
+	.ima_keys = LIST_HEAD_INIT(init_ima_ns.ima_keys),
+#endif
 };
 EXPORT_SYMBOL(init_ima_ns);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 1fe1d910996b..11e0343f1f55 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -38,6 +38,12 @@ static struct ima_namespace *create_ima_ns(struct user_namespace *user_ns)
 	if (err)
 		goto fail_free;
 
+#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+	ns->ima_process_keys = false;
+	mutex_init(&ns->ima_keys_lock);
+	INIT_LIST_HEAD(&ns->ima_keys);
+#endif
+
 	return ns;
 
 fail_free:
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index fcaa1645dba3..9e5e9a178253 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -14,17 +14,6 @@
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
-/*
- * Flag to indicate whether a key can be processed
- * right away or should be queued for processing later.
- */
-static bool ima_process_keys;
-
-/*
- * To synchronize access to the list of keys that need to be measured
- */
-static DEFINE_MUTEX(ima_keys_lock);
-static LIST_HEAD(ima_keys);
 
 /*
  * This worker function frees keys that may still be
@@ -95,7 +84,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 	return entry;
 }
 
-bool ima_queue_key(struct key *keyring, const void *payload,
+bool ima_queue_key(struct ima_namespace *ns, struct key *keyring, const void *payload,
 		   size_t payload_len)
 {
 	bool queued = false;
@@ -105,12 +94,12 @@ bool ima_queue_key(struct key *keyring, const void *payload,
 	if (!entry)
 		return false;
 
-	mutex_lock(&ima_keys_lock);
-	if (!ima_process_keys) {
-		list_add_tail(&entry->list, &ima_keys);
+	mutex_lock(&ns->ima_keys_lock);
+	if (!ns->ima_process_keys) {
+		list_add_tail(&entry->list, &ns->ima_keys);
 		queued = true;
 	}
-	mutex_unlock(&ima_keys_lock);
+	mutex_unlock(&ns->ima_keys_lock);
 
 	if (!queued)
 		ima_free_key_entry(entry);
@@ -129,7 +118,7 @@ void ima_process_queued_keys(struct ima_namespace *ns)
 	struct ima_key_entry *entry, *tmp;
 	bool process = false;
 
-	if (ima_process_keys)
+	if (ns->ima_process_keys)
 		return;
 
 	/*
@@ -138,12 +127,12 @@ void ima_process_queued_keys(struct ima_namespace *ns)
 	 * First one setting the ima_process_keys flag to true will
 	 * process the queued keys.
 	 */
-	mutex_lock(&ima_keys_lock);
-	if (!ima_process_keys) {
-		ima_process_keys = true;
+	mutex_lock(&ns->ima_keys_lock);
+	if (!ns->ima_process_keys) {
+		ns->ima_process_keys = true;
 		process = true;
 	}
-	mutex_unlock(&ima_keys_lock);
+	mutex_unlock(&ns->ima_keys_lock);
 
 	if (!process)
 		return;
@@ -151,7 +140,7 @@ void ima_process_queued_keys(struct ima_namespace *ns)
 	if (!ns->timer_expired)
 		cancel_delayed_work_sync(&ns->ima_keys_delayed_work);
 
-	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
+	list_for_each_entry_safe(entry, tmp, &ns->ima_keys, list) {
 		if (!ns->timer_expired)
 			process_buffer_measurement(&init_user_ns, NULL,
 						   entry->payload,
@@ -165,7 +154,7 @@ void ima_process_queued_keys(struct ima_namespace *ns)
 	}
 }
 
-inline bool ima_should_queue_key(void)
+inline bool ima_should_queue_key(struct ima_namespace *ns)
 {
-	return !ima_process_keys;
+	return !ns->ima_process_keys;
 }
-- 
2.31.1

