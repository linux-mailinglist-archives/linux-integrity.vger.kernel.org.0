Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D1B5B7F03
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiINCa2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiINCaZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379FC501BF
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:23 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E1qfPg006543;
        Wed, 14 Sep 2022 02:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=pHfyhfOua4HpxRTyzBCcVl8oaaFZ9UmCrfnjGPIS8I8=;
 b=JlhrBmjE/f+2A6ThjwPvyBGggdYlzr1LmnC35QT3HB/9EBfcT1BqCV6gsbxXYdWGICQN
 zF2JCdwuYmBAjSCgIOOPRv9ho1phhU8S/5R29oVMPayYmqiFWZejvXzo7oLPpxGOKu0l
 IssDG5+mWEs3ICDM4qfOyq5ODZ+KhNHwAgt5OjNSSATPe+NSCwU3KDOlu3fVZd9ndEx8
 2wBm9d72lW63i0eXqXAXJ0aXFhbVmZw5+4MnErQYTfXj18wneNpnjAXWwaxGTEcaTWwk
 QorkpOBhbSgfYAzetFGP+l0nojwVjx54QyvmXXrLSTXDLHsGlSUNA24V0XM50TxPj0AR 5Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk5pa0x2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:19 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2MMxT000993;
        Wed, 14 Sep 2022 02:30:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3jjy9a08de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2QTfK17498442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:26:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BA86A4055;
        Wed, 14 Sep 2022 02:30:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78E81A404D;
        Wed, 14 Sep 2022 02:30:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:13 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 14/15] Build OpenSSL without engine support
Date:   Tue, 13 Sep 2022 22:29:55 -0400
Message-Id: <20220914022956.1359218-15-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N-GG6qJj8IDKqtQNItuRTn76oFd_36xI
X-Proofpoint-ORIG-GUID: N-GG6qJj8IDKqtQNItuRTn76oFd_36xI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index d3f8eac26362..2e21da67c444 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2989,8 +2989,10 @@ int main(int argc, char *argv[])
 #if CONFIG_ENGINE
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

