Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041C81C1787
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2020 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgEAORP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 May 2020 10:17:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728840AbgEAORO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 May 2020 10:17:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041EDOVo167060;
        Fri, 1 May 2020 10:17:02 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r825ts9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 10:17:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041EG4uh013887;
        Fri, 1 May 2020 14:17:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5vu75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 14:17:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041EGvQp57016532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 14:16:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50247AE045;
        Fri,  1 May 2020 14:16:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA5C9AE053;
        Fri,  1 May 2020 14:16:55 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.65.217.16])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 14:16:55 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2] powerpc/ima: fix secure boot rules in ima arch policy
Date:   Fri,  1 May 2020 10:16:52 -0400
Message-Id: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_07:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010107
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To prevent verifying the kernel module appended signature twice
(finit_module), once by the module_sig_check() and again by IMA, powerpc
secure boot rules define an IMA architecture specific policy rule
only if CONFIG_MODULE_SIG_FORCE is not enabled. This, unfortunately, does
not take into account the ability of enabling "sig_enforce" on the boot
command line (module.sig_enforce=1).

Including the IMA module appraise rule results in failing the finit_module
syscall, unless the module signing public key is loaded onto the IMA
keyring.

This patch fixes secure boot policy rules to be based on CONFIG_MODULE_SIG
instead.

Fixes: 4238fad366a6 ("powerpc/ima: Add support to initialize ima policy rules")
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
v2:
* Fixes the patch description to specify the problem more clearly as asked 
by Michael Ellerman.

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
2.18.1

