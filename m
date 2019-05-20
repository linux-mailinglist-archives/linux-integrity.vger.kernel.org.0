Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00255236CB
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2019 15:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbfETMQO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 08:16:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731553AbfETMQN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 08:16:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KCCPbM081748
        for <linux-integrity@vger.kernel.org>; Mon, 20 May 2019 08:16:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sks8nqp91-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 20 May 2019 08:16:12 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 20 May 2019 13:16:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 May 2019 13:16:07 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4KCG7OO43974680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 12:16:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D9FA4054;
        Mon, 20 May 2019 12:16:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71463A4062;
        Mon, 20 May 2019 12:16:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.87])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 May 2019 12:16:06 +0000 (GMT)
Subject: [PATCH] x86/ima: check EFI SetupMode too
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>
Date:   Mon, 20 May 2019 08:15:55 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052012-0012-0000-0000-0000031D9157
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052012-0013-0000-0000-000021563DB3
Message-Id: <1558354555.4507.98.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=853 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200085
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Checking "SecureBoot" mode is not sufficient, also check "SetupMode".

Fixes: 399574c64eaf ("x86/ima: retry detecting secure boot mode")
Reported-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 arch/x86/kernel/ima_arch.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 64b973f0e985..4c407833faca 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -11,10 +11,11 @@ extern struct boot_params boot_params;
 static enum efi_secureboot_mode get_sb_mode(void)
 {
 	efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
+	efi_char16_t efi_SetupMode_name[] = L"SecureBoot";
 	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
 	efi_status_t status;
 	unsigned long size;
-	u8 secboot;
+	u8 secboot, setupmode;
 
 	size = sizeof(secboot);
 
@@ -36,7 +37,14 @@ static enum efi_secureboot_mode get_sb_mode(void)
 		return efi_secureboot_mode_unknown;
 	}
 
-	if (secboot == 0) {
+	size = sizeof(setupmode);
+	status = efi.get_variable(efi_SetupMode_name, &efi_variable_guid,
+				  NULL, &size, &setupmode);
+
+	if (status != EFI_SUCCESS)	/* ignore unknown SetupMode */
+		setupmode = 0;
+
+	if (secboot == 0 || setupmode == 1) {
 		pr_info("ima: secureboot mode disabled\n");
 		return efi_secureboot_mode_disabled;
 	}
-- 
2.7.5

