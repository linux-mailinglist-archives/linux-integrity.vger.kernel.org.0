Return-Path: <linux-integrity+bounces-9213-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wRT6CToE4WkLogAAu9opvQ
	(envelope-from <linux-integrity+bounces-9213-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 17:46:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 933AE411337
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 17:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B3EA303323B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870C2882B6;
	Thu, 16 Apr 2026 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hUqScc5m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940E1E9B3A;
	Thu, 16 Apr 2026 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354357; cv=none; b=pR3DZqtDDsduynzhGeokPR85ltl1o9IYpTVEzJPspORY/a58pq3jTS5lWNMDJ8XnYueslcAPCNy4eUVXWjK7aOJA0z2eF7bvD4l199cHWb7Fkaud5kbFjDofrNJ0Ed/T4929iAnq1UgUomaqVKVtySLtam2HbHJ/+CmvRY2Wv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354357; c=relaxed/simple;
	bh=+UPMKRQGt2oiKqYwpxIjDTS39Px41gwCkqKJkh8yXc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQ16ame+J01Zehg8nv3qSGuqVPBRFL/P5xv3wIQHKBLZdcciS/eDPsVCFbxVMHS+wZnbdo8PkmDnBJABzysb2NWiQ11TXdMVFdOdDq0pi5+FbMXGwzMdvJgMKrf3tVSJ0EKSCGCG5HWjmQXyeQfBH2gzYQdn+/2Z0KvGx7TFZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hUqScc5m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G85Tm81833338;
	Thu, 16 Apr 2026 15:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HsIV1xEB9fQ/JWCdHfzfG4/zGhRNUgvR6kV9Gf3VR
	vE=; b=hUqScc5mu/cQUVCJ3YaJP38+AwIZ+3+oIQLbd8ZX3ZflA+HpDrtsSSOAi
	IVzFEIcMWh0HrwC6z6BhSv60LWOsFchkEjvAQ1j0ezb8BXVpud/fMygrLN9Qqnk3
	Tq6QVrY8Pek+Vw2QzrAwvkV3aza+LLgx5bcmUMaTIOpqq2psz6ruRtJZ5AA2zQ5X
	NuFTX3qCRQym1vD8FqEGmida11XqzM3mzqsLd96ypRpMhij4OYLWPu4G8DbEQWpt
	h12vDlXstvuMPSEkjD5Z271wsncikMFAPQNDQD66CHfGCEU/5AiBz0G5BlPb8bOp
	O4g51st+P1UVNtpyNGuZdlNW/rJ7g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rp8x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GBuMwY003594;
	Thu, 16 Apr 2026 15:40:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnkfs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GFei9Z29229678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 15:40:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF91A58060;
	Thu, 16 Apr 2026 15:40:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F282E58054;
	Thu, 16 Apr 2026 15:40:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 15:40:43 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/4] Add support for ML-DSA signature for EVM and IMA
Date: Thu, 16 Apr 2026 11:40:35 -0400
Message-ID: <20260416154039.1648083-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NiBTYWx0ZWRfXx8wg7EBImvad
 aJRV7VFzdzZuJzvo0wjL+0N0pNob+gGbXg+CCEYsuj83sBTFUl9XK09ERmvPALNcTJ/LHzBT3fC
 DAv9TY+MhpPsy2YFx9U0+35oD6SQxOOkMz7As1AR2gOk9RlSHQRmXINnud67NtxRuSqQqZvHU2P
 5nNbVS1Zjz7+Rq5aMcELqE5bBDCW6MJg8sTbnAvH8N9RmUrzQKmE5IafNycIaZKy41ffItrg6Gz
 Z0ilNxVcLThLB3QtCjIjuUGeYxh6tPHAxMMdC+bwxbGSsJWLlyZOmjBA/NbljsCqZkKpNtYOCpm
 WEP7wYEZ7fSCH0ErNllSUuqXqxSlzRxeyE8WoW23c3EMf34HYSX5RkjTolpOrWOge2HN6UwbZnr
 aVidFBwBS4yvv4/ayd7/Snk0V1sW2N7BSWZqDD8i4GNdptXCTVT6rSnjF8uOCmNtslWuYpIAv5F
 UzcYwDFoNGZC7fGgNQw==
X-Proofpoint-ORIG-GUID: jWv8dB5JhOAR2GWJ9nGvjsUaEjb-qaoJ
X-Proofpoint-GUID: jWv8dB5JhOAR2GWJ9nGvjsUaEjb-qaoJ
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e102ff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=TEWfzw_xA5YbLXciGhYA:9 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9213-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 933AE411337
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Based on IMA sigv3 type of signatures, add support for ML-DSA signature
for EVM and IMA. Use the existing ML-DSA hashless signing mode (pure mode).

   Stefan

v3:
  - new patches 1/4 and 2/4
  - addressed Mimi's comments on v2

v2:
  - Dropped 1/3
  - Using "none" as hash_algo in 2/2

Stefan Berger (4):
  integrity: Check for NULL returned by asymmetric_key_public_key
  integrity: Check that algo parameter is within valid range
  integrity: Refactor asymmetric_verify for reusability
  integrity: Add support for sigv3 verification using ML-DSA keys

 security/integrity/digsig_asymmetric.c | 152 +++++++++++++++++++++----
 1 file changed, 131 insertions(+), 21 deletions(-)


base-commit: 82bbd447199ff1441031d2eaf9afe041550cf525
-- 
2.53.0


