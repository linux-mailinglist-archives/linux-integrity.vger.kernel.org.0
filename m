Return-Path: <linux-integrity+bounces-4083-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5F9C6209
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 21:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58256B27276
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD006206514;
	Tue, 12 Nov 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A++erLGG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D932309BF;
	Tue, 12 Nov 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429371; cv=none; b=BagcUivPoOgXDAFCjie/co6xwgC0U4L8zFnLMhrsu8B1wTWr9JfkJYNb9+ErGSgndzGA7kfzySL3b/a2+vHNB00VvSUm+60Y8rUNSn+JKSjPko9Kb3N8BXSa6VvGhDGZEfIYC+WPuI7AqmG3HhFGIKeXQaDa/d6fabqFKykvSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429371; c=relaxed/simple;
	bh=9ZoYAtxk59bGM/XIHyrszcd3j+PhG3oXS4rbt/EjZoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ZdpAPrqXo6sQODE7uNhnmsXgrHlSnYP5UI4JTfgGnO9k6E4Cxnu3lMPrzZ4ef67CHlqUkzJQQp1SWQXvg/SzJ7MKLfHwUnqGW1wQc3hpgiR/hwGKNP3gkx6OLrjglpLVD7Dn/UpN++sKilIf48DPQJzOxsApiZWzYbBjHXr0Hzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A++erLGG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFAK8P001109;
	Tue, 12 Nov 2024 16:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=7g5rlVuQ+EnvnyrhwnvqSxB556CU
	zYtmzbdYIHLZin0=; b=A++erLGGMTbItNWUGA1r4KZErFCgyW3vKiXK5ZYdIZ/F
	ZkVR5tAVXcYhfgG2W2hoVM4UPsFWenzp8cIsxrYBlKjjXKXgyd/1lxs4nBfxfzO8
	1m5QTVacZvgz1qt7ucsO/3cToOIWd6bIpZfI4eKwX6TTswc6z5kp6ESVrjEkE7al
	41EMmKm6kf4gQLMBWWD/z0RcI76wfxq+kdEtB1eOzj0DiqFSlqHl4j6zIGusiLEd
	FqX9wtTMhmRnJ2VmYqOzFENlwzg0SXIe1jYaTWgnUbGCc8XL2JG4PT8G4B/jFYhu
	39grtOLfJC6X8/pAJaQHiCOzr1q6ULXAtogkZK88wA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9dv0br5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 16:36:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFucsY018059;
	Tue, 12 Nov 2024 16:36:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2mvjka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 16:36:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACGa1rF18219702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 16:36:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3582858063;
	Tue, 12 Nov 2024 16:36:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE84758056;
	Tue, 12 Nov 2024 16:36:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.167.4])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 16:36:00 +0000 (GMT)
Message-ID: <da138eda4ad9d96a8e8d1d1cfb9cc5ac380b94cb.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v6.12
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Tue, 12 Nov 2024 11:36:00 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Domb7dLK_OFCWwq4nrbRWUwy6gO38JFq
X-Proofpoint-ORIG-GUID: Domb7dLK_OFCWwq4nrbRWUwy6gO38JFq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120133

Hi Linus,

Sorry for the delay in sending these changes.  There's just a couple of cha=
nges:
one bug fix, one performance improvement, and the use of static_assert.

- The bug fix addresses "only a cosmetic change" commit, which didn't take =
into
account the original 'ima' template definition.

- The performance improvement limits the atomic_read().

thanks,

Mimi

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/
tags/integrity-v6.12

for you to fetch changes up to 08ae3e5f5fc8edb9bd0c7ef9696ff29ef18b26ef:

  integrity: Use static_assert() to check struct sizes (2024-10-09 22:49:40=
 -
0400)

----------------------------------------------------------------
integrity-v6.12

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      integrity: Use static_assert() to check struct sizes

Mateusz Guzik (1):
      evm: stop avoidably reading i_writecount in evm_file_release

Samasth Norway Ananda (1):
      ima: fix buffer overrun in ima_eventdigest_init_common

 security/integrity/evm/evm_main.c         |  3 ++-
 security/integrity/ima/ima_template_lib.c | 14 ++++++++++----
 security/integrity/integrity.h            |  4 ++++
 3 files changed, 16 insertions(+), 5 deletions(-)


