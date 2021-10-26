Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE643AA7D
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 04:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJZCwO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Oct 2021 22:52:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20292 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230111AbhJZCwN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Oct 2021 22:52:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q27KfF024869;
        Tue, 26 Oct 2021 02:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=28+bR3paJdcLwxAEWeAqQ8ppBpzwoWLYgmERPhIko8I=;
 b=MEDXDtvLfDy7JyUVLpNlw5a2NIu63YQdVvlcaJYm7+po65s5FSraXU14DJwIDyzT+jCj
 74elLl7WtSYBWF4FJ5Fo/63Fzco65MWcrzEqvmK2C7a8FxlPs5rPoDHiJSHWtkkgazdR
 pOsmY3fwKGUyjdUQqHBqx7vLtmLsm5Rt1jJnenaeAPhDIb/4wHQSq9pHox3z9dvHKBjP
 fExkCxrfsmOWs231qPSyW3Gdi/5nzcyi4SsxeKVpavYuBlBCZ9S+uISqS36njH4T+iPN
 1Tj92ABdNJkrulpK8Q4dR2yER6+u1dtIwXwX7sJ0dfOyCZ+9wVNubYkyQcO5+cAa/ZPZ RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k8nxqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 02:49:48 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q2MS4s006542;
        Tue, 26 Oct 2021 02:49:48 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k8nxpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 02:49:48 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q2cLkb016944;
        Tue, 26 Oct 2021 02:49:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4ess6ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 02:49:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q2niYL54591944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 02:49:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01306AE04D;
        Tue, 26 Oct 2021 02:49:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52854AE045;
        Tue, 26 Oct 2021 02:49:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.77.130.61])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 02:49:43 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH ima-evm-utils 1/2] switch to using crun for podman
Date:   Mon, 25 Oct 2021 22:49:28 -0400
Message-Id: <20211026024929.535519-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -gQx05YFj6REfNFNc6xT7mgI0Xrd5bC1
X-Proofpoint-ORIG-GUID: f8c6CzI-nwhnj7f1SikisrGygvGBM4YG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix for:

"container_linux.go:367: starting container process caused: error
adding seccomp filter rule for syscall bdflush: permission denied":
OCI permission denied"

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 9d56c963ee03..ba652ceb32bc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -32,7 +32,7 @@ matrix:
 
         # glibc (gcc/clang)
         - os: linux
-          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host" COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host" COMPILE_SSL=openssl-3.0.0-beta1
           compiler: clang
 
         - os: linux
@@ -72,7 +72,8 @@ matrix:
           compiler: gcc
 
 before_install:
-    # Tumbleweed requires podman and newest runc due docker incompatible with glibc 2.33 (faccessat2)
+    # Tumbleweed requires podman due docker incompatible with glibc 2.33
+    # (faccessat2) and crun (for clone3).
     - CONTAINER="${CONTAINER:-docker}"
     - >
         if [ "$CONTAINER" = "podman" ]; then
@@ -81,11 +82,7 @@ before_install:
             sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
             wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | sudo apt-key add -
             sudo apt update
-            sudo apt -y install podman slirp4netns
-
-            # runc
-            sudo curl -L https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64 -o /usr/bin/runc
-            sudo chmod +x /usr/bin/runc
+            sudo apt -y install podman slirp4netns crun
         fi
     - $CONTAINER info
 
-- 
2.27.0

