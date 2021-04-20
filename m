Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB736614E
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhDTVDW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 17:03:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233548AbhDTVDV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 17:03:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KKY6ZT125881;
        Tue, 20 Apr 2021 17:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tjLwptpGapR+G6kW/74l72xR3hpJOewr9nnuMzs60Gs=;
 b=L8hCkc6705h8XBeoZlkxOu3RHuWi/jzm2IQY/0BCJefllhIUDaDlwQll+qDU+KS898VV
 uVPrpch8+HpXe4x7gO7TKXnNcYIBFo88qOZAVgOKJvSRSk+jBeSP7H5skvSE4tFdZroC
 9/80OOaVr7yLkwBKzh6LdO0bPfH7tIdgiFV6D6hzpy9Jvb0eJCNm4IeDJWGoFWBNRImQ
 C5NG+4LUwL6WFV45xWzNSCc21XK+vrIUGilWVBD6fIsTM/F6wuB4UICNde47bJRZ9OxX
 0Uoc/rPrcqKjRr85KsdDhtp0cGU7IrGlEWfvVSQYQXY0jSn+H2BkVQ00rmS2urgzJ3rC Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3820863srr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 17:02:48 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KKsTEh018571;
        Tue, 20 Apr 2021 17:02:47 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3820863srf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 17:02:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KKuXtN017741;
        Tue, 20 Apr 2021 21:02:46 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 37yqaa4akk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 21:02:46 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KL2jlM33751438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 21:02:45 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D3D06E052;
        Tue, 20 Apr 2021 21:02:45 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE6B26E050;
        Tue, 20 Apr 2021 21:02:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 21:02:44 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] certs: Add support for using elliptic curve keys
 for signing modules
To:     Jessica Yu <jeyu@kernel.org>
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
 <20210408152403.1189121-3-stefanb@linux.ibm.com> <YH7fKUjJoynyPkHt@gunter>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <794ef635-de91-9207-f28b-ab6805fd95c9@linux.ibm.com>
Date:   Tue, 20 Apr 2021 17:02:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YH7fKUjJoynyPkHt@gunter>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I5XP_N6a_PhFOdCTJgRAYyMeGJ6I1AWC
X-Proofpoint-ORIG-GUID: kGtwcPUsKloKTA-e0-UPqv-xapRc5t27
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200141
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/20/21 10:03 AM, Jessica Yu wrote:
> +++ Stefan Berger [08/04/21 11:24 -0400]:
>>
>> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c 
>> b/crypto/asymmetric_keys/pkcs7_parser.c
>> index 967329e0a07b..2546ec6a0505 100644
>> --- a/crypto/asymmetric_keys/pkcs7_parser.c
>> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
>> @@ -269,6 +269,10 @@ int pkcs7_sig_note_pkey_algo(void *context, 
>> size_t hdrlen,
>>         ctx->sinfo->sig->pkey_algo = "rsa";
>>         ctx->sinfo->sig->encoding = "pkcs1";
>>         break;
>> +    case OID_id_ecdsa_with_sha256:
>> +        ctx->sinfo->sig->pkey_algo = "ecdsa";
>> +        ctx->sinfo->sig->encoding = "x962";
>> +        break;
>
> Hi Stefan,
>
> Does CONFIG_MODULE_SIG_KEY_TYPE_ECDSA have a dependency on 
> MODULE_SIG_SHA256?

You are right, per the code above it does have a dependency on SHA256. 
ECDSA is using NIST p384 (secp384r1) for signing and per my tests it can 
be paired with all the sha hashes once the code above is extended. Now 
when it comes to module signing, should we pair it with a particular 
hash? I am not currently aware of a guidance document on this but sha256 
and sha384 seem to be good choices these days, so maybe selecting ECDSA 
module signing should have a 'depends on' on these?

   Stefan


