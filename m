Return-Path: <linux-integrity+bounces-2980-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E2926651
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512C72853B2
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024A17FAD4;
	Wed,  3 Jul 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hTJlTDb9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A208174EFC
	for <linux-integrity@vger.kernel.org>; Wed,  3 Jul 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025128; cv=none; b=DWJdGi7+or9tXPrfupMyxgvUyI5C7tOKV0YS1/bAUPfAMQzywhkTHARMGb6NFXivCoyouNshVzph4tafxbYEPTwPgbgOVrB7RitFkX2Ph4Gg4tC2sr6c9Oo0WvSTOQcxIFJMrboywVU8CmFeM+Zs1/r9NaFfKdh3Tf4CvWb4Q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025128; c=relaxed/simple;
	bh=vlPWHp9+cFYF0PbvqKc+wR1cx35Mg/GfAS6Hv0FD8Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2S0BBS1t93OVKh5SToDkLFQ9GyxlH0Ldzz9UYMl9/C2/1LmEapng6lXuauy+AaQDIAmtdo+Zq3vgFQd0hCl7ojtcwGpqGZ696B+sncW2wHUOSA3h0A50ZDfHEA5+gqaSHqXWr5xqFwaqUlbeWUhvsAl0/rgOABGyWwRxd8p+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hTJlTDb9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463FSK9F004183;
	Wed, 3 Jul 2024 16:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=SndWC1u9vVOuu4iaCkWPeZIz9w
	KqPV7f3g+d/4MmGzY=; b=hTJlTDb91YLVJISg6/rw4kGUN2coRSJLy4UliRvd0y
	drqNcd9hcRV4A+t/SHJ+vsjutVkaJDZdVNZaeOzoYWjjLxRMV4JBdiR4utWByqwA
	clzsMkgGX7IwzWura7TCR0LZn6d68GzOfmQXPf203+G4ZuIFPxHzVl3bxPl8BLqU
	DK0+c/G6m6Zfs26FlaPNR40MRw1H3DHH1cbW65DF6GryY/opUmrpK759KYa1orUf
	DsCGm1RKQNZcujbkdJwDTNXWusJ6OUwUqaHOH+vpzxVfXdH7wg105TukpoCmbIpd
	73lITwvwl1XOL0LKHSKAmMVoha51wv4x9zPrsfPZREqw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4059agg6e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 16:45:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 463FPLvK009150;
	Wed, 3 Jul 2024 16:45:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402w00ur2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 16:45:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 463Gj6mu31851160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 16:45:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B52062004F;
	Wed,  3 Jul 2024 16:45:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A0B82004B;
	Wed,  3 Jul 2024 16:45:05 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com.com (unknown [9.61.125.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jul 2024 16:45:04 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH] Release version 1.6
Date: Wed,  3 Jul 2024 12:44:54 -0400
Message-ID: <20240703164454.61614-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tG_Gv0nUrQpEMsKi5RSJ34k3rNEfB3Mc
X-Proofpoint-ORIG-GUID: tG_Gv0nUrQpEMsKi5RSJ34k3rNEfB3Mc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_11,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030122

ima-evm-utils originally was licensed as GPLv2 preventing it from
being linked with GPLv3-only applications.  To address this limitation,
the ima-evm-utils package and library licenses are updated to
GPL-2.0-or-later and LGPL-2.0-or-later respectively.

libimaevm defines and uses a couple of global variables making it not
concurrency-safe.  To address this issue, defined and passed local
variables, defined new library functions, and deprecated old library
functions.

See the NEWS file for a short summary of changes and the git history
for details.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 NEWS                         | 22 ++++++++++++++++++++++
 configure.ac                 |  2 +-
 packaging/ima-evm-utils.spec |  2 +-
 src/Makefile.am              |  2 +-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/NEWS b/NEWS
index 06ac13211cf5..606243896b32 100644
--- a/NEWS
+++ b/NEWS
@@ -1,3 +1,25 @@
+2024-7-1  Mimi Zohar <zohar@linux.ibm.com>
+
+	version 1.6:
+
+	* CI changes:
+	  * Update distros, removing EOL
+	  * Limit installing PKCS11 provider package until dependency (e.g.
+	    OpenSSL, p11-kit-modules, SoftHSM) deadlock on alt:sisyphus
+	    and debian:testing are addressed.
+	* License change:
+	  * Update package and library license from GPLv2 to GPL-2.0-or-later
+	    and LGPL-2.0-or-later respectively.
+	* Tests:
+	  * New ima_policy_check.test, mmap_check.test
+	  * Add PKCS11 provider test to sign_verify.test; skip PKCS11 engine
+	    test when OpenSSL engine is not supported.
+	* Misc bug fixes and code cleanup:
+	  * Instead of relying on libimaevm global variables (e.g. public_keys,
+	    struct libimaevm_params variables), which is not concurrency safe,
+	    define and pass local variables.
+	  * New ShellCheck target
+
 2023-2-24  Mimi Zohar <zohar@linux.ibm.com>
 
 	version 1.5:
diff --git a/configure.ac b/configure.ac
index d0d2e219fdc9..c4c7f68f6ba4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,7 +1,7 @@
 # autoconf script
 
 AC_PREREQ([2.65])
-AC_INIT(ima-evm-utils, 1.5, zohar@linux.ibm.com)
+AC_INIT(ima-evm-utils, 1.6, zohar@linux.ibm.com)
 AM_INIT_AUTOMAKE([foreign])
 AC_CONFIG_HEADERS([config.h])
 AC_CONFIG_MACRO_DIR([m4])
diff --git a/packaging/ima-evm-utils.spec b/packaging/ima-evm-utils.spec
index 7e40fa66cdb0..52cb2b044295 100644
--- a/packaging/ima-evm-utils.spec
+++ b/packaging/ima-evm-utils.spec
@@ -1,5 +1,5 @@
 Name:		ima-evm-utils
-Version:	1.5
+Version:	1.6
 Release:	1%{?dist}
 Summary:	ima-evm-utils - IMA/EVM control utility
 Group:		System/Libraries
diff --git a/src/Makefile.am b/src/Makefile.am
index 7c3f5fdd5080..a6e0b8efd7df 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -4,7 +4,7 @@ libimaevm_la_SOURCES = libimaevm.c
 libimaevm_la_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 # current[:revision[:age]]
 # result: [current-age].age.revision
-libimaevm_la_LDFLAGS = -version-info 4:0:0
+libimaevm_la_LDFLAGS = -version-info 5:0:0
 libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)
 
 libimaevm_la_CFLAGS =
-- 
2.43.0


