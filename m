Return-Path: <linux-integrity+bounces-9071-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLORNTwBw2nRngQAu9opvQ
	(envelope-from <linux-integrity+bounces-9071-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:25:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4131CD24
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06E2B3045015
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0FF39FD4;
	Tue, 24 Mar 2026 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TImDoRzq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3035E921
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387437; cv=none; b=Hv3ujeWs0fBmD3WGD2tj2MxLOHdKK+D3uAFb8bvO8POgmSMzsmtSn/ay38aLVx06GrkDEm3EK8g6bGwTwg9ZrLTf15UeaBnuElxo0BR56Ikug5+o0xpui6jADH2Y6oFJ7iXaL2GWNl/JfidWrswBFItA+saKc+adL1Glumorw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387437; c=relaxed/simple;
	bh=cuMuZZ5llceaOlaP7IRLuQCGnHGFR7L3Z2yDYB+wNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBsLacbzU9TqHvGHq9UhYi/fAgwCS852yaV3ztFkzD/g/HGPZCQbyh7JGljDzVCfUgZtO1UgC9xBnnWceNUyKAZ8KiNVObFHgGvCVJ/PcDyZuMEZQFYs4FEqLrrJpusWexHuG1DRZe8JF57Au2ML728DHDjIh0vjBhOcG4w30Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TImDoRzq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OGTPsN213179;
	Tue, 24 Mar 2026 21:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LibFgLp7cGA/w4A/4
	kO1rWIjTH7yb/A+27GbB4TeEJk=; b=TImDoRzq0iRNm1760yIxHxtHXaDo78DUU
	5hxFGaIdJPY5Tu+xFpi5utT3SdCynqyAPMY+I+rojYRPeBT2rYY6u6vvzIl2yU5c
	fFhoXC+3YIi4jdBfhjMFxq9xap+4qUKv2sXkZEvLaI63yMHOcgYNrdKMJw05VWj1
	kXhOWgLH9SYCwJOpS3AFAklH3eKxosAmuo4qHv4kSs4TX192Jh3La78QyGzuqZPD
	dNxgo5dgqhHDIioX5M26tf6L5Zd8uE08tVjoLOgrA6hVveCiByKyyht6BGcIg8Wn
	gXze+jjhW+Bm0or7ce9Nl3/Q3aK4+4U2j1hsHYuYtIDHWdP7Kab4Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxwsdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:23:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJC4Hn009143;
	Tue, 24 Mar 2026 21:23:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnky2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:23:47 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OLNjbY197190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 21:23:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFF645805A;
	Tue, 24 Mar 2026 21:23:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82C0558051;
	Tue, 24 Mar 2026 21:23:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 21:23:45 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 2/2] Avoid memory leak if public_keys is NULL
Date: Tue, 24 Mar 2026 17:23:42 -0400
Message-ID: <20260324212342.739685-3-stefanb@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c300e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=bs58pr9YfctX8r2ydCAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2NCBTYWx0ZWRfXyIMZRKvFnLH5
 8KJcstQbYhBk8OA/sdQtbzYON7I/IFM1N73Cqd00m0V/gqgi1mj1n356eTXn1VzPQ8O55H/MWrn
 xobG4DpWAdxVx0J3uJjY2MynGQn953FFVSlaq/In/Dgqt3/aQ+fHnsiDItRecUAO+3PYRQTHet2
 9KFJNVZhIdhYbD82VXGAbLV9sxRjnLBlmtvxBVvsV1vqyflURvTEgD+RyK7NfP/sRGHIacNjJUR
 QjwkF8iHf3vp0WUJkXFNF81+ovuCQ8luxWO1L8RBtsnU8A/sMmz0hBKuxJIK4bvP8+fXqCzY3w2
 Ak7Fn1V6aOZJccOC0R+HzK770cffVjB34AaroHHsVCgUK2mG2L/QK1nlgwzFCnp8C2q3UeKFIlP
 7m9Ya7CCwwrd8suE5THZ89gdroWX24YdpvuNVd5hQAGuPxZKTr/Ayqzl8y08A3vA0kSHwDYH0Yk
 yqPSggdexNxlrrMvqOw==
X-Proofpoint-GUID: xaDs2al5xNRB3UTj9wDK8WV9XHylnY3I
X-Proofpoint-ORIG-GUID: xaDs2al5xNRB3UTj9wDK8WV9XHylnY3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240164
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9071-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3FE4131CD24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid a memory leak of a public_key_entry if the passed public_keys
pointer is NULL because in this case the entry is lost. For this particular
case to work we would need public keys to be passed in as
'struct public_key_entry **public_keys' so that '*public_keys = entry'
could be assign. However, this change would propagate all the way to the
API of the library and we don't want to change existing functions'
signature.

This change should not have any noticeable side-effect since the resolved
case did not work before but the newly allocated entry was lost.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6512ee5..d8d5dbc 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -378,17 +378,16 @@ static EVP_PKEY *find_keyid(struct public_key_entry *public_keys,
 		tail = entry;
 	}
 
-	/* add unknown keys to list */
-	entry = calloc(1, sizeof(struct public_key_entry));
-	if (!entry) {
-		perror("calloc");
-		return 0;
-	}
-	entry->keyid = keyid;
-	if (tail)
+	/* add unknown keys to tail of list */
+	if (tail) {
+		entry = calloc(1, sizeof(struct public_key_entry));
+		if (!entry) {
+			perror("calloc");
+			return 0;
+		}
+		entry->keyid = keyid;
 		tail->next = entry;
-	else
-		public_keys = entry;
+	}
 	log_err("key %d: %x (unknown keyid)\n", i, __be32_to_cpup(&keyid));
 	return 0;
 }
-- 
2.53.0


