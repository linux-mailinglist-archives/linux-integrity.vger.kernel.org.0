Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0575D463B24
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 17:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbhK3QLX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 11:11:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243435AbhK3QLA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 11:11:00 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFlXpT001758;
        Tue, 30 Nov 2021 16:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k87Qh4JL58PaoWjNxP/QguzWPYNVZIv9+Y+W20HNtnw=;
 b=TzgE3B6B2rL5kO2qjyusvL0XhJhbp8IAb1AAjqvbIBYUVLgzjGMk+8WcRGL0IiBNaxwR
 lfSBeS653bbrbbDeavC/LR1Od2obnw/SfbYOpeVHihwDiwlEh/F9j4H2H1DYIDZemlZB
 Vu4h/L0SljfvgfrMC9KX4KxyUb6meK43fGgX0LrxaA4LDBADU1VQCqttfE6KJt++zn4N
 ImbhjXpgV2vfoAZ6MFpn8DUVKH0ZmrrF+aVqakVBY+GK5xVAoUlH4nycAMWUJWaxgJrM
 /NRCfkBgnl1Xepq7oUibMQX7FPYE1v/KY09a8GCO5oFV93zYRHRrVZxKCkVuce4rRBW9 QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpwm0gvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:15 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFm61Z003286;
        Tue, 30 Nov 2021 16:07:15 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpwm0guw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG2j4x009853;
        Tue, 30 Nov 2021 16:07:14 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcab7tjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7Ck754919658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53ACDB20A9;
        Tue, 30 Nov 2021 16:07:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FC03B2095;
        Tue, 30 Nov 2021 16:07:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 16:07:12 +0000 (GMT)
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
Subject: [RFC 11/20] securityfs: Prefix global variables with securityfs_
Date:   Tue, 30 Nov 2021 11:06:45 -0500
Message-Id: <20211130160654.1418231-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130160654.1418231-1-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SzPnfeCdJ1Gj2rHiauPRxSbAkUUzGn4e
X-Proofpoint-GUID: qiRaAPH9iTBG7hniYl5_31WY5hDaHatM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prefix global variables 'mount' and 'mount_count' with securityfs_ so they
are easier to distinguish as variables belonging to securityfs rather than
variables being passed in through new APIs we will introduce.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..e523829c22cb 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,8 +22,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 
-static struct vfsmount *mount;
-static int mount_count;
+static struct vfsmount *securityfs_mount;
+static int securityfs_mount_count;
 
 static void securityfs_free_inode(struct inode *inode)
 {
@@ -66,7 +66,7 @@ static int securityfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static struct file_system_type fs_type = {
+static struct file_system_type securityfs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
@@ -118,12 +118,12 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
+	error = simple_pin_fs(&securityfs_type, &securityfs_mount, &securityfs_mount_count);
 	if (error)
 		return ERR_PTR(error);
 
 	if (!parent)
-		parent = mount->mnt_root;
+		parent = securityfs_mount->mnt_root;
 
 	dir = d_inode(parent);
 
@@ -168,7 +168,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	simple_release_fs(&securityfs_mount, &securityfs_mount_count);
 	return dentry;
 }
 
@@ -309,7 +309,7 @@ void securityfs_remove(struct dentry *dentry)
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	simple_release_fs(&securityfs_mount, &securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
@@ -336,7 +336,7 @@ static int __init securityfs_init(void)
 	if (retval)
 		return retval;
 
-	retval = register_filesystem(&fs_type);
+	retval = register_filesystem(&securityfs_type);
 	if (retval) {
 		sysfs_remove_mount_point(kernel_kobj, "security");
 		return retval;
-- 
2.31.1

