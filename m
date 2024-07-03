Return-Path: <linux-integrity+bounces-2974-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA7924CE9
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 02:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF3C281FC6
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 00:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F82D39B;
	Wed,  3 Jul 2024 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cr8oaE2g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258117D2
	for <linux-integrity@vger.kernel.org>; Wed,  3 Jul 2024 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968222; cv=none; b=aQ8qr8avtzzXvEf3qcJyjjnVN7FHUncy3zZMRQ7LHmPXm4g7XxR1LAGKsDuk6jWov6OUBkclIMq3rMIqa3LmDMyk9gFTYI0RJANDqbnkrdszQXrUFIvU4WrWiB3lSkCea6erh5riQDeEz0agUYHt+Ibkm9XUHdVG61ziZ5yXx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968222; c=relaxed/simple;
	bh=LH8Uq8ry2DzjzT0iCxuql/22OokUEB2b1tiokp5Xk9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eISOr0ClDGjlCKtL4ocwxIP5LWyxJTFaEhXyNUEFZVuSRM/TgZyGbcerUBHzeaqBxysFl5R2lIbS08KplZnPKlvo8hitda+UBoD92aowxnMQBMLSQFJ9ty8dgvAGiNDXURRvk3KQUSzSye53gR5ccx4ysxVXB6DI/3wAR6NNFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cr8oaE2g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462Nojlc004137
	for <linux-integrity@vger.kernel.org>; Wed, 3 Jul 2024 00:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=G
	7vjnMBeYK+0r76i1yaAlF8HtzDr2f01gic5cjAdlh0=; b=Cr8oaE2gplnOIuoRd
	T1RWRU/cj+U/3G6UjJh29bNabd8bpB07augxPVmUmgJzh9rf5MKC7Akfe0AGHHqR
	pfLWJApvowx3RFL3IPx2I70WY7e795I17M43lQRmgRZ2HOmXIdMBh/jLfFXDI8fM
	EQjDFd8n7GqXP56KdZnMeNtHk0D4gIq73sCEfTt3xmOpiLjiP5ZvuFWRmRn2ngt7
	DLS5Tp2zUnc+pqm95q4jpAC4lS0iIXVRPktMXGpCXoA4eMowNNyUmFpsIWaWk+w2
	pTMjVCxQHagLWAfMcIBWVGuRWa4I1gYZg0sugTQ4n08bD6t5gic2aaMUL9xCkx/w
	M3Nyg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404ttfr6s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 03 Jul 2024 00:56:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4630pSg4029205
	for <linux-integrity@vger.kernel.org>; Wed, 3 Jul 2024 00:56:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402x3mysqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 03 Jul 2024 00:56:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4630usbJ14418612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 00:56:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA5558054;
	Wed,  3 Jul 2024 00:56:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D6515805D;
	Wed,  3 Jul 2024 00:56:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jul 2024 00:56:54 +0000 (GMT)
Message-ID: <88863d59-51c2-4eb9-a5c0-5bd15ed8ef10@linux.ibm.com>
Date: Tue, 2 Jul 2024 20:56:54 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH] Require specifying openssl PKCS11 engine or
 provider access method
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20240702225330.13136-1-zohar@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240702225330.13136-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PqGD9O9rwT0EoACEXh0iGiTLSnPcIjBy
X-Proofpoint-ORIG-GUID: PqGD9O9rwT0EoACEXh0iGiTLSnPcIjBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_18,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030005



On 7/2/24 18:53, Mimi Zohar wrote:
> Directly calling the new imaevm_signhash() function without specifying
> the access_info may result in dereferencing a NULL pointer.  Require
> specifying the openssl PKCS11 access method.
> 
> Fixes: 5d89393ff9ab ("Implement imaevm_signhash library function and deprecate sign_hash")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/libimaevm.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index a0176c0df9ef..6321f105d91f 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -1118,6 +1118,11 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass,
>   	EVP_PKEY *pkey = NULL;
>   
>   	if (!strncmp(keyfile, "pkcs11:", 7)) {
> +		if (!access_info) {
> +			log_err("PKCS11 engine or provider not specified");
> +			return NULL;
> +		}
> +
>   		switch (access_info->type) {
>   		case IMAEVM_OSSL_ACCESS_TYPE_ENGINE:
>   			pkey = read_priv_pkey_engine(access_info->u.engine,

