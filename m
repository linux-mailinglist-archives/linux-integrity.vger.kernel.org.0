Return-Path: <linux-integrity+bounces-4585-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186EA159C4
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2025 00:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E5416850E
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559AC1D5ABF;
	Fri, 17 Jan 2025 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MnAOa2ru"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC21BE87B;
	Fri, 17 Jan 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154937; cv=none; b=FVCr02OjrPRmms+y0czVe+bgBSoJwjsItpfB/f5gIjIuGwtBhhnULtF7JbcsOs55VrKCGYG7yjml7p92Oj3hpUTk/VtsL90+dZjlRmvITznhRcR/nHRSpTHyJOMLPD3JMp5e+xn09lF+r5Bhdx+QIroBEpsxecmo+2WNfd+TDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154937; c=relaxed/simple;
	bh=WtXpHW3Z0G0CfUkkdy+Xvfyqvnia/eEAZay79qOg0tE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=qIDd98egw5t3+lgyeXJviNWM8LgmsrTFh0xyqx0EqCqdN4l2lLjrMHdNlxcj0xPUCHKlDEgdJ3vVZn7n20PZmxRBfWYBI0mQ3rVyzgpIZkmKSRK1hIo/0xnfHdVjg17Pxp6TG1sznKWEuhRYx6lMpAfsnvh+1vQrVSSIv3AVH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MnAOa2ru; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HLfMQU009084;
	Fri, 17 Jan 2025 23:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=xX/5vdSaHQgRJ+0irvqUAyHw+zxa
	81wxLyUlDQbaQ1U=; b=MnAOa2ru4n5zEIeqNw3y8JuIa0ZJUc8S5IjGb1KlX6ce
	Nt7GbSny7u8QqWTFpnTjQzbARu5jkeLXHeF6IjStpM7WcZOaaw3G2UBede/fGCYC
	JsBBYWBTthYsjM9uqIO7tbK4WreOruCINj+0DrKnh8DwxUMjO1X/2iEmoeFA/6Jt
	HW3pGh9+b2Ewz7WcfwYS7aI6MF7Bmlm7nW8EgnfKrsJXPlimCrQsPXX0YRVOEY1f
	rX+KYwbagFKnjdOx4COubEx1yf6OzfNkxUE6AWvv3RdzZPjmAokTuhBa7dnmg5b1
	2eDlKE38JI32+RmDpd6c9cMtDTwzbILwr24TrkUvHw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447c8jdn3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:02:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HJtwZC016491;
	Fri, 17 Jan 2025 23:02:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p24tj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:02:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HN26OZ18154214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 23:02:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9622C58073;
	Fri, 17 Jan 2025 23:02:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11ED158072;
	Fri, 17 Jan 2025 23:02:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.15.82])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 23:02:05 +0000 (GMT)
Message-ID: <2c3b092932bac0945b6d71326a726e09a8f50ee8.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem updates for v6.13
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Fri, 17 Jan 2025 18:02:05 -0500
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
X-Proofpoint-GUID: vBXpHrXDvqgt5FWXXyTwOn07Ea4Dz5cC
X-Proofpoint-ORIG-GUID: vBXpHrXDvqgt5FWXXyTwOn07Ea4Dz5cC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=843 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170178

Hi Linus,

There's just a couple of changes: 2 kernel messages addressed, a measuremen=
t policy
collision addressed, and 1 policy cleanup.                     =20
                                                                           =
    =20
Please note that the contents of the IMA measurement list is potentially af=
fected.
The builtin tmpfs IMA policy rule change might introduce additional measure=
ments,
while detecting a reboot might eliminate some measurements.

Thanks,

Mimi


The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4=
:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v6.13

for you to fetch changes up to 4785ed362a24d4f37ee0eb4403f587fee886f8da:

  ima: ignore suffixed policy rule comments (2025-01-03 10:18:43 -0500)

----------------------------------------------------------------
integrity-v6.13

----------------------------------------------------------------
Breno Leitao (1):
      ima: kexec: silence RCU list traversal warning

Mimi Zohar (2):
      ima: limit the builtin 'tcb' dont_measure tmpfs policy rule
      ima: ignore suffixed policy rule comments

Stefan Berger (1):
      ima: Suspend PCR extends and log appends when rebooting

 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_init.c   |  2 ++
 security/integrity/ima/ima_kexec.c  |  3 ++-
 security/integrity/ima/ima_policy.c |  5 +++--
 security/integrity/ima/ima_queue.c  | 44 +++++++++++++++++++++++++++++++++=
++++
 5 files changed, 52 insertions(+), 3 deletions(-)


