Return-Path: <linux-integrity+bounces-9122-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJgWL3js0mlBcQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9122-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 01:12:56 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F26C3A01BF
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 01:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 888E03007AC2
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Apr 2026 23:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE9C3845A3;
	Sun,  5 Apr 2026 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ATwzVdR+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642B26B75B;
	Sun,  5 Apr 2026 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430770; cv=none; b=YmGmV/VBEhSs5i8XCZtPI9cMTMAluHWHYCfFOIAEVFPBSkiy8cn/WFcbSNRDSxM/tMIGDyBQGJDjQzEcwWnrdApyM9Z7+WDmSUmywd+sVqIyUS46KzwsU6gTm30x0JaZzA6JH1rNi9rKJJ3/VfkyPhy3arkynjDorXnM06hPe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430770; c=relaxed/simple;
	bh=xXl5ZKwPwjPyG+fChdAPLp1nJ01TKyy3tjcBjaeNgqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n67qkEy2qd39Decw4Fd6M8wcdtzMYn3+fmxgimvMYNfqLYyOqpKiKQ/vGz0XWqRpH1Bcm5NXVo2ScUrTrmjHX/BE+A17HS7QLatZ/Mkc2eGYOAUpeIAdK63RR070opxbcb2xeP2nw4ZwC4BZZe07eYgb3MbdHCjfmNq1C76yw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ATwzVdR+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635KxgQ13589057;
	Sun, 5 Apr 2026 23:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZhQiNzLb6ES8YivKFAR70nva5SkmipR8ttWBE3KlG
	a0=; b=ATwzVdR+qCYViSKtsx2mLicwNexTTZEa9duVaj/YGhFNMsAiuVkZYjw/Q
	T835nxlTVRfYYcKHR2AgZwnC1UVAnOkAIv/9ssj7biTWGgWur5/GKnYh1eGKbxe+
	J9+LdqViI+LeDxh2UiaADKOHw60KV1zhglQId3Cechl3HMCerae/dvaHJ0h+lI0o
	jvNlQZ3l/QWTG4hf+2/pCm6n7pmxwRE0OkQ8dLaE9XZ4OUNZSmhXLbr0cv3iqi0g
	LHlveb0PcdJuFeoMNLuc+nnp27CjN2XuxNizoNMAe5kt9gFjP1eVCX3CLztuDPU3
	CanSdtl3uVosrPOZR5ChMhSg3OuFQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dar2gcdnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 23:12:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635MFfHu021334;
	Sun, 5 Apr 2026 23:12:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdbyargy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 23:12:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 635NCWWT30802472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Apr 2026 23:12:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25EDA5805B;
	Sun,  5 Apr 2026 23:12:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680F858059;
	Sun,  5 Apr 2026 23:12:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  5 Apr 2026 23:12:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/3] Add support for ML-DSA signature for EVM and IMA
Date: Sun,  5 Apr 2026 19:12:21 -0400
Message-ID: <20260405231224.4008298-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -JaDRlSmmcmS6v8N6ivBu5aXB5UwCZrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIzNyBTYWx0ZWRfX9HNTZ0d+V28s
 Dmi79SuVYtO0kzTINh701IMdz3bijIjHix+eND09bWlesc5qjsYBP3DuuO7PQQwh8aWDqa07tGa
 NON8UcWlgZqmei+VKuMu6j7YpIKj6GFo/gf/IE8rCPWMxpDmnP+EtF7vGITWwt7RD1SIwvPutjY
 /AZL+IJbtEnclXsbPMKpFBJv5YQMNku0iE9XL3Y6BB+YbOdG+GaDVh0TBNieb6c0w9YDjZz5JdI
 fOIY0FsV6E4ADFsupaq8Ke5vUsfMw6AuTfGTcxKe92cGJ9fzXmJZNvDn0iRtLcVQu6zZll5UNfQ
 dND5gN+8IA+u64tzDbUvtFnphRxog61kC1IgqxJPBgjqItwCKdTAgaglKGFG9rvJZ8xX4CjQCsV
 SRvsUThq0NKcRGEscF0IBxXCeChYmyGpgiiJDtA+3G5TOG6FieWVADaxJbMn0MjPx2yy07A8LTp
 KSLDNzMWIFJaSaTdBSA==
X-Authority-Analysis: v=2.4 cv=b+u/I9Gx c=1 sm=1 tr=0 ts=69d2ec62 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=6z2kdCIDKq9zZarjRZwA:9 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: -JaDRlSmmcmS6v8N6ivBu5aXB5UwCZrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050237
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9122-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1F26C3A01BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Based on IMA sigv3 type of signatures, add support for ML-DSA signature
for EVM and IMA. Use the existing ML-DSA hashless signing mode (pure mode).

   Stefan

Stefan Berger (3):
  crypto: public_key: Remove check for valid hash_algo for ML-DSA keys
  integrity: Refactor asymmetric_verify for reusability
  integrity: Add support for sigv3 verification using ML-DSA keys

 crypto/asymmetric_keys/public_key.c    |   5 -
 security/integrity/digsig_asymmetric.c | 126 +++++++++++++++++++++----
 2 files changed, 107 insertions(+), 24 deletions(-)


base-commit: 82bbd447199ff1441031d2eaf9afe041550cf525
-- 
2.53.0


