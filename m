Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44878EF4
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2019 17:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfG2PSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jul 2019 11:18:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387402AbfG2PSL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jul 2019 11:18:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6TF7UKd069723
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jul 2019 11:18:09 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u2311h77w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jul 2019 11:18:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 29 Jul 2019 16:18:07 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Jul 2019 16:18:04 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6TFI3bc43385152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 15:18:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E09242049;
        Mon, 29 Jul 2019 15:18:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABE8D42047;
        Mon, 29 Jul 2019 15:18:02 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.110.133])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jul 2019 15:18:02 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima-evm-utils: limit OPENSSL_init_crypto calls
Date:   Mon, 29 Jul 2019 11:17:28 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19072915-0012-0000-0000-0000033754F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072915-0013-0000-0000-00002170F6DC
Message-Id: <1564413448-21785-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290172
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

OPENSSL_init_crypto() was introduced in version 1.1.  When using an
older version of openssl, don't call OPENSSL_init_crypto.  Partially
revert commit 782224f33cd7 ("ima-evm-utils: Rework openssl init").

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c    | 2 ++
 src/libimaevm.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index b02be8b1507a..244663f18ba8 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1943,11 +1943,13 @@ int main(int argc, char *argv[])
 	int err = 0, c, lind;
 	ENGINE *eng = NULL;
 
+#if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
 #ifndef DISABLE_OPENSSL_CONF
 			    OPENSSL_INIT_LOAD_CONFIG |
 #endif
 			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
+#endif
 	g_argv = argv;
 	g_argc = argc;
 
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 4f4b20732f4a..7c17bf4d590e 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -979,7 +979,14 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 
 static void libinit()
 {
+
+#if OPENSSL_VERSION_NUMBER < 0x10100000
+	OpenSSL_add_all_algorithms();
+	OPENSSL_add_all_algorithms_conf();
+#else
+
 	OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS |
 			    OPENSSL_INIT_ADD_ALL_DIGESTS, NULL);
 	ERR_load_crypto_strings();
+#endif
 }
-- 
2.7.5

