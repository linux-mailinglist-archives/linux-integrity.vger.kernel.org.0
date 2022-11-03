Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8386187C2
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKCSjp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiKCSjo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE92BC2
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:43 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3IHJjg029525;
        Thu, 3 Nov 2022 18:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=0gg/PuoRA55xSJxr+V7684GuzWAsjxaZmXLbf5QuGo4=;
 b=O01e3uOz68JJvxZZUcf6vuWvAUewNsleHfL8O/9qnxlaB6qMEv/OLpwa1vlRkakV1cLy
 cozriRdA4rJquNno3DUvepHT79J9Ku4E9HKHU476IlZXAN79GL4E8/e1sc9NmwGSw7FE
 2NSE9U3EjfDsYO+WhXR7qtw9TNeyngn0/NXbPWvZ5C9kcKlcxKrzZtGLvUnTRNYcom+5
 NkYe+9JzijibzU3BafU5zJlrIaNbXnZgrIfoCHTL3RQfmtjOfxljAC7IgmtldQG+J7a8
 Shf/e2ZseSBh24RaHJBAu8/+/lpnM5kNrb4MGYMcLPBxvqx3ul8Xj+g+rQEW92FQZ+u/ eA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kme7ykxt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3Ib2pN005468;
        Thu, 3 Nov 2022 18:39:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut99752-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IdT4n26411316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:39:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68D8842041;
        Thu,  3 Nov 2022 18:39:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A861F4203F;
        Thu,  3 Nov 2022 18:39:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:28 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 16/17] Build OpenSSL without engine support
Date:   Thu,  3 Nov 2022 14:39:03 -0400
Message-Id: <20221103183904.103562-17-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f_CScl33ozEElZTlOyUSCphrkaCNFhVU
X-Proofpoint-ORIG-GUID: f_CScl33ozEElZTlOyUSCphrkaCNFhVU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix COMPILE_SSL to build for the proper architecture, link with the
appropriate library, and set up library path for evmctl.

Compile OpenSSL with "no-engine" and "no-dynamic-engine" support.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .github/workflows/ci.yml  | 4 ++--
 .travis.yml               | 2 +-
 build.sh                  | 8 ++++++++
 src/evmctl.c              | 4 +++-
 tests/install-openssl3.sh | 9 ++++++++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 5595855512e4..8223b8767351 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -114,7 +114,7 @@ jobs:
         INSTALL="${INSTALL%%/*}"
         if [ "$VARIANT" ]; then ARCH="$ARCH" ./ci/$INSTALL.$VARIANT.sh; fi
         ARCH="$ARCH" CC="$CC" TSS="$TSS" ./ci/$INSTALL.sh
-        if [ "$COMPILE_SSL" ]; then COMPILE_SSL="$COMPILE_SSL" ./tests/install-openssl3.sh; fi
+        if [ "$COMPILE_SSL" ]; then COMPILE_SSL="$COMPILE_SSL" VARIANT="$VARIANT" ./tests/install-openssl3.sh; fi
 
     - name: Build swtpm
       run: |
@@ -129,4 +129,4 @@ jobs:
       run: $CC --version
 
     - name: Compile
-      run: CC="$CC" VARIANT="$VARIANT" ./build.sh
+      run: CC="$CC" VARIANT="$VARIANT" COMPILE_SSL="$COMPILE_SSL" ./build.sh
diff --git a/.travis.yml b/.travis.yml
index 09db401928f6..faaa4b5d675b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -95,4 +95,4 @@ script:
     - INSTALL="${DISTRO#${REPO}}"
     - INSTALL="${INSTALL%%:*}"
     - INSTALL="${INSTALL%%/*}"
-    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ "$COMPILE_SSL" ]; then COMPILE_SSL="$COMPILE_SSL" ./tests/install-openssl3.sh; fi && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
+    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ \"$COMPILE_SSL\" ]; then COMPILE_SSL=\"$COMPILE_SSL\" VARIANT=\"$VARIANT\" ./tests/install-openssl3.sh; fi && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" COMPILE_SSL=\"$COMPILE_SSL\" ./build.sh"
diff --git a/build.sh b/build.sh
index c4d28f1302c6..0c2fdd9e995d 100755
--- a/build.sh
+++ b/build.sh
@@ -32,6 +32,14 @@ log_exit()
 
 cd `dirname $0`
 
+if [ "$COMPILE_SSL" ]; then
+	echo "COMPILE_SSL: $COMPILE_SSL"
+	export CFLAGS="-I/opt/openssl3/include $CFLAGS"
+	export LD_LIBRARY_PATH="/opt/openssl3/lib64:/opt/openssl3/lib:$HOME/src/ima-evm-utils/src/.libs:$LD_LIBRARY_PATH"
+	export LDFLAGS="-L/opt/openssl3/lib64 -L/opt/openssl3/lib $LDFLAGS"
+	export PATH="/opt/openssl3/bin:$HOME/src/ima-evm-utils/src/.libs:$PATH"
+fi
+
 case "$VARIANT" in
 	i386)
 		echo "32-bit compilation"
diff --git a/src/evmctl.c b/src/evmctl.c
index 65e27e1681e7..a6965fde70c1 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2982,8 +2982,10 @@ int main(int argc, char *argv[])
 #if CONFIG_IMA_EVM_ENGINE
 		case 139: /* --engine e */
 			imaevm_params.eng = setup_engine(optarg);
-			if (!imaevm_params.eng)
+			if (!imaevm_params.eng) {
+				log_info("setup_engine failed\n");
 				goto error;
+			}
 			break;
 #endif
 		case 140: /* --xattr-user */
diff --git a/tests/install-openssl3.sh b/tests/install-openssl3.sh
index 1b634681a760..911c32bcf87c 100755
--- a/tests/install-openssl3.sh
+++ b/tests/install-openssl3.sh
@@ -13,7 +13,14 @@ wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags
 tar --no-same-owner -xzf ${version}.tar.gz
 cd openssl-${version}
 
-./Configure --prefix=/opt/openssl3 --openssldir=/opt/openssl3/ssl
+if [ "$VARIANT" = "i386" ]; then
+	echo "32-bit compilation"
+	FLAGS="-m32 linux-generic32"
+fi
+
+./Configure $FLAGS no-engine no-dynamic-engine --prefix=/opt/openssl3 --openssldir=/opt/openssl3
+# Uncomment for debugging
+# perl configdata.pm --dump | grep engine
 make -j$(nproc)
 # only install apps and library
 sudo make install_sw
-- 
2.31.1

