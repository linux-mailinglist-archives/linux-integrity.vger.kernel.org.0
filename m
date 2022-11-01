Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45739615300
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKAUS1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiKAUSY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154E63A2
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:23 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1J5jUu004217;
        Tue, 1 Nov 2022 20:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/pzgdG8QVbwIElZT9syZFCeYlDXsjwv5NKCpyDJxLTs=;
 b=aukc+P1Sz4cIrENzomOUHvQKC81Zidwf9HggNjZbzuZUUvKbqYPP0bd5kpoC3hS0m1w5
 udPGv4yEodEAVXKmA+Szw+cDLXUm+2S/OMXnG0NUglNby3mVjcBt91HF67Xejydf+Oj6
 WdwfSneyJLZdx04Oikq7umg0D1099xs8Z4F+rJhC2j/cxJOULWZXx498VpaVzCPiSPKm
 VDoGV3lHk9ei2e+JL89M5hg/FCA8ll3+PXB4p0HGVDqYqzECdmG4z0g9hEzRW+1BaCPM
 ZvHYXE87IEAxlAv8qmg/4AxAVw/a5AoLNug5SUyR8wkzvgrLaCobG8LCrHHGo1eHRpco pQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjtg5qak4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:15 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K6cwg014532;
        Tue, 1 Nov 2022 20:18:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut9572e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KCgwZ47841536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:12:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C909EA405F;
        Tue,  1 Nov 2022 20:18:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05114A4054;
        Tue,  1 Nov 2022 20:18:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:09 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 03/17] Log and reset 'errno' on lsetxattr failure
Date:   Tue,  1 Nov 2022 16:17:49 -0400
Message-Id: <20221101201803.372652-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6J39EkjsZtaRcZqKyzzafhl3pfj_PuPI
X-Proofpoint-GUID: 6J39EkjsZtaRcZqKyzzafhl3pfj_PuPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=785 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Writing either security.ima hashes or security.evm hmacs from userspace
will fail regardless of the IMA or EVM fix mode.  In fix mode, 'touch'
will force security.ima and security.evm to be updated.

Make the setxattr error messages more explicit and clear errno.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 54123bf20f03..b1dcd9b1c1ef 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -572,7 +572,7 @@ static int sign_evm(const char *file, const char *key)
 	if (xattr) {
 		err = lsetxattr(file, xattr_evm, sig, len, 0);
 		if (err < 0) {
-			log_err("setxattr failed: %s\n", file);
+			log_errno_reset(LOG_ERR, "Set EVM xattr failed: %s", file);
 			return err;
 		}
 	}
@@ -615,7 +615,8 @@ static int hash_ima(const char *file)
 	if (xattr) {
 		err = lsetxattr(file, xattr_ima, hash, len, 0);
 		if (err < 0) {
-			log_err("setxattr failed: %s\n", file);
+			log_errno_reset(LOG_ERR, "Set IMA hash xattr failed: %s",
+					file);
 			return err;
 		}
 	}
@@ -652,7 +653,8 @@ static int sign_ima(const char *file, const char *key)
 	if (xattr) {
 		err = lsetxattr(file, xattr_ima, sig, len, 0);
 		if (err < 0) {
-			log_err("setxattr failed: %s\n", file);
+			log_errno_reset(LOG_ERR, "Set IMA sig xattr failed: %s",
+					file);
 			return err;
 		}
 	}
@@ -1125,7 +1127,7 @@ static int setxattr_ima(const char *file, char *sig_file)
 
 	err = lsetxattr(file, xattr_ima, sig, len, 0);
 	if (err < 0)
-		log_err("setxattr failed: %s\n", file);
+		log_errno_reset(LOG_ERR, "Set IMA sig xattr failed: %s", file);
 	free(sig);
 	return err;
 }
@@ -1323,7 +1325,8 @@ static int hmac_evm(const char *file, const char *key)
 		sig[0] = EVM_XATTR_HMAC;
 		err = lsetxattr(file, xattr_evm, sig, len + 1, 0);
 		if (err < 0) {
-			log_err("setxattr failed: %s\n", file);
+			log_errno_reset(LOG_ERR, "Set EVM hmac xattr failed: %s",
+					file);
 			return err;
 		}
 	}
-- 
2.31.1

