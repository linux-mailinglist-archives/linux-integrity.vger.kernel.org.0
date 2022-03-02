Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A94CA670
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbiCBNvg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbiCBNv2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B1DC55A3;
        Wed,  2 Mar 2022 05:50:25 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222DmSAg013181;
        Wed, 2 Mar 2022 13:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K5NXUSoSyLuz4AI/royCZOMTb8jgxNpPPQg7laYI3NU=;
 b=HzMwemp77/9hXGKZwk49ElfwiFj05l0YybVdjL+lBz8hjJ9R8f5zYHYBDTvORVo0/vSP
 v/12gnM0SytZq4sZlLCg8jqOWDmDCRTqEqAgq4DT+9UC+rXNmFu3OW6Vm5e094z8jNd5
 JnJWyP7NmOR/dt6SRq64xq0shfVKq/MiQFwfBcSxhzpAN/YpZiJLKA6qFZo9bGcIP8BZ
 uD1q+BWdBV/uWE/tnh1pg9DgwX9/YO9XzpHESuvWb8cl0YZqQTuqpUssv2PY5VvAtBCs
 RdJ0djG8hv6ArAmLC4OhWL10WPFeagC5OkW9BRcXpTO8NmpIdoUW4W+/WrgWrLuWsAD8 NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej9st80p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:00 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DmfYL013448;
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej9st80nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:00 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222Dn6SX032076;
        Wed, 2 Mar 2022 13:49:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3ej75rh31s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:49:59 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Dnw4Z56295752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4501F11206B;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2888711206F;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v11 09/27] ima: Move IMA securityfs files into ima_namespace or onto stack
Date:   Wed,  2 Mar 2022 08:46:44 -0500
Message-Id: <20220302134703.1273041-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7fQa9FRveqdIe_f4DVfTJGCHpRMooQhd
X-Proofpoint-ORIG-GUID: fr3QNECMG4LGNfnD1_SG8JRjlASyz-gV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.31.1

