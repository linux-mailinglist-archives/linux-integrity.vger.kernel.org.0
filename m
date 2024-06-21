Return-Path: <linux-integrity+bounces-2899-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB639117D0
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 02:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8221C22326
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 00:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA5197;
	Fri, 21 Jun 2024 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ssufC5MS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18A4411
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718931574; cv=none; b=EcMTraTMIphbHY/sZkje54STFw9Y8JKu01rdmM+Nt9JA92lW2pDpSGxwNTUPf0il8u3XTZG0vGRYmJqdrONmOT1ExdtijSbxOBRCVHoNk3GG4VXZGjKD9yN2N8Cd3mNU3YrvFVYoasNJRFH9UXOUb8FEcO7/w7br3yBKLtDafGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718931574; c=relaxed/simple;
	bh=w9zgOwaeD7vaHA0tnaf/+2LFDBTJA1wxkjmqLSjMARM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRpg2/IQ1/el8wIPWDU5eY18p6H2RnswLPPyqkoavzanOd6eyzVQUvr+TQ60h2pzMgCRjOmL6zKF0Ax7IcvymTXA14+7q9qfAfBeS1s9XB5QL9PlN8Ay+IRUl7rwkfeU0CRkDcOnAscqrzTbvjBFRHtaSH8FSHZC54l1JHedcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ssufC5MS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0L1DO027629
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=YS6PhcmGli2BE
	1WKnwR/QBL8pKoCJXDuhtH087PS4rE=; b=ssufC5MSZIhg3zKI0epTxCmNUE5qK
	WhfFw9h7smynk1wQQFTM6yvqNHjfrsY4GxHDMFwH2ewEGm+z0hDG6VqkrSzqh6en
	01y8IwF7iRLLBEwZYI3DVNthb+W4UuH2RXU3S+Wjzdczoe0c4xGSP/XMQYVppNXf
	LWI91JhWHHpx7rWn35BVTyXTvCax5Bzx3YQINjpdEWMhOLqRHV7jgmSV5uqKMdOG
	SqQNGf5EVtBouNpTH7VisvdLSfE9SS3H2ten7gyPbgTnuuY1Ez5trBHWxbgP4eYR
	T7AyRjjSOiuyCyuTK2bbQsSZICqNw7PTB8kg4cw7n1ESek9hWCT1LnJjA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvxjjr32u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0LGOb025644
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrqv2try-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0xQ4v21431030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:59:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 008BF58066;
	Fri, 21 Jun 2024 00:59:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BEC158053;
	Fri, 21 Jun 2024 00:59:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:59:25 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils][PATCH 2/3] CI/CD: Disable pkcs11 providers for Debian and AltLinux
Date: Thu, 20 Jun 2024 20:59:11 -0400
Message-ID: <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: ufxoxGY9hmMQmZ0ZVxTzLcjN_GCHXBAy
X-Proofpoint-ORIG-GUID: ufxoxGY9hmMQmZ0ZVxTzLcjN_GCHXBAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_09,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=626 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200174

From: Stefan Berger <stefanb@linux.ibm.com>

Disable testing provider support on Debian:latest and AltLinux:sisyphus
since both now get stuck while running OpenSSL provider-related tests.
This is most likely due to an update in a dependency (OpenSSL, libp11,
softhsm,  or others).

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
2.43.0


