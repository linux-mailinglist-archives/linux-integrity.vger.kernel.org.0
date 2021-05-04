Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50FD372B2E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhEDNjF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 09:39:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230478AbhEDNjE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 09:39:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144DYQKr056784;
        Tue, 4 May 2021 09:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wltGETnf3vbl0pxHPyRst2y1SSz1U+6i+JDEOkdhoKY=;
 b=mVw5szB2IxGZcUl+uR0QnsDFvW+StdmqgdTPaUGs0sFU765ZwwCfRUg3ayoXHr2F/iW/
 DllFFXdw+N06+CaNPD8A9Bkcwgc+Pz5FKgPegVGT6HrMtph1rwuM9oFRxmswXurwks6R
 hFCQAYSbjrUztpuCs5U+WQnlrLupNMcsbvez04v1tP1EtqgYor2qiooPjNB3stbBUtuS
 mhQrAS0trBOZ3yQ8kK3c28Y5w6YHcK9v8ZZYKo48ulm+HQbWTTb8hLIRMxa3xXQszdHn
 4gMNeV/SVoHiD7gP2pMfKUjMU+6ixusGJmoYp71QTM11ozbY4VHThg946S2L3VigJdHp Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b5a4kx30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:38:08 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 144DYaWF057637;
        Tue, 4 May 2021 09:38:08 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b5a4kx2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:38:08 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144DXpJ0019742;
        Tue, 4 May 2021 13:38:07 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 38a9xfsv05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 13:38:07 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144Dc71p32440688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 13:38:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F196A112062;
        Tue,  4 May 2021 13:38:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E31DB112061;
        Tue,  4 May 2021 13:38:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 13:38:06 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter0@gmail.com>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-4-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1b5d6c49-c080-76e9-66e1-2db19bfee2c9@linux.ibm.com>
Date:   Tue, 4 May 2021 09:38:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504043357.4093409-4-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YaF6-RcSSMu7Z70a26-nwTMX199GAs0B
X-Proofpoint-ORIG-GUID: cJ4B_o77X3ektg9c8czApyumKW_8-bJV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_07:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105040101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/4/21 12:33 AM, Vitaly Chikunov wrote:
> Allow to have certificate appended to the private key of `--key'
> specified (PEM) file (for v2 signing) to facilitate reading of keyid
> from the associated cert. This will allow users to have private and
> public key as a single file. There is no check that public key form the
> cert matches associated private key.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   README          |  2 ++
>   src/libimaevm.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/README b/README
> index 0e1f6ba..2c21ba6 100644
> --- a/README
> +++ b/README
> @@ -127,6 +127,8 @@ for signing and importing the key.
>   Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
>   in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
>   
> +For v2 signatures x509 certificate with the public key could be appended to the private
> +key (both are in PEM format) to properly determine its Subject Key Identifier SKID.
>   
>   Integrity keyrings
>   ----------------
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 481d29d..3607a76 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -57,6 +57,7 @@
>   #include <openssl/pem.h>
>   #include <openssl/evp.h>
>   #include <openssl/x509.h>
> +#include <openssl/x509v3.h>
>   #include <openssl/err.h>
>   
>   #include "imaevm.h"
> @@ -748,6 +749,47 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
>   	X509_PUBKEY_free(pk);
>   }
>   
> +/* Try to read keyid from key file (in case it have appended cert). */
> +static int read_keyid(const char *keyfile, uint32_t *keyid)
> +{

So the private key is assumed to be in PEM format. I suppose if there's 
an appended X509 in the private key file as well then only one function 
should be necessary to extract the x509 cert from the files. That 
function should be able to handle PEM and DER format at the same time. 
Have you tried extracting the x509 cert from the private key file using 
that other function in 2/3 yet?


