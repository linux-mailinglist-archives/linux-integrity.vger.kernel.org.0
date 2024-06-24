Return-Path: <linux-integrity+bounces-2924-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7FC91598A
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 00:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361121F21F7E
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932B51A2FA5;
	Mon, 24 Jun 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m+Rs6uYY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133721A2C24
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266530; cv=none; b=dPhyRH/lKvvUTzHb9WU4KnK+kdvE+jVq1ri3S5Hq9o14BQoJawesOz7YDE+RNkRUOaFX1Yekb8WkzgxBw5zD+o/4dl7CdOMpTZqwZmhiGlBBsEfXuuE2xoHJfaJ41z8lfs+52k05xh3On6Jbw5aUtD7A0WX+XRtFlkjQO+GseYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266530; c=relaxed/simple;
	bh=6vKLAeFhb+QeC1Yj2HL5h90c1wd2DqMqYFezvtei/6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQZe4YeaxOO/DeIK4FTIiG5N+KAtIv631W+Oig1DjZrptegiENUSSLIn9Dvq4fb/pac83c062BHmq0M6UuPJd2mKPPJuTH24Utc69WgkE/lvx30l7GlX4dk+kn6mxdPlZxdcieSCaVehaq5VuquNNqWqGM/lHwwd9MwBpdgQ+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m+Rs6uYY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OLwUKe004244;
	Mon, 24 Jun 2024 22:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=sIW/UqhVcOXQ2
	aCgnh+FHfKvFymXdYPCs5l9C7uGgRY=; b=m+Rs6uYYwqGB05jTiwMeMl/FL/k2+
	lI1uQqg/pKAWZ4300sMsReVVmjP+/dWiZ5GYt2OhX//q7n5UEEOsfQ5vr5D4r9r+
	tjFNg4OswgKJYvYvsgCDtXZm64DihYtykoSS0jIPsDEgMJIjiH4SfqCkOq6OQXWm
	ws5Ab5YklQ3Aum1FH/doN9S5rQbyzCDGHzYhQAdcu6RusgFc8uyrdhg1+QTp9Grx
	hx9xkemMWqWqHUcWG4m97xhcd5btR0T0HQLHt8fTzQziDmenPl5faAZ2W+qdeklQ
	X9ZECmJg9waamb6hXGmB2Aj93tdO/bdblEpmA60SgpH5CkMqiqGCMUcfA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyh6ar08a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OLecga000397;
	Mon, 24 Jun 2024 22:02:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn32p5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:03 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OM20mP63308234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 22:02:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C4FB58074;
	Mon, 24 Jun 2024 22:02:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9614958073;
	Mon, 24 Jun 2024 22:01:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 22:01:59 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, noodles@earth.li,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils][PATCH v2 1/4] Call OPENSSL_Cleanup before main exit to avoid crashes when engine was used
Date: Mon, 24 Jun 2024 18:01:54 -0400
Message-ID: <20240624220157.2248556-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624220157.2248556-1-stefanb@linux.vnet.ibm.com>
References: <20240624220157.2248556-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CXf6yITmjuQq4hKopueIZ35iq1gVFtMQ
X-Proofpoint-ORIG-GUID: CXf6yITmjuQq4hKopueIZ35iq1gVFtMQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_18,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=803 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240175

From: Stefan Berger <stefanb@linux.ibm.com>

When OPENSSL_Cleanup is called via destructor after main() was left then
evmctl crashes on Ubuntu 24.04 (Noble). This can be avoided by calling
OpenSSL_Cleanup explicitly before leaving main().

Link: https://bugs.launchpad.net/ubuntu/+source/softhsm2/+bug/2059340
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3ebda6f..ad75853 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -3347,5 +3347,8 @@ error:
 	ERR_free_strings();
 	EVP_cleanup();
 	BIO_free(NULL);
+#if OPENSSL_VERSION_NUMBER >= 0x30000000
+	OPENSSL_cleanup();
+#endif
 	return err;
 }
-- 
2.45.2


