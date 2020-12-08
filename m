Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5CE2D2C17
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 14:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgLHNh7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 08:37:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729020AbgLHNh6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 08:37:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8DWOUc096510;
        Tue, 8 Dec 2020 08:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=y7Rn1mFTwjD/+UcqdZUlXv9sotblfSHf8xeTD1DjzjI=;
 b=Hb6cZuIsy6T7KmfIkrkXlaJQuBg89qEdHg7vNKiZqWyVlxvxmOqEG1qtljjfuRDtYTZz
 7qxNRtKn2MWyyQTJ2euTX21BHHyvLGxjwhTyjEJpcuS7WSYXbrpdbk8J2pL8ClhbKPC0
 MoXHEoXGiGAnct4QYI735WuN4ywrYQdIZBJyKXa2zWgNhPX/Toe/Do16VfY6iUZXe8gM
 W8F5CmEvcNicdj6LiSIVN1i+g43pd4JpGNIIGq8ocxyfaohcmv4L0tq9vUtPNLGM8uR8
 KWTqbthetWtpTvQQFBRDzET0akxOBYky8VczvxALsg0WjWFIQngxdCqU1fmv3cR73Y6L UA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 359qrpqhnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 08:37:03 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Db1Yx006716;
        Tue, 8 Dec 2020 13:37:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3583svkghm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 13:37:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8DaxFJ63635728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 13:36:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC92C42045;
        Tue,  8 Dec 2020 13:36:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70D0442049;
        Tue,  8 Dec 2020 13:36:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.221.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 13:36:57 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [ima-evm-utils][PATCH 1/2] Add support for verifying portable EVM signatures
Date:   Tue,  8 Dec 2020 08:36:38 -0500
Message-Id: <20201208133639.538269-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201208133639.538269-1-zohar@linux.ibm.com>
References: <20201208133639.538269-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=1 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 4928548d9d87 ("Add support for portable EVM format") added
support for generating portable and immutable signatures.  Support
verifying them, using either the security.ima or the user.ima.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1815f55d73e0..4fd0ed86e281 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -404,6 +404,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 	}
 
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
+		int use_xattr_ima = 0;
+
 		if (!strcmp(*xattrname, XATTR_NAME_SELINUX) && selinux_str) {
 			err = strlen(selinux_str) + 1;
 			if (err > sizeof(xattr_value)) {
@@ -420,6 +422,15 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 				return -1;
 			}
 			hex2bin(xattr_value, ima_str, err);
+		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && evm_portable){
+			err = lgetxattr(file, xattr_ima, xattr_value,
+					sizeof(xattr_value));
+			if (err < 0) {
+				log_err("EVM portable sig: %s required\n",
+					xattr_ima);
+				return -1;
+			}
+			use_xattr_ima = 1;
 		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
 			if (!caps_str)
 				continue;
@@ -442,7 +453,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			}
 		}
 		/*log_debug("name: %s, value: %s, size: %d\n", *xattrname, xattr_value, err);*/
-		log_info("name: %s, size: %d\n", *xattrname, err);
+		log_info("name: %s, size: %d\n",
+			 use_xattr_ima ? xattr_ima : *xattrname, err);
 		log_debug_dump(xattr_value, err);
 		err = EVP_DigestUpdate(pctx, xattr_value, err);
 		if (!err) {
@@ -807,11 +819,20 @@ static int verify_evm(const char *file)
 		return len;
 	}
 
-	if (sig[0] != 0x03) {
+	if ((sig[0] != EVM_IMA_XATTR_DIGSIG) &&
+	    (sig[0] != EVM_XATTR_PORTABLE_DIGSIG)) {
 		log_err("%s has no signature\n", xattr_evm);
 		return -1;
 	}
 
+	if (sig[0] == EVM_XATTR_PORTABLE_DIGSIG) {
+		if (sig[1] != DIGSIG_VERSION_2) {
+			log_err("Portable sig: invalid type\n");
+			return -1;
+		}
+		evm_portable = true;
+	}
+
 	sig_hash_algo = imaevm_hash_algo_from_sig(sig + 1);
 	if (sig_hash_algo < 0) {
 		log_err("unknown hash algo: %s\n", file);
-- 
2.18.4

