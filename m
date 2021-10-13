Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C557042BE90
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 13:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhJMLFJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 07:05:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233281AbhJMLDu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 07:03:50 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DAW0BU031483;
        Wed, 13 Oct 2021 07:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RQwZSVnWRQfmUby1fOBEr0l1Q2Bj7qzzRHKtNjsAO6I=;
 b=UgcgaeDdUV9xyOLUYZdRckdknxm51/6aT+QiG7mg4JUOrmbtRmXZvUrKqvvMFpKyPA5/
 8HWcFVTnjy4x5HdDHReGnPr9K2ZJqEkE2AExs+1c5b2039YHAQhW5pnB0VtwsYbV/UQf
 8bE+2YU211SZQ6bU9Loq4b9LphiJ4sESioCrp7IaK5Rv13iPMMm+js3JaKZ1xY4y8J1J
 zK5LRznorWY3jxqZ9XBaml8I/Ex+zrrBOFdrhmqHQdRVgwsVOJS12cYcXHrt4d8FyTUe
 vXq9m7Uopy0K84F+q9bXI7PJ5ppEAPZE9zzQHcmhJRBiV+2WLFC0aUv+3yPVMuW9FtjM Yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnrnvq6a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 07:01:44 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DAxUbw018405;
        Wed, 13 Oct 2021 11:01:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9suqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 11:01:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DB1U8R42467588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 11:01:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9B95AE065;
        Wed, 13 Oct 2021 11:01:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F8A3AE075;
        Wed, 13 Oct 2021 11:01:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.27.171])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 11:01:25 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] fs: extend the trusted_for syscall to call IMA
Date:   Wed, 13 Oct 2021 07:01:13 -0400
Message-Id: <20211013110113.13239-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013110113.13239-1-zohar@linux.ibm.com>
References: <20211013110113.13239-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O4waY295CLi37fqO5kmV8ePeG0oJfs1r
X-Proofpoint-GUID: O4waY295CLi37fqO5kmV8ePeG0oJfs1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_03,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=858 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130071
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

