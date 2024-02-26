Return-Path: <linux-integrity+bounces-1473-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6D867FB1
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A852912D0
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C112F362;
	Mon, 26 Feb 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ev7L4SZl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9660DC5
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971680; cv=none; b=BzN9yj7jXF0pg0udtMXcgRDFPySn6LtIiKEhDeB1CPTZwNZqg9ABQQGpz51oYXypL5We2Hb2Y1XNmd1ydRbveUMLqtgXyTrHER+JlOZB+zKi5Jq3FG8yC+huq7tBcfzqZgLprvlFPXpBDugFhvMQYPKMCKyMwvCL6oRYM2AEMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971680; c=relaxed/simple;
	bh=lqHtadbXbj6O5W5AQD2ro+GnD+oelkK4JLiRkxslWuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+99Ui/xySmxOO7b60omCJZ2PKjWRwdxwyoHlL92BY+qJikBBmRRBiUTiBP6jtTITZ4FM+JF+Ngmw/HRBAlNlaBR5rVedrdSnfZYF+WlODhiXgU4o58hb4C5c7k9GmuQxxXh/gQD04s8zfpgiF7af+WLmKVdweQrNuvB/oOEutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ev7L4SZl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHCLT8009499;
	Mon, 26 Feb 2024 18:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iiMpBjvXD/UR8dpbjUgqM+fMQVZYnjiYq+nxrAF/NWY=;
 b=Ev7L4SZlQp2STvohum2E7rafWnkTbBpUq3oNGdu+esyjgTYVCOcs1yj0bCv9fy40nXcl
 c7WzIU44NY4UvyqGH4B3lsw6YGQdr2lMI67lTHDiiFv2nmFwwhn6Ssqz1kFmoV9Ywh4L
 xq2Do93GJZhW/9UVIPqcimKM80aSm1VBWSUj2EMF2u7CDNCtdO4Xj14yhqg67ambevgJ
 goDDKm+NDZa2n1rFHIxFlPGHubSLjfL2CJY8qYhRwn+THm5wsKpZHYcnps65Ts8BhWJm
 qhoO4pnMWJRXgil8LwTnvdqSzulgTSwpT18+27960xvaFs0yE4qi/p9T+Hw93vfNOUxm qA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxu89pxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHAZxH021316;
	Mon, 26 Feb 2024 18:21:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfusntwgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QIL59m22348468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:21:07 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 614A55805B;
	Mon, 26 Feb 2024 18:21:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C32CA58059;
	Mon, 26 Feb 2024 18:21:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 18:21:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 2/7] headers: Remove usage of CONFIG_IMA_EVM_ENGINE from public header
Date: Mon, 26 Feb 2024 13:20:56 -0500
Message-ID: <20240226182101.25210-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226182101.25210-1-stefanb@linux.ibm.com>
References: <20240226182101.25210-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pxJSbuw2GZGCWs5xMdKsx5ScTp9jbio5
X-Proofpoint-GUID: pxJSbuw2GZGCWs5xMdKsx5ScTp9jbio5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=879 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260139

An application including the public header imaevm.h won't know whether
CONFIG_IMA_EVM_ENGINE was set during compilation of the library, so
remove the usage of CONFIG_IMA_EVM_ENGINE from it.

An application wanting to use the engine will have to find out whether
engine support is compiled-in by invoking library functions and possibly
dealing with errors if there's no engine support .

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/imaevm.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 8e24f08..6a52afb 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -48,12 +48,10 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <openssl/rsa.h>
-#ifdef CONFIG_IMA_EVM_ENGINE
-#include <openssl/engine.h>
-#endif
+#include <openssl/opensslconf.h>
 
-#if defined(OPENSSL_NO_ENGINE) || defined(OPENSSL_NO_DYNAMIC_ENGINE)
-#undef CONFIG_IMA_EVM_ENGINE
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
+#include <openssl/engine.h>
 #endif
 
 #ifdef USE_FPRINTF
-- 
2.43.2


