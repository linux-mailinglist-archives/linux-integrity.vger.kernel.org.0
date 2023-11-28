Return-Path: <linux-integrity+bounces-264-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA17B7FC213
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4211C209CF
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47C39AC0;
	Tue, 28 Nov 2023 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dkvpXRDA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A01730D1
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:17 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHlajp022785
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LoqjGlpIAVWBDdSAoxN0zsDhy0LLltKVPhX3LbfoZcw=;
 b=dkvpXRDAwe903v9M4vW7KVyFm9YvBZQocu1omuPKv49CVtA75JUOvhfrAz7oujJ5HVTT
 /DU5zIlk8+onAW3WJ5/xViu8U4rxegRCcG4oa+ZEqAlJCQdwok5qhDmFM6H+GULRxAL8
 61sfzWy3J/Rd83QDOc/7M67Qk1X06h5tVBMvjwqlkrb0vQl/CAQSiucCTQKNSnR3b2pY
 G3HyKGZHhvBQrKoKNTwkvbbgrze+6XGjUl5KJr8loqof+ImRXQ4DPEPDyh0Bim1OdMDl
 mQ4VuA7f4rUsIhbcI19uea1vDgD0o29z00vYLATdieIo3LB/dKTobJTX4vTpZ4bsPQR5 TA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unmwg8tk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG0v72031048
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8t1uhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:16 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGFsT30409446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6957658051;
	Tue, 28 Nov 2023 18:16:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 275825805E;
	Tue, 28 Nov 2023 18:16:15 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 00/14] Enable shellcheck and fix some issues
Date: Tue, 28 Nov 2023 13:15:58 -0500
Message-ID: <20231128181613.1159958-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MbTkvFSJGyi8pAaTiNS7lp8Gb9I6i5Kv
X-Proofpoint-GUID: MbTkvFSJGyi8pAaTiNS7lp8Gb9I6i5Kv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=976
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

Enable shellcheck for the bash scripts in the tests directory. Fix issues
on the way that are found when particular checks are enabled. In the end
all shellcheck v0.9 checks are enabled and shellcheck passes without any
issues.

Shellcheck can be run using the following command:

   make shellcheck

Apart from style issues two real issues are detected by SC2003 and SC2295.

Regards,
   Stefan

v2:
 - Rebased on latest next-testing branch
 - 1/14: Use ${var:+${var}} pattern for variables that hold multiple
         arguments like "--foo bar" which would become one argument
         if passed with "${var}"; fixed a build issue
 - 4/14: remove $new_policy file in success and failure cases

Stefan Berger (14):
  tests: Address issues raised by shellcheck SC2086 & enable shellcheck
  tests: Address issues raised by shellcheck SC2181
  tests: Address issues raised by shellcheck SC2046
  tests: Address issues raised by shellcheck SC2320
  tests: Address issues raised by shellcheck SC2317
  tests: Address issues raised by shellcheck SC2034
  tests: Address issues raised by shellcheck SC2164
  tests: Address issues raised by shellcheck SC2166
  tests: Address issues raised by shellcheck SC2294
  tests: Address issues raised by shellcheck SC2206
  tests: Address issues raised by shellcheck SC2196
  tests: Address issues raised by shellcheck SC2043
  tests: Address issues raised by shellcheck SC2295
  tests: Address issues raised by shellcheck SC2003

 Makefile.am                     |  5 ++-
 tests/Makefile.am               | 11 ++++++-
 tests/boot_aggregate.test       | 28 +++++++---------
 tests/fsverity.test             | 22 +++++++------
 tests/functions.sh              | 36 ++++++++++----------
 tests/gen-keys.sh               |  8 +++--
 tests/ima_hash.test             |  4 +--
 tests/install-fsverity.sh       |  4 +--
 tests/install-mount-idmapped.sh |  2 +-
 tests/install-openssl3.sh       | 14 ++++----
 tests/install-swtpm.sh          |  9 ++---
 tests/install-tss.sh            |  2 +-
 tests/mmap_check.test           | 10 +++---
 tests/portable_signatures.test  | 11 +++----
 tests/sign_verify.test          | 15 ++++-----
 tests/softhsm_setup             | 58 ++++++++++++++-------------------
 16 files changed, 119 insertions(+), 120 deletions(-)

-- 
2.43.0


