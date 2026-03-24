Return-Path: <linux-integrity+bounces-9077-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEy1MDMKw2lKnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9077-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:03:31 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22131D169
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFD3D30460B9
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A39E35E925;
	Tue, 24 Mar 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U+GDsXA1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCF23B612
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389810; cv=none; b=YbwJ32muWCGtm+Q8yYRmku0rQ1hk479ISTiCrWZlLhnufS41kal5mg26Ov0VlXviGwhIfkTNVDSyOCTvXS51JYli+4lmUyvfhtXUtSb3fulghchvaJj7RaotOCAQprA8u/ysUeA7HXWuKFMl0ZXtZbpYvm8ad3r7s3mQ7lvcFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389810; c=relaxed/simple;
	bh=1W/Xwj2X+mgfCtD0v2GkHeMJIs5t9j3U5QL0INDv0ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtwyqdQ0YgejUxEjdrUJu7GTDezZZoJ57dq+lZIKYaKwuPrNls9wf/pBcNBpA6ajhEsGWyygEOAzy92o7ocuP6kYBeW520q1TK7ia3NFkOgBWKqPVVf0ZtDPtGicAlLg2zqV/jHG2116mlFfEB0Lomp0bP/OIZVu/+0eP86CeRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U+GDsXA1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OEqMS13468674;
	Tue, 24 Mar 2026 22:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fa1h2qNNhP3Ty4GPz
	ykYhVzWwrBb592PxCTcjTd3AC4=; b=U+GDsXA1oIC4zK+zrRe9y1Z3kS8idzQkh
	OzbkA+EGcibWN4WVQ7w3eKiEGbEH7py7fFxsUDs+7fabGGPFx2rXLRDRpywRc/kb
	OsdEe1cPVKyMDswpxA52qbJyt0Uj77wSuglHd17s4xe7Z4uLJSVSKHn5Tir6z5lq
	zyl2xFvVZHqcVxwBKxibiVp1p7Bx/RE9hBzdHhwa/9t2MwRQT6G3c8+cupogw9KK
	9iQ+J3YwJuiKTwK8BpA1w86bCdBysi9OqpS8kNeqo8TQzoceBAPa6wRkjUE7UQpb
	cU+Xgfp6OpmoDbrQaEjCZ8XYOt1UbrFdhQRKkpK8Qd43LTcGMObqg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumn8hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OIunmD005972;
	Tue, 24 Mar 2026 22:03:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ym59m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3Jcg27722444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A15A58062;
	Tue, 24 Mar 2026 22:03:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D23D58052;
	Tue, 24 Mar 2026 22:03:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 5/8] Use imaevm_create_sigv3 for fsverity signature creation
Date: Tue, 24 Mar 2026 18:03:11 -0400
Message-ID: <20260324220314.743709-6-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: I3UnF5Pd3vZVGMWVtCUIo1UInc-fAB1S
X-Proofpoint-ORIG-GUID: I3UnF5Pd3vZVGMWVtCUIo1UInc-fAB1S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfX22RBkR6JG8Pu
 CEbRSpC2EWEEls8vUauimYxvImrBnU8CYvZqkgSR00nIqY61Ubk79XhyFsdFrNMtRWHj+zJmRQx
 k+JqyHnA/IfTZXqICSXLNIP8ZCA5qWFVL+FdxBrXYnDcc7Cdo3t4jjL8IWW+NAD7BZorwyyZNQ/
 vOPA5H5ex5m8xYwghhgSumMco0WaXHANFzd82gQf4wCWAAS48eBRr/C7J/1dWre5uE6mfvozoCT
 FCaEdxN3HmtD2LVemLixv6U6ORloiZk4AvBtmQqF5/B9Oy5gGcg5xOp0JiCNKb+hPBjeMWaSd2+
 G8IvEvwYf43rVvHMLZtkJGgc8JCt19yQtTstjXE2fpYGpcFXf5B27eVMGKduecg8ntWwQ9p7G9b
 In1WzsIOB87HncKV0NY2WIs9wUkkBA35IrAKdflGdLoMqR5KNHiLa4z//6IjMIvVha287kCzvUr
 V6L3DuLBG72lkS+GYbw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c30a29 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=R_VBs2EOIYhiIciYRg4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240168
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9077-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5C22131D169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the code that built the fsverity signature with V3 signing scheme
to use the new imaevm_create_sigv3 function.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 2843ff8..0a38aa7 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -828,7 +828,6 @@ static int cmd_sign_ima(struct command *cmd)
  */
 static int cmd_sign_hash(struct command *cmd)
 {
-	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
 	unsigned char sig[MAX_SIGNATURE_SIZE];
 	unsigned char hash[MAX_DIGEST_SIZE];
 	size_t algolen = 0;
@@ -840,7 +839,6 @@ static int cmd_sign_hash(struct command *cmd)
 	const char *key;
 	char algo[7];	/* Current maximum fsverity hash algo name length */
 	ssize_t len;
-	int ret;
 
 	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
@@ -888,19 +886,15 @@ static int cmd_sign_hash(struct command *cmd)
 			assert(hashlen / 2 <= sizeof(hash));
 			hex2bin(hash, hashp, hashlen / 2);
 
-			ret = calc_hash_sigv3(IMA_VERITY_DIGSIG, algo, hash,
-					      sigv3_hash);
-			if (ret < 0 || ret == 1) {
-				log_info("Failure to calculate fs-verity hash\n");
-				continue;
-			}
-
-			siglen = imaevm_signhash(algo, sigv3_hash, hashlen / 2,
-						 key, g_keypass, sig + 1, sigflags,
-						 &access_info, imaevm_keyid);
-
-			sig[0] = IMA_VERITY_DIGSIG;
-			sig[1] = DIGSIG_VERSION_3;	/* sigv3 */
+			psig = sig;
+			siglen = imaevm_create_sigv3(algo, hash,
+						     hashlen / 2, key, g_keypass,
+						     &psig, sizeof(sig), sigflags,
+						     IMA_VERITY_DIGSIG,
+						     &access_info, imaevm_keyid);
+			if (siglen <= 1)
+				return siglen;
+			assert(siglen <= (int)sizeof(sig));
 		} else {
 			/* Parse the shaXsum output */
 			token = strpbrk(line, " \t");
-- 
2.53.0


