Return-Path: <linux-integrity+bounces-4624-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA789A1A901
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1EA7A4142
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8F142E9F;
	Thu, 23 Jan 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cLDTqvjj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648CEC5
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653902; cv=none; b=hL/U+OXkTk9qqrrm60k8H+bC+VbzuiZO4UKDasy5LCCaczAoyhsgURZtcCGO6ZsA/fLzGmyk32p4rdqPsge21xExIzEqq7fiAHc9W/RBNzO3iD+gIXwlMlKm1jwzcWCFgf8y/p/JGrKd2JhagVteUU+fEEQ2JPa7ceSp4OOha5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653902; c=relaxed/simple;
	bh=yJZr6+c9VhrgevnUOne5cWNAGCX5nz2ktn6WxFzs66Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P42uG63dwS0Mfw65qmpprASKyQn7y/kRJVI611GcXYzX3LDenJpCm0lAY5/fB8Uw5nZ9g5JJq8TuguE819wCuAlaLZfXIf0vty8mu8K8CZEnBp/R661ir5UYsDbnzj8pSyMQwWneVxOyrk+FOzv7rtEAxpIrVz6GMlP1wQkEfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cLDTqvjj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NEQJnu026487;
	Thu, 23 Jan 2025 17:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=do++kN
	9OeziBKcS5mLlvvtu+ccocUOwUTuaNyHreyXY=; b=cLDTqvjj0ZuDlnya0OuaiI
	QHRTvudZ3v6VypzaKb2fsk3LOZcygh4ELgv+JoeUEjE5Bv75plViNlo3tJkbzE7A
	phTm9HyuKf72FUfQZ4P5YkhIsVC9jt70u1PccFTWLJRycaHJy8OniifxiJCcwCN0
	dfeSJM4wXNLyrWazlJ+jBFQQz/yqyamvCzlfAuBywCDHPSBMnGut7l1UCL71UFNN
	IkGRY3nsYh+RiEJa30j2386II6NHg+I02o7w/WxNN+yw29TcBecZvMpbqctHhKbS
	KdvtRZ1rhyDEjKI19alfDeGYwLNA0KQFhVxvR5dFwX3tJMlUbWZwlJYymafXM5tA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7ug3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:38:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NHZ3db019223;
	Thu, 23 Jan 2025 17:38:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsptvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:38:14 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHcEM215467078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:38:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E845458059;
	Thu, 23 Jan 2025 17:38:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB0158058;
	Thu, 23 Jan 2025 17:38:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:38:13 +0000 (GMT)
Message-ID: <52d6a8c168215e6dafe567b37bf5ac65e3b300eb.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/10] IMA: Add TCB policy as an example for
 ima_measurements.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 23 Jan 2025 12:38:12 -0500
In-Reply-To: <20250114112915.610297-3-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-3-pvorel@suse.cz>
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
X-Proofpoint-GUID: YgEcG4DbBteb5L7mvxLhX0wBH0bedKRP
X-Proofpoint-ORIG-GUID: YgEcG4DbBteb5L7mvxLhX0wBH0bedKRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128

Hi Petr,

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> Taken from IMA docs [1], removed dont_measure fsmagic=3D0x1021994 (tmpfs)
> as suggested by Mimi.

I backtracked on my original suggestion.  Instead of removing the tmpfs rul=
e, qualify
it as you did below.

-> qualified the "dont_measure fsmagic=3D0x1021994" (tmpfs) rule to the fil=
e open hook
[2].

>=20
> [1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

[2] Kernel commit 7eef7c8bac9a ("ima: limit the builtin 'tcb' dont_measure =
tmpfs
policy rule")

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0.../security/integrity/ima/datafiles/Makefile |=C2=A0 4 ++--
> =C2=A0.../ima/datafiles/ima_measurements/Makefile=C2=A0=C2=A0 | 11 ++++++=
++++
> =C2=A0.../ima/datafiles/ima_measurements/tcb.policy | 20 ++++++++++++++++=
+++
> =C2=A03 files changed, 33 insertions(+), 2 deletions(-)
> =C2=A0create mode 100644
> testcases/kernel/security/integrity/ima/datafiles/ima_measurements/Makefi=
le
> =C2=A0create mode 100644
> testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.po=
licy
>=20
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile
> b/testcases/kernel/security/integrity/ima/datafiles/Makefile
> index 200fd3f4d3..0f2b4fdb11 100644
> --- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
> +++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
> @@ -1,5 +1,5 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) Linux Test Project, 2019-2020
> +# Copyright (c) Linux Test Project, 2019-2025
> =C2=A0# Copyright (c) 2020 Microsoft Corporation
> =C2=A0# Copyright (C) 2009, Cisco Systems Inc.
> =C2=A0# Ngie Cooper, July 2009
> @@ -8,6 +8,6 @@ top_srcdir	?=3D ../../../../../..
> =C2=A0
> =C2=A0include	$(top_srcdir)/include/mk/env_pre.mk
> =C2=A0
> -SUBDIRS	:=3D ima_kexec ima_keys ima_policy ima_selinux
> +SUBDIRS	:=3D ima_kexec ima_keys ima_measurements ima_policy ima_selinux
> =C2=A0
> =C2=A0include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git
> a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/Make=
file
> b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/Make=
file
> new file mode 100644
> index 0000000000..6317f2bf85
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/=
Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) Linux Test Project, 2025
> +
> +top_srcdir	?=3D ../../../../../../..
> +
> +include	$(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_DIR		:=3D testcases/data/ima_measurements
> +INSTALL_TARGETS	:=3D *.policy
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git
> a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.=
policy
> b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.=
policy
> new file mode 100644
> index 0000000000..1e4a932bf0
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/=
tcb.policy
> @@ -0,0 +1,20 @@
> +dont_measure fsmagic=3D0x9fa0
> +dont_measure fsmagic=3D0x62656572
> +dont_measure fsmagic=3D0x64626720
> +dont_measure fsmagic=3D0x1021994 func=3DFILE_CHECK
> +dont_measure fsmagic=3D0x1cd1
> +dont_measure fsmagic=3D0x42494e4d
> +dont_measure fsmagic=3D0x73636673
> +dont_measure fsmagic=3D0xf97cff8c
> +dont_measure fsmagic=3D0x43415d53
> +dont_measure fsmagic=3D0x27e0eb
> +dont_measure fsmagic=3D0x63677270
> +dont_measure fsmagic=3D0x6e736673
> +dont_measure fsmagic=3D0xde5e81e4
> +measure func=3DMMAP_CHECK mask=3DMAY_EXEC
> +measure func=3DBPRM_CHECK mask=3DMAY_EXEC
> +measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> +measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> +measure func=3DMODULE_CHECK
> +measure func=3DFIRMWARE_CHECK
> +measure func=3DPOLICY_CHECK


