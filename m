Return-Path: <linux-integrity+bounces-4496-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2313D9FEAAC
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 21:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500A63A28A3
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54994199E94;
	Mon, 30 Dec 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZDTtK0CI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965181DA3D
	for <linux-integrity@vger.kernel.org>; Mon, 30 Dec 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735591431; cv=none; b=h8IIL6NtRyblvQm81k6AHTMEEm2PZ+p6qy+2ENd75xml8E8LCFAhSZTq4NJc7Bvy+f2If0aOgBiG7I4f+MYNrsHh+WGko5mXKd2dVyvu+lMaLwHxbpCOYmFN8GglNL2r92THxE6HLC/gM/91bgs8zw4hQ+iz5RIW5eS9AK0ue00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735591431; c=relaxed/simple;
	bh=Kwp9b+wgSztPjki28ZMwrrm6LcFcoOjA9WEGEGaRZ3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cMaxMDeXoUPPd4u8bRO8X2c7Wf5W0Ez8Nn1aRza4sc8Q6M+twpl5ofAMElrimPtbi1i+jSwNjqfOJPb/t/0bw5D6VAlGOibgv4phkFflFFLaPLj0yWsEDWHgGnU6qz09d88pTqhdm2hzRCiFXUcffuERk21pjm/whrGxy1nA2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZDTtK0CI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUE6DxI015425;
	Mon, 30 Dec 2024 20:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F2G9Tt
	3Te+rFmUbbhIz4CvSCoO8c+P1/VsXhqhm6ef4=; b=ZDTtK0CINhqbwUtrYselPW
	csUlNYA+igw/ILcHGCqC6lyMaLWkInfEbBTdRrtLiMbt/wyyLUqXPyZjeIFUZNOo
	tsl8QwvKRg1/oFqEp446+JcxB5sSeXxEaNY7ZDyOlmFwQV4HD0JaHhFuNfMFa1qj
	GdXgz7rxFgALpE8dDHCMmrpxov1j+K82M8UZprYwN/gAJIKY7Ex+xyRh+hfa4U6F
	wDDvDNKrg+qtVykxI8RYWsfmHbYKT5BK2izO5heAARgZfOZHz3tlnpv6lL/i5hB6
	/Srq3iQxl9TJ26bSarPZvH4hzdrhG23+g7NldoO49KKyfI1g127sbBv47cXcnryw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43uw04hk3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 20:43:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUHkVCr014589;
	Mon, 30 Dec 2024 20:43:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43tunsfmc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 20:43:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BUKhfET50463278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 20:43:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A563658052;
	Mon, 30 Dec 2024 20:43:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C7E758045;
	Mon, 30 Dec 2024 20:43:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.97.206])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Dec 2024 20:43:41 +0000 (GMT)
Message-ID: <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/8] ima_setup.sh: Allow to load predefined policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Mon, 30 Dec 2024 15:43:40 -0500
In-Reply-To: <20241213222014.1580991-3-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
	 <20241213222014.1580991-3-pvorel@suse.cz>
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
X-Proofpoint-GUID: 6tElxNeSnOrpeWur1lPSuYgbEe0KxMk7
X-Proofpoint-ORIG-GUID: 6tElxNeSnOrpeWur1lPSuYgbEe0KxMk7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412300176

Hi Petr,

On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
[snip]

> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2009 IBM Corporation
> -# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
>  # Author: Mimi Zohar <zohar@linux.ibm.com>
> =20
>  TST_TESTFUNC=3D"test"
> @@ -72,14 +72,20 @@ require_policy_readable()
>  	fi
>  }
> =20
> -require_policy_writable()
> +check_policy_writable()
>  {
> -	local err=3D"IMA policy already loaded and kernel not configured to ena=
ble multiple writes to it (need CONFIG_IMA_WRITE_POLICY=3Dy)"
> -
> -	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> -	# CONFIG_IMA_READ_POLICY
> +	[ -f $IMA_POLICY ] || return 1
> +	# workaround for kernels < v4.18 without fix
> +	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
>  	echo "" 2> log > $IMA_POLICY
> -	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> +	grep -q "Device or resource busy" log && return 1
> +	return 0
> +}
> +
> +require_policy_writable()
> +{
> +	check_policy_writable || tst_brk TCONF \
> +		"IMA policy already loaded and kernel not configured to enable multipl=
e writes to it (need CONFIG_IMA_WRITE_POLICY=3Dy)"
>  }
> =20
>  check_ima_policy_content()
> @@ -158,6 +164,34 @@ print_ima_config()
>  	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
>  }
> =20
> +load_ima_policy()
> +{
> +	local policy=3D"$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
> +
> +	if [ "$LTP_IMA_LOAD_POLICY" !=3D 1 -a "$policy" -a -f "$policy" ]; then
> +		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=3D1 to load policy for th=
is test"
> +		return
> +	fi
> +
> +	if [ -z "$policy" -o ! -f "$policy" ]; then
> +		tst_res TINFO "no policy for this test"
> +		LTP_IMA_LOAD_POLICY=3D
> +		return
> +	fi
> +
> +	tst_res TINFO "trying to load '$policy' policy:"
> +	cat $policy
> +	if ! check_policy_writable; then
> +		tst_res TINFO "WARNING: IMA policy already loaded and kernel not confi=
gured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=3Dy), r=
eboot required"
> +		LTP_IMA_LOAD_POLICY=3D
> +		return
> +	fi
> +
> +	cat "$policy" 2> log > $IMA_POLICY
> +	if grep -q "Device or resource busy" log; then
> +		tst_brk TBROK "Loading policy failed"
> +	fi

To write to the IMA securityfs policy file, check_policy_writable() used "e=
cho",
while here it's using "cat".  "cat" fails when signed policies are required=
.
Perhaps add something like:
+
+       if grep -q "write error: Permission denied" log; then
+               tst_brk TBROK "Loading unsigned policy failed"
+       fi

> +}

Mimi


