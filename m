Return-Path: <linux-integrity+bounces-1474-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE338867FB2
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89493291408
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C760DC5;
	Mon, 26 Feb 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J5CYLh/S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920512E1FF
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971681; cv=none; b=CXh8btTkGyeJB3aicIeQBIpSIxlBYRxo1JnSvkZ2BKF7p0/st/SSavSwx0yHtLAq+DS1ILNGQf9jDVwWylOX5SMMzryzpn0V3vs3rJR89dhGWr7owNgFot7dxRqO6rpXol51K2WkUYkMz0DzO34f1+D38cOskUX5hCNssLeSpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971681; c=relaxed/simple;
	bh=KZfxwk1BZrQV9mnxlNYh/uEmjUnR8/f9vtM7FOrueOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8ewQ/3udDAKohzp4Afy9s736PkHP96HOcul8jtJ7fVKOL7Xs1A9wnoJRvD8RjS1hHD+oeM6WV/t7skDmemUe6VKdEHhgbj0wGG6ni1imF01S5vGTGNPsiNTGR32E9MslTmrWXB23zZYUP+99G2jGP0DK1UE9vspsR6AlFEWceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J5CYLh/S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHCDNl004928;
	Mon, 26 Feb 2024 18:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bB0wMZpEG4d4Fr9NVIlwoc8CBcnTUXF3cRGcabJ76PI=;
 b=J5CYLh/S6M4SiwoM9G0A92E1+rN6KjbrlL66/Rm/z3VKGMOBVmmSCWcKCrVnBl/PL5vY
 JRdEioWgubhAtz/h0xrdSUai0pvt+AZbJAI4bQnvOQB71DsCqgGFRFTwC1hRAv0LDAnM
 tzNydJw568utr25FCVcvnhLNnycuii9cVZSDGYdt6UNOOmhmfKtBi4SbJ57x0/AITDBI
 O7fJRANRaT+bx+B7UKhyPZbcT7dOVZrvyRBl0ioZAH9xFfZ0qBRho/w6q6t7UcMN+DEq
 gLsZI29aFAmtvj8uv1y6Dv9MIENWg1ICmWcRYhWHiBIDh+2WHD+yz1Ezm9QY+QRF3Imh Lg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxu5hpaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QI3Xtk024122;
	Mon, 26 Feb 2024 18:21:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0k2jtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QIL5vg43450888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:21:07 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E45F25805F;
	Mon, 26 Feb 2024 18:21:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B80A5805D;
	Mon, 26 Feb 2024 18:21:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 18:21:03 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 0/7] Deprecate sign_hash and add provider support
Date: Mon, 26 Feb 2024 13:20:54 -0500
Message-ID: <20240226182101.25210-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mDHX9lj-sr9XNR1o70QLXu2jWheEIAmF
X-Proofpoint-GUID: mDHX9lj-sr9XNR1o70QLXu2jWheEIAmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260139

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

v3:
 - Added patch checking for engine support in evmctl before trying to run
   pkcs11 test (1/7)
 - Updated README with new --provider option (5/7)
 - Added 2 more skip's to pkcs11 test in case neither engine nor provider
   are supported (6/7)

v2:
 - Fixed some minor issues

Stefan Berger (7):
  tests: Skip pkcs11 test if no engine support in evmctl
  headers: Remove usage of CONFIG_IMA_EVM_ENGINE from public header
  Pass ENGINE and keyid through to function using them
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
 src/imaevm.h           |  39 +++++++-
 src/libimaevm.c        | 217 ++++++++++++++++++++++++++++++++++-------
 tests/functions.sh     |   1 -
 tests/sign_verify.test |  30 +++++-
 12 files changed, 368 insertions(+), 81 deletions(-)

-- 
2.43.2


