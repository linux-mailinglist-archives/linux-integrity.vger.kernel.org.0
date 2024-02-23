Return-Path: <linux-integrity+bounces-1415-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0E08615D3
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610571C2446A
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3F582D79;
	Fri, 23 Feb 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Eg5nM53N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9382882
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702242; cv=none; b=BMEvFM8UbnVe2PWhDFXqht7BDW0gBfOiOXAEEsXc2uB0ZliLiFq7a9HUTTAh1YFkuEVQ8bZ7hq3sbcdp2sEKOyV/ESqFh6ZpnMqC+CFnVw8Zez+fMKcWiL9TJqxJjLuEJqDo+uj31j9owoTS3uG8zSMrm2C0kYDY7P7EUYqRb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702242; c=relaxed/simple;
	bh=iNA/kc7UPyjMMK2i3x91mmPz5yfBx9he3h/LXxVBrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNqjM75TMlwmkALe7G5WoTM2z+VpY48ka75KY+zS6JT5puRuNHh4VjC1RmmMTZAJsdtvb/iJM/VT+Wfe1+x/vgTvPj1LQYXA4ILQhy2TkMtPYPCjj7WYLmM43bLXpFw9Xovu7wnoErqP8dBnjbivF+yot3hIoU2wiFGnO5oD5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Eg5nM53N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NF1DkI032634;
	Fri, 23 Feb 2024 15:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g/mtk9QchJ3u9KHc8aPW5RPudytJFyvaugHvgkEX84A=;
 b=Eg5nM53NqVAaZE/Sgf/PVGynhcqZCzwVFlAegcX30tSVinq9/06+Nw6e1z5zgWJ7Asly
 dh8PDg7jhA2skfF5mBb2haejahLjC/hfRQI9Wk2UzCRYvjbiZUV4efUPi3xGZDK+5Ty/
 uOQC+SWbr2OPZWXDvOQu9o5fTC1oqrIYlTsfi+ln8eT7W3715dJEzvIJ+BX4X/K1XaVX
 DRC07wm3TgkbbqoQrGJJhBzHK6BEexE+MBtx46dsKHNzHP9EBDiXJvV5SisA0/dcN+DD
 ukPWyXlzEXn6cWV2CQi7kfmie5vOvuJLmgzTT+rLunHsaaGkNSBK5mK2LF8lghLqwkgG Mg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wew4whh9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEPokq009547;
	Fri, 23 Feb 2024 15:30:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84px72a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NFUOsX66716040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:30:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2D1B5804E;
	Fri, 23 Feb 2024 15:30:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41B1958073;
	Fri, 23 Feb 2024 15:30:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:30:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 ima-evm-utils 6/6] ci: Install pkcs11-provider where available
Date: Fri, 23 Feb 2024 10:30:14 -0500
Message-ID: <20240223153014.4048133-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223153014.4048133-1-stefanb@linux.ibm.com>
References: <20240223153014.4048133-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VD5SOfRAwDq1I-xDAJv7p6Sd3mSQN9Hs
X-Proofpoint-ORIG-GUID: VD5SOfRAwDq1I-xDAJv7p6Sd3mSQN9Hs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=841 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230112

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


