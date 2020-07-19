Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560132252AC
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jul 2020 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgGSQCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Jul 2020 12:02:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22414 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgGSQCY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Jul 2020 12:02:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06JFXPmm088482;
        Sun, 19 Jul 2020 12:02:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvy3bqq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 12:02:21 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06JFmTnV114328;
        Sun, 19 Jul 2020 12:02:21 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvy3bqp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 12:02:21 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06JG0V8r019802;
        Sun, 19 Jul 2020 16:02:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 32brq80qek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 16:02:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06JG2GfH65208788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Jul 2020 16:02:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF18BAE053;
        Sun, 19 Jul 2020 16:02:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D233AE058;
        Sun, 19 Jul 2020 16:02:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.54])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 19 Jul 2020 16:02:16 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 2/3] ima-evm-utils: output specific "unknown keyid" file msg based on log level
Date:   Sun, 19 Jul 2020 12:02:03 -0400
Message-Id: <1595174524-4976-2-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
References: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-19_02:2020-07-17,2020-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007190119
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When the IMA measurement list contains file signatures, the file
signatures are verified either by calculating the local file data hash
or based on the file hash contained in the measurement list.  In either
case a list of trusted public keys needs to be provided.

In addition to the list of known/unknown public keys needed to verify
the measurement list being output, the specific files signed by an
unknown public key are output as well.

Output the individual "unknown keyid" file messages based on log level.

Example 1: "ima_measurement" list of known/unknown public keys

Verify the provided IMA measurement list against the provided TPM 1.2
PCRs.
--validate: ignore measurement violations.
--verify: calculate and verify the template digest against the template
data.
--verify-sig: verify the file signature against the file hash stored
in the template data.

$ evmctl ima_measurement /tmp/local_binary_runtime_measurements --pcrs
/tmp/local_pcrs_new --validate --verify --verify-sig
key 1: 14c2d147 /etc/keys/x509_evm.der
key 2: 6e6c1046 (unknown keyid)
key 3: c4e2426e (unknown keyid)
Matched per TPM bank calculated digest(s).

Example 2: verbose mode (-v) includes specific unknown files.

/usr/bin/evmctl: verification failed: unknown keyid 6e6c1046

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 16e07e82b9e3..fa6c27858d0f 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -512,8 +512,9 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	if (!pkey) {
 		uint32_t keyid = hdr->keyid;
 
-		log_info("%s: verification failed: unknown keyid %x\n",
-			 file, __be32_to_cpup(&keyid));
+		if (imaevm_params.verbose > LOG_INFO)
+			log_info("%s: verification failed: unknown keyid %x\n",
+				 file, __be32_to_cpup(&keyid));
 		return -1;
 	}
 
-- 
2.7.5

