Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E85AF4F9
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIFTzV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiIFTx2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:53:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B93B3B05
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:51:01 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JS69m005811;
        Tue, 6 Sep 2022 19:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=DujfPBrDN1I+E++Z2av+L+F+iQDvPctQ8iKbab5+fwA=;
 b=bMdxdNMkFBXAe3z4nELzBLXe0zGszIZE1MN/RqbxE9B902rG6Kkz4w8YiplBbCNOEtE0
 rsyLX7xtYQrxbil31mo2FC3GO6plFSQ/+KDx1VAP0jQrue/0xwsGk/B4VEhMIEyPutLT
 xycQh58JaycD84fIWJz76ynMVc5k+v9zJzeZQFzcsHh1HxsapzXpVXLoGNkzsoMEwKLc
 t7P3tukWFgDhz/Q9LfWEG9/I0yzUM7ZSpGU/5Gho3lRi5hg0NXo02wyNLO9nRryqmb8w
 rZhIamBhYzHVDj/n2SOFezl6uv2f74GITiMybSL7R1ZPRB6qoOai2ntBNLkXj3MpemMr rw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecd10hec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:57 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286Jot7U007505;
        Tue, 6 Sep 2022 19:50:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3jbxj8u372-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286JpGUi43712840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:51:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C7FB11C04C;
        Tue,  6 Sep 2022 19:50:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E642C11C04A;
        Tue,  6 Sep 2022 19:50:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:50 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH ima-evm-utils v2 12/12] Limit configuring OpenSSL engine support
Date:   Tue,  6 Sep 2022 15:50:21 -0400
Message-Id: <20220906195021.854090-13-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906195021.854090-1-zohar@linux.ibm.com>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HCHq4nTa-arRCAsVQUL3_J5oyYUvjsyo
X-Proofpoint-ORIG-GUID: HCHq4nTa-arRCAsVQUL3_J5oyYUvjsyo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If either OPENSSL_NO_DYNAMIC_ENGINE or OPENSSL_NO_ENGINE is defined
do not build ima-evm-utils with OpenSSL engine support.

Suggested-by: Vitaly Chikunov <vt@altlinux.org>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Vitaly, unlike with "--disable-engine" the "Tests requiring engine support
are skipped (not supported)" message is not being displayed after building
OpenSSL v3 with "no-engine" support.

 src/evmctl.c              | 14 ++++++++++++++
 src/libimaevm.c           |  4 +++-
 tests/install-openssl3.sh |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index e603449b7d9e..399a0d078a52 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -64,9 +64,11 @@
 #include <openssl/hmac.h>
 #include <openssl/err.h>
 #include <openssl/rsa.h>
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
 #if CONFIG_ENGINE
 #include <openssl/engine.h>
 #endif
+#endif
 #include <openssl/x509v3.h>
 #include "hash_info.h"
 #include "pcr.h"
@@ -2722,8 +2724,10 @@ static void usage(void)
 		"      --selinux      use custom Selinux label for EVM\n"
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --verify-sig   verify measurement list signatures\n"
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
 #if CONFIG_ENGINE
 		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
+#endif
 #endif
 		"      --ignore-violations ignore ToMToU measurement violations\n"
 		"  -v                 increase verbosity level\n"
@@ -2786,8 +2790,10 @@ static struct option opts[] = {
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
 	{"verify-sig", 0, 0, 138},
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
 #if CONFIG_ENGINE
 	{"engine", 1, 0, 139},
+#endif
 #endif
 	{"xattr-user", 0, 0, 140},
 	{"ignore-violations", 0, 0, 141},
@@ -2841,6 +2847,7 @@ static char *get_password(void)
 	return password;
 }
 
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
 #if CONFIG_ENGINE
 static ENGINE *setup_engine(const char *engine_id)
 {
@@ -2860,6 +2867,7 @@ static ENGINE *setup_engine(const char *engine_id)
 	return eng;
 }
 #endif
+#endif
 
 int main(int argc, char *argv[])
 {
@@ -2985,12 +2993,14 @@ int main(int argc, char *argv[])
 		case 138:
 			verify_list_sig = 1;
 			break;
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
 #if CONFIG_ENGINE
 		case 139: /* --engine e */
 			imaevm_params.eng = setup_engine(optarg);
 			if (!imaevm_params.eng)
 				goto error;
 			break;
+#endif
 #endif
 		case 140: /* --xattr-user */
 			xattr_ima = "user.ima";
@@ -3050,8 +3060,10 @@ int main(int argc, char *argv[])
 	if (imaevm_params.keyfile != NULL &&
 	    imaevm_params.eng == NULL &&
 	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
 #if CONFIG_ENGINE
 		imaevm_params.eng = setup_engine("pkcs11");
+#endif
 #endif
 		if (!imaevm_params.eng)
 			goto error;
@@ -3078,6 +3090,7 @@ int main(int argc, char *argv[])
 	}
 
 error:
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
 #if CONFIG_ENGINE
 	if (imaevm_params.eng) {
 		ENGINE_finish(imaevm_params.eng);
@@ -3086,6 +3099,7 @@ error:
 		ENGINE_cleanup();
 #endif
 	}
+#endif
 #endif
 	ERR_free_strings();
 	EVP_cleanup();
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 037027c1d951..c41b63fb97b9 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -959,7 +959,8 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 	EVP_PKEY *pkey;
 
 	if (!strncmp(keyfile, "pkcs11:", 7)) {
-#ifdef CONFIG_ENGINE
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
+#if CONFIG_ENGINE
 		if (!imaevm_params.keyid) {
 			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
 			return NULL;
@@ -979,6 +980,7 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 #else
 		log_err("OpenSSL \"engine\" support is disabled\n");
 		goto err_engine;
+#endif
 #endif
 	} else {
 		fp = fopen(keyfile, "r");
diff --git a/tests/install-openssl3.sh b/tests/install-openssl3.sh
index 1b634681a760..cdda77980fea 100755
--- a/tests/install-openssl3.sh
+++ b/tests/install-openssl3.sh
@@ -13,7 +13,7 @@ wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags
 tar --no-same-owner -xzf ${version}.tar.gz
 cd openssl-${version}
 
-./Configure --prefix=/opt/openssl3 --openssldir=/opt/openssl3/ssl
+./Configure no-engine no-dynamic-engine --prefix=/opt/openssl3 --openssldir=/opt/openssl3/ssl
 make -j$(nproc)
 # only install apps and library
 sudo make install_sw
-- 
2.31.1

