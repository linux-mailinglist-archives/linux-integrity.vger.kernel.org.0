Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89C46DE23
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 23:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbhLHWWS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 17:22:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47300 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240627AbhLHWWM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 17:22:12 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8KXah2017412;
        Wed, 8 Dec 2021 22:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xyy/62S2WuL5SQas3SuJCQFiQYhPgxAGgROqP3TXoiY=;
 b=LUaWjD8Fmg8Te1nn7NDbLTxX7fxQ3Q55cHCYReI8DKyydSonV8Axa3CHnwjTb381g3nU
 cLHm7C5jW4WvgkNlppdK7Tf0VVeQ66Gn6aptLvOaPE7vrCsR4m6o8otl3GB3vbdw2ydb
 pY7kUxyJeOStC+tnw+Zuo7H0KtgjAwS/z3XYUndCo+y7GI4K0IYXuwe+O4Dpc91OB/KW
 ATKHxA+wh2atEx97kD0Ve7bGYvo/0nb6xH30jeIJAVa53x86e7O9pazpatdxnu+DvuUP
 /v+4ukrXWq/7UbOoWIQUOQ95vZs9is0zqEQqNbel38ffeyEzSAhugx2TAG8LmEFAo/US AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu10a4yq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:27 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8MHWh5037590;
        Wed, 8 Dec 2021 22:18:26 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu10a4yq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:26 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MC6UP003558;
        Wed, 8 Dec 2021 22:18:25 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 3cqyybqh1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:25 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8MIO3p23527882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 22:18:24 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 390652805C;
        Wed,  8 Dec 2021 22:18:24 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1908F28060;
        Wed,  8 Dec 2021 22:18:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 22:18:24 +0000 (GMT)
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
Subject: [PATCH v5 05/16] ima: Move IMA's keys queue related variables into ima_namespace
Date:   Wed,  8 Dec 2021 17:18:07 -0500
Message-Id: <20211208221818.1519628-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208221818.1519628-1-stefanb@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lFffXfttmj3Ne1obf2MRAaaaMfy0V3v3
X-Proofpoint-ORIG-GUID: P3VHKaT4FVONWNJVSHZzqjNHKa6ym2pg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080121
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
index 529defe4d272..0ce58c17cb25 100644
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
index 75ef17d52b5b..144b30ceefb0 100644
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
index 000dbde2f264..1ee724bab714 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -38,6 +38,12 @@ int create_ima_ns(struct user_namespace *user_ns)
 	if (err)
 		goto fail_free;
 
+#ifdef CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS
+	ns->ima_process_keys = false;
+	mutex_init(&ns->ima_keys_lock);
+	INIT_LIST_HEAD(&ns->ima_keys);
+#endif
+
 	user_ns->ima_ns = ns;
 
 	return 0;
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index ed5923dfe71b..4c69178b1ffe 100644
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
@@ -100,7 +89,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 	return entry;
 }
 
-bool ima_queue_key(struct key *keyring, const void *payload,
+bool ima_queue_key(struct ima_namespace *ns, struct key *keyring, const void *payload,
 		   size_t payload_len)
 {
 	bool queued = false;
@@ -110,12 +99,12 @@ bool ima_queue_key(struct key *keyring, const void *payload,
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
@@ -134,7 +123,7 @@ void ima_process_queued_keys(struct ima_namespace *ns)
 	struct ima_key_entry *entry, *tmp;
 	bool process = false;
 
-	if (ima_process_keys)
+	if (ns->ima_process_keys)
 		return;
 
 	/*
@@ -143,12 +132,12 @@ void ima_process_queued_keys(struct ima_namespace *ns)
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
@@ -159,7 +148,7 @@ void ima_process_queued_keys(struct ima_namespace *ns)
 			put_user_ns(ns->user_ns);
 	}
 
-	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
+	list_for_each_entry_safe(entry, tmp, &ns->ima_keys, list) {
 		if (!ns->timer_expired)
 			process_buffer_measurement(&init_user_ns, NULL,
 						   entry->payload,
@@ -173,7 +162,7 @@ void ima_process_queued_keys(struct ima_namespace *ns)
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

