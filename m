Return-Path: <linux-integrity+bounces-2923-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB0A915989
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 00:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C1028270C
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9057B1A0B1D;
	Mon, 24 Jun 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qsgm25BS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2351A2C1C
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266530; cv=none; b=XfnEraKdAYqPvgZpvWRpqSZYQDxx/P4TD7MKnJ54lJ4MBrNF2goXVV3mCUkdhnMLLTq1/qICoOrdOs1hU7rMJbQWwH+LuvtgwVV0qek5DkkGgVN1qV7rx7Z7MvX4vevE0mBeehtY36ej+eavIgPAszJZuwnrMIeN6PxZX6Zpyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266530; c=relaxed/simple;
	bh=fm9GEnE5uDqIbAAmssW+rmForZYgANvxxKDq1ZFXzro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RARdnphfg/pGCS3aiu6jPQDSmsfsQOHRzZKhRFD29gZ8808yW+cUh95ZRwyQvFTmFu7RoT9bDGdK3YJM97ViYWlCVy1eJDbPmUYX26UoLyY5ujgXpSBjeB3bPusR5O3V3SZ8O3e1U8kKUw9lfGFBqswZoTLA/CZkROV4d8u4/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qsgm25BS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OLx7x3006204;
	Mon, 24 Jun 2024 22:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=uESKFsm+Q8IytVOZacPClM919AI4izkY5vRuDcH
	KLZ8=; b=qsgm25BS6NFbYGI20zI1fMu+zwIP/KAWMFOFW35fBOsgDL/F3aQCWd8
	4tFkyUJnglgLppBoPynQrWDvUq5rp+aOkzBLZgSTCUVsZ5YXhbhvY29kX3k3tGGe
	eDG0D5ACwzw+VmoyST7Togc5iZdZI+ugGdsIJ6RtMR5Ll6KyutlbsLqpRRnIiL25
	/gGOTi7aHvLg6BROIElVnU0pREuxNdvJ+omE4QZOuEaltiJzj+UeEwykAHL5iQ+F
	oVHT5wTachNYupN6Y68x1KqiSKGeiTx6Tlv3oxrio4ea8LMOxxC/+NVZf+6VO5Ih
	xiAgHBOj1w2lZ1BnDCtwhfvITVpf6dw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyh6ar085-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OIeOBO018093;
	Mon, 24 Jun 2024 22:02:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xu3a8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OM1xrn38994328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 22:02:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7295758071;
	Mon, 24 Jun 2024 22:01:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 018AA5806C;
	Mon, 24 Jun 2024 22:01:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 22:01:58 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, noodles@earth.li,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [ima-evm-utils][PATCH v2 0/4] Enable and disable OpenSSL provider tests
Date: Mon, 24 Jun 2024 18:01:53 -0400
Message-ID: <20240624220157.2248556-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hBdSZG6zc4iK_QAaThtnKJyCD-bNr6Gq
X-Proofpoint-ORIG-GUID: hBdSZG6zc4iK_QAaThtnKJyCD-bNr6Gq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_18,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=610 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240175

This series enables tests with OpenSSL providers on Ubuntu for testing with
pkcs11 and SoftHSM. At the same time it disables testing with OpenSSL
providers on AltLinux and Debian due to an issue that most likely stems
from a bug in a dependency (OpenSSL, p11-kit-modules, SoftHSM, or others).

Thanks to Jonathan McDowell for the backtrace on Debian. It seemms to be
the same problem as on AltLinux - a locking issue in the C_Login ->
C_OpenSession callpath that blocks forever in a pthread_mutex_lock().

https://lore.kernel.org/linux-integrity/20240621005912.1365462-1-stefanb@linux.vnet.ibm.com/T/#meb2e76c337fe8d140cdbcc699c0606d31d7749a2

v2:
  - dropped ci/cd changes from 3/4 in favor of 4/4

Regards,
   Stefan

Stefan Berger (4):
  Call OPENSSL_Cleanup before main exit to avoid crashes when engine was
    used
  CI/CD: Disable pkcs11 providers for Debian and AltLinux
  CI/CD: Prepare Ubuntu 24.04 (Noble) to run provider tests
  Replace Ubuntu mantic with noble

 .github/workflows/ci.yml |  5 ++--
 .travis.yml              |  4 +--
 ci/alt.sh                |  2 +-
 ci/debian.sh             |  2 +-
 ci/ubuntu.sh             | 63 +++++++++++++++++++++++++++++++++++++++-
 src/evmctl.c             |  3 ++
 6 files changed, 71 insertions(+), 8 deletions(-)
 mode change 120000 => 100755 ci/ubuntu.sh

-- 
2.45.2


