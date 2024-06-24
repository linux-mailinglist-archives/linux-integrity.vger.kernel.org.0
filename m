Return-Path: <linux-integrity+bounces-2926-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FA91598C
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 00:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945661F24ED1
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF21A2554;
	Mon, 24 Jun 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jtsUgCjS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7219F48B
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266531; cv=none; b=DAcdkx0TgRJVA9wr/kcgp6xgk86A8USMWtLzJfFdruXcJ9mInBmbUISPiEKigwGiCZBOe6XP9SsruA21nn4ax5p9I3d2a0trrNd55/oJ4DawrxwnL+JQY5NBXujubqKYALiVOJRC228toKK3gdsW0LTZSp8JCtq1RCBBPNBObBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266531; c=relaxed/simple;
	bh=DHUOwhNcj8kPNHuUp2c8J5oitS+X2+wIV/cmt8wxc+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnDxhRRt0n/C1G88TY2nLfRYk4GKaNBogG1T/3qEBeSpZ30VHN1lZPXAWeBJbU6KqYKk4gdk5gE6PyiNQTjAf3cZd2tknl6UyW1T24TDyRKwb4C4iRLlV/Af+/c9dbI2g7tDlxkMGuwx6MB8AYnaho9TsyN+4GCtXs6gyFhMYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jtsUgCjS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OLuU2q007194;
	Mon, 24 Jun 2024 22:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=FU/1ohnBYnzIv
	rJ0A381BQNGXn+MLd+rF/s0PX8pu/0=; b=jtsUgCjS+qxBLSsdRPRajade1fQaf
	TPM9XVCytkeIxailo79p84rLo7KyrCJZbI89PVJIELmcmLFGTyl5okiKZEFsO6tv
	zfpL5JfQCb6Zb887tdoQc3cdh/TpgE02dUPSgD3UsRH0OvMaK7KrbjjQi9A/HmTh
	Qi5VxVdExUvkaNXy6czMRO8N1wT9J7yP//SRCjB3QD+gRyoVbHKhez9yNOLEQ/p2
	WXFfUkFmWpzNa9NAUToimJlMdZ+zxqoyZPVgR2Kgx4Vmndykm1XwDORR6WuMPWCe
	9kMp5CSvacN8+uM9GNemf2GWu7fR4QS9sHC2fhg8v/DTPkb6GgyhrlSJw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yygr9g22v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OL4ZW7032606;
	Mon, 24 Jun 2024 22:02:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn32p5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:02:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OM22gL28049746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 22:02:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C03A58066;
	Mon, 24 Jun 2024 22:02:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DB945805F;
	Mon, 24 Jun 2024 22:02:01 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 22:02:01 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, noodles@earth.li,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils][PATCH v2 4/4] Replace Ubuntu mantic with noble
Date: Mon, 24 Jun 2024 18:01:57 -0400
Message-ID: <20240624220157.2248556-5-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624220157.2248556-1-stefanb@linux.vnet.ibm.com>
References: <20240624220157.2248556-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ij7Pdp2cZBaxX7g4nYPFQzA52c4pH1AH
X-Proofpoint-ORIG-GUID: ij7Pdp2cZBaxX7g4nYPFQzA52c4pH1AH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_18,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=912
 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240175

As Ubuntu noble contains a pkcs11-provider package, use it for testing.
Also use the distro provided openssl version.

Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .github/workflows/ci.yml | 5 ++---
 .travis.yml              | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 8471096..71fcaae 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -132,13 +132,12 @@ jobs:
               CC: gcc
               TSS: tpm2-tss
 
-          - container: "ubuntu:jammy"
+          - container: "ubuntu:noble"
             env:
               CC: gcc
               TSS: ibmtss
-              COMPILE_SSL: openssl-3.0.5
 
-          - container: "ubuntu:mantic"
+          - container: "ubuntu:jammy"
             env:
               CC: gcc
               TSS: ibmtss
diff --git a/.travis.yml b/.travis.yml
index adaf095..b8876f4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,11 +40,11 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:mantic TSS=ibmtss
+          env: DISTRO=ubuntu:noble TSS=ibmtss
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.5
+          env: DISTRO=ubuntu:jammy TSS=ibmtss
           compiler: gcc
 
         - os: linux
-- 
2.45.2


