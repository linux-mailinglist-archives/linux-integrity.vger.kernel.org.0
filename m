Return-Path: <linux-integrity+bounces-6312-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA07AC5CC9
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E29E1037
	for <lists+linux-integrity@lfdr.de>; Tue, 27 May 2025 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D25E214812;
	Tue, 27 May 2025 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OZ8GVL53"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22AD2153C7;
	Tue, 27 May 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748383727; cv=none; b=BlNp/XPk7z8D46uXXt/R9hfudVZYbzfZ4m7eCgaEfIXOOc8FyC5Y5E0eRv2oHzhIf6eFb4yZa7vltwJTuHqSfFIxgOgx3+BGjL79LlnhX6XVVFNuavNNij/D0GC5+B92TzVU+tYwRVMEiaI9R5pj9cCPXanXvcT+CN7Tca0u+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748383727; c=relaxed/simple;
	bh=nfbvpQXSErwoMt1fAZCaoWf2Wp0M63j9GJB+h1tYXu4=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=Ln2kuqZviZZF2lcY2vPqJdYcdY1K/Ga2/wiMnA808OpehbxY65hw/sgcKxpxc5GBhIzjTsmAUaAZnDkxEwp6ioPEI5snI6GfYr18g8zqPelr3xihyUjoDvrfl7vEd73FtV0Z40Ja9L5/xWadUDGqm19uvZOmq5zctGHaQsLaeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OZ8GVL53; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RGHQ6a017244;
	Tue, 27 May 2025 22:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=WhGjwuAmWq7QvhA7Pl1DzvvUw0nA
	pFVIUNFIHpnkn68=; b=OZ8GVL531rZZf13wfPiH6b6foiKTMAu7/M4sSwznO45U
	v2/ArXD9321GCp9x+Th/71lpydcHCEMSMgGxKuB5hVIGHw4dHYKtsVx3ytZ9IpsR
	htTU6caxGWeSTH3kpVkWt8ieh5kLTTOkZg54qMIC9G7E8oESXFQvhj9/67N+IEIY
	5H8MSbIOq0OA06LxHi0yiHbgMms/2n1MAbQUq7YgICsjv0ZiqzyIFOtwY4iI32pf
	pjb/eghca7PeS+ZZwogEQlTxI58szSZl5QPA8q56rd/cESLzE8ZiU467QF2dMtqD
	YT3wUT3Zw4hUYNI4uEtRTwfqt1XxVZzL2lNTWpo8BA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsghg98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 22:08:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54RLgb9w028983;
	Tue, 27 May 2025 22:08:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46usepvmam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 22:08:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54RM8a6828836492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 22:08:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367135805D;
	Tue, 27 May 2025 22:08:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB19E58052;
	Tue, 27 May 2025 22:08:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 22:08:35 +0000 (GMT)
Message-ID: <283be073924bd046f180880b5912338744550884.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v6.16
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 May 2025 18:08:35 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: piJ-QIMhxf0-6imdi4PFOEZEAgO9UKuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE4NiBTYWx0ZWRfX9mGqTff/zw63 cafc2TsnVimEQNhOTBNNoqh17rAWGSIArlfUpzXPE/2kaRYwbxVda1CoociwFntrbgEaPlXK+1H Mj16t22fezjKabHPTR7Gzu8J/8Zo5iM13jqI5FzpOoDFRFNzMD0RWvAurBu4l2dN6fo9tetcaNm
 DMSdMXlvTSX3z2CIyWvHaQDn2rWSabXwaKLRXkwHTRUOMfP6iLqH/xh3pcKeL8UfhVhu9NtdYZN h2BejZBbdN47Kq24vLlgClBgqEcpELMmCW6xFWUnIouX1fM+eO2HwrtbbEGjQqVm35hqssYZERJ ilI+PRgHbP1X2nKwbF8SjYZv024/ACm7SZ+RGbWDxt+gWvx24zMaYAl13KmM034pmOpAuv2BV9D
 3KXNpwqNv8swqT2G/Sk7jbFcpDQ5jF/Kdo3hYZNT16ypEAd+FWTCIm9wOePsJ8U+DZ9uMCxp
X-Authority-Analysis: v=2.4 cv=bZRrUPPB c=1 sm=1 tr=0 ts=683637e5 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=ADT_KZKfxQbkmW_C2EoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: piJ-QIMhxf0-6imdi4PFOEZEAgO9UKuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_10,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270186

Hi Linus,

Carrying the IMA measurement list across kexec is not a new feature, but is
updated to address a couple of issues:
                                          =20
- Carrying the IMA measurement list across kexec required knowing apriori a=
ll
the file measurements between the "kexec load" and "kexec execute" in order=
 to
measure them before the "kexec load".  Any delay between the "kexec load" a=
nd
"kexec exec" exacerbated the problem.
                                                                           =
    =20
- Any file measurements post "kexec load" were not carried across kexec,
resulting in the measurement list being out of sync with the TPM PCR.
                                                                           =
   =20
With these changes, the buffer for the IMA measurement list is still alloca=
ted
at "kexec load", but copying the IMA measurement list is deferred to after
quiescing the TPM.

Two new kexec critical data records are defined.

Note:                                                                      =
    =20
- The IMA kexec segment hash is not calculated or verified.              =
=20
                                                                           =
    =20
thanks,                                                                    =
    =20
                                                                           =
    =20
Mimi                                                                       =
   =20


The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e=
:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v6.16

for you to fetch changes up to fe3aebf27dc1875b2a0d13431e2e8cf3cf350cca:

  ima: do not copy measurement list to kdump kernel (2025-05-14 06:40:09 -0=
400)

----------------------------------------------------------------
integrity-v6.16

----------------------------------------------------------------
Steven Chen (10):
      ima: rename variable the seq_file "file" to "ima_kexec_file"
      ima: define and call ima_alloc_kexec_file_buf()
      kexec: define functions to map and unmap segments
      ima: kexec: skip IMA segment validation after kexec soft reboot
      ima: kexec: define functions to copy IMA log at soft boot
      ima: kexec: move IMA log copy from kexec load to execute
      ima: verify if the segment size has changed
      ima: make the kexec extra memory configurable
      ima: measure kexec load and exec events as critical data
      ima: do not copy measurement list to kdump kernel

 include/linux/ima.h                |   3 +
 include/linux/kexec.h              |   9 ++
 kernel/kexec_core.c                |  54 ++++++++++
 kernel/kexec_file.c                |  33 ++++++-
 security/integrity/ima/Kconfig     |  11 +++
 security/integrity/ima/ima.h       |   6 ++
 security/integrity/ima/ima_kexec.c | 196 ++++++++++++++++++++++++++++++---=
----
 security/integrity/ima/ima_queue.c |   5 +
 8 files changed, 283 insertions(+), 34 deletions(-)


