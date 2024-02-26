Return-Path: <linux-integrity+bounces-1479-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E6867FB7
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E05B22C55
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EF12E1CC;
	Mon, 26 Feb 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hU8R6LHs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FE12EBEA
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971684; cv=none; b=INWvdQPHxi91LDN02MGWLDrfErldEy6P72V8fK4VvfKe61zRgmqkpZenZbkvha4bwdJ5cJjwOxnYJYryGHg3k73SB+uUe41Il8tBG+aqVyX+bGEzMrH5iYSuBfEJS0PZmX5Xe0wC5T4x1vqDIHCuwO+9B/Dp5xd1kdIGV5H9zxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971684; c=relaxed/simple;
	bh=iNA/kc7UPyjMMK2i3x91mmPz5yfBx9he3h/LXxVBrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBr2RGeNljGq8+acvDNqYmJxHzC9I4SpEatmiVMfmF5dy0koSrey///TnWqvqQ3Szf2Ti3NO+syy/nhPBJ9/bHAFhovq+uBuPTAOjV8kZlJQDP+3/2gOvJYu2lj7FG4GPHmtgOFo/R3ZWkUR/Ma5YSpcTLIRtgN4Kp4GLYjh1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hU8R6LHs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QIDB4B016041;
	Mon, 26 Feb 2024 18:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g/mtk9QchJ3u9KHc8aPW5RPudytJFyvaugHvgkEX84A=;
 b=hU8R6LHsRkS2F9vOyMH3EegvfxQCIAsIej4V2R8hM9JlwSatvQCAfpjxLY2+PUIe5zYZ
 Lc8xIIEXsmvsxOi77ocAwkTzArMEerU57hLYLGyZzIuPbblYnJRZ7EquZsiJjmqzhc/d
 IronghYXQLc7iCjOSE9tpnUJINQTLk00ZTBhzNndud83n3zRVYAIAnQsxURq61v1edvz
 RaY+S4JUMR37ld6rCBRV5D9H1FZgm7jn4T+HJ2WXFm6LInEz1uz0pTUUQ810qzdxz4yV
 iufLoa3N8sYb+pZQ5BvRyB9mRXhcfUQMNnSiRcjZpOXZRlHBNGaD298m+bEoI9E5DbBQ KA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgyqm85bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGRMcn021756;
	Mon, 26 Feb 2024 18:21:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu5yu2sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QIL91w18612982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:21:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E84815806C;
	Mon, 26 Feb 2024 18:21:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6042D58059;
	Mon, 26 Feb 2024 18:21:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 18:21:08 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 7/7] ci: Install pkcs11-provider where available
Date: Mon, 26 Feb 2024 13:21:01 -0500
Message-ID: <20240226182101.25210-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226182101.25210-1-stefanb@linux.ibm.com>
References: <20240226182101.25210-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RMT9O6yG4Bmz_sBGyy-MMQVXRAATU5kl
X-Proofpoint-ORIG-GUID: RMT9O6yG4Bmz_sBGyy-MMQVXRAATU5kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=841 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260139

Install the pkcs11-provider package. For it to be useful softhsm and gnutls
are also needed, so in some cases install them together so that if one of
the packages cannot be installed then none of them are installed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 ci/alt.sh        | 2 ++
 ci/debian.sh     | 1 +
 ci/fedora.sh     | 1 +
 ci/tumbleweed.sh | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/ci/alt.sh b/ci/alt.sh
index 36ff657..f86dcec 100755
--- a/ci/alt.sh
+++ b/ci/alt.sh
@@ -27,3 +27,5 @@ apt-get install -y \
 		xsltproc \
 		xxd \
 	&& control openssl-gost enabled
+
+apt-get install -y pkcs11-provider || true
diff --git a/ci/debian.sh b/ci/debian.sh
index 7676191..740eb9e 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -59,3 +59,4 @@ $apt \
 $apt xxd || $apt vim-common
 $apt libengine-gost-openssl1.1$ARCH || true
 $apt softhsm gnutls-bin libengine-pkcs11-openssl1.1$ARCH || true
+$apt softhsm gnutls-bin pkcs11-provider || true
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 1d17c6b..44fd956 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -60,6 +60,7 @@ if [ -f /etc/centos-release ]; then
 	yum -y install epel-release
 fi
 yum -y install softhsm || true
+yum -y install softhsm pkcs11-provider || true
 
 # haveged is available via EPEL on CentOS stream8.
 yum -y install haveged || true
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index bc111fe..a58c296 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -48,6 +48,8 @@ zypper --non-interactive install --force-resolution --no-recommends \
 
 zypper --non-interactive install --force-resolution --no-recommends \
 	gnutls openssl-engine-libp11 softhsm || true
+zypper --non-interactive install --force-resolution --no-recommends \
+	gnutls pkcs11-provider softhsm || true
 
 if [ -f /usr/lib/ibmtss/tpm_server -a ! -e /usr/local/bin/tpm_server ]; then
 	ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
-- 
2.43.2


