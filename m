Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2067C466FE9
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378303AbhLCCfe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:35:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378156AbhLCCfT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:19 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31qlJq008772;
        Fri, 3 Dec 2021 02:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hEdI4aBLFFLpCOrcNtnP/fiAlaQIVSyXlVHCjtm7n/M=;
 b=rQA0hVqwgL2LXsUDySA0Nn9MeV35/C8QXvusyMBOoG4CuJ/AaVWK6K02ten9g/aV4TY/
 Voeg+s3D1MfpGgLERJukxriINycfzG4UPXRzYbh/2WUvM1bNgo+6fK0x64hI+Lt9O3jr
 SHfsg8a3ywFBe2xa+mfjecuVs5CVRwN4P3Pr4L0dN6q+IA8//iBRwKWDMJ66A86QyBFm
 5k/ggb7ZGnkAOp1LQiQ1QNTXzfbr4haU74yTpUSlPbRciYU8KoSpQtVvSVBBf5kCuk7H
 JzuY/RNpD4a9hrKQt7TfGXqTz9NHIIaETWTo34ZSNtcUdYRyzFsjVst4py3l/BbYwC6s RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9y40h2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:43 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32Vg9l011202;
        Fri, 3 Dec 2021 02:31:42 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9y40h22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:42 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32RkoO025349;
        Fri, 3 Dec 2021 02:31:41 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcacuf04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:41 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32Vdb956426834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:39 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8669D6E06A;
        Fri,  3 Dec 2021 02:31:39 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 738A46E052;
        Fri,  3 Dec 2021 02:31:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:38 +0000 (GMT)
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
Subject: [RFC v2 11/19] securityfs: Prefix global variables with securityfs_
Date:   Thu,  2 Dec 2021 21:31:10 -0500
Message-Id: <20211203023118.1447229-12-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: syknhlNM_dun_8oVrXuy8HwT4qZxrP_p
X-Proofpoint-GUID: QFoYem00JcNejYosv21QR7fvlklao97R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112030014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prefix global variables 'mount' and 'mount_count' with securityfs_ so they
are easier to distinguish as variables belonging to securityfs rather than
variables being passed in through new APIs we will introduce.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..71d93108de55 100644
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
@@ -118,12 +118,12 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
+	error = simple_pin_fs(&fs_type, &securityfs_mount, &securityfs_mount_count);
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
 
-- 
2.31.1

