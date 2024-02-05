Return-Path: <linux-integrity+bounces-1034-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C57849CC9
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7469A1F2695E
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422A12C877;
	Mon,  5 Feb 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q3zFbTM1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619432E63C
	for <linux-integrity@vger.kernel.org>; Mon,  5 Feb 2024 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142543; cv=none; b=GVHhIni8FTaxdfEL7aV1UTHXkYsPTW/Dxi0bdUi8+CGSlI27j6uQu67ff0uqXv11ai1sYMfr8NTAJ7Y4VQ+tI7iJkEPP5ISrKfJPvfIevTL4wLq94D9C3OSCy/DwODyyqOe16C3Oh+Hpqhk9Tj99BgJzT9/WZGgoH9rcizHo5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142543; c=relaxed/simple;
	bh=oXQUdL9LgqVzhXDOZ12EGklj5jroDJXHJqKZLXVV8qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTL/HvYkfIcPxTCmNsUdtYMG1Bf6jqWwvIib7s3yU4vRPfVsLH4baWirRd6S0HZbGel9nbP4oGv3JcV1Dsx3jJa+d6Bnr3wbUmRWa48FnB0oxwM72o+j0cg7EYcz2+VX9rcwgtuEzm+dIK2ZUBL1Aax3yXI5g2NRh4q0LJs1Hys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q3zFbTM1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415DbNm6005442;
	Mon, 5 Feb 2024 14:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5NterFa7RUhkraQd5XhRh3xcD1Swx7MLFqaALZosXo8=;
 b=q3zFbTM1sSX0BVOePfwnZII+FPZJg68xda0fRsdSkfReNHDzpi4NyIEQtJOvdpOpLGo3
 lHLWnlKQwfz+5Fh11aVcJf43IZmdpGNMjRwODYO0P6+cot6NgggxP9KeT312rhUUeQ+d
 ZRS7vB0HmMRbhUymaiGl32ANCulolbeSUUNoQq230zyVxQ8oWq2IPXE/jgCxbKNCFkbT
 /r4OxTevNL83bGDzW8qqU4DkkOHN/iRgQIzTG7FARnpPzJnundd64Q5DLYhZ07tbLXMU
 tB/WweFhQ3+CIZkQLrBp/ypoBAtJimsZrvqmk+5PK6hQfdh5VCKzPIPer5XNCvPiSz9+ yw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w30qe95av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415DLJ92008770;
	Mon, 5 Feb 2024 14:15:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206y92eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415EFVbU38601076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 14:15:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07C0E5805A;
	Mon,  5 Feb 2024 14:15:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A59A258067;
	Mon,  5 Feb 2024 14:15:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 14:15:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v1 ima-evm-utils 1/6] headers: Remove usage of CONFIG_IMA_EVM_ENGINE from public header
Date: Mon,  5 Feb 2024 09:15:23 -0500
Message-ID: <20240205141528.3566511-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205141528.3566511-1-stefanb@linux.ibm.com>
References: <20240205141528.3566511-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iV7ZNlSLS_8dLDJ0HKeNHTS9TRQXLnY1
X-Proofpoint-GUID: iV7ZNlSLS_8dLDJ0HKeNHTS9TRQXLnY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=766 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050108

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
2.43.0


