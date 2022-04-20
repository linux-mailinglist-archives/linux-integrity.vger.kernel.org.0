Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA9508A3F
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379533AbiDTOLq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379389AbiDTOKP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A04475C;
        Wed, 20 Apr 2022 07:07:19 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KDigcv011787;
        Wed, 20 Apr 2022 14:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HznB44C2uHxQCiTCnuZt+O06VqTT5wSPcwXI8z64pJA=;
 b=hqpfv+9XALioWeyhuUDIPEhbmbiigOp8OR9DAshu/EcCgtUTLpuL8nLqwiDdgu6xPF3k
 39BasbLqE4kkJLsB0Jt+FN+MJjwingN8qoutLOnK17PD8l3tmeRh7mQy7z0Y6b+DH5re
 6fHrsV4+YBKZThV0eKKy58OTvRoEd9Dp97+bMXDIGMRTdUPk0LWOQ3LZlDiqeZA12gvr
 R4NgGeRchq9tBhbDbGT2+XTEJd2x9HK7zMX/7sXu8CmdXSLxogIwdaeboFtqu9FzocqF
 Yg9EIyFvRMWmR7/roDwUsJnmURpF4XJuDNrI2cubmi/uSX+O9KH1/yPBIIrJPfM5L0Iu dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7vpqyvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:46 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KDmj5p022846;
        Wed, 20 Apr 2022 14:06:45 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7vpqyv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:45 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE3CJi015545;
        Wed, 20 Apr 2022 14:06:44 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3ffnea3tvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:44 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6hKp54133188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:43 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 765CAAE060;
        Wed, 20 Apr 2022 14:06:43 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60455AE06F;
        Wed, 20 Apr 2022 14:06:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 14:06:43 +0000 (GMT)
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
Subject: [PATCH v12 18/26] integrity: Add optional callback function to integrity_inode_free()
Date:   Wed, 20 Apr 2022 10:06:25 -0400
Message-Id: <20220420140633.753772-19-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vRpXfs8Pqb5gWo1j3twOra1cTHcQLC_7
X-Proofpoint-GUID: Bz9-3S5Pw8lEpuAQn801v0kYf3byOXnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=889 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index b7cf5cbfdc67..2acd11e6b6bb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1040,7 +1040,7 @@ static void inode_free_by_rcu(struct rcu_head *head)
 
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
+	integrity_inode_free(inode, NULL);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
-- 
2.34.1

