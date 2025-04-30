Return-Path: <linux-integrity+bounces-6091-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636DAA501F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392D99E1E51
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0694D20CCE4;
	Wed, 30 Apr 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PIq+/w3v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706EC25A2A1;
	Wed, 30 Apr 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026567; cv=none; b=LvPoO+HIXCd756IXwbRabqoCTaDLGdeBCAlqlRe6vL0zSORQibEskcGJ5IQQYQrnIDThC50DB3GgPzvTGB/pgN6Ty1E+ZHJ4oaGt2XPQKwc16tpYuY6ZkECOHRDzwvljhbkfrHosY5gv+MciKqZ6dRRSoJ0sUzc3/nxspQrjos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026567; c=relaxed/simple;
	bh=vK9x+fKPiphgnYio19S12ceCgeUhQ6mE/xg797ES+Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cC1FxMgKDzLW1VnJIX46XfteLgMLPi/MxlncV9bWUXi99ehf0GI6Q1hR9cKMcTkQt86N8iPIiCzi1zQzA4l/mqYG1UZ7Slh/W6vwo/5+hAOY+mGPJZVMzm3U6sNgo6rYOYXyu4BF9RdbidGNAMi6pJ4CuWB+2miZ4JrPy1DkUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PIq+/w3v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UA4D8s006429;
	Wed, 30 Apr 2025 15:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qel6dC
	z7U0QSLGwxwhtVvAr2kR+Adu0rEYWSsIjsTbY=; b=PIq+/w3vZHiC7BGoySnV6C
	DhbHM0/dBCx11uXLIuoiv30NxQSkggFk4G/9mo9Iv3jTVFos6007a8Bik67GuZa6
	pda98LoS+ZRpukf9nR/URjcMZ1ovs2K5tMdjaoYQbl4Bpxur4KU0mnL0HnE//ssI
	eYhKz7fpJqAYWEQ4zcw78jG7vmPaNk84i9PV8FiaVS1mQIsJlhwxxx9Mf5+7bn/E
	X6yspfsCVZnDILFbGULYelC+1dGcLSOXxn/1Qn/MNMq3dQEFy29Ol3ObXBHz1wzi
	wDDUpKSQ8FxBmrP/Cd9Zq7UftO0n5EkYeR61vUqMFqmkvKjwfJJkNEkvlB7m0IOA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bhsjsh9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 15:22:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53UFM9gS025898;
	Wed, 30 Apr 2025 15:22:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bhsjsh9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 15:22:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UE72aJ024679;
	Wed, 30 Apr 2025 15:22:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1m86ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 15:22:32 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53UFMVMw19268028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:22:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1562558061;
	Wed, 30 Apr 2025 15:22:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F19EE58054;
	Wed, 30 Apr 2025 15:22:29 +0000 (GMT)
Received: from [9.61.140.105] (unknown [9.61.140.105])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Apr 2025 15:22:29 +0000 (GMT)
Message-ID: <135ceca8-e98a-407f-a301-8b4720c8e8f0@linux.ibm.com>
Date: Wed, 30 Apr 2025 11:22:29 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] integrity/platform_certs: Allow loading of keys in
 static key management mode
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
 <20250430090350.30023-4-ssrish@linux.ibm.com>
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <20250430090350.30023-4-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dcuA3WXe c=1 sm=1 tr=0 ts=6812403a cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=KmA9UCYRVGLAr49MUM8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bxiKuflN9motG-j3lwDGZK_NwY8jAYZ0
X-Proofpoint-ORIG-GUID: 1VHetqsTmLpayLE2wP_W6Ed7bBU9fglq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwNyBTYWx0ZWRfX35Mo87z6GspG lfncH6zxnv3JpMWNydyqlW3vKBQ0Vx4cY/mq/qcTajHJyzD4BdFvzdPNBqzK79v23YcpoV2U4Rl mGf7jLUCqEEEeWK9DzgzSpkPNYoXwjOIH8gNzzUJ9WZV4N/8yhH93lbrXVkt6YZsYJz4TRGrQSc
 xjph8xt61b/B8+tDGgQToDw2CWGt5KREpaT1kcA3mLwvREgTjrhEt+O3WXF+GjJwpSnmDw2RHJk MCJaOMN/tIRTG8v+olfCbRkY0L1lCZ7/K8QpZVLwyWcdqvx1IqpOE/gMZvJs1o00G0gtwcK7LGD UBd0DvCcUcZlBOLyKhWgofQg4cPNMNfXtceezskgApRbSsvC+709C7V8OjGi00QJBAYuSnKpjlW
 85hA25azAv+WoYb7o99bvd0Ok91r07otbKmD0pBZll7SXvijrBzW1Tjy/lbOobOXdi7DU/xB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300107


On 4/30/25 5:03 AM, Srish Srinivasan wrote:
> On PLPKS enabled PowerVM LPAR, there is no provision to load signed
> third-party kernel modules when the key management mode is static. This
> is because keys from secure boot secvars are only loaded when the key
> management mode is dynamic.
>
> Allow loading of the trustedcadb and moduledb keys even in the static
> key management mode, where the secvar format string takes the form
> "ibm,plpks-sb-v0".

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,
    - Nayna

>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   security/integrity/platform_certs/load_powerpc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> index c85febca3343..714c961a00f5 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -75,12 +75,13 @@ static int __init load_powerpc_certs(void)
>   		return -ENODEV;
>   
>   	// Check for known secure boot implementations from OPAL or PLPKS
> -	if (strcmp("ibm,edk2-compat-v1", buf) && strcmp("ibm,plpks-sb-v1", buf)) {
> +	if (strcmp("ibm,edk2-compat-v1", buf) && strcmp("ibm,plpks-sb-v1", buf) &&
> +	    strcmp("ibm,plpks-sb-v0", buf)) {
>   		pr_err("Unsupported secvar implementation \"%s\", not loading certs\n", buf);
>   		return -ENODEV;
>   	}
>   
> -	if (strcmp("ibm,plpks-sb-v1", buf) == 0)
> +	if (strcmp("ibm,plpks-sb-v1", buf) == 0 || strcmp("ibm,plpks-sb-v0", buf) == 0)
>   		/* PLPKS authenticated variables ESL data is prefixed with 8 bytes of timestamp */
>   		offset = 8;
>   

