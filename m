Return-Path: <linux-integrity+bounces-307-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A599A800C28
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90EA1C20FAE
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70262554A;
	Fri,  1 Dec 2023 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z7aK0mAn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7D131
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:51 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DCMck004523
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=sPLc3kOpzYIvkz7sbbz5FiRMXYu97+9PMN4RlV0nr/s=;
 b=Z7aK0mAn364N3ogb/b+yjjG0EKpR6eMQ98mP6AsIOUsWiC0u2xY4kBMf48JdF6BQ48QW
 vrjgVh3T3ga2KXGJrXsbr7ZNvNmULZd+xSGv22xDWqNHaL0FhidXiAVNtc5Aw3vi8lAZ
 7cm+/60XSDzJA6+x1TDCZe6N7jhAVmYaI8O1g72TYubxfF+hRbGrnGexaGGJu43QKg2b
 GOQadIUYS+jFs/hTa0I8lOQbIthSx1MjfPWZbm2lHMlLAss8Ouw1ZYT8xblvCnZLCCCM
 vJ2l0J5wZH2v70xcHm8QPmsJ2zIuZPBdH0ZmUMm4f2FnsxYVlGGiHTUKJxchCvOCloq8 cQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqg5qrjde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXvde002651
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8p57r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:49 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVm0120709928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EAD15805E;
	Fri,  1 Dec 2023 13:31:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5004A58056;
	Fri,  1 Dec 2023 13:31:48 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:48 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 00/14] Enable shellcheck and fix some issues
Date: Fri,  1 Dec 2023 08:31:22 -0500
Message-ID: <20231201133136.2124147-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y_U8Q08jz-5NsX24mvTKlTEHgiPH_CBO
X-Proofpoint-ORIG-GUID: Y_U8Q08jz-5NsX24mvTKlTEHgiPH_CBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=998 malwarescore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010092

Enable shellcheck for the bash scripts in the tests directory. Fix issues
on the way that are found when particular checks are enabled. In the end
all shellcheck v0.9 checks are enabled and shellcheck passes without any
issues.

Shellcheck can be run using the following command:

   make shellcheck

Apart from style issues two real issues are detected by SC2003 and SC2295.

Regards,
   Stefan

v3:
 - Replace read with readarray

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
 tests/boot_aggregate.test       | 29 +++++++----------
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
 16 files changed, 119 insertions(+), 121 deletions(-)

-- 
2.43.0


