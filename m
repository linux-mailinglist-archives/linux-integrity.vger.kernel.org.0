Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C925146C478
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 21:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbhLGU0Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 15:26:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241375AbhLGU0F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 15:26:05 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7JbexM027041;
        Tue, 7 Dec 2021 20:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ktXstX4IY55NsI3XTmgUUkWJ8V5FVyP8KeNa3VQmlY8=;
 b=KEAFg8/gmPeiWVsRXI9bEYdo6S3VW/TEnjKUJs2xd3YymqXa/pwSWr1AS1CztAF94SEm
 v1n683b2/pthFAbw1MRV7QX+YxL+GhZ49OozXj+Et+o8QExPu/SD6otlzHovWtk+j29G
 h7400dZv+2mrpNq8iCmzCQfaysDyGGwLlNsUYGaawd6fi6ZL7I2+/VnwZQc8tzXyRgnT
 OyQfipVuAxQH69gTGN8YsWrTwVNzDNYU21PddnEH6dBjYNAtl38CdCEuhhWWxJPNTZ81
 5jC96Io5XdUESTM8rae4FyTh8Fn5oTz1n/FcdtzC3RcD6L4fRfWUdWi3b3Acv8srUs2P sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct811j042-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:25 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7KIkkl027907;
        Tue, 7 Dec 2021 20:22:24 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct811j03f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:24 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7K7rGc023097;
        Tue, 7 Dec 2021 20:22:23 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 3cqyyam1be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:23 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7KMMrK56230356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 20:22:22 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1319E136055;
        Tue,  7 Dec 2021 20:22:22 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 060D1136059;
        Tue,  7 Dec 2021 20:22:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 20:22:19 +0000 (GMT)
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
Subject: [PATCH v4 11/16] securityfs: Only use simple_pin_fs/simple_release_fs for init_user_ns
Date:   Tue,  7 Dec 2021 15:21:22 -0500
Message-Id: <20211207202127.1508689-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211207202127.1508689-1-stefanb@linux.ibm.com>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V7gTMEkuxBoPLEvXKQ3D0dsfMZqXlAdR
X-Proofpoint-GUID: YtHDTspPcCQFS6dcfAo2EueGvWr_v4iI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112070122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To prepare for virtualization of SecurityFS, use simple_pin_fs and
simpe_release_fs only when init_user_ns is active.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 security/inode.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..1a720b2c566d 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,9 +21,10 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/user_namespace.h>
 
-static struct vfsmount *mount;
-static int mount_count;
+static struct vfsmount *securityfs_mount;
+static int securityfs_mount_count;
 
 static void securityfs_free_inode(struct inode *inode)
 {
@@ -109,6 +110,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 					const struct file_operations *fops,
 					const struct inode_operations *iops)
 {
+	struct user_namespace *ns = current_user_ns();
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
@@ -118,12 +120,17 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
-	if (error)
-		return ERR_PTR(error);
+	if (ns == &init_user_ns) {
+		error = simple_pin_fs(&fs_type, &securityfs_mount,
+				      &securityfs_mount_count);
+		if (error)
+			return ERR_PTR(error);
+	}
 
-	if (!parent)
-		parent = mount->mnt_root;
+	if (!parent) {
+		if (ns == &init_user_ns)
+			parent = securityfs_mount->mnt_root;
+	}
 
 	dir = d_inode(parent);
 
@@ -168,7 +175,9 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&securityfs_mount,
+				  &securityfs_mount_count);
 	return dentry;
 }
 
@@ -294,6 +303,7 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
  */
 void securityfs_remove(struct dentry *dentry)
 {
+	struct user_namespace *ns = dentry->d_sb->s_user_ns;
 	struct inode *dir;
 
 	if (!dentry || IS_ERR(dentry))
@@ -309,7 +319,9 @@ void securityfs_remove(struct dentry *dentry)
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&securityfs_mount,
+				  &securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
-- 
2.31.1

