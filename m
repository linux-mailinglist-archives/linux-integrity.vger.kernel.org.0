Return-Path: <linux-integrity+bounces-1493-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E207186B47A
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 17:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C75B1C2061D
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E723FB96;
	Wed, 28 Feb 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kb2kxo8x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88843FB89
	for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136874; cv=none; b=plG6lvh3lhEpH6OzZrV3L+jUOCLlA7otHSTnYh8O6nxbteRKfwwEtR3dZjYjVZZIq1t5r/SFOP5E7+xtDiCTQ4p6KCCBApDuLnFxXbV56q2gltFXQZjv/Bb8sIulsbOkbW/70cz8KcSkhJu0OgkvtbcoXtmB3vaMGOPwYvnX1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136874; c=relaxed/simple;
	bh=LAR/yEJG+6tVTMsLn8OtvR1/i5rp4+VJNNPi1smhSUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JzaRcK87SD9r0wlZwGV4wiQCUFnWyfWhJ8f4UO/SFVV6Ehbol7HFTDGvmygNBYCux2PbUs72zAZ5ChOP0nG5WGAuXSDI0UkXNnOocQD0R8PpO+rtIpL+kDE8ba93/1dS2YYF++/LpCRPKABNy9ApRXj7NpNIeAtQcHtv5pKKdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kb2kxo8x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SG0SXc014174;
	Wed, 28 Feb 2024 16:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XlR+KDsYxROXqXWa0XgiB9yfEXCVpcoXdNx2j3hyHTY=;
 b=Kb2kxo8xivtSYe/LT0EFZO7jB6YCDa7hBnHKDuO9bJMvc7vjRJZZ6mVMv6YtWH23WmQO
 LKltkVsrmSwEiuohRom6kx5opYDDB2IkQYI3TmOPplMZW4JbEq97C7BJ5Sg8Fob7hQ3O
 O2JwjyFrM4lEPK2WtyB6f3JbGMKJcO/HdxvHdAgfuiX0EuZ+3mcfy4n3ICWCoKHDbm7V
 Sw/VDoJDV438GhtGYt+vfu504SS9wlD8S4B4+KCono3Q+vLhIUiXQpoXVwcahLuBMtPI
 xG5xtr/1MeqEN6LVXJ3/3/QObFixhF0YudRzn728H51OUVV8kM3nSJHEM/j0tcXti+vT xQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj7yk0g0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:21 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SDPCfn012312;
	Wed, 28 Feb 2024 16:14:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2euxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SGEHtm27853336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:14:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A529F5805F;
	Wed, 28 Feb 2024 16:14:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BDF658059;
	Wed, 28 Feb 2024 16:14:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 16:14:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 ima-evm-utils 0/7] Implement imaevm_signhash and add provider support
Date: Wed, 28 Feb 2024 11:14:00 -0500
Message-ID: <20240228161408.284098-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8nGojKavuwcQk7LYWiZjLpNrBB1Atokp
X-Proofpoint-GUID: 8nGojKavuwcQk7LYWiZjLpNrBB1Atokp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280127

This series deprecates the sign_hash function and introduces
imaevm_signhash that requires the necessary parameters to be passed rather
than relying on the global imaevm_params variable. This way we can remove
the usage of imaevm_params for the OpenSSL engine and the keyid.

Add support for an OpenSSL provider. The choice of engine versus provider
is implemented using a struct imaevm_ossl_access that wraps the engine or
provider parameters. It also provides a type field where the user can
choose one or the other. imaevm_signhash takes this structure as an optional
parameter to support engines and providers.

Also extend existing test cases with tests with a pkcs11 provider.

Regards,
   Stefan

v4:
 - Fixed subject line in 3/7
 - Have sign_hash call imaevm_signhash (3/7)

v3:
 - Added patch checking for engine support in evmctl before trying to run
   pkcs11 test (1/7)
 - Updated README with new --provider option (5/7)
 - Added 2 more skip's to pkcs11 test in case softhsm is not installed
   (6/7)

v2:
 - Fixed some minor issues


Stefan Berger (7):
  tests: Skip pkcs11 test if no engine support in evmctl
  headers: Remove usage of CONFIG_IMA_EVM_ENGINE from public header
  Implement imaevm_signhash library function and deprecate sign_hash
  evmctl: Replace deprecated sign_hash with imaevm_signhash
  Add support for OpenSSL provider to the library and evmctl
  tests: Add pkcs11 test using provider
  ci: Install pkcs11-provider where available

 README                 |   5 +-
 ci/alt.sh              |   2 +
 ci/debian.sh           |   1 +
 ci/fedora.sh           |   1 +
 ci/tumbleweed.sh       |   2 +
 configure.ac           |   6 ++
 src/Makefile.am        |  21 +++-
 src/evmctl.c           | 124 +++++++++++++++++------
 src/imaevm.h           |  39 ++++++-
 src/libimaevm.c        | 225 +++++++++++++++++++++++++++++++++--------
 tests/functions.sh     |   1 -
 tests/sign_verify.test |  30 +++++-
 12 files changed, 369 insertions(+), 88 deletions(-)

-- 
2.43.2


