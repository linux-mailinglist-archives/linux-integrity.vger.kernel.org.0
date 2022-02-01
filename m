Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9374A65E4
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbiBAUiU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33256 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239865AbiBAUiN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:13 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211K2RYY007406;
        Tue, 1 Feb 2022 20:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fUlyRIVWJ4Srak9bU1o0uRoRZnQEW9IGDoHv8s37O4Y=;
 b=gxF6VTJuihEumMeRYnOyMtc9S0gOJ1913bX1djlhF0ToYi9D2Ju/BpyIhk3iuuJUWvzJ
 Mu2UKRnZ2ZlOgGiSnFpgaysdYr9CGnjf5wgWqnjyQ5XFPxPCUWrHxiQLW7HWnSAYyJrv
 X1F/0VA0GMNLKaeD2cjE2u9aeph95vIAtQRGFLU7bcuac/btvOAhBvrLYmzWa+8vEknZ
 PuwJ3TRMi/80BbKyXcPFb067IJSmUoEePe7Uj+jsMY0EtO3gNgpeiOPBAcyZMVOk77mv
 yAXzCjFci0lB9wGgXdUX0MaH24+xnppgZ1v5RL6MVhbIu55ga8awLR1VwE88xbJ+mUfw Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dy8u5byhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KDK62021947;
        Tue, 1 Feb 2022 20:37:53 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dy8u5byha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:53 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KXCph009588;
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 3dvw7as59c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:52 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Kbp4r36372944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C013BB206C;
        Tue,  1 Feb 2022 20:37:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD206B2065;
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
Subject: [PATCH v10 19/27] integrity: Add optional callback function to integrity_inode_free()
Date:   Tue,  1 Feb 2022 15:37:27 -0500
Message-Id: <20220201203735.164593-20-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: znPBCEav9hTUri_CYoJWpExTS7auEsjk
X-Proofpoint-ORIG-GUID: MsqkzJLkzZ7ZmqKhFcMv_7rK91cHSemv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=935 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an optional callback function to integrity_inode_free() that,
if provided, must be called and determines whether the iint can be
freed. Adjust all callers of this function to provide a NULL pointer
since none of the existing callers needs this check.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/integrity.h |  8 ++++++--
 security/integrity/iint.c | 15 +++++++++++++--
 security/security.c       |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2ea0f2f65ab6..9fe826b9146e 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -19,10 +19,13 @@ enum integrity_status {
 	INTEGRITY_UNKNOWN,
 };
 
+struct integrity_iint_cache;
+typedef bool (*iint_removable_cb)(struct integrity_iint_cache *iint);
+
 /* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
 extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
-extern void integrity_inode_free(struct inode *inode);
+extern void integrity_inode_free(struct inode *inode, iint_removable_cb check);
 extern void __init integrity_load_keys(void);
 
 #else
@@ -32,7 +35,8 @@ static inline struct integrity_iint_cache *
 	return NULL;
 }
 
-static inline void integrity_inode_free(struct inode *inode)
+static inline void integrity_inode_free(struct inode *inode,
+					iint_removable_cb check)
 {
 	return;
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 371cbceaf479..4580df0e716e 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -143,21 +143,32 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 /**
  * integrity_inode_free - called on security_inode_free
  * @inode: pointer to the inode
+ * @check: optional callback function to check whether the iint can be freed
  *
  * Free the integrity information(iint) associated with an inode.
  */
-void integrity_inode_free(struct inode *inode)
+void integrity_inode_free(struct inode *inode, iint_removable_cb check)
 {
 	struct integrity_iint_cache *iint;
+	bool freeit = true;
 
 	if (!IS_IMA(inode))
 		return;
 
 	write_lock(&integrity_iint_lock);
+
 	iint = __integrity_iint_find(inode);
-	rb_erase(&iint->rb_node, &integrity_iint_tree);
+
+	if (check)
+		freeit = check(iint);
+	if (freeit)
+		rb_erase(&iint->rb_node, &integrity_iint_tree);
+
 	write_unlock(&integrity_iint_lock);
 
+	if (!freeit)
+		return;
+
 	ima_free_ns_status_list(&iint->ns_list, &iint->ns_list_lock);
 
 	iint_free(iint);
diff --git a/security/security.c b/security/security.c
index c88167a414b4..84c9ed18a4b1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1035,7 +1035,7 @@ static void inode_free_by_rcu(struct rcu_head *head)
 
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
+	integrity_inode_free(inode, NULL);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
-- 
2.31.1

