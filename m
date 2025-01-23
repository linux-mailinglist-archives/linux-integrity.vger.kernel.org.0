Return-Path: <linux-integrity+bounces-4623-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088FA1A8FF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 18:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570533AB4D5
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E6C1474A2;
	Thu, 23 Jan 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kp2QmF17"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C9EC5
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653881; cv=none; b=LoFt+6pgud4oRsKVJld7Li48515L3IYWcgb1nMWoc5KBiWxW4iKJn1VzLB+wna4GeHbyf2KooNE1dxPn/AhYYGRpmtbTjb06KLh/v3Qhp3mmtwKJ4Esbn+3PilFmeoq7ntimKBg3n3lwvOkmfZ+wBoT15Zoqq1VDk2LuiydwmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653881; c=relaxed/simple;
	bh=9GrfNkHz1Orfs1/DrqIfULBmIyxQmc4xZ+pRQP5CUCo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=udAbyGc8JiHRMAArnnJromktplUCAVGG3VA2neZe1vgRo7D5I/IQJ2lwuSg259SIoH5tmKENdV3q7A6hY+QbOBztFh2RruqeISiL71fOzFkt4yE/dys5cu/chesOHA35DG+o35B7/vvAXlI8PF0lB+l/RQzE0OZaoA/ra844XgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kp2QmF17; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFBkaw026409;
	Thu, 23 Jan 2025 17:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5hdb8R
	DZHZwd7QD6bx4y5esLgapaGmH4Dp6faO6XXlM=; b=kp2QmF17X6eOwZAd5nvtfC
	1y67axZkEEkcqWz6ulT7Fvdh37rkBBDPnEbwUFz8kvptarCRN6jTBtofHWa+jpxO
	zzmI8IyX2jjMJba96xxtBOKMFaKA2OT5KHc0WspuGk+IGkQJs/yK7iqNtEUDpT9g
	E4cq2mYtlnC30UWOTJZTsBag+cfKs+Vj8InilvERNrk2ur25cc6qBAqL7gtusHgM
	8W7sfknxQr6uMnC5y7onb6iKUpMIsMaNpO7TTxI8PYMIAv6mHRKB5owELs9VZ5vS
	lr3HFHTofEmuIPqrejmOfN+PSFfjgM8tMw14waM2h0TKKkotTLj8WOoDSGelJ8jQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7ug1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:37:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGdRaw032274;
	Thu, 23 Jan 2025 17:37:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujx9bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:37:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHbqNF14746358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:37:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4196758059;
	Thu, 23 Jan 2025 17:37:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7C2058057;
	Thu, 23 Jan 2025 17:37:51 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.223])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:37:51 +0000 (GMT)
Message-ID: <b1b395ef22f9d7cf50116edf121f3b195b0ea4f3.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/10] ima_violations.sh: Fix log detection
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 23 Jan 2025 12:37:51 -0500
In-Reply-To: <20250114112915.610297-2-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-2-pvorel@suse.cz>
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
X-Proofpoint-GUID: hf_kVxsGusR6wNilzj3mu8X3sBpXlrk1
X-Proofpoint-ORIG-GUID: hf_kVxsGusR6wNilzj3mu8X3sBpXlrk1
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
> Fix TBROK on systems which does not have /var/log/messages
> (any modern distro is using systemd) not auditd installed:

-> and auditd is not installed:

>=20
> =C2=A0=C2=A0=C2=A0 ima_violations 1 TBROK: log /var/log/messages does not=
 exist (bug in
> detection?)
>=20
> Instead TCONF with more meaningful message:
>=20
> =C2=A0=C2=A0=C2=A0 ima_violations 1 TCONF: log file not found, install au=
ditd
>=20
> Fixes: https://github.com/linux-test-project/ltp/issues/372

Perhaps /var/log/messages was being rate limited.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0.../kernel/security/integrity/ima/tests/ima_violations.sh=C2=A0=C2=
=A0 | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations=
.sh
> b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 0f710dea2e..b2b597ad08 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -23,8 +23,10 @@ setup()
> =C2=A0		PRINTK_RATE_LIMIT=3D`sysctl -n kernel.printk_ratelimit`
> =C2=A0		sysctl -wq kernel.printk_ratelimit=3D0
> =C2=A0	fi
> -	[ -f "$LOG" ] || \
> -		tst_brk TBROK "log $LOG does not exist (bug in detection?)"
> +
> +	if [ ! -e "$LOG" ]; then
> +		tst_brk TCONF "log file not found, install auditd"
> +	fi
> =C2=A0	tst_res TINFO "using log $LOG"
> =C2=A0}
> =C2=A0


