Return-Path: <linux-integrity+bounces-4587-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6C3A159EE
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2025 00:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C407D188AC10
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9601D8A16;
	Fri, 17 Jan 2025 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dfB6nT56"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB025A636;
	Fri, 17 Jan 2025 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737157031; cv=none; b=t9u4IHYbD8S6TGD5cFr5RcjS4Aj5RS9q7nxmxMEgHFg6hei/jCMsuHL6g0uFdmvVf/FLamvdtIKacRUUf+DTzzrQ9OPLTz6ewY+wceLYmHcBCZFyv3z0IvgJkVXMKRZRfnFqaETWUfNCabFZIA2b1lwj3jidUg2RC9o1jG4Ycrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737157031; c=relaxed/simple;
	bh=2nN7/55RwskFz0G1Ns+R44BJLdB4ctwFC47JoqOOsSQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=iXSd/MDglOlB2Bi3OhgDNzqRklrTQrqilkOnaRclbeuOGvmIRoZwVezV0n9lYew/KQHeImCHxtcBCYXIW06SUV2o6LQ9Nht//RrgE5wiRM0Tj4qI1p9Aq65iMITCjVnWqGuScBCYhp/zWgntfp4sNsV4xn6z/2S7ajA2TPZx57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dfB6nT56; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HLfMS3009084;
	Fri, 17 Jan 2025 23:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=M/EK3uHPhM3yEJh4E77zBOeW9gBU
	tUbQNBzYE/ceaR4=; b=dfB6nT56PbiXfXrOm6h/W9dN3qmT/CWrt4QnnrgdIVjB
	JUnerxGSmYwE0krQnkcuFJZRQppecFrJjc202dsUWJrNc+OsqyiadqbqjiolGw99
	IHtpBPL29B0OiDp5pCIU3HWidjf+orfB70TUWJ8hSehIdqT3nPKCgMxYZuPsAVzv
	Uj+vvlcrcY6CBhsuJrscQWqrw+i5yagy54aLZEM/nzdD/qkW/ogqvIVTGBfIBjlo
	fIVP1sYkL6iVxWbeKrxIFABHKDuU0FGs9B+V5ccuUhYmXWkNgY4wzLUgHlY+9PVN
	szYJLvCAWr7DcMgYEM3zJ0dclJn/VHMrEeAxq8kEOA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447c8jdr3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:37:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HJifet016571;
	Fri, 17 Jan 2025 23:37:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p24wr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:37:04 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HNb47E26936038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 23:37:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D39A58064;
	Fri, 17 Jan 2025 23:37:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8DD658056;
	Fri, 17 Jan 2025 23:37:03 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.15.82])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 23:37:03 +0000 (GMT)
Message-ID: <bb2b508eb974e2c33032aa06daf32819546184a8.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem updates for v6.14
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Fri, 17 Jan 2025 18:37:03 -0500
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
X-Proofpoint-GUID: n6Jwsi-wStffmdpp8Tfaug0vJZhwLSmj
X-Proofpoint-ORIG-GUID: n6Jwsi-wStffmdpp8Tfaug0vJZhwLSmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=843 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170182

Hi Linus,

There's just a couple of changes: 2 kernel messages addressed, a measuremen=
t policy
collision addressed, and 1 policy cleanup.
                                    =20
Please note that the contents of the IMA measurement list is potentially af=
fected.=20
The builtin tmpfs IMA policy rule change might introduce additional measure=
ments,
while detecting a reboot might eliminate some measurements.

thanks,

Mimi

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4=
:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v6.14

for you to fetch changes up to 4785ed362a24d4f37ee0eb4403f587fee886f8da:

  ima: ignore suffixed policy rule comments (2025-01-03 10:18:43 -0500)

----------------------------------------------------------------
integrity-v6.14

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

