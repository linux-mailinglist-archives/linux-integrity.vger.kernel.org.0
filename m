Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3233140D
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Mar 2021 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCHREe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Mar 2021 12:04:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229650AbhCHRET (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Mar 2021 12:04:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128H3sGJ125483;
        Mon, 8 Mar 2021 12:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j3z0BrGwRD1VmA8bd9vyTkFINn0wCAo42neIz5HC674=;
 b=ob5SVBsJ5cVnWL0bq2cx2uOBadY2j3EAteR1bS+7/+l5GOtmEKA0tBeQTkWv1AhNfRJy
 x3MbNm+AuCbrDB4Q1fFDycHwsJXZz5SiaqWEOcqUbyB6EsVk+IRISg/5/AdPBqTnMGHN
 mx4uEu5GOZ5LMmxrbXQe9+KGeLCOf3+a5M/Rs6b+zFSrDyM68rRgXIprS/ZzeBc3p6bo
 Jy15xqPJZ352hlij/JnfXJ8MzYF8e1WY86A3Eop+bSKZL6rzvVluqGG2hPW547OUQIB3
 9j0D0mgg9g7Q9Gk0ta4C0E8dE9DbnRsh+ThKMC9OTjEQ+4gD9RnD1ioqU/lD1cs3lHcV nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375qh6rkku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 12:04:06 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 128H404r125898;
        Mon, 8 Mar 2021 12:04:05 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375qh6rjqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 12:04:05 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 128Gaqkp015654;
        Mon, 8 Mar 2021 17:00:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3741c883b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 17:00:07 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 128H06Xw42664236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 17:00:06 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26BD813605E;
        Mon,  8 Mar 2021 17:00:06 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93254136068;
        Mon,  8 Mar 2021 17:00:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  8 Mar 2021 17:00:05 +0000 (GMT)
Subject: Re: [PATCH v11 02/10] crypto: Add support for ECDSA signature
 verification
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
References: <20210305205956.3594375-1-stefanb@linux.vnet.ibm.com>
 <20210305205956.3594375-3-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8d7b4ee1-cf71-ce2d-abaf-2ad1e472f1af@linux.ibm.com>
Date:   Mon, 8 Mar 2021 12:00:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210305205956.3594375-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_14:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/21 3:59 PM, Stefan Berger wrote:
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index a367fcfeb5d4..a31df40591f5 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -247,6 +247,16 @@ config CRYPTO_ECDH
>   	help
>   	  Generic implementation of the ECDH algorithm
>   
> @@ -70,6 +72,30 @@ struct ecc_curve {
>   	u64 *b;
>   };
>   
> +/**
> + * ecc_swap_digits() - Copy ndigits from big endian array to native array
> + * @in:       Input array
> + * @out:      Output array
> + * @ndigits:  Number of digits to copy
> + */
> +static inline void ecc_swap_digits(const u64 *in, u64 *out, unsigned int ndigits)
> +{
> +	const __be64 *src = (__force __be64 *)in;
> +	int i;
> +
> +	for (i = 0; i < ndigits; i++)
> +		out[i] = be64_to_cpu(src[ndigits - 1 - i]);
> +}
> +
> +/**
> + * ecc_get_curve()  - Get a curve given its curve_id
> + *

There's still an additional empty line here (as is the case with other 
existing functions in this file). I will fix this one in v12.


