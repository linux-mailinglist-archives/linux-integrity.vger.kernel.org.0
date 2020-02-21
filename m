Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33FFA1686C9
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 19:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBUSjR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 13:39:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4346 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgBUSjR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 13:39:17 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LIO2oO094387
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y92xftskn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:15 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Feb 2020 18:39:13 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 18:39:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LIdA2P43909470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 18:39:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE6E7AE053;
        Fri, 21 Feb 2020 18:39:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBC9FAE045;
        Fri, 21 Feb 2020 18:39:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 18:39:09 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 4/8] ima-evm-utils: add support in tpm2_read_pcrs to read different TPM banks
Date:   Fri, 21 Feb 2020 13:38:54 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022118-0012-0000-0000-00000389153F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-0013-0000-0000-000021C5AFD2
Message-Id: <1582310338-1562-5-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=3 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=940 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm2_read_pcrs() reads the sha1 PCRs in order to verify the measurmeent
list.  This patch adds support for reading other TPM banks.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 61a0e15c8dd7..1eeab1d8268b 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1423,14 +1423,16 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 }
 
 #ifdef HAVE_TSSPCRREAD
-static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
+static int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+			 int len, char **errmsg)
 {
 	FILE *fp;
 	char pcr[100];	/* may contain an error */
 	char cmd[50];
 	int ret;
 
-	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns 2> /dev/null", idx);
+	sprintf(cmd, "tsspcrread -halg %s -ha %d -ns 2> /dev/null",
+		algo_name, idx);
 	fp = popen(cmd, "r");
 	if (!fp) {
 		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
@@ -1456,7 +1458,7 @@ static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
 		ret = -1;
 
 	if (!ret)
-		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
+		hex2bin(hwpcr, pcr, len);
 	else
 		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */
 
@@ -1885,7 +1887,8 @@ static int ima_measurement(const char *file)
 #ifdef HAVE_TSSPCRREAD
 			char *errmsg = NULL;
 
-			err = tpm2_pcr_read(i, hwpcr, sizeof(hwpcr), &errmsg);
+			err = tpm2_pcr_read("sha1", i, hwpcr, sizeof(hwpcr),
+					    &errmsg);
 			if (err) {
 				log_info("Failed to read PCRs: (%s)\n", errmsg);
 				free(errmsg);
-- 
2.7.5

