Return-Path: <linux-integrity+bounces-9076-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAD7Ga8Kw2nQnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9076-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:05:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0770A31D1B4
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FE7A3019F29
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C90E298CAB;
	Tue, 24 Mar 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q1Q6LwvN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518B35E925
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389810; cv=none; b=niMLGQkMksITRQx1xmc3t8s8mYvSDnniGfFp40hgfiGrlq/f2zLymjqFLEG9b8ToP4noAXUVzYhZTdkq3FH+5fTsvMSlorkU+zxMVwDsMbf/f/v1bVgbXyR+5tElDx+V+aP2KHt8n18OQ0l5uGy31cSDgjGd2COKz9BurfCg8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389810; c=relaxed/simple;
	bh=bjwIHGLLegNcz33BuxxyjNfzVIuR2H5SKP10qPTgvdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdg2Mn3aY4fLQaPFCZnx2BpGjxLEUV70cqlRhDOgnRJfK7lp9fXVRcqKRTx0doBCOOuvHICvJXxTXfGgj/sZbF+TUGobosa5eGBknOQUCgI1GI3/f1luvmM7OLIycYC4eHIgFUm/VQkmvfFdkNh6vxYd5hpElwm6FDF16W8+NQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q1Q6LwvN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OHYG8H044132;
	Tue, 24 Mar 2026 22:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VnX7fY+8+now1qa+ofNP7tz7XK9ze63EysjFWR/bT
	/0=; b=q1Q6LwvN8SiDVohr4i4vNO83ks7aToWVs2FvvgwqNXyf9AWSD/Nit+YMC
	s5x7KG/8yNDnC2YDlub6OI5eBbv66wKwWewO8IPpseUF6jd0L06A/tymk73MYjZq
	xKv6bdOc8sdZUAsGmDj8CeUsS8W8gEZw2ZA9Crt7qhVHf+GnHafA1l/1YETh2iHZ
	M7bt1qRaDx+Ixax35vyNREM5ajB8LngqMMik/nNA//wWzEU9SBi/eWkBL2w1zf50
	kU7NOkxMbeATbB1swIyJ/Y00JKOy4QyF3k/+iBqGOvii9y77lmiAAGeaNB9EZTSi
	/PbOE+ri6hY/Dnu8Gk+YyPrvGx3rA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9wwm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJUAcF009115;
	Tue, 24 Mar 2026 22:03:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnm2p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3HQm23462434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C34D58056;
	Tue, 24 Mar 2026 22:03:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25DF458052;
	Tue, 24 Mar 2026 22:03:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 0/8] Add sigv3 support for IMA and EVM and all key types
Date: Tue, 24 Mar 2026 18:03:06 -0400
Message-ID: <20260324220314.743709-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oX5qxTFlbJB49njZKO_XwZs1TUiSzFa8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfX/ONa86xXwU3d
 r6kpyL0iKTDk9AwGuG7LMl9HsTUvR5xPNUKf7m6Qw6amcS9aBACsH36Do8PrXeU4miqWs1ZN8LP
 ETaVGREeBaHIBguJkJN2rfqVmvbdlNiQqVq0W5/Zg3D1IB+GEpZfHIQKhTbpH9G/baehNo/bJdu
 1k3pVsycWiAxISggUR+O0CdMenJPECuMCc9TbEM/mWbSKdbzBPW52ld2tVfuW1Kd/1H5eQyM+YT
 l9dOTmmwAUwYVDgpeXeam4cLT7+QD08Sx3WbwhDK1FSsh9FUalP8olaF/cRxlXmnW9YqJOek0vb
 hNnPQZ2ZFmi/WUZjamqsYFrnF1retomn/QVF/CU/9bvE8f2PxuTcM5hEbhpuANesFvogDdpkzXo
 xU2HhMyIbCWF9u0ROGbwhE2p2jsWFQuTYKbWyBBqSHUC9Ejj70MOo5WX4I6tTi/TutEu0xc3NJy
 h0KoM7B63m5QL6kVa6A==
X-Proofpoint-GUID: oX5qxTFlbJB49njZKO_XwZs1TUiSzFa8
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c30a28 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=-bVt1fKA4n57iD5zKkkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240168
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9076-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0770A31D1B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series of patches adds sigv3 support for IMA and EVM for all currently
supported key types (RSA, ECDSA, ECRDSA, SM2). evmctl gets a --v3 option
for creating the sigv3 signatures and also a --v2 option for creating the
old sigv2 signatures. --v2 is still the default.

Some test cases are duplicated to test with --v3.

Regards,
   Stefan

Stefan Berger (8):
  Implement imaevm_create_sigv3 for creating V3 signatures
  Implement support for IMA signatures V3 signing scheme
  Implement support for EVM signatures V3 signing scheme
  Support v3 IMA and EVM file signatures with --v3 option.
  Use imaevm_create_sigv3 for fsverity signature creation
  tests: Add new --v3 option to sign_verify tests
  Allow verification of EVM_XATTR_PORTABLE_DIGSIG with sigv3
  Allow hashing for sigv3 on EVM_XATTR_PORTABLE_DIGSIG

 README                 |   6 +-
 src/evmctl.c           | 170 ++++++++++++++++++++++++++++-------------
 src/imaevm.h           |   7 ++
 src/libimaevm.c        |  69 ++++++++++++++++-
 tests/sign_verify.test |  31 ++++++--
 5 files changed, 221 insertions(+), 62 deletions(-)

-- 
2.53.0


