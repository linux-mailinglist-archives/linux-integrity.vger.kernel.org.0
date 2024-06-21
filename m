Return-Path: <linux-integrity+bounces-2900-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B009117D1
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 02:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D561C21D9D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 00:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A21110FA;
	Fri, 21 Jun 2024 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l+gdRKjM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1513C39
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718931575; cv=none; b=kSeezPHiyKJ9zpdfzCFUg2v/WnKpV7SJnV8VD1Vzutvg93J29GTDB4Tu/VkP6XZkQvE2O4fqakMINAytFXrHGD6zRCq3c161bQTRIamFkuEcomlpyBFUf6FJxIdCt64wtK2sDYogXC4b1FCnnatDVIkbCeoQSus0utQu+guHoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718931575; c=relaxed/simple;
	bh=vuD98UR9s/UsH9o4QLJuJCyEYc386Adqfc/rOX83/N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCikCv3eL38W6e/7uVnY6BEZgEdhJ8mptaE0p9AvAiWiHfoQ4ToJoq3VzwzyzIXvzMvduG4FUfRLqtV4+bWmYHzWfYhQJO4RcPVGdoQb+Wxi3aX326R1yvRyP8AID44Uc+4BheW5S5Ou8vcQVmeiW3bxHHcMJIky2VOzxmrOze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l+gdRKjM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0pDVr028472
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=9BbyOoWrvQMNc
	rfLWqST6i65BiwMFEo4Co13wIB+/tQ=; b=l+gdRKjMbZjYpyIxLx2k/jgGV7+Nw
	3oatoLVuPGVD/s62axVmj1MxToPoe6tq8ObqHrCwiTIL6AQz1VQiqotVOD100PIn
	pMxMeg0zTAMHB2wmYfzaeS3UufgLkoZTYHSi1jmFJIxsTFYfKrDOHuq6+t8HgFUH
	TOBIdzeC+jUnsmb5jndMtZqZeb2RkFnI4ODEWUuaHGrjLO0TF9U5+Q7gVZrDIu5g
	+x/DsKkKuzz+XKMHPUdXod1vqP8BZHzXzccq63ayIjkfCOBHxsEVcfPWVC8rQoKO
	FxNpf6ih4K9sP5P6C9npF4P/bXHv9VEdMq+U6u0Gk3Ql/0lbBFzg3l3Lg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvwpq86u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0PCZS019980
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrquju5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0xQ0R23659022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:59:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8335458068;
	Fri, 21 Jun 2024 00:59:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23E2658053;
	Fri, 21 Jun 2024 00:59:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:59:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils][PATCH 3/3] CI/CD: Also enable Ubuntu 24.04 (Noble) and run provider tests
Date: Thu, 20 Jun 2024 20:59:12 -0400
Message-ID: <20240621005912.1365462-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7OfCa4Vs4KdIrRDxMz3nqeL7ZOOupkcq
X-Proofpoint-ORIG-GUID: 7OfCa4Vs4KdIrRDxMz3nqeL7ZOOupkcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=892 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

From: Stefan Berger <stefanb@linux.ibm.com>

With provider support fixed for Ubuntu 24.04 (Noble), enable testing with
it. To test provider support on Ubuntu, make a copy of the debian.sh
install file and enable the installation of provider support there.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 .github/workflows/ci.yml |  5 ++++
 .travis.yml              |  4 +++
 ci/ubuntu.sh             | 63 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)
 mode change 120000 => 100755 ci/ubuntu.sh

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 5d67c70..772eb34 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -143,6 +143,11 @@ jobs:
               CC: gcc
               TSS: ibmtss
 
+          - container: "ubuntu:noble"
+            env:
+              CC: gcc
+              TSS: ibmtss
+
           - container: "ubuntu:xenial"
             env:
               CC: clang
diff --git a/.travis.yml b/.travis.yml
index af82040..0c78958 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -43,6 +43,10 @@ matrix:
           env: DISTRO=ubuntu:mantic TSS=ibmtss
           compiler: gcc
 
+        - os: linux
+          env: DISTRO=ubuntu:noble TSS=ibmtss
+          compiler: gcc
+
         - os: linux
           env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.5
           compiler: gcc
diff --git a/ci/ubuntu.sh b/ci/ubuntu.sh
deleted file mode 120000
index 0edcb8b..0000000
--- a/ci/ubuntu.sh
+++ /dev/null
@@ -1 +0,0 @@
-debian.sh
\ No newline at end of file
diff --git a/ci/ubuntu.sh b/ci/ubuntu.sh
new file mode 100755
index 0000000..e1bae43
--- /dev/null
+++ b/ci/ubuntu.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+set -ex
+
+# workaround for Ubuntu impish asking to interactively configure tzdata
+export DEBIAN_FRONTEND="noninteractive"
+
+if [ -z "$CC" ]; then
+	echo "missing \$CC!" >&2
+	exit 1
+fi
+
+# debian.*.sh must be run first
+if [ "$ARCH" ]; then
+	ARCH=":$ARCH"
+	unset CC
+else
+	apt update
+fi
+
+# ibmswtpm2 requires gcc
+[ "$CC" = "gcc" ] || CC="gcc $CC"
+
+case "$TSS" in
+ibmtss) TSS="libtss-dev";;
+tpm2-tss) TSS="libtss2-dev";;
+'') echo "Missing TSS!" >&2; exit 1;;
+*) [ "$TSS" ] && echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
+esac
+
+apt="apt install -y --no-install-recommends"
+
+$apt \
+	$CC $TSS \
+	asciidoc \
+	attr \
+	autoconf \
+	automake \
+	diffutils \
+	debianutils \
+	docbook-xml \
+	docbook-xsl \
+	e2fsprogs \
+	gzip \
+	libattr1-dev$ARCH \
+	libkeyutils-dev$ARCH \
+	libssl-dev$ARCH \
+	libtool \
+	make \
+	openssl \
+	pkg-config \
+	procps \
+	sudo \
+	util-linux \
+	wget \
+	xsltproc \
+	gawk
+
+$apt xxd || $apt vim-common
+$apt libengine-gost-openssl || true
+$apt softhsm2 gnutls-bin libengine-pkcs11-openssl || true
+$apt softhsm2 gnutls-bin pkcs11-provider || true
-- 
2.43.0


