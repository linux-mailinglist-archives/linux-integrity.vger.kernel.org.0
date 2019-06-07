Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA939551
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 21:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfFGTMY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 15:12:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728783AbfFGTMY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 15:12:24 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x57J1ZhT087182
        for <linux-integrity@vger.kernel.org>; Fri, 7 Jun 2019 15:12:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sywfqs0qh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jun 2019 15:12:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Fri, 7 Jun 2019 20:12:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Jun 2019 20:12:18 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x57JCG9x39321786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jun 2019 19:12:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 666D35204F;
        Fri,  7 Jun 2019 19:12:16 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.199.252])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6018C52052;
        Fri,  7 Jun 2019 19:12:15 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>
Subject: [PATCH] x86/ima: fix the Kconfig dependency for IMA_ARCH_POLICY
Date:   Fri,  7 Jun 2019 15:12:06 -0400
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19060719-4275-0000-0000-000003405B06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060719-4276-0000-0000-000038506435
Message-Id: <1559934726-18650-1-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=835 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If enabled, ima arch specific policies always adds the measurements rules,
this makes it dependent on CONFIG_IMA. CONFIG_IMA_APPRAISE implicitly takes
care of this, however it is needed explicitly for CONFIG_KEXEC_VERIFY_SIG.

This patch adds the CONFIG_IMA dependency in combination with
CONFIG_KEXEC_VERIFY_SIG for CONFIG_IMA_ARCH_POLICY

Fixes: d958083a8f640 (x86/ima: define arch_get_ima_policy() for x86)
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
---
 security/integrity/ima/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a18f8c6d13b5..df65d2d41905 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -159,7 +159,8 @@ config IMA_APPRAISE
 
 config IMA_ARCH_POLICY
         bool "Enable loading an IMA architecture specific policy"
-        depends on KEXEC_VERIFY_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+        depends on (KEXEC_VERIFY_SIG && IMA) || IMA_APPRAISE \
+		   && INTEGRITY_ASYMMETRIC_KEYS
         default n
         help
           This option enables loading an IMA architecture specific policy
-- 
2.17.1

