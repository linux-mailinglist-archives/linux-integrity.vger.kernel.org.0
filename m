Return-Path: <linux-integrity+bounces-9125-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC6YO5Xs0mk6cQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9125-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 01:13:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902B83A01EC
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 01:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 514C430158BE
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Apr 2026 23:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D62D385536;
	Sun,  5 Apr 2026 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qn7JKr4T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F63845BA;
	Sun,  5 Apr 2026 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430772; cv=none; b=SRkWHWmJwMaB6EBpSXly8DAG1BppsMmG7Mp3Jjaw+zcZU9J2QwlhTEJM9KI9+0Tcc87mTpND3dLkiEjhI0rClL40jy6EPqXeU3bZEHn3W9WJBSaVrRVI39wRLXaOezWQMywZhMxg61C7v4nXGYdNuydp+jO9hc0jJghls1ZJiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430772; c=relaxed/simple;
	bh=RKscOPFvYdq0dd98pq3pzwNgVvMIRTQZM+3SnWFroVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIDNGs3QqKTSVX/OFCjyYKBWYkMa8jHoPlnjTODbneAYL+RTW++s61HrlxUKxiPp2e5zENJkRLr/TYWHn2KWDNhKqRMn/iM6Km1NFiNw5WA1tbT+TbkWVCCOG5j1iXzwQT4gdB4tNAJM1YDatEEoYGjAMwMwlAcOVBbjzTQLtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qn7JKr4T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635K04So3444047;
	Sun, 5 Apr 2026 23:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YC0+m+DhEARNhrzYM
	b8TiEdynyxP4Br8iE3bDr8XovE=; b=Qn7JKr4THG+kS6BY0aMMtUMBXT6eYpYX9
	55pA0Cr6sElQlUhAAtrTwBRWnKQk/gFA5yziYggj3e4FgI8wHOKLjSMoxfVEx4rg
	npXWSamHb4gWUjZWql2WycrJXjhbQeN45tk3OpPhKPk7lf2bwA8NYU3KdaP9iAl4
	33v8lVpmr5yf5uWRrIF3lT+uZC94uVIZbfel/lmqWE8M0BK4jWAx+wbetJDg2ZST
	cHWEKAWy0Y/ilvpbxZvW2g3UJ4/TKQnLMIslEJ78sPKTEGC5th1f0q3sre9GXvfx
	IknkilwXVgL+9l4z6eyjlJXEfWRAjipxWMd25AyhtpJWqLEczlTzw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat9rc64b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 23:12:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635MsDcI020298;
	Sun, 5 Apr 2026 23:12:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdynanxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 23:12:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 635NCXRS24904230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Apr 2026 23:12:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 615D15805B;
	Sun,  5 Apr 2026 23:12:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE6858059;
	Sun,  5 Apr 2026 23:12:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  5 Apr 2026 23:12:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Ignat Korchagin <ignat@linux.win>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 1/3] crypto: public_key: Remove check for valid hash_algo for ML-DSA keys
Date: Sun,  5 Apr 2026 19:12:22 -0400
Message-ID: <20260405231224.4008298-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405231224.4008298-1-stefanb@linux.ibm.com>
References: <20260405231224.4008298-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E2_gpMsXKyTCKxIyhMMyi9dQ7_Ljeu70
X-Proofpoint-ORIG-GUID: E2_gpMsXKyTCKxIyhMMyi9dQ7_Ljeu70
X-Authority-Analysis: v=2.4 cv=bLYb4f+Z c=1 sm=1 tr=0 ts=69d2ec63 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZmJwLY9U1ndrk4b8UDEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIzNyBTYWx0ZWRfX8M6uFqyctA6d
 W8Ps4YI/PoLhVbuEhrcEZwVKkL/n5DbGkg2QemXdx7ZAxWrIIQlL7VLnsF3MEbjM0rKU5/97LYW
 n5X/1zD21efxESlHEyUu78vrOSsSsEB/+JIunvB0shbqbcnj0J5LZTCPVUo/E2i7qrVv+ZI/NsS
 Xk3gepLpDmTIPK5DRu37R6+kahvU64Jy32GQkHxDj80iSnQhJg8AGGq8OArE+9pLb2Qxb8Eceih
 DEeY4H1WDUL7rsPzzmxCkZZjfb/EmdIGBG8fz2umew0VaptwIPvhW3Gs/JwwZ/hY/V11F6ufvjY
 PzoQB0Zpr44OIb+0hn4MYLoWcN8uffrVPjlw3HJ/nvBelOCC9TWLKNzETc63ngx9e8LsfJPNKnY
 25gEOy3Pyy7SQeBFW+6pau4si0cKb3JwtJvAkDxYyeiOXxrh6J7XY6dRiqPgFL5/AIDVIfMGkXK
 q+nNnXAu80/ozCa01JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050237
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9125-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,linux.win:email,linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 902B83A01EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the check for the hash_algo since ML-DSA is only used in pure mode
and there is no relevance of a hash_algo for the input data.

Cc: David Howells <dhowells@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Ignat Korchagin <ignat@linux.win>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/asymmetric_keys/public_key.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 09a0b83d5d77..df6918a77ab8 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -147,11 +147,6 @@ software_key_determine_akcipher(const struct public_key *pkey,
 		   strcmp(pkey->pkey_algo, "mldsa87") == 0) {
 		if (strcmp(encoding, "raw") != 0)
 			return -EINVAL;
-		if (!hash_algo)
-			return -EINVAL;
-		if (strcmp(hash_algo, "none") != 0 &&
-		    strcmp(hash_algo, "sha512") != 0)
-			return -EINVAL;
 	} else {
 		/* Unknown public key algorithm */
 		return -ENOPKG;
-- 
2.53.0


