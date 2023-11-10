Return-Path: <linux-integrity+bounces-3-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E587E83A3
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72492B20BC9
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4B3B78F;
	Fri, 10 Nov 2023 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o0Qc9FAu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB441208C1
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:47 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46609D64
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:46 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKGjCL022420;
	Fri, 10 Nov 2023 20:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CK+dR++0tGEXBmhXj3cUY8MYHIWnH9xU/B+SmgZvkgI=;
 b=o0Qc9FAue4pKhna561sBOBZMRRWYGmR2J89kKbjpV4Kdw6cO/Xc/jYRaADoVGx/GisG2
 fhBMi9lalO3aDzM8U5PboOPIQOaa2zG2+S8tI8KGYMakvI8GkbXO1Ly1QOlzlu0yzw8h
 TC2Hedfpd+UP3YxfEXnN3tcIt6nUXMC5Kx6kkKtJERPzLldtOdVQHG88Fib1WSP7hb4U
 53R6ZOqyVIeboSIkpOv6s1mfD9paQbSPzfAHUjfZbAl0k7lSaySYve1xaQglxeoaxbf2
 +ZfH/K0LUUDLj2CxaBgd/0UjxFwYkMqOfdGJrp3kHnR1BMt9RTZ7fWZDVYxuke7aj+SR hw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9udp03mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJ4aWd014346;
	Fri, 10 Nov 2023 20:21:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22de7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLdHY18809580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A741A58059;
	Fri, 10 Nov 2023 20:21:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E94458057;
	Fri, 10 Nov 2023 20:21:39 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 00/14] Enable shellcheck and fix some issue
Date: Fri, 10 Nov 2023 15:21:23 -0500
Message-ID: <20231110202137.3978820-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s0_RDIN5XnBv1mKLtbPxk5TsxqG01s0Q
X-Proofpoint-GUID: s0_RDIN5XnBv1mKLtbPxk5TsxqG01s0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=673
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100170

Enable shellcheck for the bash scripts in the tests directory. Fix issues
on the way that are found when particular checks are enabled. In the end
all shellcheck v0.9 checks are enabled and shellcheck passes without any
issues.

Shellcheck can be run using the following command:

   make shellcheck

Apart from style issues two real issues are detected by SC2003 and SC2295.

Regards,
   Stefan

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
 tests/fsverity.test             | 20 +++++++-----
 tests/functions.sh              | 36 ++++++++++----------
 tests/gen-keys.sh               |  8 +++--
 tests/ima_hash.test             |  4 +--
 tests/install-fsverity.sh       |  4 +--
 tests/install-mount-idmapped.sh |  2 +-
 tests/install-openssl3.sh       | 14 ++++----
 tests/install-swtpm.sh          |  2 +-
 tests/install-tss.sh            |  2 +-
 tests/mmap_check.test           | 10 +++---
 tests/portable_signatures.test  | 11 +++----
 tests/sign_verify.test          | 15 ++++-----
 tests/softhsm_setup             | 58 ++++++++++++++-------------------
 16 files changed, 114 insertions(+), 116 deletions(-)

-- 
2.41.0


