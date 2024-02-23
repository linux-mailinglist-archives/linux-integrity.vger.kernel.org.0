Return-Path: <linux-integrity+bounces-1418-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4C8615D7
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711A3286242
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C564C79;
	Fri, 23 Feb 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qs5eyo/c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF85823A7
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702270; cv=none; b=uAmXQiqQVV02yFU00BJ0qLL/OvH745SxdiYAYmPD7FaoB9sq8h7k/4jxGxwHt9KF0Ab2dABXDVJY3sMvq6G/Xt6eV2BTLa1A3w/EJMNxmmK1aI1WWw4wg8IXIltZ7Yw/7S1zaSyIpIuFXRPBf8MNv0o8LDw4ZysxCnJWRFEWXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702270; c=relaxed/simple;
	bh=lqHtadbXbj6O5W5AQD2ro+GnD+oelkK4JLiRkxslWuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0QorTOEtVHGPCIhguAQlAUL8ZwdkZfhKQbGE1DPb/7thn+UGdnhcD6mPD2gOl2TJ4lmsddPXXN+vcPBXynKxmwoV+vI0b3vvUaPFMbUCaGau5/zBSziiwDyohBIKHmSa03UVBRrjkEsUoxdez6U0ZIhTveLpBL9OiGjftYBx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qs5eyo/c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEVeTG012731;
	Fri, 23 Feb 2024 15:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iiMpBjvXD/UR8dpbjUgqM+fMQVZYnjiYq+nxrAF/NWY=;
 b=qs5eyo/c9vLAA9S03BrdWNQAIklc15JAg6HmSAHcaU6PPsHTdbgnJjDKzRyeJSrCglvX
 nV8t1YNfjmCxVFygvXbFR1jj+OtV60wE+vP4wjwMalaBvMENZenWt3ZQyJhWY+ZzKfla
 r0j/EWjGJMQ/phzJLf1koCmxRk2wnNMRZvjkZM+DUUG6IgQl2fGYQVfngN1MwkKODLNi
 gG4T1/GEF1ZXEKQ7J7nSkRcjTvY4V9kLiPPbInYOWpaVPRrdI6qXd0jyrr6IgSlOuKBV
 SC/5MLNpb6MXl180u8sD0Q5ESueZCZ+d4L5bw5fdOwtoTpQxwcboCqTJJXKHocFzWCDE Ug== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wevxdt41b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEfCxd009577;
	Fri, 23 Feb 2024 15:30:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84px71n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NFULWr29819326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:30:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD7A58079;
	Fri, 23 Feb 2024 15:30:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD6F75804E;
	Fri, 23 Feb 2024 15:30:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:30:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 ima-evm-utils 1/6] headers: Remove usage of CONFIG_IMA_EVM_ENGINE from public header
Date: Fri, 23 Feb 2024 10:30:09 -0500
Message-ID: <20240223153014.4048133-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223153014.4048133-1-stefanb@linux.ibm.com>
References: <20240223153014.4048133-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DYrrqQdn4xHQyOnUVHZEi7tYHd9fMCzc
X-Proofpoint-GUID: DYrrqQdn4xHQyOnUVHZEi7tYHd9fMCzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=875 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230112

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


