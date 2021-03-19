Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF13426A0
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Mar 2021 21:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCSUE5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Mar 2021 16:04:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8612 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229912AbhCSUEW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Mar 2021 16:04:22 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JK3PbM088662;
        Fri, 19 Mar 2021 16:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bK+JXs12xOWgzRK2d9NUjHcvEDRCeXPN3ChdaM5lhbk=;
 b=o/xZU6JNTXhqHix71J5GadNCkDfIWrN5yMZOl63XQu27mcYCGyNOWCU63/WUQtOSJFmF
 MPsZvY6v/POJmM06tK8CwJ4Ib1i3uOPWfKIqPjaNa1sTid1oEVCwc+zW5Mfu62eA3a/5
 1xUjWlKkbXGgAWL5raMU3jvzT9emZPg1f6tvspq/ZeLcE71AKJRJtChNvs2FRfNI9MWa
 Bexgb22V1m2rWNkX8QdogcN8RXaKVHGlPVKY/7qFAAK4Lk915zaBxLPixRLR0anxGqNi
 H1KrHw4ODV0Bikm/b0UH5DA/SBSLgsN19gK6UpET5xpkv8VChIKPQENg+/mmpKzjXIa5 iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c2vqnq3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 16:04:12 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12JK4BEm091537;
        Fri, 19 Mar 2021 16:04:11 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c2vqnq30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 16:04:11 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12JJwPAh016089;
        Fri, 19 Mar 2021 20:04:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 378n18b6gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 20:04:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12JK47Ex328356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 20:04:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01E645204F;
        Fri, 19 Mar 2021 20:04:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.211.66.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6164B52051;
        Fri, 19 Mar 2021 20:04:04 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-integrity@vger.kernel.org, Test <test@localhost.localdomain>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 1/2] ima: don't access a file's integrity status before an IMA policy is loaded
Date:   Fri, 19 Mar 2021 16:03:57 -0400
Message-Id: <20210319200358.22816-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Test <test@localhost.localdomain>

Only after an IMA policy is loaded, check, save, or update the cached
file's integrity status.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9ef748ea829f..9d1196f712e1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -606,6 +606,9 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
+	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+		return;
+
 	must_appraise = ima_must_appraise(mnt_userns, inode, MAY_ACCESS,
 					  FILE_CHECK);
 	if (!must_appraise)
@@ -636,6 +639,9 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
+	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+		return;
+
 	must_appraise = ima_must_appraise(mnt_userns, inode, MAY_ACCESS,
 					  FILE_CHECK);
 	if (!must_appraise)
-- 
2.27.0

