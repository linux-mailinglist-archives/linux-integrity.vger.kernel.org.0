Return-Path: <linux-integrity+bounces-2897-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413969117CF
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 02:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94FF284206
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 00:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2AEA21;
	Fri, 21 Jun 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B0PPGvBO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B91FA1
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718931573; cv=none; b=et5oqup0pJDwbeNcOLBc+QrJbULaQTpBkCfKEeGV07HIDUoX74IqPJRKV7E2cwDVRnryW+vIYfE96xUs6x7hF1OgOv/2Agx1iH2s+jtQppvNgFiLEqLui9d/Xc256HKPz/5GvuEGdctYKsAaPP7THXLG9WL39FC1pF1BjN6tA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718931573; c=relaxed/simple;
	bh=tPFahPIvr4e382g+NZPrvv0FhS5mbdiPoCuiwfEP3K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNZ2IUdziE30Rf4WOWgymJ/ALDLWoc4xlUuUOqnssut2jn1hCVCdkUreHKfGzCtdRXMR01NgEoN+e5NmGJAL+GenBCvXuA/mDTTTcbbsFDF7ObaLB+SAufI3SXLYnYYYlrH7doY6QWuPQhtQBKB9Rco3fNE86qu7iMcoeaY3W10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B0PPGvBO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0v0UF029467
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=rKR+Utwz/uHCvL/eJCJeOYcH+i
	5RLW+oSGIw5y5LP0M=; b=B0PPGvBO3k88xtPHaNjIjGr99XaI9Ukp8COvmRV+Q9
	mqep7loCfwESbcmEKVqYYLMuNZ3GaqvCGVdPG4j9Pkw6gUSYS9GqVdAMNVc64sP9
	Z1ytyjcZ9Vs0HxwVnSJGQluDxuyZgrQd+KmILB9Ql2TcDAonjmYpXTyZ1x1JrMY5
	2WmVDMwQcAkl7o9enzlZZAXxJm/xI8dwUa9eU0iRAPPjH2eXxMSbeZc3/pBCNauh
	VWC6zBXCUmhg41rRxv9LK18X1MNDHvnXDqJkgNjtKEPljHm1mI69nvuji0L6ETJO
	mREk0NWGg53M56x3R5pNvS5UnWQgVT523UM7yZT216qA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvx4g042t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0MCm4031884
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspjt45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 00:59:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0xOne37028254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:59:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D18BC58043;
	Fri, 21 Jun 2024 00:59:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 688BD58053;
	Fri, 21 Jun 2024 00:59:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:59:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils][PATCH 0/3] Enable and disable OpenSSL provider tests
Date: Thu, 20 Jun 2024 20:59:09 -0400
Message-ID: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ARt-qhHtk5w2O6wYd7qbFGd7PzFotaSY
X-Proofpoint-ORIG-GUID: ARt-qhHtk5w2O6wYd7qbFGd7PzFotaSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=476 phishscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406210005

From: Stefan Berger <stefanb@linux.ibm.com>

This series enables tests with OpenSSL providers on Ubuntu for testing with
pkcs11 and SoftHSM. At the same time it disables testing with OpenSSL
providers on AltLinux and Debian due to an issue that most likely stems
from a bug in a dependency (OpenSSL, libp11, SoftHSM, or others).

Regards,
   Stefan

Stefan Berger (3):
  Call OPENSSL_Cleanup before main exit to avoid crashes when engine was
    used
  CI/CD: Disable pkcs11 providers for Debian and AltLinux
  CI/CD: Also enable Ubuntu 24.04 (Noble) and run provider tests

 .github/workflows/ci.yml |  5 ++++
 .travis.yml              |  4 +++
 ci/alt.sh                |  2 +-
 ci/debian.sh             |  2 +-
 ci/ubuntu.sh             | 63 +++++++++++++++++++++++++++++++++++++++-
 src/evmctl.c             |  3 ++
 6 files changed, 76 insertions(+), 3 deletions(-)
 mode change 120000 => 100755 ci/ubuntu.sh

-- 
2.43.0


