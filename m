Return-Path: <linux-integrity+bounces-9070-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAbnLO0Aw2nRngQAu9opvQ
	(envelope-from <linux-integrity+bounces-9070-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:23:57 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D04F31CCFD
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A758D303A494
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0031F994;
	Tue, 24 Mar 2026 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dUCP/LzN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9A39FD4
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387435; cv=none; b=P5flb6pGlYRvUhDiv+K3JQzEW5Ro0u3lgubjJNlEWlATIBoeW2Dc71+0wswcnBLHnb2iCiF7kUMPlb1J1Lx5C6iWRbmsfkKBAaUDEdito88LFRDRMplYimNMpxidsc2zD6XSo0oPN/0wPVEXW202SEfq/AFy+bvPFwzaDTFTN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387435; c=relaxed/simple;
	bh=P3XsuEvNDGG3u79TasiDPcvLdP3Uf1LXFt0CPftImjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YE8Jjrh1TRtHoRL4aPj+TUVD+wdXrv+yBYLZcPqliCX/GtPphi+Ov36qvgM0R9SjAe+O0Vy+A7qXqQuSu2X7JUJkshYsIWOf6tOwLWTBIWXz3CNObToYlmnzFfeBTpYtnGFJvXyRQ6avinoeEsMb0NcafTgXsuTg1XeZj7E+t74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dUCP/LzN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OGo1iw3644267;
	Tue, 24 Mar 2026 21:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OX7ePHKBLjgIQ4lYU
	plD1WUHGVyYiJZiVMGo6JHaDMA=; b=dUCP/LzNpgpPHpt65vbYDvCs6TN3Kaiur
	8YFP3TnlAmYS8VT3eVgN8UdgLQw1HsW5KFInYck0jUFdy+GPjMfRcxoxzX9KSl7M
	YJunoztyiUFGYzyOvYuGgep2ZtsbzzrAPrzbT5breH1DfjH691iqBPSZ6H54WsCp
	BJxnnaytdIt/7fdqZgAlT/DXkxiyF8da1tzQyF6ySIgQWWOZqRaD1R9bmNvuzrmb
	8+Ee80+KVkEJ4DVQKpII/A7f8GxCg/3+CP7uSZaOPlxBcpRFQaj92s1JJZ2Qwiza
	p11c95a50ZzYsysY3vsEUBwOUiAMz+lTedQyiml5sgasmZjJpnbgg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky05290-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:23:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJcWsH026681;
	Tue, 24 Mar 2026 21:23:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kuuu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:23:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OLNjjJ197188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 21:23:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B59D5805C;
	Tue, 24 Mar 2026 21:23:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 151D05805A;
	Tue, 24 Mar 2026 21:23:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 21:23:44 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 1/2] Use EVP_PKEY_free to free a key of public_key_entry
Date: Tue, 24 Mar 2026 17:23:41 -0400
Message-ID: <20260324212342.739685-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324212342.739685-1-stefanb@linux.ibm.com>
References: <20260324212342.739685-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2NCBTYWx0ZWRfX+tQJrjU8D59p
 kPeORHrYQE1r6T2LAG5fR1KvEQEwNNP0FXyeiMwnGeDQLIedj8bBXPWE40HueO5TjcJ4A2SAkMG
 F5mGGi7ozvyCIXxQhaoFPhavwzANNodwoRGQfYNtZwNKoL5MONpQEfN9qx09jNRkzki1tqHsprM
 Q58e0Qiiqo7A+vi+RFvnD8eXzOgL3YSiMj0AUIuMEa72FIeQopTS6RCw8bTGD+OpVeUs1PpUsGK
 EgM+AxwlS5td2yP+LeA5kWuxCghQ422EG1dKTvPJyevLNDysUegUJT+x6sTwhV75UOoB/vQwus0
 yU1IJNzMMXTpGZBhkaYhb5/yrNOHue8W2ZoH1GZv2UuELsn2mgehR063HOehQ/KmjPVbwevRijS
 bdpc6Mkjpcpj5mCN5pgiaa/5u8YjK4RPXiaEvDFAnC6Wzy7lnAAODk6RtQS/RIFCYVjXuOYRf+T
 pXr9CD3WVIztF+F7Vgw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c300e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=orq__4l21HafBDcdUQEA:9
X-Proofpoint-ORIG-GUID: Qx_v8_4KVWI65sgThCh2S8KHhUkayteH
X-Proofpoint-GUID: Qx_v8_4KVWI65sgThCh2S8KHhUkayteH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240164
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9070-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5D04F31CCFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use EVP_PKEY_free to fix a memory leak that occurs when using free() on the
key field of public_key_entry that is a pointer to an EVP_PKEY.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 3b268d5..6512ee5 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -400,7 +400,7 @@ void imaevm_free_public_keys(struct public_key_entry *public_keys)
 	while (entry) {
 		next = entry->next;
 		if (entry->key)
-			free(entry->key);
+			EVP_PKEY_free(entry->key);
 		free(entry);
 		entry = next;
 	}
-- 
2.53.0


