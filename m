Return-Path: <linux-integrity+bounces-7770-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0602C9D1F6
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 22:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 877314E06B7
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 21:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507CC2F7459;
	Tue,  2 Dec 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EL0oxxrv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C9222597;
	Tue,  2 Dec 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764712521; cv=none; b=nzk9RxfNxdmgR09cg0Y6eiMFfFaG0j1PXSXyhP/3CAL76JXM0xd1vSJMFGZnmqXDgQ0px0sMGi1692q8m35spwpgxk99RLeI9oXtURNlQAb/A6TkYUAmICa569h8spwaTWmEGENBOZK/8kvKLYagA3iKUOgVzioqaVEo+zHuCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764712521; c=relaxed/simple;
	bh=2jWq2tP5r1wQR38ZegYCXLQ/w39ADCABRX+T4gQJBYw=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=el7XDU0JP0+SJgKePN8FmzWqzGtleuL/CNxGloefiJITv7mAMA8GakZt39VqQLAdTCDX2pMk5JqNy86U9DIVbJv/fNEReYwcosA9FL5oJbS85Ux6kMSjXvG4apnI+m9iZeT7M3E3+UW/fBGKhkFtdSUlz/aZ1+lvVetJTpvHwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EL0oxxrv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2CRVhk006817;
	Tue, 2 Dec 2025 21:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=FdL256TvALAJyUbo5i537K68FyIx
	VTajVeDoO2HsqHA=; b=EL0oxxrvgzGcf92LEDEWRQTQLV9IGB6unzezTCpXFecF
	X+crX0mERvV6yaPaFQScLvjbs3qeK99QeYwEUQ4A7dDuAdFl5QpQIH00O78SIKOW
	CsYp+/JjtsL2VMnhJQyWH00/p+X7jwcOTVZjAkrg9MOjG+UU1zFK7Eqjb+HMrvC5
	AFCBTNNbpJwxw5a9/RgNOHjpt45zVtZEgHVAc/amL0yCEdaU9QWfP+r8oi5nguge
	Q/Ad0Y22x/bf0Vz69rzxSjgVZF2TDGeBi3Nm003CT8K3tA4xYZfbPRUqhCUfMOnu
	NKTqbQEhAGn5KYhSfVntqUgg9jKKCz2hxVOgxx5uJQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg7kw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 21:55:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2KnNj1010227;
	Tue, 2 Dec 2025 21:55:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnk6s0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 21:55:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2LtDv825952872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 21:55:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5844F58062;
	Tue,  2 Dec 2025 21:55:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2D8958052;
	Tue,  2 Dec 2025 21:55:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.103.34])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 21:55:12 +0000 (GMT)
Message-ID: <58c716aa7e18d107590f98705c29e5a0434cbcbf.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem updates for v6.19
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Dec 2025 16:55:12 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R_fbU6c2Kd1bU9-YN3kssL7wfvfzyhGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX+7bXJ2FARJLK
 EOR5C+1N1o+t6SsAUsz3vculw08DyWXSU9/hvyl/a2oxUu58nFj35c8MiwnkGTcXzrYrChkzwLi
 K5uPvX3lpZDYdXkvbD9BT6t656067mdnnr0Nyo/bcxKuCk3By4J4o4iFCf2O9iIvBe7YeG/C6GF
 4eHDlRjC63kaCfqHOXp4zK5Hwvefiq5TIhz90FDlu3I1HB4cP4XdTiNJcCDSa+FuZzHcfvEiYsU
 uBIWoRpwOfE8d8N7OubrEW2bhapzIuauRdPRZtWlk3s78Ze9pWP3m4GL5D499oqB/ftFQbUbmu5
 YzHOPCsxtmkRfe1MRBLLme6dO63c7ZauJQ3llLFQBh2QBa91oi02Ve6be9FfzO8OOWL15QZxY2S
 0WDvpRxpCr7wWFhNLiGQWA04U7WNEA==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692f6043 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KG-1SvKtyEtj3UQqM1sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: R_fbU6c2Kd1bU9-YN3kssL7wfvfzyhGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

Hi Linus,

There are two bug fixes: defer credentials checking from the bprm_check_sec=
urity
hook to the bprm_creds_from_file security hook, properly ignore IMA policy =
rules
based on undefined SELinux labels.

And two IMA policy rule extensions: extend IMA to limit including file hash=
es in
the audit logs (dont_audit action), define a new filesystem subtype policy
option (fs_subtype).

And extend IMA to support commit b1ae6dc41eaa ("module: add in-kernel suppo=
rt
for decompressing") by deferring the IMA signature verification in
kernel_read_file() to after the kernel module is decompressed.

thanks,

Mimi

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787=
:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v6.19

for you to fetch changes up to 738c9738e690f5cea24a3ad6fd2d9a323cf614f6:

  ima: Handle error code returned by ima_filter_rule_match() (2025-11-21 07=
:24:01 -0500)

----------------------------------------------------------------
integrity-v6.19

----------------------------------------------------------------
Coiby Xu (1):
      ima: Access decompressed kernel module to verify appended signature

Jann Horn (2):
      ima: add dont_audit action to suppress audit actions
      ima: add fs_subtype condition for distinguishing FUSE instances

Roberto Sassu (1):
      ima: Attach CREDS_CHECK IMA hook to bprm_creds_from_file LSM hook

Zhao Yipeng (1):
      ima: Handle error code returned by ima_filter_rule_match()

 Documentation/ABI/testing/ima_policy |  3 +-
 include/linux/kernel_read_file.h     |  1 +
 kernel/module/main.c                 | 17 ++++++++--
 security/integrity/ima/ima_main.c    | 62 +++++++++++++++++++++++++++-----=
----
 security/integrity/ima/ima_policy.c  | 62 ++++++++++++++++++++++++++++++++=
----
 security/ipe/hooks.c                 |  1 +
 security/selinux/hooks.c             |  5 +--
 7 files changed, 123 insertions(+), 28 deletions(-)


