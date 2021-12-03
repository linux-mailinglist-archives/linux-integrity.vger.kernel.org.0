Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B4466FE8
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378318AbhLCCfg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:35:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1378152AbhLCCfW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31nCB6026032;
        Fri, 3 Dec 2021 02:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LHZvxuk+acd/BERYtogpkfL18BmpFVKnHWj1YcQoIOU=;
 b=PzH44tyMCXFU51m1ymBqEl2OnnhWJcWN7Xc6uXLwthmW/mUo50FafYLtGHfegBs/Vmqv
 JlZuKa7Y+DdLeyn5+b1/GXyEFnOT0aSAc225DbLldc3on/wrWX4JEyJyR1/HKywf38zl
 qk1jpTK4kxfBaKNKCNfFpZrkRpaO6i7HXrTgNU7JKJBNW+a+hvqSSD2Jz7p4tFgLlkqV
 sOtRO+IounvVlYGe1lzGfvdxoHxPoOi0lpK62+8CfqLAuGC3sSC0C0YmOIWPJUnbvXZF
 SdldxSgXAj7XS9ThFxJsVFsq8gkkq7xNIGMLvg5y9/hI/ohG3u/jro5gjHk38mufeQx9 jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq9wb8kk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:49 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32FMHG015277;
        Fri, 3 Dec 2021 02:31:48 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq9wb8kk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:48 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32SNFc014623;
        Fri, 3 Dec 2021 02:31:47 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3cn3k3k5ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:47 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32Vk6l56230164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:46 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEED56E092;
        Fri,  3 Dec 2021 02:31:45 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1A506E059;
        Fri,  3 Dec 2021 02:31:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:44 +0000 (GMT)
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
Subject: [RFC v2 16/19] ima: Use integrity_admin_ns_capable() to check corresponding capability
Date:   Thu,  2 Dec 2021 21:31:15 -0500
Message-Id: <20211203023118.1447229-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cVYh-xxCDc3_fE1cZstz4MyJ2d4UHxhr
X-Proofpoint-GUID: 6ZCV_KnOtbqnV4G2rULZanO4Ewl_yh2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_16,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=900 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use integrity_admin_ns_capable() to check corresponding capability to
allow read/write IMA policy without CAP_SYS_ADMIN but with
CAP_INTEGRITY_ADMIN.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 6c86f81c9998..6766bb8262f2 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -393,7 +393,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!integrity_admin_ns_capable(ns->user_ns))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
-- 
2.31.1

