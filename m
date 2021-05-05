Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89616374BE9
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 01:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhEEXaT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 19:30:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231154AbhEEXaT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 19:30:19 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145N6Gnf183503;
        Wed, 5 May 2021 19:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pdcoi5rnA5eeYAv9V/BZ9g5bdfRzY5wMnvjfO3VZCek=;
 b=FWV2IxHbldIlI6A+OScg2xfU32g9OgybpdMKZNP0Ns5r64Gsl0fXPdf5Z8U905UvGlnV
 trgTr8QCMjvoKO03d4oXTaKUcXF3rINvkAbsvKO5aOqnfUp6YJMxB7sDShCrscgtU/bb
 btYvMx4xyfGcdOcX5//RaiN612D2Wzy3KFQCRWf2MiQR1D05rHrmz1dMipAqvGn1JPx7
 nRlXloUUxrYHK1TOKyhJK1GwQoPlNchlD/tOGqSbzXxWJecH3RYnvv0/RgC5/xgLjnFd
 OyavgV9tS2hb1Hrnyw1hvMmcMppwzOtqaxl+wVyubeQrQZcqs37PEHifUTj3cnJ1F4+g ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c3qahkge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 19:29:20 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 145N8opQ191659;
        Wed, 5 May 2021 19:29:19 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c3qahkg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 19:29:19 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 145NRrs3015430;
        Wed, 5 May 2021 23:29:18 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 38bedwfq5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 23:29:18 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 145NTHCT21692868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 May 2021 23:29:17 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5B716E04C;
        Wed,  5 May 2021 23:29:17 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89D5D6E050;
        Wed,  5 May 2021 23:29:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 May 2021 23:29:17 +0000 (GMT)
Subject: Re: [PATCH v4 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210505064843.111900-1-vt@altlinux.org>
 <20210505064843.111900-4-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <2209bd5d-9255-4954-2a61-2d2e7f23a433@linux.ibm.com>
Date:   Wed, 5 May 2021 19:29:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210505064843.111900-4-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zhpbl73yjtKgfvzu5QKbowVBII-7DLZ4
X-Proofpoint-ORIG-GUID: camrbHy8z3x-UTk5NXrciaIeCyVn9YBA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_11:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050159
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/5/21 2:48 AM, Vitaly Chikunov wrote:
> Allow to have certificate appended to the private key of `--key'
> specified (PEM) file (for v2 signing) to facilitate reading of keyid
> from the associated cert. This will allow users to have private and
> public key as a single file. There is no check that public key form the
> cert matches associated private key.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   README          | 3 +++
>   src/libimaevm.c | 8 +++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/README b/README
> index 0e1f6ba..ea11bde 100644
> --- a/README
> +++ b/README
> @@ -127,6 +127,9 @@ for signing and importing the key.
>   Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
>   in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
>   
> +For v2 signatures x509 certificate with the public key could be appended to the private
> +key (both are in PEM format) to properly determine its Subject Key Identifier (SKID).
> +
>   
>   Integrity keyrings
>   ----------------
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index a22d9bb..ac4bb46 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -1017,10 +1017,12 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>   		return -1;
>   	}
>   
> -	if (imaevm_params.keyid)
> +	if (imaevm_params.keyid) {
>   		hdr->keyid = htonl(imaevm_params.keyid);
> -	else
> -		calc_keyid_v2(&hdr->keyid, name, pkey);
> +	} else {
> +		if (_ima_read_keyid(keyfile, &hdr->keyid, KEYID_FILE_PEM_KEY) == ULONG_MAX)
> +			calc_keyid_v2(&hdr->keyid, name, pkey);
> +	}

It might be convenient here to just write the result in network byte 
order into the header but for a library API I find it not so nice, but 
then there's calc_keyid_v2 that does that already... I just wouldn't 
expect that these parameter are in big endian order already, I would 
expect them in native order. So maybe ima_read_keyid should just return 
ULONG_MAX or the keyid in host order and it call _ima_read_keyid() with 
a NULL pointer or a dummy variable as keyid that the library API caller 
doesn't see.

    Stefan


>   
>   	st = "EVP_PKEY_CTX_new";
>   	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
