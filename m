Return-Path: <linux-integrity+bounces-2405-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726FF8C5AFF
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DBA28255C
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F881802D2;
	Tue, 14 May 2024 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bZPAKUBU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474A1802C6
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710998; cv=none; b=FiQjjpPs1RBU2tNDsu9q+PzNsXpS5z6t5RWBEaRXmjJMP9cujy47LCiN3wmAySyGZSBp3NV7M2zCM6A1lYGNYJeDGcKHz8iuLxm30aI2SPJ5JAotUnD7v2UX+/8/5ao9M94VxzwGzKK3bzNdLg8u1uVbocdJ8QsK65RObek0HFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710998; c=relaxed/simple;
	bh=jkAEtd3gIfVw32C/yi16Db0Hv9RIPMkpd1OAL+owqyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCH9+aefS9Jpka5UZ/OlRU7ZETMFAFCF5f6xqLXX1+hUpo85iK5hZNvp0Ej7YCaeEdSSMnVadBSSgqAcgZHZSEQszxUNszjxOkl+61NCkJdemvtltLTz9F+eY9Cbcx4+FO5GboZO5vj6Z98Et31Dgl3Va5ea7kISsXrno80m4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bZPAKUBU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHuun1032515;
	Tue, 14 May 2024 18:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nIgXHatx5AhlVOb1f9yUU8m/7PvN36q0dz+M/hWWJJU=;
 b=bZPAKUBUuLj+kyWDLpwkyxZ/OfuERrnFEP8Szec+O/t4K8qI2BJ44X38uDdZjKvdIywo
 746xul1lbP+n3iZatVzU+U3TD9HZYBZe2MMSz/lmiygEedMR+ruAm3ApghHFP+gslDfe
 9Apy4SOosSJ5phy/7koFTbJvJ+gscKh5SBR8iqCGuUdrTYLd0BWZaYUMRzvWc4WZq78V
 tqeh8mqnvNuB0vILjuJ8TeihrOsl3rF/T9NFE2xCB1fQ+iwDrrKS0hiiOWfjN6hg1xKI
 dBY6Onibn02oQ6BFzf6JOtcQawykLCm8HjrAmR7bJVF7aSywLyCkI+bxRgPNRtG3/VHf 0A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4ct9g1k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:23:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EI2E1t020460;
	Tue, 14 May 2024 18:23:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kcyy3gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:23:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EIN30q8978946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 18:23:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D3E758066;
	Tue, 14 May 2024 18:23:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEEE558062;
	Tue, 14 May 2024 18:23:02 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 18:23:02 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 0/2] Fix issue with tests and provider on Ubuntu 24.04
Date: Tue, 14 May 2024 14:22:58 -0400
Message-ID: <20240514182300.92440-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9VOGzh8OZP2phQmRvzxGmGLA8hsW9159
X-Proofpoint-ORIG-GUID: 9VOGzh8OZP2phQmRvzxGmGLA8hsW9159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_10,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=605 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140130

The 1st patch fixes an issue on Ubuntu 24.04 due to which an OpenSSL
provider could not be used.

The 2nd patch passes --engine pkcs11 or --provider pkcs11 options via
EVNCTL_ENGINE variable so that the proper values are used on the command
line for a pkcs11 test case evmctl.

Regards,
   Stefan

Stefan Berger (2):
  evmctl: Replace OSS_PROVIDER_load with OSSL_PROVIDER_try_load (Ubuntu)
  tests: Use EVMCTL_ENGINE to set engine or provider for test case

 src/evmctl.c           | 2 +-
 tests/sign_verify.test | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.45.0


