Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB61A2252AB
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jul 2020 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgGSQCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Jul 2020 12:02:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgGSQCX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Jul 2020 12:02:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06JFX361068428;
        Sun, 19 Jul 2020 12:02:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvcs495d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 12:02:20 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06JFohcM101047;
        Sun, 19 Jul 2020 12:02:20 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvcs494n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 12:02:20 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06JG1bdj008653;
        Sun, 19 Jul 2020 16:02:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 32brbh1em4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 16:02:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06JG2GbS62456146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Jul 2020 16:02:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10C39AE057;
        Sun, 19 Jul 2020 16:02:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B947AE04D;
        Sun, 19 Jul 2020 16:02:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.54])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 19 Jul 2020 16:02:15 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 1/3] ima-evm-utils: similarly add sanity check for file parameter of TPM 1.2 PCRs
Date:   Sun, 19 Jul 2020 12:02:02 -0400
Message-Id: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-19_03:2020-07-17,2020-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007190119
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Parameter expects to be a copy of /sys/class/tpm/tpm0/device/pcrs (i.e.
regular file, not a directory, block or character device, socket, ...)

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 0f1c5a023516..06a2ffb879d9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1379,14 +1379,26 @@ static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
 /* Read all of the TPM 1.2 PCRs */
 static int tpm_pcr_read(struct tpm_bank_info *tpm_banks, int len)
 {
+	struct stat s;
 	FILE *fp = NULL;
 	char *p, pcr_str[8], buf[70]; /* length of the TPM string */
 	int result = -1;
 	int i = 0;
 
 	/* Use the provided TPM 1.2 pcrs file */
-	if (pcrfile)
+	if (pcrfile) {
+		if (stat(pcrfile, &s) == -1) {
+			errno = 0;
+			return 1;
+		}
+
+		if (!S_ISREG(s.st_mode)) {
+			log_info("TPM 1.2 PCR file: not a regular file or link to regular file\n");
+			return 1;
+		}
+
 		fp = fopen(pcrfile, "r");
+	}
 
 	if (!fp)
 		fp = fopen(pcrs, "r");
-- 
2.7.5

