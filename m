Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F215226
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEFQ6J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 12:58:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726985AbfEFQ5y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 12:57:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46GqQWp176503
        for <linux-integrity@vger.kernel.org>; Mon, 6 May 2019 12:57:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2saqrh35s8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 12:57:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 May 2019 17:57:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 17:57:49 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46Gvmhl62586934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 16:57:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19BC9A4040;
        Mon,  6 May 2019 16:57:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34EC3A404D;
        Mon,  6 May 2019 16:57:47 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.95.145])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 16:57:47 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 2/3] ima: prevent a file already mmap'ed write to be mmap'ed execute
Date:   Mon,  6 May 2019 12:57:03 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1557161824-6623-1-git-send-email-zohar@linux.ibm.com>
References: <1557161824-6623-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050616-0008-0000-0000-000002E3DF89
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050616-0009-0000-0000-0000225058CB
Message-Id: <1557161824-6623-3-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel calls deny_write_access() to prevent a file already opened
for write from being executed and also prevents files being executed
from being opened for write.  For some reason this does not extend to
files being mmap'ed execute.

From an IMA perspective, measuring/appraising the integrity of a file
being mmap'ed execute, without first making sure the file cannot be
modified, makes no sense.  This patch prevents files, in policy, already
mmap'ed write, from being mmap'ed execute.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..ae77d13cb43c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -72,6 +72,27 @@ static int __init hash_setup(char *str)
 }
 __setup("ima_hash=", hash_setup);
 
+/* Prevent mmap'ing a file execute that is already mmap'ed write */
+static int mmap_violation_check(enum ima_hooks func, struct file *file,
+				char **pathbuf, const char **pathname,
+				char *filename)
+{
+	struct inode *inode;
+	int rc = 0;
+
+	if ((func == MMAP_CHECK) && mapping_writably_mapped(file->f_mapping)) {
+		rc = -ETXTBSY;
+		inode = file_inode(file);
+
+		if (!*pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
+			*pathname = ima_d_path(&file->f_path, pathbuf,
+					       filename);
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathname,
+				    "mmap_file", "mmapped_writers", rc, 0);
+	}
+	return rc;
+}
+
 /*
  * ima_rdwr_violation_check
  *
@@ -270,8 +291,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	/* Nothing to do, just return existing appraised status */
 	if (!action) {
-		if (must_appraise)
-			rc = ima_get_cache_status(iint, func);
+		if (must_appraise) {
+			rc = mmap_violation_check(func, file, &pathbuf,
+						  &pathname, filename);
+			if (!rc)
+				rc = ima_get_cache_status(iint, func);
+		}
 		goto out_locked;
 	}
 
@@ -298,6 +323,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len);
 		inode_unlock(inode);
+
+		rc = mmap_violation_check(func, file, &pathbuf, &pathname,
+					  filename);
 	}
 	if (action & IMA_AUDIT)
 		ima_audit_measurement(iint, pathname);
-- 
2.7.5

