Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6F6187B1
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKCSj0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKCSjZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973B2638
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:25 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3I4OXT030520;
        Thu, 3 Nov 2022 18:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=n/JiJBLrPuaClsy5G+OlJVO7MQUePKn8+v2ekw+9h88=;
 b=NsdXckT04AyCP0vLPllnr8lKFBVSRt/f/DLUMhKs1jemxaHcS3AmQoO/Da987BnHPyOD
 b0IH3bkZ75PUUgag2unU49k0i7ktxWiLh/Xy1mKGZCHWf6JZwc/Yd7pQcijubeZyrnmg
 k6a5S9gss+H7OUsokN34yobHdJIvWKNAgG0X7Vd0kcJ64CVHVo7cjtKVxPeT2N09+VJt
 kdAaJOH+WaG1fNXcqwaRxgNQy1t8qDOPOHbTGK0kEnL2uk9GAgmXLcV2w1w3Kwlg0CBh
 rlpv/0yjKQIH5bdi8Xw08eufGVK0/1WBjpvtT0Vt8u35PZ7Ofv6INaFjiaVUYGsUyWHJ tA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmcac11gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3IbCjl005474;
        Thu, 3 Nov 2022 18:39:18 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut9974n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IdF0619137278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:39:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A61F42045;
        Thu,  3 Nov 2022 18:39:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14D2E4203F;
        Thu,  3 Nov 2022 18:39:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:13 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 03/17] Log and reset 'errno' on lsetxattr failure
Date:   Thu,  3 Nov 2022 14:38:50 -0400
Message-Id: <20221103183904.103562-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _OZIWl6NGeqCvgneIX2q1fFES2WCWID3
X-Proofpoint-GUID: _OZIWl6NGeqCvgneIX2q1fFES2WCWID3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=949
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030125
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

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 54123bf20f03..53af4d2cb961 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -572,7 +572,8 @@ static int sign_evm(const char *file, const char *key)
 	if (xattr) {
 		err = lsetxattr(file, xattr_evm, sig, len, 0);
 		if (err < 0) {
-			log_err("setxattr failed: %s\n", file);
+			log_errno_reset(LOG_ERR, "Setting EVM xattr failed: %s",
+					file);
 			return err;
 		}
 	}
@@ -615,7 +616,9 @@ static int hash_ima(const char *file)
 	if (xattr) {
 		err = lsetxattr(file, xattr_ima, hash, len, 0);
 		if (err < 0) {
-			log_err("setxattr failed: %s\n", file);
+			log_errno_reset(LOG_ERR,
+					"Setting IMA hash xattr failed: %s",
+					file);
 			return err;
 		}
 	}
@@ -652,7 +655,9 @@ static int sign_ima(const char *file, const char *key)
 	if (xattr) {
 		err = lsetxattr(file, xattr_ima, sig, len, 0);
 		if (err < 0) {
-			log_err("setxattr failed: %s\n", file);
+			log_errno_reset(LOG_ERR,
+					"Setting IMA sig xattr failed: %s",
+					file);
 			return err;
 		}
 	}
@@ -1125,7 +1130,8 @@ static int setxattr_ima(const char *file, char *sig_file)
 
 	err = lsetxattr(file, xattr_ima, sig, len, 0);
 	if (err < 0)
-		log_err("setxattr failed: %s\n", file);
+		log_errno_reset(LOG_ERR, "Setting IMA sig xattr failed: %s",
+				file);
 	free(sig);
 	return err;
 }
@@ -1323,7 +1329,9 @@ static int hmac_evm(const char *file, const char *key)
 		sig[0] = EVM_XATTR_HMAC;
 		err = lsetxattr(file, xattr_evm, sig, len + 1, 0);
 		if (err < 0) {
-			log_err("setxattr failed: %s\n", file);
+			log_errno_reset(LOG_ERR,
+					"Setting EVM hmac xattr failed: %s",
+					file);
 			return err;
 		}
 	}
-- 
2.31.1

