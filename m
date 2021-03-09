Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F856331D60
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 04:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhCIDUT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Mar 2021 22:20:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229497AbhCIDUF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Mar 2021 22:20:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12934muX186976;
        Mon, 8 Mar 2021 22:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2d0WAZinEuJOPbJAkL64nMb6zFdaqdv/rb34gsHFNjM=;
 b=hdrFrFsPDv8rsxRpccl1B5NgYLnJIb2Iu1tK9lmabEeiSK//z2TCbdBoI/Hki8esjK9c
 anTFcIaCYZfboyMm3U1I2/YcEzqGtsyUP2M4B5925Pk7HYWOMhoWrBZ/Zb6FjCBjzbqL
 0O0NTXgAThzlJk8si2j4uf5re1RyuHXVIRNcUFtQyTJOn1JjD+wAyxFKsWWJzcfJgGNT
 8DaWG8jqztRAL2Er0pAr1aLO59hWu/lVhw+Nl4SW4NVCM03ss/18J98KqR2nqnP96Qk0
 0Y6D7nGIGFq66FCrv72luRNE+yx2wV3nkPckNFmgNtCaC/5V97GYKpSDk7bHLN3j3ypo CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 375wmjc2km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 22:20:03 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 129353Yh187822;
        Mon, 8 Mar 2021 22:20:02 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 375wmjc2kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 22:20:02 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1293CrVa032256;
        Tue, 9 Mar 2021 03:20:02 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3741c9843v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 03:20:02 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1293K0gT14942506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 03:20:01 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAF28BE062;
        Tue,  9 Mar 2021 03:20:00 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48082BE056;
        Tue,  9 Mar 2021 03:20:00 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 03:20:00 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/3] tpm: efi: Use local variable for calculating final log size
Date:   Mon,  8 Mar 2021 22:19:52 -0500
Message-Id: <20210309031954.6232-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309031954.6232-1-stefanb@linux.ibm.com>
References: <20210309031954.6232-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_22:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When tpm_read_log_efi was called multiple times, which happens when one
loads and unloads a TPM2 driver multiple times, then the global variable
efi_tpm_final_log_size will at some point become a negative number due
to the subtraction of final_events_preboot_size occurring each time. Use
a local_efi_tpm_final_log_size to avoid this integer underflow.

The following issue is now resolved:

Mar  8 15:35:12 hibinst kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
Mar  8 15:35:12 hibinst kernel: Workqueue: tpm-vtpm vtpm_proxy_work [tpm_vtpm_proxy]
Mar  8 15:35:12 hibinst kernel: RIP: 0010:__memcpy+0x12/0x20
Mar  8 15:35:12 hibinst kernel: Code: 00 b8 01 00 00 00 85 d2 74 0a c7 05 44 7b ef 00 0f 00 00 00 c3 cc cc cc 66 66 90 66 90 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4
Mar  8 15:35:12 hibinst kernel: RSP: 0018:ffff9ac4c0fcfde0 EFLAGS: 00010206
Mar  8 15:35:12 hibinst kernel: RAX: ffff88f878cefed5 RBX: ffff88f878ce9000 RCX: 1ffffffffffffe0f
Mar  8 15:35:12 hibinst kernel: RDX: 0000000000000003 RSI: ffff9ac4c003bff9 RDI: ffff88f878cf0e4d
Mar  8 15:35:12 hibinst kernel: RBP: ffff9ac4c003b000 R08: 0000000000001000 R09: 000000007e9d6073
Mar  8 15:35:12 hibinst kernel: R10: ffff9ac4c003b000 R11: ffff88f879ad3500 R12: 0000000000000ed5
Mar  8 15:35:12 hibinst kernel: R13: ffff88f878ce9760 R14: 0000000000000002 R15: ffff88f77de7f018
Mar  8 15:35:12 hibinst kernel: FS:  0000000000000000(0000) GS:ffff88f87bd00000(0000) knlGS:0000000000000000
Mar  8 15:35:12 hibinst kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar  8 15:35:12 hibinst kernel: CR2: ffff9ac4c003c000 CR3: 00000001785a6004 CR4: 0000000000060ee0
Mar  8 15:35:12 hibinst kernel: Call Trace:
Mar  8 15:35:12 hibinst kernel: tpm_read_log_efi+0x152/0x1a7
Mar  8 15:35:12 hibinst kernel: tpm_bios_log_setup+0xc8/0x1c0
Mar  8 15:35:12 hibinst kernel: tpm_chip_register+0x8f/0x260
Mar  8 15:35:12 hibinst kernel: vtpm_proxy_work+0x16/0x60 [tpm_vtpm_proxy]
Mar  8 15:35:12 hibinst kernel: process_one_work+0x1b4/0x370
Mar  8 15:35:12 hibinst kernel: worker_thread+0x53/0x3e0
Mar  8 15:35:12 hibinst kernel: ? process_one_work+0x370/0x370

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/eventlog/efi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 35229e5143ca..b6ffb5faf416 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -18,6 +18,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 
 	struct efi_tcg2_final_events_table *final_tbl = NULL;
 	struct linux_efi_tpm_eventlog *log_tbl;
+	int local_efi_tpm_final_log_size;
 	struct tpm_bios_log *log;
 	u32 log_size;
 	u8 tpm_log_version;
@@ -80,10 +81,11 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 		goto out;
 	}
 
-	efi_tpm_final_log_size -= log_tbl->final_events_preboot_size;
+	local_efi_tpm_final_log_size = efi_tpm_final_log_size -
+					log_tbl->final_events_preboot_size;
 
 	tmp = krealloc(log->bios_event_log,
-		       log_size + efi_tpm_final_log_size,
+		       log_size + local_efi_tpm_final_log_size,
 		       GFP_KERNEL);
 	if (!tmp) {
 		kfree(log->bios_event_log);
@@ -100,9 +102,9 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	 */
 	memcpy((void *)log->bios_event_log + log_size,
 	       final_tbl->events + log_tbl->final_events_preboot_size,
-	       efi_tpm_final_log_size);
+	       local_efi_tpm_final_log_size);
 	log->bios_event_log_end = log->bios_event_log +
-		log_size + efi_tpm_final_log_size;
+		log_size + local_efi_tpm_final_log_size;
 
 out:
 	memunmap(final_tbl);
-- 
2.29.2

