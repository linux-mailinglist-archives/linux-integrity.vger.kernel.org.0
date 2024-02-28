Return-Path: <linux-integrity+bounces-1492-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15686B479
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 17:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352E9288DBD
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8506D160862;
	Wed, 28 Feb 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N0IeVR8g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89173FB91
	for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136874; cv=none; b=G0fj+AKf7nK2IFD0dIqvyzC5nVB9d+XPT1dDcsxtcRbFGe54LqDRcYNe0NnAHIYGishwT6UTAr6ERlzYCXgaz5kUYnsTwEq6vHrxuPYud3sJkHTifsC13V+vLUiOqii+EdF4pmc2YLajILOSIP59MV/uYLg2s3ddwl1fmTPZoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136874; c=relaxed/simple;
	bh=lqHtadbXbj6O5W5AQD2ro+GnD+oelkK4JLiRkxslWuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHIQYdcdNuff/3W4E5rGtEtSJFvU4SRae8thzaXq/oblnfAvL4NNj5/AJ7RPhPfnK9Dw06YD4QYsoc9fcinL1ejMUlJ5YJmNetDZpc32OB/YMUalTfWwUTGBhjnroxBPwmXY6YdyTol/abXmF7crc3KMEFk/zeXmv/Wkf//8IdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N0IeVR8g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SG0R93019568;
	Wed, 28 Feb 2024 16:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iiMpBjvXD/UR8dpbjUgqM+fMQVZYnjiYq+nxrAF/NWY=;
 b=N0IeVR8gzlExKlmKON0jZCARPg2WwBvxajG1KpdDsRmdnkDlFFhSg9WltusRCGTB71GF
 0vwOpuaJidifsUuJe3fxocdi3fUPQfIl2ZCe+tuO7zli/erUD3UPQprlJM78Cb83bjrH
 UuBM6NPhY6sctopFumtu2eSwSiLQiERE/wZ9QC7C/5hdTmaO19XFw57h/v+t4sgRcBlm
 UI4/wjND0dt5YXudMaotBJCOO4Ro5KCA07T7LaNQhtOgpX5EokBqnps/M84LWFag7CEA
 HHMmPCoNzBsLEO7VphrERzYXszyMyvEf1GV4kGRODxF1FxjnidA/neMOZAkglfNHRvzq Dg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj7yfrfrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:22 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SDKqcd012332;
	Wed, 28 Feb 2024 16:14:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2euxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SGEIdT17171102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:14:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D14158065;
	Wed, 28 Feb 2024 16:14:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AC7858060;
	Wed, 28 Feb 2024 16:14:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 16:14:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 ima-evm-utils 2/7] headers: Remove usage of CONFIG_IMA_EVM_ENGINE from public header
Date: Wed, 28 Feb 2024 11:14:02 -0500
Message-ID: <20240228161408.284098-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228161408.284098-1-stefanb@linux.ibm.com>
References: <20240228161408.284098-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2SBGpo5u6tkNWNYA2k7vjtROYE8kBR2-
X-Proofpoint-ORIG-GUID: 2SBGpo5u6tkNWNYA2k7vjtROYE8kBR2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=879 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280127

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


