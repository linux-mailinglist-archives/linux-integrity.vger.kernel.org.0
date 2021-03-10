Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B74334B6A
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 23:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhCJWTv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 17:19:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232177AbhCJWT1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 17:19:27 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AMJPoG080888;
        Wed, 10 Mar 2021 17:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kVgwSvq8dluP885Ow6BV488HoWQExJIS3NDuXxsYwPc=;
 b=Ozo1qPDKl+UmXk0xRVHwihnMAGbSFabDQnKJOEpbnNsndGkWLEQdNfvxekiI7ZKyTiI3
 6nMceDBUI+eo5NTcerEMliisg127IznjJpj5xHM+Lp/cXK6omsCKAgt40d8O26dBS4YY
 Vh9NaJPwxDb3XveUJt2I1XUpDX05f3mJOg2++y1+lcUTA+a/FD0pUvIzjsdwVeV0MTvE
 vVIdHQ9Zi+MYAs2gO5UpUpFCXjY4D4tPNtOSHQNK19597QJLnwt90OzOMPlhNwO35H+T
 OkeB71zFu91K6FZvakPKbwlwy0roWGdKcvPLvf01C1RvTSoOws/rhn+dj3t8g+TZdrjR Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774mdupyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:19:26 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AMJPDg080829;
        Wed, 10 Mar 2021 17:19:25 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774mdupx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:19:25 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AMHOMk009190;
        Wed, 10 Mar 2021 22:19:20 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3768s25yct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 22:19:20 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AMJJa427066706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 22:19:19 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61D3CAE05F;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49939AE067;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/3] tpm: efi: Use local variable for calculating final log size
Date:   Wed, 10 Mar 2021 17:19:14 -0500
Message-Id: <20210310221916.356716-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210310221916.356716-1-stefanb@linux.ibm.com>
References: <20210310221916.356716-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_12:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When tpm_read_log_efi is called multiple times, which happens when
one loads and unloads a TPM2 driver multiple times, then the global
variable efi_tpm_final_log_size will at some point become a negative
number due to the subtraction of final_events_preboot_size occurring
each time. Use a local variable to avoid this integer underflow.

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
 drivers/char/tpm/eventlog/efi.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 35229e5143ca..e6cb9d525e30 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -17,6 +17,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 {
 
 	struct efi_tcg2_final_events_table *final_tbl = NULL;
+	int final_events_log_size = efi_tpm_final_log_size;
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct tpm_bios_log *log;
 	u32 log_size;
@@ -66,12 +67,12 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	ret = tpm_log_version;
 
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
-	    efi_tpm_final_log_size == 0 ||
+	    final_events_log_size == 0 ||
 	    tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
 		goto out;
 
 	final_tbl = memremap(efi.tpm_final_log,
-			     sizeof(*final_tbl) + efi_tpm_final_log_size,
+			     sizeof(*final_tbl) + final_events_log_size,
 			     MEMREMAP_WB);
 	if (!final_tbl) {
 		pr_err("Could not map UEFI TPM final log\n");
@@ -80,10 +81,18 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 		goto out;
 	}
 
-	efi_tpm_final_log_size -= log_tbl->final_events_preboot_size;
+	/*
+	 * The 'final events log' size excludes the 'final events preboot log'
+	 * at its beginning.
+	 */
+	final_events_log_size -= log_tbl->final_events_preboot_size;
 
+	/*
+	 * Allocate memory for the 'combined log' where we will append the
+	 * 'final events log' to.
+	 */
 	tmp = krealloc(log->bios_event_log,
-		       log_size + efi_tpm_final_log_size,
+		       log_size + final_events_log_size,
 		       GFP_KERNEL);
 	if (!tmp) {
 		kfree(log->bios_event_log);
@@ -94,15 +103,19 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	log->bios_event_log = tmp;
 
 	/*
-	 * Copy any of the final events log that didn't also end up in the
-	 * main log. Events can be logged in both if events are generated
+	 * Append any of the 'final events log' that didn't also end up in the
+	 * 'main log'. Events can be logged in both if events are generated
 	 * between GetEventLog() and ExitBootServices().
 	 */
 	memcpy((void *)log->bios_event_log + log_size,
 	       final_tbl->events + log_tbl->final_events_preboot_size,
-	       efi_tpm_final_log_size);
+	       final_events_log_size);
+	/*
+	 * The size of the 'combined log' is the size of the 'main log' plus
+	 * the size of the 'final events log'.
+	 */
 	log->bios_event_log_end = log->bios_event_log +
-		log_size + efi_tpm_final_log_size;
+		log_size + final_events_log_size;
 
 out:
 	memunmap(final_tbl);
-- 
2.29.2

