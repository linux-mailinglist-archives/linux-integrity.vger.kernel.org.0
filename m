Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B224595D
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Aug 2020 21:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgHPTgw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Aug 2020 15:36:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2194 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726949AbgHPTgw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Aug 2020 15:36:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07GJVHRm069793;
        Sun, 16 Aug 2020 15:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=MxBKKCUodt1bC4FSS218SyMZYPz2TON5zOg6754+Smk=;
 b=Gs3jTQH0/twn/c3u01IM9ELLvp8D1+w7nLgplp1AUVba7TnIdMjV4n2mRZ/rkUgP5+rP
 FT1XwYl4pd/vz92XDivCx8nMd353+5JVBQfOmR/YD7CkCtKMRIvzQFoj2wUxP81HK0hh
 xRpDLgto++9x6TTIY/QOp1unC2vcsMuv1X47djchBPtHpFp4BBK5j2g0HI82c7Lz0TVq
 clT8UKiB1zMDaU0uhYPoKHKP6Lt/1H/lfEnFdFNwcoubWy8dsOjuWMWxc7s8gpNdzD0n
 vQfjkYl2LkOAUnaV0UX6F+kdl2hIWOYmYYDyiAR4qAqL1Etnlx64MTiT3TLuX2mNpnvq Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y7ay3t4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 15:36:47 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07GJWSlM072342;
        Sun, 16 Aug 2020 15:36:47 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y7ay3t4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 15:36:47 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07GJThOQ012237;
        Sun, 16 Aug 2020 19:36:45 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 32x7b80vtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 19:36:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07GJahvU27787632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 19:36:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1431B42041;
        Sun, 16 Aug 2020 19:36:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC48B4203F;
        Sun, 16 Aug 2020 19:36:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.65.247])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Aug 2020 19:36:41 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [ima-evm-utils][PATCH] Install the swtpm package, if available
Date:   Sun, 16 Aug 2020 15:36:27 -0400
Message-Id: <20200816193627.73935-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-16_07:2020-08-14,2020-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "boot_aggregate.test" requires either a hardware or software TPM.
Support using the swtpm, if packaged for the distro, in addition to
tpm_server.

Note: Some travis/<distro>.sh scripts are links to other scripts.
Don't fail the build of the linked script if the swtpm package doesn't
exist.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml               |  2 +-
 tests/boot_aggregate.test | 40 ++++++++++++++++++++++++++++-----------
 travis/fedora.sh          |  1 +
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 849fcb6ba822..9bea5d19bd0e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -75,4 +75,4 @@ before_install:
 script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
-    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
+    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 43de67de1468..ce310b6ae5b4 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -33,6 +33,10 @@ else
 	ASCII_RUNTIME_MEASUREMENTS="./sample-ascii_runtime_measurements-pcrs-8-9"
 	export TPM_INTERFACE_TYPE="socsim"
 	export TPM_COMMAND_PORT=2321
+	export TPM_PLATFORM_PORT=2322
+	export TPM_SERVER_NAME="localhost"
+	export TPM_SERVER_TYPE="raw"
+
 fi
 
 # Only stop this test's software TPM.  Preferred method: "tsstpmcmd -stop"
@@ -48,22 +52,36 @@ cleanup() {
 
 # Try to start a software TPM if needed.
 swtpm_start() {
-	local swtpm
+	local swtpm swtpm1
 
 	swtpm="$(which tpm_server)"
-	if [ -z "${swtpm}" ]; then
-		echo "${CYAN}SKIP: Softare TPM (tpm_server) not found${NORM}"
+	swtpm1="$(which swtpm)"
+	if [ -z "${swtpm}" ] && [ -z "${swptm1}" ]; then
+		echo "${CYAN}SKIP: Softare TPM (tpm_server and swtpm) not found${NORM}"
 		return "$SKIP"
 	fi
 
-	pgrep tpm_server
-	if [ $? -eq 0 ]; then
-		echo "INFO: Software TPM (tpm_server) already running"
-		return 114
-	else
-		echo "INFO: Starting software TPM: ${swtpm}"
-		${swtpm} > /dev/null 2>&1 &
-		SWTPM_PPID=$!
+	if [ ! -z "${swtpm1}" ]; then
+		pgrep swtpm1
+		if [ $? -eq 0 ]; then
+			echo "INFO: Software TPM (swtpm) already running"
+			return 114
+		else
+			echo "INFO: Starting software TPM: ${swtpm1}"
+			mkdir ./myvtpm
+			${swtpm1} socket --tpmstate dir=./myvtpm --tpm2 --ctrl type=tcp,port=2322 --server type=tcp,port=2321 --flags not-need-init > /dev/null 2>&1 &
+			SWTPM_PPID=$!
+		fi
+	elif [ ! -z "${swtpm}" ]; then
+		pgrep swtpm
+		if [ $? -eq 0 ]; then
+			echo "INFO: Software TPM (tpm_server) already running"
+			return 114
+		else
+			echo "INFO: Starting software TPM: ${swtpm}"
+			${swtpm} > /dev/null 2>&1 &
+			SWTPM_PPID=$!
+		fi
 	fi
 	return 0
 }
diff --git a/travis/fedora.sh b/travis/fedora.sh
index d3459e408d81..f9ee9bed7bc1 100755
--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -41,6 +41,7 @@ yum -y install \
 	which
 
 yum -y install docbook5-style-xsl || true
+yum -y install swtpm || true
 
 # FIXME: debug
 echo "find /tss2_esys.h"
-- 
2.18.4

