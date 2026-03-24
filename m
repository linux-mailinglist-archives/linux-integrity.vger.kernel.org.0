Return-Path: <linux-integrity+bounces-9080-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGLTA8MKw2nQnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9080-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:05:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F63531D1CA
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF83C3028365
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008A333442;
	Tue, 24 Mar 2026 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SMBynIec"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084D23B612
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389812; cv=none; b=TvfTx5zietrNciDdm/VpHaJTHDekkVH6x8V361Pb0kyH3bxsEMOPh+Jk6Av+tKeJYRgYmKcRHDoB+Y4ad0Dj9Uj4p+BMwv8ltXqWq101R5g6PEFwGll7Ka8o0qdKgA2pPDOQZT1rppLRQNTRldrFCbunaaesZsL63SwYHeEOcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389812; c=relaxed/simple;
	bh=ufIGW5fqNxEVNu7JtH9QQ3IiUf/pqW02ip4NF/WQbAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cByeDvXERJEdSUg7d0jZoHTZt+fauneQZKek66XO8EVMbohBhnvSOrSDwMLb6DhVXjxzkXIaFQ+VawA9ryzf6XYbzrCAyVdyRv2Iy04agXuXBOIEaldeTwmw2YS56jL6+zeYWlmon3mU9l207k9fMFqfpTEPAwITw02jsWClJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SMBynIec; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OFSKsE3743898;
	Tue, 24 Mar 2026 22:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i1kGp51gS0aryqo5a
	1nWMg16KJCANoQCgkqHjOTFA4M=; b=SMBynIecQFZZN/p+UVFGgrr8rZxZ+xxXD
	XOn7xtkRbzSUZjqOwltpcbS34Ch1cb4GB11CdW8nAb0AzBSow6VgBYQsr/lP64e8
	XfgHaljTUv7+0BCjUqCkCWIIfHHuDLA2znXXaX/t2DosadTsxJeyGN+Dapq6jtln
	LKoHHFAlhRhShLPAtb2IvBCNrWeirtIWdVHH0Rbl/Qwj3Rv+chc6uZ3bE8sAaruT
	iDADm/TzN9TZgRwT5zds69T8PtymK46hsygMhEq/77peNXhgZ0NOHxqN6bVI1XNK
	0e/dt74nMzfS2MXipV45/v4WHk+28SDrYA5ipEbPQuZbCgBhlMAbw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqdxjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJJdV8031635;
	Tue, 24 Mar 2026 22:03:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsv5pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3K4Z22741728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D37D55805A;
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DD3458052;
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 8/8] Allow hashing for sigv3 on EVM_XATTR_PORTABLE_DIGSIG
Date: Tue, 24 Mar 2026 18:03:14 -0400
Message-ID: <20260324220314.743709-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324220314.743709-1-stefanb@linux.ibm.com>
References: <20260324220314.743709-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FN8T7dLrQnn6XpHuALdde7A3onGt_ath
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfX/NN9i6BnZ2Nt
 Na3Cm888xSxh7q7Je0vyXShALbXogH3R9NwpEWLF/M8b5/uspR905uBWCpletsaCnMkNKSPcjQx
 wzqotpzgIiB3rGuNdv0gStfh9oeaplAasY44vyoaDehPhT35aiEtS+9GZ3Cm0YrUBeEVRsjkmS4
 +ANyp4jNveU5U8XdrJnrh08qQR9x1g1OhrZNKJy62t2zKlnPm6KaNwuef2TI31aUFRYHHV8SAMq
 KeQgHHUkXumAxvQewjTObMGoB697xTTtJrFoZKflIrdF5FCRpBb6Yt/tHKxEI1RKUNOI+p/qxHG
 6yOhximkDmo5wAkfTLnq5LLLIad0oOn+Txr7CYiAc56LYs4AQGH+FP7Oae3onCmQQ8LnR9KjDvs
 tvSb3AhPKKBhnZKlgX7yd3ExmFTzNcKzYAMexu8Xs2IS0Ep+TrIvxeT0VD5Qwp+XChKrEnbEORn
 /80k5tKRlD+4H8muqjA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c30a2a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=umbOzg4GSnhNpTA8p7kA:9
X-Proofpoint-GUID: FN8T7dLrQnn6XpHuALdde7A3onGt_ath
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240168
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9080-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9F63531D1CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To enable sigv3 for EVM portable signatures, enable hashing for sigv3 for
EVM_XATTR_PORTABLE_DIGSIG.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 7c78432..49bfb62 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -623,7 +623,8 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
 	unsigned int unused;
 
 	if (type != IMA_VERITY_DIGSIG &&
-	    type != EVM_IMA_XATTR_DIGSIG) {
+	    type != EVM_IMA_XATTR_DIGSIG &&
+	    type != EVM_XATTR_PORTABLE_DIGSIG) {
 		log_err("Only fsverity and IMA/EVM support signature format v3 (sigv3)\n");
 		return -EINVAL;
 	}
-- 
2.53.0


