Return-Path: <linux-integrity+bounces-4627-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E16A1A907
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6003A4D56
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BB1474A2;
	Thu, 23 Jan 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gLfrAtO4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9BEC5
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653980; cv=none; b=mZvrEkOgvx2GYQ1kndWu7/10+4d8nuP+Hb1imJs2ola2DTwjnBR3zo1SBJW8oyek5Ln6Uksh2LifXEWh7ceORFKFiAItHDmlRvSkBYb1gJB8fUntjUIrkYIiR8spDajm5soU8vxNWz3BuEEWgIDHwtV0GmYSFEadO+OLeiWvrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653980; c=relaxed/simple;
	bh=8nkxBtaekUM9MYT2r/bff9egF0arQA4rSAKOE35M94w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IlFQZl1DF83mBd8wISD5+pO1U7WwZ65U2YRCR75cY9ovCRHpO51JYC6A149HaeDAPNWymA/HfGHuIHGK1SGaalVhMgwNFiah4dMH0ZAJ6cOeXzrwAOz3IeoFGOp43SPjjgKAUcCKfvqqIuly1BjSfNUxUOsJevroKCQOhq9sZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gLfrAtO4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFdTaC002081;
	Thu, 23 Jan 2025 17:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EHqpjC
	GrKpx9Eoz058268XOm9Wnw8zMWMHDj+Tvv/pM=; b=gLfrAtO4QioJKEhVdY1T0d
	1eIzqtrCxvcc9IQG7VqkSfbEn4WOMgKLoCNKIMNVEXeIiyuctXJAF6DxNMBrow+D
	11iJV69wW06WffLlwyE+asHBT8mScYU8KEnAhgNlH+u6tFRXP6ZiK3XN40yKiRb4
	pSDfyhaCteYPBO/DoW9ISq9wKrrzRLNroTEe3Jsehfe95oSP2OuWV1Ka1SYH70o5
	cdT2GRw0jemUhX2gEnl1e4a8uCAd8nXtmQqjWAsfvh/TMQKUyvL4g4146GlmMOeY
	boeh+vw+B5VwKZ362xv0USshiBbTzQljeukk0KddlRc/NXDH8HDgh7PY92C+HhAw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44brku0jny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:39:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGKB86020994;
	Thu, 23 Jan 2025 17:39:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1p8wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:39:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHdWPN12976724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:39:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D5F55805D;
	Thu, 23 Jan 2025 17:39:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32D3358059;
	Thu, 23 Jan 2025 17:39:32 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.223])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:39:32 +0000 (GMT)
Message-ID: <574f3ba3c29253ccdc4ad4be469a7382f5904b4d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 10/10] tst_test.sh: IMA: Allow to disable LSM
 warnings and use it for IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 23 Jan 2025 12:39:31 -0500
In-Reply-To: <20250114112915.610297-11-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-11-pvorel@suse.cz>
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
X-Proofpoint-ORIG-GUID: eMZlH1JryrB6hYcAB9A2f0a4KV0iOjla
X-Proofpoint-GUID: eMZlH1JryrB6hYcAB9A2f0a4KV0iOjla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=737 clxscore=1015 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.=20

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 1 +
> =C2=A0testcases/lib/tst_test.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 4 ++--
> =C2=A02 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 5213763ee0..69ee5a3d65 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -11,6 +11,7 @@ TST_CLEANUP_CALLER=3D"$TST_CLEANUP"
> =C2=A0TST_CLEANUP=3D"ima_cleanup"
> =C2=A0TST_NEEDS_ROOT=3D1
> =C2=A0TST_MOUNT_DEVICE=3D1
> +TST_SKIP_LSM_WARNINGS=3D1
> =C2=A0
> =C2=A0# TST_MOUNT_DEVICE can be unset, therefore specify explicitly
> =C2=A0TST_NEEDS_TMPDIR=3D1
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index cfdae02300..2b797705e3 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -1,6 +1,6 @@
> =C2=A0#!/bin/sh
> =C2=A0# SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) Linux Test Project, 2014-2022
> +# Copyright (c) Linux Test Project, 2014-2025
> =C2=A0# Author: Cyril Hrubis <chrubis@suse.cz>
> =C2=A0#
> =C2=A0# LTP test library for shell.
> @@ -81,7 +81,7 @@ _tst_do_exit()
> =C2=A0	fi
> =C2=A0
> =C2=A0	if [ $TST_BROK -gt 0 -o $TST_FAIL -gt 0 -o $TST_WARN -gt 0 ]; then
> -		_tst_check_security_modules
> +		[ -z "$TST_SKIP_LSM_WARNINGS" ] && _tst_check_security_modules
> =C2=A0	fi
> =C2=A0
> =C2=A0	cat >&2 << EOF


