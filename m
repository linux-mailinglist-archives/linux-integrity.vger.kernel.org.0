Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2661521F
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfEFQ5y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 12:57:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726608AbfEFQ5x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 12:57:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46GqTlZ123403
        for <linux-integrity@vger.kernel.org>; Mon, 6 May 2019 12:57:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2saq79n0y8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 12:57:52 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 May 2019 17:57:50 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 17:57:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46GvlVs43843706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 16:57:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05750A4059;
        Mon,  6 May 2019 16:57:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14EB6A4051;
        Mon,  6 May 2019 16:57:46 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.95.145])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 16:57:45 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/3] ima: verify mprotect change is consistent with mmap policy
Date:   Mon,  6 May 2019 12:57:02 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1557161824-6623-1-git-send-email-zohar@linux.ibm.com>
References: <1557161824-6623-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050616-0028-0000-0000-0000036AE60D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050616-0029-0000-0000-0000242A5C11
Message-Id: <1557161824-6623-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=786 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA can be configured to measure and appraise a file's integrity being
mmap'ed execute.  Files can be mmap'ed read/write and later changed to
execute to circumvent IMA's mmap measurement and appraisal policy rules.

To prevent this from happening, this patch similarly calls
ima_file_mmap() for mprotect changes.

Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/security.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 23cbb1a295a3..98ce27933e72 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1411,7 +1411,12 @@ int security_mmap_addr(unsigned long addr)
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			    unsigned long prot)
 {
-	return call_int_hook(file_mprotect, 0, vma, reqprot, prot);
+	int ret;
+
+	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
+	if (ret)
+		return ret;
+	return ima_file_mmap(vma->vm_file, prot);
 }
 
 int security_file_lock(struct file *file, unsigned int cmd)
-- 
2.7.5

