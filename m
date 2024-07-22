Return-Path: <linux-integrity+bounces-3223-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A55938F02
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2024 14:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D8828197D
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB816C86E;
	Mon, 22 Jul 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kw/PURPT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532914AD3F;
	Mon, 22 Jul 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721650811; cv=none; b=aCWeWLHJW9/Qz+KOGsqY67Sj5N94wRgnxJyICdI8ohGvfOSeZxqO13iKfKXfTCmz7QnnGyYE+vb1M8Ir+ewgMFlWYVCXRaCYoEr7RI8UGURnp9EvNuyeEKtSIcKcUi3aSFQIvo/8YWnClAfU4bIHuaWWd3Uiw/J6C1UrqSMDAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721650811; c=relaxed/simple;
	bh=m5DugPP1DC1LZ2XEUi0/l+kGRbWjHA0M/x0whe3bE/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p3xN9SaBP/lki8ebL9D2YibjDy5Ufhzbm7wyiQ1uZNGtCiFbsLsrstwYN1+52wX279Jgz9gslSNBnmR2Dc4v1OGo0RnPqUbW4Lva3vxSoweZEAmEC+yvSaeNdj6nmDGoMpD/lJsc/Z1Xbg2d4E5wPwTHuxv0sE2ADMmImiTUWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kw/PURPT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MBQwpt025216;
	Mon, 22 Jul 2024 12:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	uFvmW9DpP7Xjc69hppvUAoyualI8ZPVCYAqWtlAoRtw=; b=kw/PURPTMFS/jbnG
	6ujRl0GRIUB9R02YAg/qGE4OY4/wwia6Wh7DQBOVkkj/VQ1wPLoJ94qXo0e8PPsU
	F4PRyXAntyh9A+yBix/IouGlEpgjfKFkwmlWUhd8o4Kssbblx1zjzOoCLFeLBVlg
	2uTorxnT93EVlnvYsuMJjPqbVkLvMzle8P2GyD2EseIb8r8wfLpYBEm+4PUO7sQS
	XUzDvLpDX2qWKXKnt8cC+VZuYjnVHZJoFgkZoblEeZ/bFI4rrWwiJfQGYCYJOMjl
	T5Kyy8vKlawMuP9KrgF3zNXw4Bo4Ig4uYbyZIG3r7T6I2rzovS4IXjLJk9eEP5xS
	6hIK7g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40gtw42pb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 12:19:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46MCJkWU003879;
	Mon, 22 Jul 2024 12:19:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40gtw42pb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 12:19:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46M9FqPP005776;
	Mon, 22 Jul 2024 12:19:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2p53rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 12:19:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46MCJhSk9372344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 12:19:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 240CB58065;
	Mon, 22 Jul 2024 12:19:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2710958043;
	Mon, 22 Jul 2024 12:19:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jul 2024 12:19:42 +0000 (GMT)
Message-ID: <6eee0c55-40cd-4e7b-8819-1a4c9596062a@linux.ibm.com>
Date: Mon, 22 Jul 2024 08:19:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/10] crypto: Add support for ECDSA signature
 verification
To: Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org
References: <20210316210740.1592994-1-stefanb@linux.ibm.com>
 <20210316210740.1592994-3-stefanb@linux.ibm.com> <ZpfuqeSVC47jqme2@wunner.de>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <ZpfuqeSVC47jqme2@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JxPgH5XzRCm_YZnQxQxY_MsvRm-z8XMR
X-Proofpoint-ORIG-GUID: xAotsV-GmwKR1gYlGG3n10-BunaDlMsd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_08,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407220090



On 7/17/24 12:17, Lukas Wunner wrote:
> Hi Stefan,
> 
> On Tue, Mar 16, 2021 at 05:07:32PM -0400, Stefan Berger wrote:
>> +/*
>> + * Get the r and s components of a signature from the X509 certificate.
>> + */
>> +static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
>> +				  const void *value, size_t vlen, unsigned int ndigits)
>> +{
>> +	size_t keylen = ndigits * sizeof(u64);
>> +	ssize_t diff = vlen - keylen;
>> +	const char *d = value;
>> +	u8 rs[ECC_MAX_BYTES];
>> +
>> +	if (!value || !vlen)
>> +		return -EINVAL;
>> +
>> +	/* diff = 0: 'value' has exacly the right size
>> +	 * diff > 0: 'value' has too many bytes; one leading zero is allowed that
>> +	 *           makes the value a positive integer; error on more
>> +	 * diff < 0: 'value' is missing leading zeros, which we add
>> +	 */
>> +	if (diff > 0) {
>> +		/* skip over leading zeros that make 'value' a positive int */
>> +		if (*d == 0) {
>> +			vlen -= 1;
>> +			diff--;
>> +			d++;
>> +		}
>> +		if (diff)
>> +			return -EINVAL;
>> +	}
>> +	if (-diff >= keylen)
>> +		return -EINVAL;
> 
> I'm in the process of creating a crypto_template for decoding an x962
> signature as requested by Herbert:
> 
> https://lore.kernel.org/all/ZoHXyGwRzVvYkcTP@gondor.apana.org.au/
> 
> I intend to move the above code to the template and to do so I'm
> trying to understand what it's doing.
> 
> There's an oddity in the above-quoted function.  The check ...
> 
> +	if (-diff >= keylen)
> +		return -EINVAL;
> 
> ... seems superfluous. diff is assigned the following value at the
> top of the function:
> 
> +	ssize_t diff = vlen - keylen;
> 
> This means that:  -diff == keylen - vlen.
> 
> Now, if vlen is zero, -diff would equal keylen and then the
> "-diff >= keylen" check would be true.  However at the top of
> the function, there's already a !vlen check.  No need to check
> the same thing again!

You're right, this check is not necessary.

    Stefan

