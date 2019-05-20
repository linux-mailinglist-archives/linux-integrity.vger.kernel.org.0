Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47EA237AB
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2019 15:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfETMyD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 08:54:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731662AbfETMyC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 08:54:02 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KChnS3035360
        for <linux-integrity@vger.kernel.org>; Mon, 20 May 2019 08:54:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2skvebrfcv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 20 May 2019 08:54:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 20 May 2019 13:53:59 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 May 2019 13:53:57 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4KCruKx25428168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 12:53:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A444C04E;
        Mon, 20 May 2019 12:53:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5EA34C046;
        Mon, 20 May 2019 12:53:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.87])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 May 2019 12:53:55 +0000 (GMT)
Subject: [PATCH] x86/ima: check EFI SetupMode too
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Matthew Garrett <mjg59@google.com>
Date:   Mon, 20 May 2019 08:53:45 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052012-0008-0000-0000-000002E8925B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052012-0009-0000-0000-00002255443F
Message-Id: <1558356825.4507.103.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=937 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200087
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Resending because it didn't make it to the list.] 

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

