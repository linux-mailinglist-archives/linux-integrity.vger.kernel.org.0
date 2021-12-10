Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221C7470ACB
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 20:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbhLJTvs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 14:51:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343839AbhLJTvo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 14:51:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJfbr4003784;
        Fri, 10 Dec 2021 19:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=T0p8yQkb5het3/69uVSEvEhiCwN07UUzs4owyWuTuf8=;
 b=M2p7CePiS4DAmBSVMRSRAwm5IZO234MgobUJ1itcqlB967N0ifD/gswSh0QVVY8rnWyZ
 De1xUR+cMlRot6M1JytCyWOL5gkMdTiN7KoxlFBl514uxlnK9aiY0mc1O4lPyYHjvcJv
 WE1XzlBlzuZUgFTCZySMdvG8A/k7D2vAOsXT6Q6P/XI+0/CyRlfQ95uVszrdeuAZD79q
 NK/Ez+FfJ9GMrBvRgZsSVbs+iIzj83pbMX0UtYtDvFQ1f6OXRFytkktNWBfjmKhIM6Ts
 4ZJMdNDaGKZnKinT+lj5Me3FuBC0BKdOoj2LuHxRq9dP0gdN99MVJL3S27EfcLraVL+9 fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvd97r2qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:42 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAJlgXn027292;
        Fri, 10 Dec 2021 19:47:42 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvd97r2qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:42 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJchee013159;
        Fri, 10 Dec 2021 19:47:40 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3cqyycnqk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:40 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAJld6n29753826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:47:39 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CD8BAE067;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ABD5AE068;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
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
Subject: [PATCH v6 12/17] securityfs: Extend securityfs with namespacing support
Date:   Fri, 10 Dec 2021 14:47:31 -0500
Message-Id: <20211210194736.1538863-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210194736.1538863-1-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yncE3-5-nmbwVC_TY2vqF6NCf808KFlR
X-Proofpoint-ORIG-GUID: gy02mhljES78at2VC1PcId8HQy6zn44N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend 'securityfs' for support of IMA namespacing so that each
IMA (user) namespace can have its own front-end for showing the currently
active policy, the measurement list, number of violations and so on.

Drop the addition dentry reference and simplify cleanup to work without
the additional reference. This enables simple cleanup of dentries upon
umount.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 security/inode.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index fee01ff4d831..c77ae8ecc464 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -54,7 +54,7 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int securityfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, securityfs_fill_super);
+	return get_tree_keyed(fc, securityfs_fill_super, fc->user_ns);
 }
 
 static const struct fs_context_operations securityfs_context_ops = {
@@ -72,6 +72,7 @@ static struct file_system_type fs_type = {
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_USERNS_MOUNT,
 };
 
 /**
@@ -168,7 +169,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -306,23 +306,17 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
 void securityfs_remove(struct dentry *dentry)
 {
 	struct user_namespace *ns;
-	struct inode *dir;
 
 	if (!dentry || IS_ERR(dentry))
 		return;
 
 	ns = dentry->d_sb->s_user_ns;
 
-	dir = d_inode(dentry->d_parent);
-	inode_lock(dir);
 	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(dir, dentry);
-		else
-			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
-	inode_unlock(dir);
+
 	if (ns == &init_user_ns)
 		simple_release_fs(&init_securityfs_mount,
 				  &init_securityfs_mount_count);
-- 
2.31.1

