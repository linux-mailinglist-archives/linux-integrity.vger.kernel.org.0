Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C869344978
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Mar 2021 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCVPnK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 11:43:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230034AbhCVPmk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 11:42:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MFYCQb050623;
        Mon, 22 Mar 2021 11:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JSGjVlSecphP6Rjd5Yu8JmkAMUWPNySTAdpd2p4Iy40=;
 b=WmG9LedD/nB60DmtYU1RcobF8drhFu6Vo3N/rpDEGJnVTpR4NgTtYq/sxCfJdqds+9zZ
 D4hLG168AupmirTihXJOQ9J55IJKEfw7SbpdhSB7qEjYslImm7sQaYFvQN0vWuhbRX+q
 Ylqaf31ncJPeuJMw1yd6ENd5dW33jm8g6BDy9TLt9iYJ4CGo40Wj6bfczvVOZZImoOM/
 IChgSY6cFG3kfTqxi/d8N7lkl6GdQYJ+At9BD/riXk2hicCpRHOf8TX0ttU5b+7D3oU+
 soJKUsrv7eJoiXoEylJ2Q5j50tJFa6qawOrXRiJUk2Ydjpwg25Dsx57c8sN5+SpdLsA4 UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dwy5nede-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 11:42:30 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12MFai07061716;
        Mon, 22 Mar 2021 11:42:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dwy5nebs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 11:42:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12MFdP38005787;
        Mon, 22 Mar 2021 15:42:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rag6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 15:42:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12MFgPDM40567134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 15:42:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1EC24C046;
        Mon, 22 Mar 2021 15:42:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 718874C052;
        Mon, 22 Mar 2021 15:42:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.211.152.56])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Mar 2021 15:42:22 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/2] ima: don't access a file's integrity status before an IMA policy is loaded
Date:   Mon, 22 Mar 2021 11:42:06 -0400
Message-Id: <20210322154207.6802-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_08:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103220111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

