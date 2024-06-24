Return-Path: <linux-integrity+bounces-2927-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5416491598D
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 00:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794871C210F8
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C61A2540;
	Mon, 24 Jun 2024 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n0jcjb5C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB81A2FA0
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266532; cv=none; b=pJYIWHkVqYoiNHer2XGY6KTfKfpIcjh3LhKkgWvijD00xU4mDma4QxkE+cLGTiBTxpW0AZk4eFSca/iRrrjeNwY187fNUQVaj+Oc2sClVysM5+5AALzFIHEKL5M0nppuWYBFhOp8v1/idx9oMPaXF0a9Hc3xw4CUPA9xA5tu95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266532; c=relaxed/simple;
	bh=ayc7jGLvco6oRXy8QnVQZ7tD+UavLJsJJYwQxNs9OH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe1qGVRHV+jsyTnJGNwLpTVm/0PtgmvflT8ImYuAmI8HOhOAxksanDA9ivTqoN9mNA9ejdXjrBBPI/503rctoaaMkFhLIUVsZ6is2EXB9vGTq7RR5nxlCanL+qjR386YU1AS/UIIgiaUx79ionJonZUQTwivqik37bwDSYuTv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n0jcjb5C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OM016X002631;
	Mon, 24 Jun 2024 22:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=2ZpN4c7u1hHKq
	4DW78E+Tc3IL80tS0d2TCNKnshk8Zc=; b=n0jcjb5C5UUzLdWP/6gmXN3nRVtlM
	5eAQc6TyHEUwTKIYnprUNXQZ5CGW4qB5RBMWKDERaMvpkc/kPhz0vMJKubThCXtm
	Ya6uYRqa7xU7VzKyS36mHkc2/tKmab24prXQWeQdJ6yFbFNXzFXoZm1div/OB+fC
	H8zcYeVuVPxdoUHWd0NyGrRyhb2wgVxbW+yWymDnnhpsu97bM0gZQ728wZv1r98x
	hHXdgZWHAuhX1YDt9vyD11OTLFL8FbJnkNoQWRuTzTq4NzmVLnvtzsOpI0gNxzxX
	8oKhvjfcxtATjo+go6kgbSyoCyfw39Y+DBy1pgc2HnC2dhZsSRQ97FUNQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyh6b0077-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OIUM6j018115;
	Mon, 24 Jun 2024 22:02:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xu3a91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OM21kh18612814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 22:02:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A10458064;
	Mon, 24 Jun 2024 22:02:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD35758066;
	Mon, 24 Jun 2024 22:02:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 22:02:00 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, noodles@earth.li,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils][PATCH v2 3/4] CI/CD: Prepare Ubuntu 24.04 (Noble) to run provider tests
Date: Mon, 24 Jun 2024 18:01:56 -0400
Message-ID: <20240624220157.2248556-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624220157.2248556-1-stefanb@linux.vnet.ibm.com>
References: <20240624220157.2248556-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PvWUeSvKPky1CxXmYSDfkkeV2CokKlTW
X-Proofpoint-ORIG-GUID: PvWUeSvKPky1CxXmYSDfkkeV2CokKlTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_18,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=699
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240175

From: Stefan Berger <stefanb@linux.ibm.com>

With provider support fixed for Ubuntu 24.04 (Noble), prepare for
enabling testing with it. To test provider support on Ubuntu, make a copy
of the debian.sh install file and enable the installation of provider
support there.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 ci/ubuntu.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)
 mode change 120000 => 100755 ci/ubuntu.sh

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
2.45.2


