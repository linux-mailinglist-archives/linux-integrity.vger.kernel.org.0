Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E7F5BA157
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiIOTdq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIOTdT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 15:33:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF99D669;
        Thu, 15 Sep 2022 12:33:11 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FJVFEO001232;
        Thu, 15 Sep 2022 19:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lHCCxePa3T0WrjlbB0wOUUdwKE4sDoLahUzbO6Jkun8=;
 b=XWTPeI4TGEVFHPOEZvgiNEuZV2dESIfMtO6Z2Bb0kJkTHHx2UQcBcmoUyShsYfm9GVAG
 z3XY9j8qS3XS+WPalU5lsvKJedk2WwTBc+FvHhC3kz+Uca8wLqtbQ3zvNXSNPMxZ7bjh
 1kHTYTsEAOQlTdP7WDOH3nRUIlxn3uB8yXH9B8sbgMX801rDWInhqJ8iH71IIUVbmAyf
 um35Kb3GE8xkWWw21ko5641QjH3kVLPM2CZ0NeUI5HwlUTbWdbf1cY2fhLYhiUrhFzxf
 E9EdUEPrypgof6oAW/FReTT+EZQ6e0Lw/mF6T4ZWc2gTMPPvFu0jFF+WTUXGbX7CdhpJ eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jma9eg285-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:41 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28FJWemT012770;
        Thu, 15 Sep 2022 19:32:40 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jma9eg272-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:40 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FJJuXT004482;
        Thu, 15 Sep 2022 19:32:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3jm91q8gdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:39 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FJWcVI9437836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 19:32:38 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 095F1AE05C;
        Thu, 15 Sep 2022 19:32:38 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF4CFAE063;
        Thu, 15 Sep 2022 19:32:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 19:32:37 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v14 20/26] ima: Remove unused iints from the integrity_iint_cache
Date:   Thu, 15 Sep 2022 15:32:15 -0400
Message-Id: <20220915193221.1728029-21-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915193221.1728029-1-stefanb@linux.ibm.com>
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p2vhgN_Nk47s4KXhc91IZbDdZ3mZtxfE
X-Proofpoint-ORIG-GUID: 08JHR29yodKwBR4izmN7UOrqeKZ92tyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209150119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

