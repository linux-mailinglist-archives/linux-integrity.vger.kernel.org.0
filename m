Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D172868BF6F
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjBFOE6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBFOE0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:04:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D327495;
        Mon,  6 Feb 2023 06:03:54 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqLIR023078;
        Mon, 6 Feb 2023 14:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s1edFH2qTR/cMKYj/JHX4rluR5lgk1wtRdjk7i6fOMU=;
 b=mTZ9InxqzRCyM4ZPq5qWqXvNFOUWHzNMOAuH/UpFGwha2VwmCJS8rpahDuGLGQfuU6QH
 WJb2BIEfhmOCrxkJFUFOGI8ePb31pmm/M/2AJ1IWRJI+sCvibbBpmte7+VK9QqrtNFod
 rqM3R5/V51765soZfCR2mLliyeQRV7+/WMK4ybbsoulxd51VZ/9AmTa78Eid4etilFyn
 dDNGOKx2DPcxIDDgC/FjxqPl8XhlJE1y0of4myo0vUJ6g+/4SOLngaTPY2XkAt1Slkih
 VmYOrC9JlJoL8qtbwmmztdXem8fhbL8e25oHuCkEp/K1j1dDg8Tg+VAeIhsQ9BHw+M16 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1abkje0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:41 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316Dtdj6024351;
        Mon, 6 Feb 2023 14:03:41 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1abkjd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:41 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CL24L001953;
        Mon, 6 Feb 2023 14:03:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3nhf075pxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3cUO8717010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 205075805C;
        Mon,  6 Feb 2023 14:03:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5040958059;
        Mon,  6 Feb 2023 14:03:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:36 +0000 (GMT)
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
Subject: [PATCH v15 18/26] integrity: Add optional callback function to integrity_inode_free()
Date:   Mon,  6 Feb 2023 09:02:45 -0500
Message-Id: <20230206140253.3755945-19-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cHOPMZ_29Si-x4dUfqSmKGnTmQi4qyNC
X-Proofpoint-GUID: 6dHNROqfxV077ztijvvyOeI_hHJUoAAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=889 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index d1571900a8c7..2b1f9ec8dea9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1071,7 +1071,7 @@ static void inode_free_by_rcu(struct rcu_head *head)
 
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
+	integrity_inode_free(inode, NULL);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
-- 
2.37.3

