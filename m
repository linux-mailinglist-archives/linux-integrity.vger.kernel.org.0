Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB4756A5D8
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiGGOsh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiGGOsb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17FD55B7;
        Thu,  7 Jul 2022 07:48:27 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EMpXe030516;
        Thu, 7 Jul 2022 14:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hHJIBF4rbvlnLqiL0Grn08f7zLRut4GfBSNfNo0ju1I=;
 b=Iz7zKmDmspKaqhFgohhQimrPlbeP8Lu0XfIIBMIjntaRIDDq0HQNrPpUpmwC1rJnDjyK
 olRGsXLZ8qiHeGvJzRr/ZAbas8ZeOlAAHfGJf9Grcz+RG2S9CqsOKB79Ec6w1bGDIFD+
 yFpm92ilcaP86ZMvxsBv1/wJ4X9i91Q3xceJxAz6rMzY7rWTomjd3pea9ZjWPyjeMyZa
 Gk7u2knaNWiblTFDrn7A6G8uJZ3DTRa/WYbx/9ockXSd4eVuB3Gn0S7bLv8xlW0R4GYE
 /IoccGlEbHbKhtMD8h1FlRJ2GFkZlN12bG/BhenWFyfVQNuxpaQRE4SDl+Nkf5ZH9ytW 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h60u1huam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EMq5c030587;
        Thu, 7 Jul 2022 14:48:07 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h60u1hu9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:07 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EZYWm029886;
        Thu, 7 Jul 2022 14:48:06 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3h4ud53ybm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:06 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em5np38076774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B2A7112061;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D39D11206B;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v13 08/26] ima: Move IMA securityfs files into ima_namespace or onto stack
Date:   Thu,  7 Jul 2022 10:47:42 -0400
Message-Id: <20220707144800.828288-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: haLKEj3CKDMCO5F_YsPQLVYkJAS6ERSq
X-Proofpoint-ORIG-GUID: xKoxRzO7jHM6IACEsasU6Kc8iXOCXHuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Earlier we simplified how dentry creation and deletion is manged in
securityfs. This allows us to move IMA securityfs files from global
variables directly into ima_fs_ns_init() itself. We can now rely on
those dentries to be cleaned up when the securityfs instance is cleaned
when the last reference to it is dropped.

Things are slightly different for the initial IMA namespace. In contrast
to non-initial IMA namespaces it has pinning logic binding the lifetime
of the securityfs superblock to created dentries. We need to keep this
behavior to not regress userspace. Since IMA never removes most of the
securityfs files the initial securityfs instance stays pinned. This also
means even for the initial IMA namespace we don't need to keep
references to these dentries anywhere.

The ima_policy file is the exception since IMA can end up removing it
on systems that don't allow reading or extending the IMA custom policy.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>

---

v9:
 - Revert renaming of ima_policy to policy_dentry
---
 security/integrity/ima/ima.h    |  2 ++
 security/integrity/ima/ima_fs.c | 37 ++++++++++++++++++---------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a144edfdb9a1..b35c8504ef87 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -142,6 +142,8 @@ struct ima_namespace {
 	struct mutex ima_write_mutex;
 	unsigned long ima_fs_flags;
 	int valid_policy;
+
+	struct dentry *ima_policy;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 4cf786f0bba8..89d3113ceda1 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -359,14 +359,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	return result;
 }
 
-static struct dentry *ima_dir;
-static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
-static struct dentry *ima_policy;
-
 enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
@@ -436,8 +428,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	securityfs_remove(ns->ima_policy);
+	ns->ima_policy = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -454,8 +446,14 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-int __init ima_fs_init(void)
+static int __init ima_fs_ns_init(struct ima_namespace *ns)
 {
+	struct dentry *ima_dir;
+	struct dentry *ima_symlink = NULL;
+	struct dentry *binary_runtime_measurements = NULL;
+	struct dentry *ascii_runtime_measurements = NULL;
+	struct dentry *runtime_measurements_count = NULL;
+	struct dentry *violations = NULL;
 	int ret;
 
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
@@ -504,17 +502,17 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
-					    ima_dir, NULL,
-					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy)) {
-		ret = PTR_ERR(ima_policy);
+	ns->ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
+						ima_dir, NULL,
+						&ima_measure_policy_ops);
+	if (IS_ERR(ns->ima_policy)) {
+		ret = PTR_ERR(ns->ima_policy);
 		goto out;
 	}
 
 	return 0;
 out:
-	securityfs_remove(ima_policy);
+	securityfs_remove(ns->ima_policy);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
@@ -524,3 +522,8 @@ int __init ima_fs_init(void)
 
 	return ret;
 }
+
+int __init ima_fs_init(void)
+{
+	return ima_fs_ns_init(&init_ima_ns);
+}
-- 
2.36.1

