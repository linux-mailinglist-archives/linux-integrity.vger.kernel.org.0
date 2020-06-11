Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9AC1F6681
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgFKLVG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jun 2020 07:21:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727907AbgFKLVG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jun 2020 07:21:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BB3s5G029997;
        Thu, 11 Jun 2020 07:20:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31khbym853-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 07:20:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BBFXcp001911;
        Thu, 11 Jun 2020 11:20:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s81gh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 11:20:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05BBJwBt63897802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 11:19:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4FE3A4069;
        Thu, 11 Jun 2020 11:19:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 056FAA405C;
        Thu, 11 Jun 2020 11:19:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.183.79])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jun 2020 11:19:57 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: [PATCH] ima: fix mprotect checking
Date:   Thu, 11 Jun 2020 07:19:23 -0400
Message-Id: <1591874363-28939-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_10:2020-06-10,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 cotscore=-2147483648 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=1 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110086
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Make sure IMA is enabled before checking mprotect change.  Addresses
report of a 3.7% regression of boot-time.dhcp.

Fixes: 8eb613c0b8f1 ("ima: verify mprotect change is consistent with mmap policy")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 800fb3bba418..c1583d98c5e5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -419,7 +419,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
-	if (!vma->vm_file || !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
+	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
+	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
 	security_task_getsecid(current, &secid);
-- 
2.7.5

