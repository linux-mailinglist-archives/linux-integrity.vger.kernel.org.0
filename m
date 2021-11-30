Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D3463B13
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 17:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbhK3QLM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 11:11:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243387AbhK3QK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 11:10:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFkTUG019631;
        Tue, 30 Nov 2021 16:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HvSIr4/cE/ykM+BOl8ggkrbIKLz5U1uXYA78J57ufog=;
 b=NQVHtdu3D0Bd2RiDaNXboEk+ZgdAZ4q9k3CmSiYrYl8nsi8n9btCrXABASIi+SOZrEOb
 /rcUdNi7y1oyfZJT7c8mepu6GSbCv+jYUiOGpQsnsfwWhD+4g784trIxGTRHPr/1QBiD
 LRfsbEhSRm6Xnp3DtYlumuLGV71ChTO5NGW/ckUa/tnGKuaLyP1bHzZEUG+4bVZkezds
 yIar4cdPlFwUsoIjHO8xnugwoEKKlnfoBoZ3dmAURfUajeQ6saS82TXCkaUPLRaQWUrm
 nGWlWiv/Dm0HjG2CALMuHUGXKBjp9jNVIkkQR62rY2tLFnhLXC3mPx5v/xMM80PVpyZ0 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpw4ghv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:17 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFl0Br023444;
        Tue, 30 Nov 2021 16:07:16 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpw4ghud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:16 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG4NH5023605;
        Tue, 30 Nov 2021 16:07:15 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3cn5ey2839-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:15 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7DFo18481582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 506BDB209A;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34878B2091;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
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
        Denis Semakin <denis.semakin@huawei.com>
Subject: [RFC 17/20] ima: Use integrity_admin_ns_capable() to check corresponding capability
Date:   Tue, 30 Nov 2021 11:06:51 -0500
Message-Id: <20211130160654.1418231-18-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130160654.1418231-1-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s2aGokf7_edb40E58NOr039WG-427ibL
X-Proofpoint-ORIG-GUID: bO9JnrnDA_K5u2L7k0F-whjc2HbLO096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=831 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Denis Semakin <denis.semakin@huawei.com>

Use integrity_admin_ns_capable() to check corresponding capability to
allow read/write IMA policy without CAP_SYS_ADMIN but with
CAP_INTEGRITY_ADMIN.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
---
 security/integrity/ima/ima_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index fd2798f2d224..6766bb8262f2 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -393,7 +393,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		if (!integrity_admin_ns_capable(ns->user_ns))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
-- 
2.31.1

