Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7531A4AED
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2020 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDJUN4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Apr 2020 16:13:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgDJUNz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Apr 2020 16:13:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AK67uv035854
        for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2020 16:13:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 309212bu74-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2020 16:13:54 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Fri, 10 Apr 2020 21:13:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Apr 2020 21:13:30 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03AKDhSw54132968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Apr 2020 20:13:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18D02AE04D;
        Fri, 10 Apr 2020 20:13:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D51E4AE045;
        Fri, 10 Apr 2020 20:13:41 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.47.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Apr 2020 20:13:41 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH] powerpc/ima: fix secure boot rules in ima arch policy
Date:   Fri, 10 Apr 2020 16:13:38 -0400
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 20041020-0012-0000-0000-000003A22E08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041020-0013-0000-0000-000021DF5C38
Message-Id: <1586549618-6106-1-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_08:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To prevent verifying the kernel module appended signature twice
(finit_module), once by the module_sig_check() and again by IMA, powerpc
IMA secure boot rules define an IMA architecture specific policy rule
only if CONFIG_MODULE_SIG_FORCE is not enabled. This, unfortunately, does
not take into account the ability of enabling "sig_enforce" on the boot
command line (module.sig_enforce=1).

This patch fixes secure boot policy rules to be based on CONFIG_MODULE_SIG
instead.

Fixes: 4238fad366a6 ("powerpc/ima: Add support to initialize ima policy rules")
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/kernel/ima_arch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index e34116255ced..957abd592075 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -19,12 +19,12 @@ bool arch_ima_get_secureboot(void)
  * to be stored as an xattr or as an appended signature.
  *
  * To avoid duplicate signature verification as much as possible, the IMA
- * policy rule for module appraisal is added only if CONFIG_MODULE_SIG_FORCE
+ * policy rule for module appraisal is added only if CONFIG_MODULE_SIG
  * is not enabled.
  */
 static const char *const secure_rules[] = {
 	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
-#ifndef CONFIG_MODULE_SIG_FORCE
+#ifndef CONFIG_MODULE_SIG
 	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
 #endif
 	NULL
@@ -50,7 +50,7 @@ static const char *const secure_and_trusted_rules[] = {
 	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
 	"measure func=MODULE_CHECK template=ima-modsig",
 	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
-#ifndef CONFIG_MODULE_SIG_FORCE
+#ifndef CONFIG_MODULE_SIG
 	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
 #endif
 	NULL
-- 
2.25.1

