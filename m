Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4549946A2C3
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbhLFR36 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 12:29:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239732AbhLFR3y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 12:29:54 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6FfUL2024271;
        Mon, 6 Dec 2021 17:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OXDy9G0mMI3RZtXT+af7CYVx5nY+Svs5EcZ7oljGHZQ=;
 b=BMCJfTKu4g+srkDOS/egUYLNxo4UDTQEZQ0XleEL99BnosgiwV0lYH/ChSjldpcGAv2r
 b5EpjRAf30q5xeS2MTtIQ1XsX+04ZEkXuSwoB5uecIJ9GEZvZ9AoKzNNpFS5AwDAR2WV
 87OfP2yG5pNSKravX6/m9Ckzhq8AKqhbtEj/Xa8mciaF+gLN+a3e5HNWlbTgIcgWmoyB
 HCtVN4ofwZ207ozwepMXSdx8kNX8DCx7GrNZIlyANakbqEy/Hmd3DUBML+4W11Ekxcu6
 H9qk4giHsvA35YW9MHurzCCwRF5sREz2Ugwol4hcMYf4jmUreQ7YrtN3QJUeoXk70PW/ rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csjtre6cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:12 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6Fu8Gb002196;
        Mon, 6 Dec 2021 17:26:11 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csjtre6bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:11 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HEITT000459;
        Mon, 6 Dec 2021 17:26:10 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3cqyy72d0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:10 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6HQ88T20840820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 17:26:08 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE3962806A;
        Mon,  6 Dec 2021 17:26:08 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB1BC28064;
        Mon,  6 Dec 2021 17:26:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 17:26:08 +0000 (GMT)
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
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v3 11/16] securityfs: Move vfsmount into user_namespace
Date:   Mon,  6 Dec 2021 12:25:55 -0500
Message-Id: <20211206172600.1495968-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206172600.1495968-1-stefanb@linux.ibm.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xC0VRwRrtS_PQ2t8y30jEwbkQ0EyBc9c
X-Proofpoint-ORIG-GUID: HhZ4noGnklDFHO1aQ0Tw3ghXr4vBNSYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move vfsmount into user_namesapce so that every instance of the
virtualized SecurityFS can have this parameter. Use simple_pin_fs only for
the init_user_ns expecting that the parent node can be found using the
vfsmount from the user_namespace for non-init_user_ns case.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/user_namespace.h |  3 +++
 security/inode.c               | 25 +++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 5249db04d62b..89663e6e0e85 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -103,6 +103,9 @@ struct user_namespace {
 #ifdef CONFIG_IMA
 	struct ima_namespace	*ima_ns;
 #endif
+#ifdef CONFIG_SECURITYFS
+	struct vfsmount		*securityfs_mount;
+#endif
 } __randomize_layout;
 
 struct ucounts {
diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..f1006cec6ce6 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,9 +21,9 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/user_namespace.h>
 
-static struct vfsmount *mount;
-static int mount_count;
+static int securityfs_mount_count;
 
 static void securityfs_free_inode(struct inode *inode)
 {
@@ -109,6 +109,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 					const struct file_operations *fops,
 					const struct inode_operations *iops)
 {
+	struct user_namespace *ns = current_user_ns();
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
@@ -118,12 +119,15 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
-	if (error)
-		return ERR_PTR(error);
+	if (ns == &init_user_ns) {
+		error = simple_pin_fs(&fs_type, &ns->securityfs_mount,
+				      &securityfs_mount_count);
+		if (error)
+			return ERR_PTR(error);
+	}
 
 	if (!parent)
-		parent = mount->mnt_root;
+		parent = ns->securityfs_mount->mnt_root;
 
 	dir = d_inode(parent);
 
@@ -168,7 +172,9 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&ns->securityfs_mount,
+				  &securityfs_mount_count);
 	return dentry;
 }
 
@@ -294,6 +300,7 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
  */
 void securityfs_remove(struct dentry *dentry)
 {
+	struct user_namespace *ns = dentry->d_sb->s_user_ns;
 	struct inode *dir;
 
 	if (!dentry || IS_ERR(dentry))
@@ -309,7 +316,9 @@ void securityfs_remove(struct dentry *dentry)
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&ns->securityfs_mount,
+				  &securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
-- 
2.31.1

