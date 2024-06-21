Return-Path: <linux-integrity+bounces-2898-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A79117D2
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 02:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF4FB2190F
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 00:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535C5EA4;
	Fri, 21 Jun 2024 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ye7fmycd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B51197
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718931574; cv=none; b=bQIvaBGWSzZGxrbzwMlSLU3xIGJdtVu9Hsnih1wUpLc17ptQxHCfao+dXkQL4lon6XGIIY/AqVWARdkFoXOarxy28V/1R+dRbv66azwrCsx2EjcUR6VWG2UxUeHW+J6b0UJ1SoHNlEdeq9q+BMdVx66JAwOWnNSKWd+TM8HqoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718931574; c=relaxed/simple;
	bh=mtnpJpVNOxDSYNzrCPxtmj0JreNV2ScktFRyYfyIbJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpy4R7S6X7af2umjv3rY9fiPtec5v03LGhhCFqIIaHmTszawwQTSSKr2L7TMlr62EJyH1ovIgBMFT+E0nF6qiIcPi5Z/k2qK0hL5oaSMQNWR351cQgKw4vDB787Dm6jj0mNLEKaQdnHhlEtw/Wn5w2QT5Ijklwc+cMh8hQSV/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ye7fmycd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0RKvj025221
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=rhQjeN3iYO8Ej
	PN8Fdjq3snF57dBV/HMi+ZylvaS0MI=; b=Ye7fmycd5ViIsf7QR0G79NBJ5rkGC
	3PRE6LUbajIyawpi/yjLS70ghz6YzdSKR+3KPZ14io+flvU8sWp0AQBowSR2GZL9
	hB1zy59lVVlcm0DnT7t+IMz1GLmw7EJF2oP86XE6r1Si7HwMt0qDqx6l/AhuLoKF
	bdt61DFCYGGqDeKV1iLGr4bbQTfqE7V+AcvtbH+uIDxlLj780C9rmzuhU0SSXApc
	hR7MQq2/ljxb+iXH7SD/LYf4VBEOJFtqa1lGZvF311PFDOumMNg+S6fOPOPgqZzX
	+3JdoKg4m8QJPBzezHEFTEAkuORYidbvowduE/lBaCrBEoxnmndoVzxDg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvwpq86tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0DBOV019999
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrquju5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0xPBn24314560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:59:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68B2D5805F;
	Fri, 21 Jun 2024 00:59:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0031F58053;
	Fri, 21 Jun 2024 00:59:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:59:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils][PATCH 1/3] Call OPENSSL_Cleanup before main exit to avoid crashes when engine was used
Date: Thu, 20 Jun 2024 20:59:10 -0400
Message-ID: <20240621005912.1365462-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FQ7gx84gEdWGHvscyc-TecPH5_jVxmcY
X-Proofpoint-ORIG-GUID: FQ7gx84gEdWGHvscyc-TecPH5_jVxmcY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 mlxlogscore=792 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

From: Stefan Berger <stefanb@linux.ibm.com>

When OPENSSL_Cleanup is called via destructor after main() was left then
evmctl crashes on Ubuntu 24.04 (Noble). This can be avoided by calling
OpenSSL_Cleanup explicitly before leaving main().

Link: https://bugs.launchpad.net/ubuntu/+source/softhsm2/+bug/2059340
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3ebda6f..ad75853 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -3347,5 +3347,8 @@ error:
 	ERR_free_strings();
 	EVP_cleanup();
 	BIO_free(NULL);
+#if OPENSSL_VERSION_NUMBER >= 0x30000000
+	OPENSSL_cleanup();
+#endif
 	return err;
 }
-- 
2.43.0


