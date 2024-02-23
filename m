Return-Path: <linux-integrity+bounces-1414-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B081C8615D2
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 16:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28A41C2424D
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578808288A;
	Fri, 23 Feb 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ivnTwe1D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517694C79
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702242; cv=none; b=kcuuQaAdMJb68a+Bw4ZDM8Td5t1A9nh4OrQN1CYC5sfOkfc7Ng9HidTVOKY1zp6Kc26kxy53qCvbC8DgfsY9ZP1UZuOBeLhcYpV9Ptcz418d8HdBr1QZBA0cHmAJ9x94oPL1GtBKlZT0VjtRyoNTUoATZDIyiUk6koRg3gQ4JrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702242; c=relaxed/simple;
	bh=ycQLaq8XK6OTOU0OPBxiiOITC5NqcuA88N02tOVCpak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHhjG6Ux4Kv6j2EoxIvj7/+ue9Qn4x1ioUVjOQ+4wCItruWhDBSPB9YgwsILNn+yiOSdnitYmVNbt1/ehAAfEQfrFTUUvr+nsE6cX8uKp1xLExpdHVEHRmTJDyl0gHtVabKwyakr+APbcu/GbzTna4/dP6VdbTUweGCjl6JNNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ivnTwe1D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NF2DgL014856;
	Fri, 23 Feb 2024 15:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Q1yLUe/j8gmnJRu979025ErSBpUyq0rMbWl+yF33yRY=;
 b=ivnTwe1DFI4OZEt70Zy5OilfRPkzybTwbCAIvziw5GnuBymcMHd1p1iQHoffqbsCKweD
 B01AHB2/DQNVBnFJO8L6teVPRdmNtdX2SN004TnJLnbDcFuAT7QS/z1XUH7Fe8cWbQEf
 OsaLlyuka2ELyCgBVw234jvtSNg0NcTfrHFAg/tU7frmQgGj4qUyabtrwfW39DJ3Vw9H
 m1Jcse7u/i+xbblrllJR2d30he3NAjxMeXUQFLBHZoFCc5H4wiWi7Lxvzf5D3tA6AOUZ
 iwcbjd1jjSLp2Pq65O/8oZ+guBn+v5c16JJoIOdWN1VlYBW/AIsf5XyfszGo65oLhA3W gA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wewn98sxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NDJhV4013522;
	Fri, 23 Feb 2024 15:30:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0xes5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NFUKdU8586214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:30:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA40558075;
	Fri, 23 Feb 2024 15:30:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2958C58068;
	Fri, 23 Feb 2024 15:30:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:30:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 ima-evm-utils 0/6] Deprecate sign_hash and add provider support
Date: Fri, 23 Feb 2024 10:30:08 -0500
Message-ID: <20240223153014.4048133-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Wf802iyyjzd6YoSeUoauT-heERJG_zA
X-Proofpoint-GUID: 6Wf802iyyjzd6YoSeUoauT-heERJG_zA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230112

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

v2:
 - Fixed some minor issues

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
 src/evmctl.c           | 124 +++++++++++++++++------
 src/imaevm.h           |  39 +++++++-
 src/libimaevm.c        | 217 ++++++++++++++++++++++++++++++++++-------
 tests/functions.sh     |   1 -
 tests/sign_verify.test |  19 +++-
 11 files changed, 356 insertions(+), 77 deletions(-)

-- 
2.43.2


