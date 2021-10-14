Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A842D9B1
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Oct 2021 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJNNGN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Oct 2021 09:06:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231300AbhJNNGN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Oct 2021 09:06:13 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EB24Nn007542;
        Thu, 14 Oct 2021 09:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RQwZSVnWRQfmUby1fOBEr0l1Q2Bj7qzzRHKtNjsAO6I=;
 b=bQaLuzpaMK+4ujE3LQv7M3fBh5QJd4TQmeDID4duiDNleklsk7Cuk236hqjTFoJapE07
 UJ1N6/KrzozD887FRmW2Tu8GMOEsf/mqSaCwyFyRg0m6Z627U+Cwf/i6wPG4zpRIgWyG
 c4Q+QaGY8UoS6wDkDZX8GzTkZ3TVrdk2Xv9bTrmRESO4px/fSc1JEaPOTPSvOoySJfxO
 lQNjtmRfNlFZsQddzBfH2ADb47JOXemCg6iQvmdQy5FXo2vGFjGMhqkQef36EDSUVChs
 bBzSRFZhhzfYdGDn0Od+exZpa2h45Cb4ubVODfWhEqZA1lZr8p2u/yr486YGs1yb0kd5 eQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnt94587f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 09:03:44 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19ECprG6005422;
        Thu, 14 Oct 2021 13:01:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3bk2qaacfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 13:01:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19ED1WcY47120886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 13:01:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6102A4053;
        Thu, 14 Oct 2021 13:01:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88633A4051;
        Thu, 14 Oct 2021 13:01:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.55.249])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Oct 2021 13:01:31 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v1 2/3] fs: extend the trusted_for syscall to call IMA
Date:   Thu, 14 Oct 2021 09:01:24 -0400
Message-Id: <20211014130125.6991-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211014130125.6991-1-zohar@linux.ibm.com>
References: <20211014130125.6991-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uFH-1qJrG5ogzbhdwb1f_520nqU1pz2B
X-Proofpoint-ORIG-GUID: uFH-1qJrG5ogzbhdwb1f_520nqU1pz2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_03,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=854
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend the trusted_for syscall to call the newly defined
ima_trusted_for hook.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/open.c           | 3 +++
 include/linux/ima.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index c79c138a638c..4d54e2a727e1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -585,6 +585,9 @@ SYSCALL_DEFINE3(trusted_for, const int, fd, const enum trusted_for_usage, usage,
 	err = inode_permission(file_mnt_user_ns(f.file), inode,
 			mask | MAY_ACCESS);
 
+	if (!err)
+		err = ima_trusted_for(f.file, usage);
+
 out_fd:
 	fdput(f);
 	return err;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index b6ab66a546ae..603df9932817 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -12,12 +12,15 @@
 #include <linux/security.h>
 #include <linux/kexec.h>
 #include <crypto/hash_info.h>
+#include <uapi/linux/trusted-for.h>
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
 extern enum hash_algo ima_get_current_hash_algo(void);
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
+extern int ima_trusted_for(struct file *file,
+			   const enum trusted_for_usage usage);
 extern void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 				    struct inode *inode);
 extern void ima_file_free(struct file *file);
@@ -81,6 +84,12 @@ static inline int ima_file_check(struct file *file, int mask)
 	return 0;
 }
 
+static inline int ima_trusted_for(struct file *file,
+				  const enum trusted_for_usage usage)
+{
+	return 0;
+}
+
 static inline void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 					   struct inode *inode)
 {
-- 
2.27.0

