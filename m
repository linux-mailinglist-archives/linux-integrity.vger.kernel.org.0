Return-Path: <linux-integrity+bounces-6748-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4B0B1718B
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 14:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAD31AA68F9
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BAF2C15A5;
	Thu, 31 Jul 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hd6PeUTE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1251E50E;
	Thu, 31 Jul 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966354; cv=none; b=W9JlrJN8cxpOCEPZ0FkNgODqU9O/ervXMUxoj7+RtAUb/CWDvWeiqM/0VdrMi0YZ02eMtuNbdaws+VQGTEb6Yfj78m5XfqFqwzZ0E6BWjXWiyA/TOdOuxGDXoifwcXLFVDjcYJjScxQ/Xc9QwXIOTihLkNZLoiFY+zVLMfbgRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966354; c=relaxed/simple;
	bh=IdHbz+n/VCVFoskpthFvu8eGP49AeiyXCPOV5CUPDCY=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=nOBTZ0YUHlOzcBg9kXXkvktMemksZj/nKNVZiFzb1qF/tCWw3c8jkY3gSRRn02rXYKrYH/k/7rFCEgVjVnKiJgLk+iecv0sB0NUr8Cz62ZtoQhojAgOTLINGUhJdc35aRDt720hKYLt/echcM2DoL6jBWqVvU8eGObW77FiC7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hd6PeUTE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V7dXil015077;
	Thu, 31 Jul 2025 12:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=HX8KTmyvbuQvdZZi3jKG6Grxwvv/
	C9vsXSC9qDlV+Io=; b=hd6PeUTE14bDSVQBtGJ6AAmlBNraXUhfHTUG/r9yK5qq
	UYFuOkP3RMZt7QyQhQn6SkgwJ06KHdCRIknstT9ykA9mv/7vYhf91b0qMw6o00hz
	3a28L2ZuGacrA6JMWb58tYtA9PtQM15SttIZ+AmKY9tJxEFj6A2aON/VPlTnE+Ll
	3MSdYrAcoVtkrzU3nNznXEUp0WppYw4pQ5DTFuY9aQvM3U8AtgZ5FjCioGx9FclF
	Jm8Jynzm3CZgraO8nSYevpkvwpFGuLJneHD8doUWfGcQ0qJzJc+hi48pT5DyQI0x
	39ggEdT8qikRcSlyPD3MLKI4gBVl6N0/32D/nNoAlQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfr2kum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:52:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAbkXX018307;
	Thu, 31 Jul 2025 12:52:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abpcftv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:52:30 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56VCqTYx33817076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:52:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5428858059;
	Thu, 31 Jul 2025 12:52:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08DA358043;
	Thu, 31 Jul 2025 12:52:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.117.201])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 12:52:28 +0000 (GMT)
Message-ID: <807ead8fdb2761721a4d79b89efb385420a0d6f0.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v6.17
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
	 <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Jul 2025 08:52:07 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA4OCBTYWx0ZWRfX714tfRmZBrn2
 2AF62YFJzWwA8HdQ4FWsE/LJvH6KwB2w8sYHb6nkOBxucgjrXgIZBF0ME4Hhciig/SmM6wOtsX4
 aVtwWFVobGTlDbdEaLpmo33UR63iCdgssDEXPU3K2q9ewq9Jz7hUrhE4bCoDfTk863GyC71o5hC
 FD9Uy+D3D+ozwTslHS5/oSO0VLIbHSmLj+3Qlj/TAKu2KL5wzWWFoKSl7iD6JEAGKM7YvjBgPpo
 46tDtlmz8nTnaa4rdJ2o+9TYjRw9VuI0b8YfbtjEcUmLGaeA+zGbChsCYVHWS+VqfxVRkeLjSUj
 jRTC4nwQpAK1Hvt7IlI0W75cXg5GDyKqWAnQuPy2TgM/dfKV7/dK76g4Nywc/tgbLhO2obSYzrI
 GQewr9SnIWE0YnHtqCS0Cj4ZGvrKwIqc/dphtKVpU8/EvAlFaN15IoZ/o/EuAW8LqTi57Zhs
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=688b670f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-3QCYIlBTK7xTtPJjuYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gBUcPCjjZ3soAgel5gwrpzontjf0UZ76
X-Proofpoint-ORIG-GUID: gBUcPCjjZ3soAgel5gwrpzontjf0UZ76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=855 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310088

Hi Linus,

With hesitancy, I'm sending this pull request containing a single commit=C2=
=A0to
permit disabling IMA from the boot command line for just the kdump kernel. =
The
exception itself sort of makes sense. My concern is that exceptions do not
remain as exceptions, but somehow morph to become the norm [1].

Permit disabling IMA from the boot command line as an exception for just th=
e
kdump kernel.

[1]
https://lore.kernel.org/linux-integrity/b1b5feaa93922c9b5a8f1a1e41385d266fe=
640ce.camel@linux.ibm.com/

thanks,

Mimi

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e=
:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v6.17

for you to fetch changes up to aa9bb1b32594cd67cafd29b330b158128b503882:

  ima: add a knob ima=3D to allow disabling IMA in kdump kernel (2025-06-16=
 09:15:13 -0400)

----------------------------------------------------------------
integrity-v6.17

----------------------------------------------------------------
Baoquan He (1):
      ima: add a knob ima=3D to allow disabling IMA in kdump kernel

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 security/integrity/ima/ima_main.c               | 26 +++++++++++++++++++++=
++++
 2 files changed, 31 insertions(+)

