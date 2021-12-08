Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8F46DE29
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 23:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbhLHWWY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 17:22:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240636AbhLHWWN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 17:22:13 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8KQux0005086;
        Wed, 8 Dec 2021 22:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NAf16XpmdHctlgU2n3jNuYnLGYZmwH3akWx3Xr06KYA=;
 b=ZM8541UKzdz7Jvixu/kSCkhf/TKm6VvhM/Zrkci33/fg9MQ+bdZxqpGFas0hnRcE+ITI
 JNslOtaCrlHqXr/hRPK8UtIRRw3hohbH1m8xRl+LM3idVSdv/pq10/o/u3rPHD7lW/L1
 6j1dT/XX96uXUO9HpF0WnKobG6/qmBdaeBbS7WXlJe6qfniV6i4BcBPgqQZmnRUQ+Dww
 RsNepPgB1CqfRAmcFLLTSoZzZVTDlMOy0jgIkF1q1fYFjppAa1WY742H1iG0vutIxyhD
 sSmxvCKvd2alg5eh6rPjBWfwAYPt/m72o0oZqEoIb6Dl+DeRe9pI66qA1bGSiaXfSVdH IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu1gk4uae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:28 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8MISO1004800;
        Wed, 8 Dec 2021 22:18:28 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu1gk4ua7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:28 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MDuq7021827;
        Wed, 8 Dec 2021 22:18:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyybyknq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:26 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8MIPQB23790034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 22:18:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6476A28059;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 518CC2806A;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
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
        Denis Semakin <denis.semakin@huawei.com>
Subject: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check corresponding capability
Date:   Wed,  8 Dec 2021 17:18:16 -0500
Message-Id: <20211208221818.1519628-15-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208221818.1519628-1-stefanb@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gw53Spfiu02jrJfU2kz970xtYotbVlQ6
X-Proofpoint-ORIG-GUID: taZ1FXfESC3MF1Y1QnK-n5hLniY7FWya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use mac_admin_ns_capable() to check corresponding capability to allow
read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/capability.h      | 6 ++++++
 security/integrity/ima/ima_fs.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..991579178f32 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool mac_admin_ns_capable(struct user_namespace *ns)
+{
+	return ns_capable(ns, CAP_MAC_ADMIN) ||
+		ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 			   const struct dentry *dentry,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 0e582ceecc7f..a749a3e79304 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -394,7 +394,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!mac_admin_ns_capable(ns->user_ns))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
-- 
2.31.1

