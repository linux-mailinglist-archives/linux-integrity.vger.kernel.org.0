Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5968BF77
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjBFOE6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjBFOE2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:04:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574D0241E1;
        Mon,  6 Feb 2023 06:03:57 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqMSS022762;
        Mon, 6 Feb 2023 14:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=93DDU/Azt3RdacYDN+QmUzQz6lIczxDJCJ+bLgbHD90=;
 b=dlDqjjccky7iP6vXnXnRxXbFH71qVA7lHgb2y0F3tGHlR3mivpPfx+QFyeNOIkRgEE4j
 kjsSx4Ij90K/OOKPBykA8VlY8C3Bwf/kwAMPc0dBGDeSmAqRO8Jj6O097cVdZVK4FNAE
 cnUDpNjErGb5n49cXFZcL3iUZKRbb/WZUWzsX1GYWOLfTl6aoAL4XRkYAbKzrH5JT/Sm
 NbWMcWJ/2NlNxn+RxNWaDqcq97WfQLesl/7nvomuCix7SyMN2g5lDj5iLJ3L0QlozwDU
 nfTyMRdL18QvUkin+MsPVrLx4NKKTlYi6x6i8mi8Bq9dspGiKSyYzXxWQyEAzr++ORVu cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tf0d01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:45 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DsVQw008866;
        Mon, 6 Feb 2023 14:03:45 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tf0cyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:45 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CNNQs003055;
        Mon, 6 Feb 2023 14:03:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3nhf07dqcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3gbC5309012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25A6158059;
        Mon,  6 Feb 2023 14:03:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5531A58058;
        Mon,  6 Feb 2023 14:03:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:40 +0000 (GMT)
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
Subject: [PATCH v15 20/26] ima: Remove unused iints from the integrity_iint_cache
Date:   Mon,  6 Feb 2023 09:02:47 -0500
Message-Id: <20230206140253.3755945-21-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T5W-8djRhCXaV6la8IByiDXutrDa5olH
X-Proofpoint-ORIG-GUID: pBxC-xhyJ7VTvtY5tr5L2kxtdei2snC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060116
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
index 4ac937c2c039..dfbe1a59b9a1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -502,6 +502,8 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
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
2.37.3

