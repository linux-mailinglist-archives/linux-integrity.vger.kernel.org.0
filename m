Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA0366B55
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 14:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhDUMzi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 08:55:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234786AbhDUMzh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 08:55:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LCXcVX172431;
        Wed, 21 Apr 2021 08:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+8tDOy3QEBxTbIcWNen4a65kOsTqC91/N7Cf3PLS8Us=;
 b=szK4U/DPEjiUPIgrukXi7tpq303SPBTJZT9QAmVf2hbOEjWwr70ejQwu+v56zafV6fgf
 rQyFT4gIkCVi2eeiw/sJr4FB/Fz1C1aiB4k/qyQT/+2g6Yan9STdBNBQIGV0X1AI2GAD
 uBBgjBL90/s0W/VywMDeSaLv3uuoIDWj63t4NbbCIvKBE5D6iCZjqzefpOoPhQgVcrLr
 5c5LhAuYKASpXHzfs//Pm1j1653opXYHF9eMbGHRttl4YNTAY9SOqEkZwT7WSaDtbNsz
 Uk4PPSmO8ZCINofCPHAYcKuavnrSXFd+V6yRuPnDQjLOQZm9uKMO3hSXcHyI6mmPxdD0 qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382kvps42f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 08:55:02 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13LCYiXR178998;
        Wed, 21 Apr 2021 08:55:02 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382kvps41g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 08:55:01 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LCre3L025882;
        Wed, 21 Apr 2021 12:55:00 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 37yqaa1y72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 12:55:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LCt0a736372988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 12:55:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 216C9B2065;
        Wed, 21 Apr 2021 12:55:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A05FB2064;
        Wed, 21 Apr 2021 12:55:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 12:55:00 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] certs: Add support for using elliptic curve keys
 for signing modules
To:     Jessica Yu <jeyu@kernel.org>
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
 <20210408152403.1189121-3-stefanb@linux.ibm.com> <YH7fKUjJoynyPkHt@gunter>
 <794ef635-de91-9207-f28b-ab6805fd95c9@linux.ibm.com>
 <YIAf9jYGu03lrJLn@gunter>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <c562e50f-b25c-4cf0-80c7-a5aa56d0d5f7@linux.ibm.com>
Date:   Wed, 21 Apr 2021 08:54:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YIAf9jYGu03lrJLn@gunter>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QF7k2R3pV0gPlh4Hzgnkvb8mPH9PNfI-
X-Proofpoint-GUID: toVW58-lb19Rnfj7q1nOQnXtj4hWX46B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_04:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/21/21 8:52 AM, Jessica Yu wrote:
> +++ Stefan Berger [20/04/21 17:02 -0400]:
>>
>> On 4/20/21 10:03 AM, Jessica Yu wrote:
>>> +++ Stefan Berger [08/04/21 11:24 -0400]:
>>>>
>>>> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c 
>>>> b/crypto/asymmetric_keys/pkcs7_parser.c
>>>> index 967329e0a07b..2546ec6a0505 100644
>>>> --- a/crypto/asymmetric_keys/pkcs7_parser.c
>>>> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
>>>> @@ -269,6 +269,10 @@ int pkcs7_sig_note_pkey_algo(void *context, 
>>>> size_t hdrlen,
>>>>         ctx->sinfo->sig->pkey_algo = "rsa";
>>>>         ctx->sinfo->sig->encoding = "pkcs1";
>>>>         break;
>>>> +    case OID_id_ecdsa_with_sha256:
>>>> +        ctx->sinfo->sig->pkey_algo = "ecdsa";
>>>> +        ctx->sinfo->sig->encoding = "x962";
>>>> +        break;
>>>
>>> Hi Stefan,
>>>
>>> Does CONFIG_MODULE_SIG_KEY_TYPE_ECDSA have a dependency on 
>>> MODULE_SIG_SHA256?
>>
>> You are right, per the code above it does have a dependency on 
>> SHA256. ECDSA is using NIST p384 (secp384r1) for signing and per my 
>> tests it can be paired with all the sha hashes once the code above is 
>> extended. Now when it comes to module signing, should we pair it with 
>> a particular hash? I am not currently aware of a guidance document on 
>> this but sha256 and sha384 seem to be good choices these days, so 
>> maybe selecting ECDSA module signing should have a 'depends on' on 
>> these?
>
> Yeah, I would tack on the 'depends on' until the code above has been
> extended to cover more sha hashes - because currently if someone
> builds and signs a bunch of modules with an ECDSA key, they will fail
> to load if they picked something other than sha256. I am unfortunately
> not knowledgeable enough to suggest an official guideline on choice of
> hash, but for now it is reasonable to have a 'depends on' for which
> hashes the code currently supports, so that users don't run into
> module loading rejection issues.


I was going to repost this series now with the additional OIDs supported 
above and a recommendation to use sha384 in the help text for 
ECDSA-signed modules, but not enforcing this but instead trusting the 
user that they will choose a reasonable hash (probably >= sha256).


    Stefan


>
> Thanks!
>
> Jessica
