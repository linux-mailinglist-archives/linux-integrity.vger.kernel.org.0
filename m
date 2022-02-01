Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381B34A65D4
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiBAUiL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239503AbiBAUiK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211JvABG023093;
        Tue, 1 Feb 2022 20:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z80/W21Ihg4AUC+YtudwoMjbM394bXruob1gf5dd54s=;
 b=oL+WyHGWoD+lr8YMoqtusA0P5ab1haWoqNcLhf8wxDfmchfpmP2smTVXRCsXOVqAXyk5
 XMX7bqreT9JHxlbo5caVKFu/6S+GFlWSqLwg9OAQBEuXwhOrxQTo4v305UOcMACTb0kf
 JJbi14afJdO8Lb60+KvcfNCj68QVTp2OwhITNd7ErTJ1N/gC81WBHGhOSDzkLiptNnO8
 upt3Bngc5tUPN2BF/w29d5CVWX2XiJ3xMv4w81qofkCzWWYY3a4HKh0sGbewhAQO5+SF
 F1kFvH3CqUz9nWWCg+9uqYrNOHp24jKEOPR/YjRFIqAE/D10Ka4FvQvAnsxI7pu3iTNN uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxvkkarut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:55 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KLdeu001711;
        Tue, 1 Feb 2022 20:37:55 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxvkkarud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KWPlc004997;
        Tue, 1 Feb 2022 20:37:53 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3dvw7b14hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:53 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Kbq3g35389864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13B77B2066;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2AC1B2071;
        Tue,  1 Feb 2022 20:37:51 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:51 +0000 (GMT)
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
Subject: [PATCH v10 21/27] ima: Remove unused iints from the integrity_iint_cache
Date:   Tue,  1 Feb 2022 15:37:29 -0500
Message-Id: <20220201203735.164593-22-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: szlSbu6nzVRIXlfBcLAfwqLFg_d9zHJG
X-Proofpoint-ORIG-GUID: XvFdHlI9PqZB-NoBqAFKCa2YfmUiH1RT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When the rbtree of an IMA namespace is torn down, also remove those iints
that are completely unused since only the torn-down namespace stored data
about the associated inode in it.

An iint is unused when the following two conditions are met:

- Its ns_status list is empty which means that no IMA namespace
  currently has auditing related state stored in it.

- The iint's flags don't contain any of the flags IMA_MEASURE,
  IMA_APPRAISE or IMA_HASH that the host would still store there.
  It doesn't need an ns_status list for these but also only for
  IMA_AUDIT.

Introduce the #define IMA_IINT_FLAGS that represent the mask to test the
iint->flags with in this case. This test provides the reason to keep the
iint if any of these flags are set.

The IMA_IINT_FLAGS mask will loose its flags as more flags are namespaced
and can then be removed in the end and only the check for the empty list
will remain.

Process the list of garbage-collected ns_status outside the locking of
the ns_status tree and related lock-group and free any iint that was
previously found to be unused while walking the list. File accesses, that
may have happened in the meantime, could have re-activated the iint and
therefore pass along the test function to check whether the iint is still
unused.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/iint.c              |  4 +++
 security/integrity/ima/ima.h           |  2 ++
 security/integrity/ima/ima_ns_status.c | 43 +++++++++++++++++++++++++-
 security/integrity/integrity.h         |  1 +
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 4580df0e716e..b0996bd0ee67 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -158,6 +158,10 @@ void integrity_inode_free(struct inode *inode, iint_removable_cb check)
 	write_lock(&integrity_iint_lock);
 
 	iint = __integrity_iint_find(inode);
+	if (!iint) {
+		write_unlock(&integrity_iint_lock);
+		return;
+	}
 
 	if (check)
 		freeit = check(iint);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 883aeb30590f..ec0b81c7dbf5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -497,6 +497,8 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #define IMA_NS_STATUS_ACTIONS   IMA_AUDIT
 #define IMA_NS_STATUS_FLAGS     (IMA_AUDIT | IMA_AUDITED)
 
+#define IMA_IINT_FLAGS		(IMA_MEASURE | IMA_APPRAISE | IMA_HASH)
+
 static inline unsigned long iint_flags(struct integrity_iint_cache *iint,
 				       struct ns_status *ns_status)
 {
diff --git a/security/integrity/ima/ima_ns_status.c b/security/integrity/ima/ima_ns_status.c
index 9c753caad6ac..d1ccae2c2313 100644
--- a/security/integrity/ima/ima_ns_status.c
+++ b/security/integrity/ima/ima_ns_status.c
@@ -131,6 +131,26 @@ static void ns_status_free(struct ima_namespace *ns,
 	kmem_cache_free(ns->ns_status_cache, ns_status);
 }
 
+/* Test whether an iint is unused due to empty ns_status list AND the
+ * not-yet namespaced flags are not set on it.
+ */
+static bool __iint_is_unused(struct integrity_iint_cache *iint)
+{
+	return list_empty(&iint->ns_list) &&
+		(iint_flags(iint, NULL) & IMA_IINT_FLAGS) == 0;
+}
+
+static bool iint_is_unused(struct integrity_iint_cache *iint)
+{
+	bool ret;
+
+	write_lock(&iint->ns_list_lock);
+	ret = __iint_is_unused(iint);
+	write_unlock(&iint->ns_list_lock);
+
+	return ret;
+}
+
 /*
  * ima_free_ns_status_tree - free all items on the ns_status_tree and take each
  *                           one off the list; yield to ns_list free'ers
@@ -161,6 +181,18 @@ void ima_free_ns_status_tree(struct ima_namespace *ns)
 			if (!list_empty(&ns_status->ns_next)) {
 				list_del_init(&ns_status->ns_next);
 				llist_add(&ns_status->gc_llist, &garbage);
+
+				/*
+				 * While ns_status->iint is guaranteed to be
+				 * there, check whether the iint is still in
+				 * use by anyone at this moment.
+				 */
+				if (__iint_is_unused(ns_status->iint)) {
+					ns_status->inode_to_remove =
+						ns_status->iint->inode;
+				} else {
+					ns_status->inode_to_remove = NULL;
+				}
 				ctr++;
 			}
 			write_unlock(&ns_status->iint->ns_list_lock);
@@ -180,8 +212,17 @@ void ima_free_ns_status_tree(struct ima_namespace *ns)
 	} while (restart);
 
 	node = llist_del_all(&garbage);
-	llist_for_each_entry_safe(ns_status, next, node, gc_llist)
+	llist_for_each_entry_safe(ns_status, next, node, gc_llist) {
+		if (ns_status->inode_to_remove) {
+			/*
+			 * Pass along the test function in case inode is in
+			 * use now.
+			 */
+			integrity_inode_free(ns_status->inode_to_remove,
+					     iint_is_unused);
+		}
 		ns_status_free(ns, ns_status);
+	}
 
 	kmem_cache_destroy(ns->ns_status_cache);
 }
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index dbe9f36d3692..6276e6a615b7 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -134,6 +134,7 @@ struct ns_status {
 	ino_t i_ino;
 	u32 i_generation;
 	struct llist_node gc_llist;	/* used while freeing */
+	void *inode_to_remove;		/* used while freeing */
 #endif
 };
 
-- 
2.31.1

