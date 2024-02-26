Return-Path: <linux-integrity+bounces-1469-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA9867B51
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 17:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E469AB27C7A
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F5F12BF1C;
	Mon, 26 Feb 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BxUBcDx9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C712BEBD
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963612; cv=none; b=i5zb5/nRWbTyJSbfIE2TU+s0jTSCS6EYIXGhmffs1A9d2e5jHzdVeHRtwI0HBMxu9GNHShGSfzct+7BmvVwkBhzqJY2AlOldsGjkwj7KXG5TJYEk/PcPfvgecnsUBtqiDKgZzE1iULrtEDftXWxIywokK7OFT42Aqet0wt4MsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963612; c=relaxed/simple;
	bh=MmLt2fo829BvMcjmIOq2FZxriKsoaKUGit95QWHkJI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Mr5BohDMqv4wnn50PI7hvi0hxLahxuaC7udXs/RjmyAHRLDVTE/yV2XncKmuarzC+i6DkRM4Zru2/TvQyp1Xvheu0SSoZsMw4zlXwywe4gXItl4EOkbdmXOarqMeIqC9D1VCyRH3UE0r8Uy0AOnBwaV8LHLqZZis/ok1dQNPEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BxUBcDx9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QFQoji030017;
	Mon, 26 Feb 2024 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yIJ/Llk/A7MZ/Bh4KYPG9K7QxaGBy6eRQKL8KdmrgLE=;
 b=BxUBcDx9pb/yMYXLtRQwNJgQXjm0pGmWuZodiF5HIL2MDV5ueBbUfRAzxy6iJcLBXvxC
 1tNvAwjCs25cfaXMb1F13k1lmwRpT/5tmv7n8tQwhJN0pcJM0V8U6OTFgxZHqMITAheE
 QeEu7dMndxpeo61lUSsE9BJ7f4mSrFfs9hVPQpslZYFyNZRPJEp8bQRn65C4hQJGXOfF
 diS8jR0aCc1AAOEASK8Yrok6mnaZjWo9RjqD5S2AoFCQ6xKI4HkV1wsFXu6s0J3daa8X
 pzwsfYbDp2jODaN2hNlMENC1kEihPdR56gEs7MhHXiGHa1cLVM4vDfHkKZAEZCDzWloG kg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgujb46je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:06:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QFfiKK008852;
	Mon, 26 Feb 2024 16:06:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstageq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:06:41 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QG6da322020434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 16:06:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ED0F58067;
	Mon, 26 Feb 2024 16:06:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9120058055;
	Mon, 26 Feb 2024 16:06:38 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.183.51])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 16:06:38 +0000 (GMT)
Message-ID: <a9f8d72bcc13156fc074acd0ec3b063436f608b0.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils 2/6] Pass ENGINE and keyid through to
 function using them
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, vt@altlinux.org
Date: Mon, 26 Feb 2024 11:06:38 -0500
In-Reply-To: <20240223153014.4048133-3-stefanb@linux.ibm.com>
References: <20240223153014.4048133-1-stefanb@linux.ibm.com>
	 <20240223153014.4048133-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y-wuWHiJe3JOy9vQgGwvg2xMZ1wWKb1Y
X-Proofpoint-GUID: Y-wuWHiJe3JOy9vQgGwvg2xMZ1wWKb1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402260122

Hi Stefan,

"Pass ENGINE and keyid through to function using them" describes what the patch
does, but not the reason for the patch.  Please update the patch description
Subject line and similarly the cover letter Subject line.


On Fri, 2024-02-23 at 10:30 -0500, Stefan Berger wrote:
> Pass the ENGINE and keyid all the way through to the function that is
> using them and deprecate sign_hash since it needs to pass these parameters
> from the global imaevm_params. Define a new API call imaevm_signhash that
> takes all necessary variables as parameters.

The motiviation for this patch is missing.

Instead of relying on imaevm_params.engine and imaevm_params.keyid global
variables, which are not concurrency-safe, define a new library function
imaevm_signhash() function with the engine and keyid as parameters.

Pass the ENGINE and keyid ...

> 
> In preparation of support for OpenSSL providers, wrap the ENGINE in a
> union inside a struct imaevm_ossl_access and add a type for the selection
> of the ENGINE or provider later on.

(If possible) Make sign_hash() a wrapper for imaevm_signhash().

Deprecate sign_hash().

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

[...]

>  int sign_hash(const char *hashalgo, const unsigned char *hash, int size,
> const char *keyfile, const char *keypass, unsigned char *sig)
>  {
> +	const struct imaevm_ossl_access access_info = {
> +		.type = IMAEVM_OSSL_ACCESS_TYPE_ENGINE,
> +		.u.engine = imaevm_params.eng,
> +	};
>  	if (!keypass)	/* Avoid breaking existing libimaevm usage */
>  		keypass = imaevm_params.keypass;
>  
>  	if (imaevm_params.x509)
> -		return sign_hash_v2(hashalgo, hash, size, keyfile, keypass,
> sig);
> +		return sign_hash_v2(hashalgo, hash, size, keyfile, keypass, sig,
> +				    &access_info, imaevm_params.keyid);
>  #if CONFIG_SIGV1
>  	else
> -		return sign_hash_v1(hashalgo, hash, size, keyfile, keypass,
> sig);
> +		return sign_hash_v1(hashalgo, hash, size, keyfile, keypass, sig,
> +				    &access_info, imaevm_params.keyid);

If possible sign_hash() should become a wrapper for imaevm_signhash().

>  #endif
>  	log_info("Signature version 1 deprecated.");

>  	return -1;


thanks,

Mimi


