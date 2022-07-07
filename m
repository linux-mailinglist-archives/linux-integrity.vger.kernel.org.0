Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442E56A5E7
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiGGOtT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbiGGOsh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A831DF6;
        Thu,  7 Jul 2022 07:48:37 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EMe6A006268;
        Thu, 7 Jul 2022 14:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lHCCxePa3T0WrjlbB0wOUUdwKE4sDoLahUzbO6Jkun8=;
 b=qsUZueMh1s/J4m531PIBT5z9d8jADFA2ClZjTtawOzMupECZS+OPkS1XhvF1EU0a7r+8
 PGX2a9m5ZW9z4gkj7xCI85CvYBLN+rG3Fv9zR6ADCKbU6cb/UE/4rkbQrOQa16lPhu7D
 tKQP2y7B93VIOfD5AQBO1gFkf6Y+QNs1UyXzjydZ+NXtf5fpmCPHm4idjYb05pz+AYgA
 39uafw+bpxiM9N42sPA97gFIcOVun9jFlCRp7nvm2GUxQmQTyVmFTxjc3H0Ck7j2/WB+
 qxO6oxP5738CRf/h4+r4v287rNOHA8b4UADTM1EthtrxM8Q7XALWeRMwVm5hcyoGHw4o 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h605j3c7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:10 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EMsdx007641;
        Thu, 7 Jul 2022 14:48:10 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h605j3c63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:10 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EZkOV021769;
        Thu, 7 Jul 2022 14:48:08 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3h4ud7pvtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em70k26607956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EA0C112061;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5C73112062;
        Thu,  7 Jul 2022 14:48:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:06 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v13 20/26] ima: Remove unused iints from the integrity_iint_cache
Date:   Thu,  7 Jul 2022 10:47:54 -0400
Message-Id: <20220707144800.828288-21-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3E6Betu8Jk7Qtq7WuITirZO82JfYoy7s
X-Proofpoint-GUID: 9KVxp6xkJ3056uFyC66pFFYQUCA_TsYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v11:
  - change write_lock to read_lock in callback
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
index 74d70debb645..0ac76e1a0fff 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -501,6 +501,8 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #define IMA_NS_STATUS_ACTIONS   IMA_AUDIT
 #define IMA_NS_STATUS_FLAGS     (IMA_AUDIT | IMA_AUDITED)
 
+#define IMA_IINT_FLAGS		(IMA_MEASURE | IMA_APPRAISE | IMA_HASH)
+
 static inline unsigned long iint_flags(struct integrity_iint_cache *iint,
 				       struct ns_status *ns_status)
 {
diff --git a/security/integrity/ima/ima_ns_status.c b/security/integrity/ima/ima_ns_status.c
index 9c753caad6ac..32d75dbd9c21 100644
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
+	read_lock(&iint->ns_list_lock);
+	ret = __iint_is_unused(iint);
+	read_unlock(&iint->ns_list_lock);
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
index 50a5d94593e1..0634320a6bc2 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -167,6 +167,7 @@ struct ns_status {
 	ino_t i_ino;
 	u32 i_generation;
 	struct llist_node gc_llist;	/* used while freeing */
+	void *inode_to_remove;		/* used while freeing */
 #endif
 };
 
-- 
2.36.1

