Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D815374D72
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 04:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhEFCWG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 22:22:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhEFCWG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 22:22:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14623Lua108883;
        Wed, 5 May 2021 22:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7SbzpIcTDH1Jy2C3TDgpW3gLB/SwV4VwfTe7SNrGLjo=;
 b=Rh0CKT8y0mazq+Wn8k+845DKTDhxCwABEwmQTBAUcbWogGZigepqZkPnQj2pxVS7YwNh
 hWGvwBj88R8JG+vSddFieOZjsp/WThLfAmA9LQxTODlDKhEyTPfTKVKgpCO56zJ0p6IZ
 DMy3j9MBpEuh9UyK6Vu2XDwPnkV7iNTRxS5QMl21Un5xZUjSRWXrHNZTtuk0q1YPY6UL
 3ZxEtChmJOF6/xewe/f0bsjnuUqMxNpzhcidTMnpFDg5vOaRuYXIAcWgC/4N7uNOHObs
 OCxs3rtIQoClNtPapgdKA0lb4mlpfhlymRzfKmQ4UUumuoGoaBhiIxWBo6nZWk8X8+g6 tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c60bhx4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 22:21:07 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14623SoS112414;
        Wed, 5 May 2021 22:21:06 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c60bhx4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 22:21:06 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1462GdRB024774;
        Thu, 6 May 2021 02:21:06 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 38bee8js8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 02:21:06 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1462L5Ro28115414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 02:21:05 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A2E2AE05F;
        Thu,  6 May 2021 02:21:05 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12334AE05C;
        Thu,  6 May 2021 02:21:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 02:21:05 +0000 (GMT)
Subject: Re: [PATCH v4 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210505064843.111900-1-vt@altlinux.org>
 <20210505064843.111900-4-vt@altlinux.org>
 <2209bd5d-9255-4954-2a61-2d2e7f23a433@linux.ibm.com>
 <20210506002932.zt4mcihtl4v2yfxo@altlinux.org>
 <20210506005317.olcsehs4ou26gwjg@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <17417c8c-3214-5bd1-8c7a-a596fbe8f8c7@linux.ibm.com>
Date:   Wed, 5 May 2021 22:21:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506005317.olcsehs4ou26gwjg@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P1RI9IoWY4TTHDd4sHRrz72Y7-eEo6tQ
X-Proofpoint-ORIG-GUID: -61YhtunH8Tt-SDj7YyWkcbA0Sl3T2cp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_11:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105060012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/5/21 8:53 PM, Vitaly Chikunov wrote:
> Stefan,
>
> On Thu, May 06, 2021 at 03:29:32AM +0300, Vitaly Chikunov wrote:
>> On Wed, May 05, 2021 at 07:29:17PM -0400, Stefan Berger wrote:
>>> On 5/5/21 2:48 AM, Vitaly Chikunov wrote:
>>>> Allow to have certificate appended to the private key of `--key'
>>>> specified (PEM) file (for v2 signing) to facilitate reading of keyid
>>>> from the associated cert. This will allow users to have private and
>>>> public key as a single file. There is no check that public key form the
>>>> cert matches associated private key.
>>>>
>>>> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
>>>> ---
>>>>    README          | 3 +++
>>>>    src/libimaevm.c | 8 +++++---
>>>>    2 files changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/README b/README
>>>> index 0e1f6ba..ea11bde 100644
>>>> --- a/README
>>>> +++ b/README
>>>> @@ -127,6 +127,9 @@ for signing and importing the key.
>>>>    Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
>>>>    in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
>>>> +For v2 signatures x509 certificate with the public key could be appended to the private
>>>> +key (both are in PEM format) to properly determine its Subject Key Identifier (SKID).
>>>> +
>>>>    Integrity keyrings
>>>>    ----------------
>>>> diff --git a/src/libimaevm.c b/src/libimaevm.c
>>>> index a22d9bb..ac4bb46 100644
>>>> --- a/src/libimaevm.c
>>>> +++ b/src/libimaevm.c
>>>> @@ -1017,10 +1017,12 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>>>>    		return -1;
>>>>    	}
>>>> -	if (imaevm_params.keyid)
>>>> +	if (imaevm_params.keyid) {
>>>>    		hdr->keyid = htonl(imaevm_params.keyid);
>>>> -	else
>>>> -		calc_keyid_v2(&hdr->keyid, name, pkey);
>>>> +	} else {
>>>> +		if (_ima_read_keyid(keyfile, &hdr->keyid, KEYID_FILE_PEM_KEY) == ULONG_MAX)
>>>> +			calc_keyid_v2(&hdr->keyid, name, pkey);
>>>> +	}
>>> It might be convenient here to just write the result in network byte order
>>> into the header but for a library API I find it not so nice, but then
>>> there's calc_keyid_v2 that does that already... I just wouldn't expect that
>>> these parameter are in big endian order already, I would expect them in
>>> native order.
>> I expect them in network order, similar to how calc_keyid_v2() already
>> writes it one line below. So, why should we mix orders? Both functions
>> write keyids, so it's not like completely different parts of API. Also,
>> it's documented that ima_read_keyid() writes to the pointer in network
>> order (and returns integer in host order), so I don't see the
>> problem. Thus, I would prefer not to follow this suggestion.
>>
>> Thanks,
>>
>>> So maybe ima_read_keyid should just return ULONG_MAX or the
>>> keyid in host order and it call _ima_read_keyid() with a NULL pointer or a
>>> dummy variable as keyid that the library API caller doesn't see.
> So there will be exported
>     uint32_t ima_read_keyid(char *certfile);
> and internal
>     static bool _read_keyid(char *certfile, uint32_t *keyid)
>
> ima_read_keyid will wrap read_keyid and return keyid via intermediate
> variable. Right?

Yes like this. 0 returned from ima_read_keyid would indicate that 
nothing was found but could with a chance of 1/2^-32 be also a valid key 
id. Though we already declare it invalid in 1/3 when parsing a 0 from 
command line.


