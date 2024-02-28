Return-Path: <linux-integrity+bounces-1495-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1686B47C
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 17:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747311C226A9
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5A3FB84;
	Wed, 28 Feb 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KIIh2e6P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52AC3FB97
	for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136877; cv=none; b=m1PFbycEyWCl+5zEGTuwQUcs4uP+y4ejVV0py4LG5zhosCtDbaB6z8ovMjpB4Ivf/BKAC1dXizFmp78tyoS1PZ+M0VsRtR65BIGvtxF48DCSu4AgsdgSzTFTar4V5nkuAkbl+toYRKDF4r2bkXECcYKTfKbq/2hibIAa+BgIxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136877; c=relaxed/simple;
	bh=iNA/kc7UPyjMMK2i3x91mmPz5yfBx9he3h/LXxVBrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uq1goZMkh6zQ8OAP57+Vb8Zrdn2FtoXCZbmye+yjgdL5GvJNsw36OSI6kG6LiZo5IU1FO25QEnD68te7jfvcnNIELXsssfvjUdwMJcVBE7pKZvO9RiFz4MQchcr7R1/VdkRUmXbkxZkEfrgkFAwd1b+vl8uSkQ/QTWgsiMOczps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KIIh2e6P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SFsmpa000418;
	Wed, 28 Feb 2024 16:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g/mtk9QchJ3u9KHc8aPW5RPudytJFyvaugHvgkEX84A=;
 b=KIIh2e6PlCLDSi93CTJY7D7/5zJUS1OnH7XnzzQ+YXko0Au3/o6BMAdvRkX8hswXxisQ
 bHEP1+1a3Wy4sMubT7K6RFMo7Cl8QHzodHqORErm5IlRQqXj2LKphfDHlKY72RoQExgi
 RyqLmsw/zdLPqR1V9+O88lNSZ49J65IzGBUPMJ3ksZm0x+qx3QgwVMSpIk4TH4kg0uA4
 I0Yo2jxAYPk2Ako7ibUAE8N8753dOGM9s18CCeuT3ezhVMFzOJ1guWtALv1lhUV0m1tf
 Me+ej8WXnzAKnqSfgmCCPEWUkzjU8EWqUe8zt8n451g1DYBpDBDHvG/ULl/5nlUbR+fN Dg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj74rtfcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SEKc4F021728;
	Wed, 28 Feb 2024 16:14:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu607fur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SGELc247907508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:14:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F16705805F;
	Wed, 28 Feb 2024 16:14:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9779758055;
	Wed, 28 Feb 2024 16:14:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 16:14:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 ima-evm-utils 7/7] ci: Install pkcs11-provider where available
Date: Wed, 28 Feb 2024 11:14:07 -0500
Message-ID: <20240228161408.284098-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228161408.284098-1-stefanb@linux.ibm.com>
References: <20240228161408.284098-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aLE5tSCh_Yhs3fibUkX9uHu-fsins16c
X-Proofpoint-GUID: aLE5tSCh_Yhs3fibUkX9uHu-fsins16c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=841 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402280127

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


