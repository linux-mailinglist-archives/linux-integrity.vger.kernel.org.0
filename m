Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9763D21BA2F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgGJQBR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:01:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727901AbgGJQBQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AFVvEk034066;
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpbhfrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:13 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFW1d2034558;
        Fri, 10 Jul 2020 12:01:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpbhfqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AG1Bn4002571;
        Fri, 10 Jul 2020 16:01:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 326bch8rqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:01:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AG18N563701092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:01:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3BF34203F;
        Fri, 10 Jul 2020 16:01:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2702442041;
        Fri, 10 Jul 2020 16:01:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:08 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 4/8] ima-evm-utils: emit "ima_measurement" messages based on log level
Date:   Fri, 10 Jul 2020 12:00:55 -0400
Message-Id: <1594396859-9232-5-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_10:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=1
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

"ima_measurement" emits quite a few messages.  Only a few messages
belong at the default log level.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 21ae1c7ca5a7..fac6a270794f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1638,21 +1638,27 @@ static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
 			if (memcmp(bank[i].pcr[j], zero, bank[i].digest_size)
 			    == 0)
 				continue;
+
+			if (memcmp(bank[i].pcr[j], tpm_bank[i].pcr[j],
+				     bank[i].digest_size) != 0)
+				ret = 1;
+
+			if ((!ret && imaevm_params.verbose <= LOG_INFO) ||
+			    (ret && imaevm_params.verbose <= LOG_DEBUG))
+				continue;
+
 			log_info("%s: PCRAgg  %d: ", bank[i].algo_name, j);
 			log_dump(bank[i].pcr[j], bank[i].digest_size);
 
 			log_info("%s: TPM PCR-%d: ", tpm_bank[i].algo_name, j);
 			log_dump(tpm_bank[i].pcr[j], tpm_bank[i].digest_size);
 
-			if (memcmp(bank[i].pcr[j], tpm_bank[i].pcr[j],
-				     bank[i].digest_size) == 0) {
+			if (!ret)
 				log_info("%s PCR-%d: succeed\n",
 					 bank[i].algo_name, j);
-			} else {
-				ret = 1;
+			else
 				log_info("%s: PCRAgg %d does not match TPM PCR-%d\n",
 					 bank[i].algo_name, j, j);
-			}
 		}
 	}
 	return ret;
@@ -1997,15 +2003,20 @@ static int ima_measurement(const char *file)
 		err = 0;
 		log_info("Failed to read any TPM PCRs\n");
 	} else {
-		log_info("Comparing with per TPM digest\n");
 		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
+		if (!err)
+			log_info("Matched per TPM bank calculated digest(s).\n");
 
 		/* On failure, check older SHA1 zero padded hashes */
 		if (err) {
-			log_info("Comparing with SHA1 padded digest\n");
 			err = compare_tpm_banks(num_banks, pseudo_padded_banks,
 						tpm_banks);
+			if (!err)
+				log_info("Matched SHA1 padded TPM digest(s).\n");
 		}
+
+		if (err)
+			log_info("Failed to match per TPM bank or SHA1 padded TPM digest(s).\n");
 	}
 
 out:
-- 
2.7.5

