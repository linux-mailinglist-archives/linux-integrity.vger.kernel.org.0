Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191D821BA30
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgGJQBR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:01:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbgGJQBQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AFWoLV156659;
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk8ur8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFXGwG159652;
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk8uph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:13 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AG0lqh003422;
        Fri, 10 Jul 2020 16:01:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 326bc30rk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:01:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AG197763111332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:01:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7320F4204C;
        Fri, 10 Jul 2020 16:01:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D72B14203F;
        Fri, 10 Jul 2020 16:01:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:08 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 5/8] ima-evm-utils: guarantee the measurement list contains all the records
Date:   Fri, 10 Jul 2020 12:00:56 -0400
Message-Id: <1594396859-9232-6-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_10:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007100104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reading the TPM PCRs before walking the measurement list guarantees
the measurement list contains all the records.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index fac6a270794f..5787887882b4 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1876,6 +1876,7 @@ static int ima_measurement(const char *file)
 	struct tpm_bank_info *tpm_banks;
 	int is_ima_template, cur_template_fmt;
 	int num_banks = 0;
+	int tpmbanks = 1;
 	int first_record = 1;
 
 	struct template_entry entry = { .template = 0 };
@@ -1901,6 +1902,14 @@ static int ima_measurement(const char *file)
 	else				/* assume read pubkey from x509 cert */
 		init_public_keys("/etc/keys/x509_evm.der");
 
+	/*
+	 * Reading the PCRs before walking the IMA measurement list
+	 * guarantees that all of the measurements are included in
+	 * the PCRs.
+	 */
+	if (read_tpm_banks(num_banks, tpm_banks) != 0)
+		tpmbanks = 0;
+
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
 		if (entry.header.name_len > TCG_EVENT_NAME_LEN_MAX) {
 			log_err("%d ERROR: event name too long!\n",
@@ -1999,10 +2008,9 @@ static int ima_measurement(const char *file)
 			ima_ng_show(&entry);
 	}
 
-	if (read_tpm_banks(num_banks, tpm_banks) != 0) {
-		err = 0;
+	if (tpmbanks == 0)
 		log_info("Failed to read any TPM PCRs\n");
-	} else {
+	else {
 		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
 		if (!err)
 			log_info("Matched per TPM bank calculated digest(s).\n");
-- 
2.7.5

