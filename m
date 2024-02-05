Return-Path: <linux-integrity+bounces-1036-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99A849CCB
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 15:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3CD283FD7
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A9C2D045;
	Mon,  5 Feb 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sje6SV+Q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD132C86A
	for <linux-integrity@vger.kernel.org>; Mon,  5 Feb 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142544; cv=none; b=aJ8IgAfH07z8eah3xLUsGmRRgdX4VvPkADWhf+77t+li9bgfGCbH1BU+q2ecdc5CLfwRfDInufoXBKM/EEgM0B9gzuf/Fj+35ekxP53MGPDervpwIwx+0tDUmkXUlv9agf/qQZFd6xv5EUstIErlMnZS2jYl3gN6a47nqylXqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142544; c=relaxed/simple;
	bh=aHcekcL/kaAPMtQaqq0Uav30j6gZ6UMi46rFXPS55xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3apF3F9DLc9L+eun621tMFKsymvuCi8nyDSbVpzdrI/ykEeLnjD36C4i3ubslrH5QD93sPHrnlXz3HRUwb8ujlrQlrzz/Tc0I+uIq3dDb24q5h4F263ZUL5ByEBKBHOQ81oXeVc1DpKSnNRXnxzrDXQn15W3ES6fXP9WBKp6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sje6SV+Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415E3FAn015743;
	Mon, 5 Feb 2024 14:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=50GJFoOptfHW53VmwKnjaoK4cctvOO18NvxymGPupyk=;
 b=Sje6SV+Q9C2iikmg7aW2K1amS8YC5PmxrkHdkgfLfmsa8RaBLFi84TrQaofomVAIGn8X
 WYv56JzJM18NU/RGcLG6D8ilazYAZHf5mKQh+W8x3WgRsWfpM0v/DO0R87foQmfWQfB9
 lOn8vRGvsuN5Xc7onogqjp4rvl7h4QqODqKvOcEGKjk4Tx0h2FQiorKi565r+37Xz5G5
 zkKxZAWtD8X4yRmQn8aLHshGRaj6QJqpJoYk9sBcATJ+GFy3yfxIKkw5m4Etpzc9H+TX
 j5H7vDK0sbbFhw2N9kpUUyr6LPR9r9Wc7fWpMXNAP70K2ltDwsVklneH+R62Agj4Z4uX Cw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w313krd2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:32 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415CxkUv019996;
	Mon, 5 Feb 2024 14:15:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytss5nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415EFUxm23528004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 14:15:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EBC558063;
	Mon,  5 Feb 2024 14:15:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F8E358052;
	Mon,  5 Feb 2024 14:15:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 14:15:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v1 ima-evm-utils 0/6] Deprecate sign_hash and add provider support
Date: Mon,  5 Feb 2024 09:15:22 -0500
Message-ID: <20240205141528.3566511-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bXj6UbNeBEWR2TM0l2lsNjyjZPmuaNHe
X-Proofpoint-ORIG-GUID: bXj6UbNeBEWR2TM0l2lsNjyjZPmuaNHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=935 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050108

This series deprecates the sign_hash function and introduces
imaevm_signhash that requires the necessary parameters to be passed rather
than relying on the global imaevm_params variable. This way we can get rid
of the usage of imaevm_params for the OpenSSL engine and the keyid. Then
add support for an OpenSSL provider. The choice of engine versus provider
is implemented using a struct imaevm_ossl_access that wraps the engine or
provider parameters. It also provides a type field where the user can
choose on or the other. imaevm_signhash takes this structure as an optional
parameter to support engines and providers.

Also extend existing test cases with tests with a pkcs11 provider.

Regards,
   Stefan

Stefan Berger (6):
  headers: Remove usage of CONFIG_IMA_EVM_ENGINE from public header
  Pass ENGINE and keyid through to function using them
  evmctl: Replace deprecated sign_hash with imaevm_signhash
  Add support for OpenSSL provider to the library and evmctl
  tests: Add pkcs11 test using provider
  ci: Install pkcs11-provider where available

 ci/alt.sh              |   2 +
 ci/debian.sh           |   1 +
 ci/fedora.sh           |   1 +
 ci/tumbleweed.sh       |   2 +
 configure.ac           |   6 ++
 src/Makefile.am        |  21 +++-
 src/evmctl.c           | 124 ++++++++++++++++++------
 src/imaevm.h           |  39 +++++++-
 src/libimaevm.c        | 215 ++++++++++++++++++++++++++++++++++-------
 tests/functions.sh     |   1 -
 tests/sign_verify.test |  19 +++-
 11 files changed, 354 insertions(+), 77 deletions(-)

-- 
2.43.0


