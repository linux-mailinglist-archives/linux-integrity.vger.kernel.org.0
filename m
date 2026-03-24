Return-Path: <linux-integrity+bounces-9081-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAHPFskKw2nQnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9081-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:06:01 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8A31D1D1
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 385C93029E46
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164F419343E;
	Tue, 24 Mar 2026 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GYnkd6IZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD182C11D9
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389813; cv=none; b=fispKc8vpcen+KIDeVk4tXUvUgpVBz48PlfUAoSb58QVDx3+dNJFNRTHW9GEW+jrfaD0/iRbZEiXtKOhSFJ5IfyAAGw+vV98nzXKx38lD2PYbMpEIoA/I9ZEzN2E/n4hJgXoz6Vy+4q1xr3sJ/Mj2MZkJcSlv8+wbQ8RcPHG+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389813; c=relaxed/simple;
	bh=hWpjj9FK4vJWnv7kPHaYm5Uzm9WjP5w0FaNXvLFulxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpMFi+DbG4CWbUpKQ+n1WtdLrO0dFNa9VMG/rUIscS9KdUHXK7HHhBGgVPr1F2GiVvMbKhKWOe4p1pgiliPIIE7IA+T19F4wklwV7SP/SB2H7JOxTixv/27eFNgntYe02rFmMJV7mrmKild71Y51hVId9z3ArefTxi58iC3TRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GYnkd6IZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OHpdkM504443;
	Tue, 24 Mar 2026 22:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gRvUVA+RUUXz0DiyF
	hn61k4WLv0cFOPoEVVoM+IykfI=; b=GYnkd6IZvlRomD+BMGsiiFqJGCuBIVWvT
	INRhQBGDQjR1jDXwbBGBGb/zqrY58vNsv184cq5wiWlDqacFcD0bdn0zib90ckYr
	PsTMU7tk9eRXIkIn5O0ptONIIr4TpOxE488oHqih3i+kAAUi5UMN533i7v2FsomQ
	ieNrS2pi4eQgjSWX0Duvl7wultiCCIeaUo2WpjGhMwTcsmWEyutep2StzHfLgxsF
	ycZqHgIcyJ+AjbTPKRr5HRC/W3HSsn4eGOK7hsSpuHabqO+SYCVTLKw7P3TvrEvf
	8E8ftckJEyV5KEeVUcgJUkJ+TgJ8b7clfzXkrulslyzdnc1Fklcag==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqdxjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJ0JnA005996;
	Tue, 24 Mar 2026 22:03:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ym59q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3K3K12321438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 669735805A;
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10C0158052;
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 7/8] Allow verification of EVM_XATTR_PORTABLE_DIGSIG with sigv3
Date: Tue, 24 Mar 2026 18:03:13 -0400
Message-ID: <20260324220314.743709-8-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 3siCEspYw6yIJIGHFU4s5oqf4Jp85P-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfX/HFicwGyXvMg
 U91HKjXyWMrTuVcxRP8edKhYr4PoWlg0RusZI+aYJWp/TbM3yZTsWNZIm9VpaOmk1DSLYgDW7bk
 0hZWy0jCfnnSDIOW06RybaeuxGOjUzGMJ2Q7jZUz1JClZp5BIbjaLG8WovXir9290MqSqqxkEbP
 1IogwXqKMFJVF76SMareaSG8zHWfBNMXnYD4R5rP8Joqp0PjIS2w0LqUiIt3XG3W5kNAEilAomL
 FtU1osZ8tesrxkUEJ0U0+hvA7cepT36+7S7fVEumhWl5VtnfUiCvxDMuRVqMfM1RRqGS4adpHuq
 aKywUy/RJ6ZRh74hjltLSFpYLgOWGpxpzjiraN0v25jTvahZtYLiVC9+dJ58g1XVAOPhFvIfzZh
 u34vBieyxq826XrN3U15/LgeKdnIgd0K0l4IlKzdZIHIYxdImg6tiEqUi4cTy/HcDJvqlxxizz3
 FCmFwsXOUj2Ovy008Jw==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c30a2a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=GCipd1XZ1XVNMLpqfbMA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 3siCEspYw6yIJIGHFU4s5oqf4Jp85P-4
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9081-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: BEA8A31D1D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To enable sigv3 signature verification for EVM portable signatures, allow
signature verification on EVM_XATTR_PORTABLE_DIGSIG type of xattrs
with sigv3.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 0a38aa7..de67178 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -995,7 +995,7 @@ static int verify_evm(struct public_key_entry *public_keys, const char *file)
 	}
 
 	if (sig[0] == EVM_XATTR_PORTABLE_DIGSIG) {
-		if (sig[1] != DIGSIG_VERSION_2) {
+		if (sig[1] != DIGSIG_VERSION_2 && sig[1] != DIGSIG_VERSION_3) {
 			log_err("Portable sig: invalid type\n");
 			return -1;
 		}
-- 
2.53.0


