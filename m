Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3537336D
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 03:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhEEBFq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 21:05:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231408AbhEEBFp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 21:05:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14512gsP026654;
        Tue, 4 May 2021 21:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T+myMbg4CS9D6JT5j44g5uV0UUqcC6IEM5BbJcycpjo=;
 b=WL/GvX2Cd+h94V8H3gSPvo1P3cYVFGMPYzVJE4WmKPf7+JvKqsflmh7XZjT8ANp7xQgE
 4UOXK+zcwkI8ImZexMJ4aooIN0aXO/gk5rEmkYF5uncDKO25Ic+qeQWhHfgs7nM52HZq
 XPQ//wxpQ/wujApb/hzsF5hWt1bjNniM4sPpl8mBYKCmVB6nCsWMAyGY/8JKMliOM5FB
 gsnN74+r/MyKkOESPDzeEXMc0HBM+8gyJetSXqsBhUf7ZaYHq2V46/9D7gmIaYmkIb/W
 Di2CAB7olAd2tvdDw3uKXFssJl0j+E9jfbED/X/hljmfpW3LZnD+oip5ub6MM1ougAS/ Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38bgmm0ttm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 21:04:47 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14512oJN026998;
        Tue, 4 May 2021 21:04:47 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38bgmm0tt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 21:04:47 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14511cnU012750;
        Wed, 5 May 2021 01:04:45 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 38bedtrwjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 01:04:45 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14514jOE37093778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 May 2021 01:04:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CB3DB2065;
        Wed,  5 May 2021 01:04:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D08AB2064;
        Wed,  5 May 2021 01:04:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 May 2021 01:04:45 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Elvira Khabirova <lineprinter0@gmail.com>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-4-vt@altlinux.org>
 <1b5d6c49-c080-76e9-66e1-2db19bfee2c9@linux.ibm.com>
 <20210504222723.wirqlwsz2xtnfqz7@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <fbe258e3-5cd4-5d67-7622-431a6434d64f@linux.ibm.com>
Date:   Tue, 4 May 2021 21:04:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504222723.wirqlwsz2xtnfqz7@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DAcGAicC5NC0r-_7BRkT4nMCWgqrYrMK
X-Proofpoint-ORIG-GUID: ZZUA7T2i0Cq2pdPeQOZ53hhs0W9oIfd4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_15:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050004
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/4/21 6:27 PM, Vitaly Chikunov wrote:
> Stefan,
>
> On Tue, May 04, 2021 at 09:38:06AM -0400, Stefan Berger wrote:
>> On 5/4/21 12:33 AM, Vitaly Chikunov wrote:
>>> Allow to have certificate appended to the private key of `--key'
>>> specified (PEM) file (for v2 signing) to facilitate reading of keyid
>>> from the associated cert. This will allow users to have private and
>>> public key as a single file. There is no check that public key form the
>>> cert matches associated private key.
>>>
>>> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
>>> ---
>>>    README          |  2 ++
>>>    src/libimaevm.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>>>    2 files changed, 49 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/README b/README
>>> index 0e1f6ba..2c21ba6 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -127,6 +127,8 @@ for signing and importing the key.
>>>    Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
>>>    in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
>>> +For v2 signatures x509 certificate with the public key could be appended to the private
>>> +key (both are in PEM format) to properly determine its Subject Key Identifier SKID.
>>>    Integrity keyrings
>>>    ----------------
>>> diff --git a/src/libimaevm.c b/src/libimaevm.c
>>> index 481d29d..3607a76 100644
>>> --- a/src/libimaevm.c
>>> +++ b/src/libimaevm.c
>>> @@ -57,6 +57,7 @@
>>>    #include <openssl/pem.h>
>>>    #include <openssl/evp.h>
>>>    #include <openssl/x509.h>
>>> +#include <openssl/x509v3.h>
>>>    #include <openssl/err.h>
>>>    #include "imaevm.h"
>>> @@ -748,6 +749,47 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
>>>    	X509_PUBKEY_free(pk);
>>>    }
>>> +/* Try to read keyid from key file (in case it have appended cert). */
>>> +static int read_keyid(const char *keyfile, uint32_t *keyid)
>>> +{
>> So the private key is assumed to be in PEM format.
> Yes, even though README says something different.
>
>> I suppose if there's an
>> appended X509 in the private key file as well then only one function should
>> be necessary to extract the x509 cert from the files. That function should
>> be able to handle PEM and DER format at the same time. Have you tried
>> extracting the x509 cert from the private key file using that other function
>> in 2/3 yet?
> Excuse me, I don't understand what you talking about in this note.
> 2/3 does not read private keys. Where and why should be one function?
> And what other function?

It should be possible to combine yourš functions extract_keyid (2/3) and 
read_keyid (3/3) into a single function that can handle PEM files 
containing X509 certs as well as DER files. It's two times very similar 
code and the function that can handle DER and PEM should be able to 
handle PEM files with private keys + X509 certs.

 ššš Stefan


> Thanks,
>
