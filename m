Return-Path: <linux-integrity+bounces-1039-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79152849CCE
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 15:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C372843D6
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AFA2CCDF;
	Mon,  5 Feb 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mK9rYzkO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1A2C86A
	for <linux-integrity@vger.kernel.org>; Mon,  5 Feb 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142546; cv=none; b=gH7QWjU3GeGTyv17jAOdwJgcDKIIH6d+G5urbmNjLjByoRBX4QFrPzzzedT8yERzPuXExlD+LM8bU/jNnLPBrg5M3bXdOK/AkIvB+DGgGzCQmMxCEaHcx6dh0XkHZDGXKHZ4kgGxg+uIhwSvR6ZFTCRqU0EFRK06P/pF62WPf2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142546; c=relaxed/simple;
	bh=Y6eMCAEzX/E4S0ajagufYTfPDk723QIYonhFGI+uBfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt8mecfKurBWSwN4nIXhYcsVA/s6tE2oO+jdm+AmdQeZvwC4DVAOhYhexgMkSDTV+K4TahzoNIx4X5J+kd84mJ/Sy+edd/lXDSbKkdHt8v9ZnC/3syYgmrparLFmXQy+m8NKPrfHxtNq3BHNB/1XAxpXYCQG1raY1pgBFUpcNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mK9rYzkO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415E374q013492;
	Mon, 5 Feb 2024 14:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=razTQywDLNbyJz3HNi3brSqQXdoskxSbEYYQoZVe1xo=;
 b=mK9rYzkOJDEA7Q6DbC8/LPhNC+NWo6GRBQPaR0pBPRo1PjZimt19he4FgBiFMsu8INC6
 JdQSk0NRHvAP6bQ1O9EkcO4g8aAoLBf4AHDgCeMubEZelZzQvZjPykdraQst3NWIrY0Z
 1doeEPe6XR/QoOkGyM2auHH5ejqIgOow3OE9zP1KumRDJ8if+LtBuWsmkdGZCW3jIXWx
 LVQmtdG6Q1OSanoRCyTQ2YgvJAcV57G9bdXK6WGyz3d9xPaITVXRg51esCr2/DehSwCu
 85dx+hhV6Ohd1RzHfanWJl5kuzH1N7L4BY6h9qi1KYO1uW7/eonb6tPlPFFDkp2Rd+kn mg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w313mrcym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415D5qkh019985;
	Mon, 5 Feb 2024 14:15:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytss5p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415EFXw640436220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 14:15:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DA2B58052;
	Mon,  5 Feb 2024 14:15:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C29CE5805A;
	Mon,  5 Feb 2024 14:15:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 14:15:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v1 ima-evm-utils 6/6] ci: Install pkcs11-provider where available
Date: Mon,  5 Feb 2024 09:15:28 -0500
Message-ID: <20240205141528.3566511-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205141528.3566511-1-stefanb@linux.ibm.com>
References: <20240205141528.3566511-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5ntH5kYk6zoKKOznGEXc1ghQOBjZNh8m
X-Proofpoint-ORIG-GUID: 5ntH5kYk6zoKKOznGEXc1ghQOBjZNh8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=727 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050108

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
2.43.0


