Return-Path: <linux-integrity+bounces-2925-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB091598B
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 00:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B0A1C2247D
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214621A256D;
	Mon, 24 Jun 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tqcg32Lg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A561A2554
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266531; cv=none; b=RJ2lLnQL+csKe1LUzqWrg7R8/xyYtfidHcVCrZkm8AWWDrfkOZ60dQ1ChMPVRNMUELnUlRMXNjCzHTgS+e8BUt6+lItGejU2pP3TVYv1/Wou1foIy1Wp5T6ig5m5kWVHizxne4uSJRKArdzHjjgh45YNL74+MkogfZ2bNqNXpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266531; c=relaxed/simple;
	bh=K0PaBxKiaOYNdfWl5Wbqu93EnQ36lUwweTbgsgMpJsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7U4zVlKq6Gd/FAFLKV3JxFzGLHlP3XtGenWSJadoS09Hl+IdWauNl1UWTAQpGgsbKuFHGY/D7mwxXjbqWh2n82aeXH1Ds1TKoUNNtajZ7a1oKnKPoyz0+IxNA3m73vAQj+Chvb9ICCrrP8eyei+HwqmbS3hGM2luZk9DTDQUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tqcg32Lg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OLvANM023731;
	Mon, 24 Jun 2024 22:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=eUWYv3t7kdrCZ
	g3v8bfDt0tJ7Abpgg7TeDIK8tq6jMs=; b=tqcg32LgaPBQnmk8cl6utYB8xCPBO
	fhxsqbyyGNZn8GbV2H+o7HHXPsnrQOgh0lEEMWzOcq3LyCMhZcDws5fP+9SPHNgz
	tl4eUEdTP3AkEMfOxpOX2CK/QdmjvLeyHIuK9hGLAQPCBRNRT96r6hMnuiX4NfTJ
	ssCz3gwkt/0S00YL9W6z1ERMIzgBe3ZmBebS2wsvJLtknZxgglbV1Xye+FQI4CpG
	uGfS1EdgwA6FjSKb5kLU2y7hs3IN12GkpO6NjDNaPHKOplYI4kLab1hhHSCU/zsW
	ICFL3AVJhfOk/mfV2s3CeWC0j+vy210R6Py88gs+aS0/wfM909d3UhAMg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yygad843x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OIwZFO008196;
	Mon, 24 Jun 2024 22:02:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b0k8ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OM22CH18547450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 22:02:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA07F58062;
	Mon, 24 Jun 2024 22:02:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F9CB5806C;
	Mon, 24 Jun 2024 22:02:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 22:02:00 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, noodles@earth.li,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils][PATCH v2 2/4] CI/CD: Disable pkcs11 providers for Debian and AltLinux
Date: Mon, 24 Jun 2024 18:01:55 -0400
Message-ID: <20240624220157.2248556-3-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-ORIG-GUID: Hg6PWQvYa8LaDkK3saMj6Vf3fhEP2Z35
X-Proofpoint-GUID: Hg6PWQvYa8LaDkK3saMj6Vf3fhEP2Z35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_18,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=675
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240175

From: Stefan Berger <stefanb@linux.ibm.com>

Disable testing provider support on Debian:latest and AltLinux:sisyphus
since both now get stuck while running OpenSSL provider-related tests.
This is most likely due to an update in a dependency (OpenSSL,
p11-kit-modules, softhsm, or others).

On AltLinux the issues is related to a pthread_mutex_lock() down the
C_Login -> C_OpenSession callpath that blocks forever.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 ci/alt.sh    | 2 +-
 ci/debian.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/alt.sh b/ci/alt.sh
index f86dcec..f1eefbf 100755
--- a/ci/alt.sh
+++ b/ci/alt.sh
@@ -28,4 +28,4 @@ apt-get install -y \
 		xxd \
 	&& control openssl-gost enabled
 
-apt-get install -y pkcs11-provider || true
+# apt-get install -y pkcs11-provider || true
diff --git a/ci/debian.sh b/ci/debian.sh
index e1bae43..34125d4 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -59,4 +59,4 @@ $apt \
 $apt xxd || $apt vim-common
 $apt libengine-gost-openssl || true
 $apt softhsm2 gnutls-bin libengine-pkcs11-openssl || true
-$apt softhsm2 gnutls-bin pkcs11-provider || true
+# $apt softhsm2 gnutls-bin pkcs11-provider || true
-- 
2.45.2


