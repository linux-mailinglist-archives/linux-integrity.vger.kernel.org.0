Return-Path: <linux-integrity+bounces-5487-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADD2A7376B
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 17:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4133A7289
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C4213E7C;
	Thu, 27 Mar 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pmllQSfw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB855217670;
	Thu, 27 Mar 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094494; cv=none; b=jCe9eF/UWwTE3MmJ9LO4xM/Had9nvBiIz66N4MgTT/mus0DXZteihkdLqrRNZsUxzrdhsFsYiJDMkFfaatc+LLm2awPT90r6zeUynkAt6r5TxZkY8zU4matBRa85Es9pFetUm3hTzkaLuZF9Z98KZsDVDYnKn3Jnr24H+vMS2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094494; c=relaxed/simple;
	bh=0vPLlBQahTkP5pEjRqrWCsnDf4JZXiYtg3Pn1gNdtwI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=J8yND5/L41qJZoWg51WsYMwLQ3JPBvXEAqlHLOGqjWVeh48X2q5hs0mlkL4SKgEERy/LcqtV1/d1mrnWF4xgSRIKbbAwBDKAw76Su15oWnCVEXfz7GQ5oW0XZIz3rO7Jdv0YpD8GOlloBBzLNurW8XO31AwDWmmZeiW2RMGQPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pmllQSfw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RGoJ0T009525;
	Thu, 27 Mar 2025 16:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=WvF7I3iYygiopYEt+jKYWKVxx9Bh
	3XKfhxNPDKdO7nA=; b=pmllQSfwatHIRvzUeVVeNDHfdWopX6YGHAjEKHOPnAgH
	cxI0pdZxvhzDYW7rbRbteDT6cr0xMf8QFexzQbxKEOp8WDI6j5qqVyeMMgQc4VZ8
	QA4xYjXaO0a2UwG7Yr3S4FozeOQFpQ5Hs77A1pe4do+c5xNVmN9Ll1DW16CQKjdF
	iB1kTU3i0nX37OdDwejNC6hbnTWix2/tFWbdRewdDZMsNQOdXqSvJeWeL98VUhlP
	XblPdvQKqdSfZNn0wBtEpglTxemhtOiMUJojLwKHR28tz9lxZvySZAkS8jbfOaww
	RvSVy9PruzJVzScO4wMjQxQ+Ryr7L1eLr88AO1UYcQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrrq57ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 16:54:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RG1uoS009709;
	Thu, 27 Mar 2025 16:54:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkx2kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 16:54:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52RGsgY84391626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 16:54:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5F745805B;
	Thu, 27 Mar 2025 16:54:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4054A58058;
	Thu, 27 Mar 2025 16:54:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.156.46])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 16:54:42 +0000 (GMT)
Message-ID: <b33c8cbb7038a65f51677e547ebcabcaebdd5305.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v6.15
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Thu, 27 Mar 2025 12:54:41 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eTJh9dvoyiplxxOPo3suCOwSnWjJaasr
X-Proofpoint-GUID: eTJh9dvoyiplxxOPo3suCOwSnWjJaasr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_02,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=893
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503270112

Hi Linus,

There's two performance improvements, which minimize the number of integrit=
y
violations.

thanks,

Mimi

The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6=
:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v6.15

for you to fetch changes up to a414016218ca97140171aa3bb926b02e1f68c2cc:

  ima: limit the number of ToMToU integrity violations (2025-03-27 12:40:12=
 -0400)

----------------------------------------------------------------
integrity-v6.15

----------------------------------------------------------------
Mimi Zohar (2):
      ima: limit the number of open-writers integrity violations
      ima: limit the number of ToMToU integrity violations

 security/integrity/ima/ima.h      |  3 ++-
 security/integrity/ima/ima_main.c | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)


