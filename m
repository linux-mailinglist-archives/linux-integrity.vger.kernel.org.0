Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4DD1686C8
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 19:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgBUSjQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 13:39:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbgBUSjQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 13:39:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LIKcip109979
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:14 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y9tkdacwe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:14 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Feb 2020 18:39:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 18:39:09 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LId8DT45744364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 18:39:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ECC7AE053;
        Fri, 21 Feb 2020 18:39:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55238AE045;
        Fri, 21 Feb 2020 18:39:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 18:39:07 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 2/8] ima-evm-utils: increase the size of "zero" and "fox" variables
Date:   Fri, 21 Feb 2020 13:38:52 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022118-4275-0000-0000-000003A443FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-4276-0000-0000-000038B853EA
Message-Id: <1582310338-1562-3-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=1 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=918 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Opening a file for write when it is already opened for read, results in
a time of measure, time of use (ToMToU) error.  Similarly, when opening
a file for read, when it is already opened for write, results in a file
measurement error.  These violations are flagged by including 0x00's as
the template digest in the measurement list, but extending the TPM with
0xFF's.

In preparation of extending the TPM banks with bank specific digest
values, increase the "zero" and "fox" variable sizes.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 704615694cec..9c8544a95b6a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1477,8 +1477,8 @@ struct template_entry {
 	int template_buf_len;
 };
 
-static uint8_t zero[SHA_DIGEST_LENGTH];
-static uint8_t fox[SHA_DIGEST_LENGTH];
+static uint8_t zero[MAX_DIGEST_SIZE];
+static uint8_t fox[MAX_DIGEST_SIZE];
 
 int validate = 1;
 
@@ -1499,7 +1499,7 @@ static int ima_verify_template_hash(struct template_entry *entry)
 {
 	uint8_t digest[SHA_DIGEST_LENGTH];
 
-	if (!memcmp(zero, entry->header.digest, sizeof(zero)))
+	if (!memcmp(zero, entry->header.digest, sizeof(digest)))
 		return 0;
 
 	SHA1(entry->template, entry->template_len, digest);
@@ -1658,8 +1658,8 @@ static int ima_measurement(const char *file)
 	int i;
 
 	errno = 0;
-	memset(zero, 0, SHA_DIGEST_LENGTH);
-	memset(fox, 0xff, SHA_DIGEST_LENGTH);
+	memset(zero, 0, MAX_DIGEST_SIZE);
+	memset(fox, 0xff, MAX_DIGEST_SIZE);
 
 	log_debug("Initial PCR value: ");
 	log_debug_dump(pcr, sizeof(pcr));
-- 
2.7.5

