Return-Path: <linux-integrity+bounces-9069-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DHvE/L2wmkEngQAu9opvQ
	(envelope-from <linux-integrity+bounces-9069-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:41:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDAE31C6EE
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26551302B201
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 20:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277F434A77D;
	Tue, 24 Mar 2026 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L/GvNeyB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D03537FE
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384794; cv=none; b=c5B81bzEILNkYDm9xo7KpZXh027jXDPUuyLx3wWRBsprdg86eaW7IAWAkWlzzExCWUDYIsMueRdiDoWrDvf904bncv5ZLuTrCDDAG3CCflMs/vsD0Bcg3gZREqnlT2f+aIykSIMJHkW6Td0R/j1qx2BNH9ClPACXY8b0HwDXOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384794; c=relaxed/simple;
	bh=VvAmSMSvguohda0PK7YKr9AzZHOcmdxzs4TJ7RHKRSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=de+C5Fr9+T/FBeofFvyckoC86bVAFOb8a014Cy9XzPmCyGjq7uLWmFP1IWy9R/8Ajg3zDgBhPPQUoUofKShfchzJ7Mhml3X60AnzLoWFcCculyFK3AzsF70tcAzPgN8quF4xTTIabP/iZaLYGbMB8NCV4GR+TBGWTQRYfv3kCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L/GvNeyB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OKKE0l566222;
	Tue, 24 Mar 2026 20:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v6m0QiYoIgs2FtQDC
	RKUYfSgaA25+huWeJaGnpMEXEE=; b=L/GvNeyBAir7Fybe/u+IAWp3KS7CJ4Tqw
	xZGwDTQpjweikxOMSxndB1qIBnWNNyza7Qp0aC8+3cmZmlxZ6Xyir9AanmPVFWBe
	1gZundag3pnWgeahtB/hmp2yGjNk0q3C6U3xisCp86x9V27z8APfq2/kyXkqs4rH
	HmyfQgpTye7bG4Ut4woj5OVvpchhKkU/b8+lJH+dMdG5ZMtfM2G2IZRktRb4ZPJG
	hx2Q1Dnes807ZTBU26rXiFR4h1JFOqpTNKV+r6vFggev+n26PJnDWiSKtv5GCbMx
	pMgV/4DOOhACEHFcEvgrjy3WOHibv4wosljVt4Oc7MyDFxOQcMmbA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxwmxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:39:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OIu66s031687;
	Tue, 24 Mar 2026 20:39:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsuwg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:39:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OKdfFI15860124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 20:39:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB8F220043;
	Tue, 24 Mar 2026 20:39:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 513BC20040;
	Tue, 24 Mar 2026 20:39:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.188.204])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 20:39:40 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/3] ima: add regular file data hash signature version 3 support
Date: Tue, 24 Mar 2026 16:39:28 -0400
Message-ID: <20260324203929.2475782-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324203929.2475782-1-zohar@linux.ibm.com>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c2f692 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=g0zj6DZiIQ_7T17LzpgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1NyBTYWx0ZWRfX/xAmddaNFokS
 NN0D4BqNid6B5oP9LhNK8RPDzmrmLeRUtW+rh8DklP4jrGP8T1azV0W5XOfqPC18dRCAxKafPkw
 xK7Yt0TUHb756YVEjbbKNHqUgDYXBU1RvbDpqjOgW3U5P14cnR6DcUgxb/hUsNkAb5/LUxzBgir
 RZiBn8f/igefuY/8VAz+eNtPl6uC2ROqvumRk+UUjMq0SJAx/G60hrWv0EPjFhR3aiQMv8RI/Eh
 Cb5rddcM7vUkuWsM8V1sKrfKQFTsDr3DmBY2PGwbqbAza+hybIg6mztEoN4SjmW35DtqR0oUHkh
 KX+8A4nGVGvF+G870UzQO5N0ZxDR2NGeojw9x8tdXVeyVx0Km2QTOJ+d9tbiMlxrE6ZwkVt39Ww
 EytQcbt9nyZAFRNmr2ZRGrNkTWhzTcMka+1F77zcSW7SDjzRuUg3PRHa5VY/hpe9LNEbWDAzRex
 vejjKo47YS1nMta411w==
X-Proofpoint-GUID: 8zcAIO-2MeXYAyOqUL1CbFm2_EbmZQmi
X-Proofpoint-ORIG-GUID: 8zcAIO-2MeXYAyOqUL1CbFm2_EbmZQmi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240157
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9069-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0FDAE31C6EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of directly verifying the signature of a file data hash,
signature v3 verifies the signature of the ima_file_id structure
containing the file data hash.

To disambiguate the signature usage, the ima_file_id structure also
includes the hash algorithm and the type of data (e.g. regular file
hash or fs-verity root hash).

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/digsig_asymmetric.c | 2 +-
 security/integrity/ima/ima_appraise.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index dc5313746609..6b21b9bf829e 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -154,7 +154,7 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
 	size_t file_id_size;
 	int rc;
 
-	if (type != IMA_VERITY_DIGSIG)
+	if (type != IMA_VERITY_DIGSIG && type != EVM_IMA_XATTR_DIGSIG)
 		return -EINVAL;
 
 	tfm = crypto_alloc_shash(hash_algo_name[algo], 0, 0);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5b42307ac254..8f182d808b09 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -297,7 +297,7 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 		}
 
 		sig = (typeof(sig))xattr_value;
-		if (sig->version >= 3) {
+		if (sig->version > 3) {
 			*cause = "invalid-signature-version";
 			*status = INTEGRITY_FAIL;
 			break;
-- 
2.53.0


