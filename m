Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400A931F209
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBRWEA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:04:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhBRWD6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:03:58 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IM3EHb041452;
        Thu, 18 Feb 2021 17:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rYEWiDhJo8xqBxtCjR7vOI84a6AhNxwReSQB5H6lFk8=;
 b=aBLepCMdtd8aDWCbXa4JTnLXAr4OEs2PFpmX+WScnapFhWPMBUi1BreJ2Oj1k11nG+gk
 RZZYvD8j7I2PnRAjVoYFyJ9jlxVxPVUQAjWlta2vs/mku8cZxuqboxwgTddPAYyoscue
 7dQkjhPgJNjGyHaDZhSKkAI0EsN02LYvoXsjqK0A1/ZXhNa6m8MNSWeWsFQAeGv6kr9H
 nqFnCtvBteLj5yMP+ozBLUIL3fl6TZrtZjs1PWiaCuEygriRrYyMMNuGDbXf0seWxoq8
 i/7p+U9QyMNehX5j6tOm+3b0F5pzYq/Pu3QTs+P1c6xiF8Ux2F696exADYgS06dhVJKN 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36sy3atmpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:03:14 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11IM3Dk7041347;
        Thu, 18 Feb 2021 17:03:13 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36sy3atme8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:03:13 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ILpqRg006684;
        Thu, 18 Feb 2021 22:02:55 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 36p6d9h5rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 22:02:55 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IM2sjI22544720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:02:54 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A8306E05F;
        Thu, 18 Feb 2021 22:02:54 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F7F76E05E;
        Thu, 18 Feb 2021 22:02:53 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.211.90.194])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 22:02:53 +0000 (GMT)
Subject: Re: [PATCH 2/5] keys: generate self-signed module signing key using
 CSR
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
 <20210211195435.135582-3-nayna@linux.ibm.com>
 <c9e509fb-59df-28b4-654c-543cd922239c@linux.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <92dcd8a4-4cb8-e0d0-56cb-e3c0736278ce@linux.vnet.ibm.com>
Date:   Thu, 18 Feb 2021 17:02:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <c9e509fb-59df-28b4-654c-543cd922239c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180182
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/11/21 5:01 PM, Stefan Berger wrote:
> On 2/11/21 2:54 PM, Nayna Jain wrote:
>> Loading a key on the IMA trusted keyring requires the key be signed
>> by an existing key on the builtin or secondary trusted keyring.
>> Creating a Certificate Signing Request (CSR) allows the certificate
>> to be self-signed or signed by a CA.
>>
>> This patch generates a self-signed module signing key using CSR.
>>
>> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>> ---
>>   Makefile       |  3 ++-
>>   certs/Makefile | 15 +++++++++++----
>>   2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index af18aab6bbee..9c87fdd600d8 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1473,7 +1473,8 @@ MRPROPER_FILES += include/config 
>> include/generated          \
>>             .config .config.old .version \
>>             Module.symvers \
>>             certs/signing_key.pem certs/signing_key.x509 \
>> -          certs/x509.genkey \
>> +          certs/x509.genkey certs/signing_key.key \
>> +          certs/signing_key.crt certs/signing_key.csr \
>>             vmlinux-gdb.py \
>>             *.spec
>>   diff --git a/certs/Makefile b/certs/Makefile
>> index f4c25b67aad9..b2be7eb413d3 100644
>> --- a/certs/Makefile
>> +++ b/certs/Makefile
>> @@ -60,11 +60,18 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
>>       @$(kecho) "### needs to be run as root, and uses a hardware 
>> random"
>>       @$(kecho) "### number generator if one is available."
>>       @$(kecho) "###"
>> -    $(Q)openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) 
>> -days 36500 \
>> -        -batch -x509 -config $(obj)/x509.genkey \
>> -        -outform PEM -out $(obj)/signing_key.pem \
>> -        -keyout $(obj)/signing_key.pem \
>> +    $(Q)openssl req -new -nodes -utf8 \
>> +        -batch -config $(obj)/x509.genkey \
>> +        -outform PEM -out $(obj)/signing_key.csr \
>> +        -keyout $(obj)/signing_key.key -extensions myexts \
>>           $($(quiet)redirect_openssl)
>> +    $(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
>> +        -outform PEM -out $(obj)/signing_key.crt \
>> +        -signkey $(obj)/signing_key.key \
>> +        -$(CONFIG_MODULE_SIG_HASH) -extensions myexts \
>> +        -extfile $(obj)/x509.genkey \
>> +        $($(quiet)redirect_openssl)
>> +    @cat $(obj)/signing_key.key $(obj)/signing_key.crt >> 
>> $(obj)/signing_key.pem
>
>
> Could you not just rename signing_key.key to signing_key.pem (as it 
> was before) and that would be it? Why do you need the .crt in that pem 
> bundle?

I had also thought so, but the PEM file contains both the private key 
and the certificate. I found the reasoning in the commit "fb1179499134 
modsign: Use single PEM file for autogenerated key". I addressed your 
other feedback in v2, posted just now.

Thanks & Regards,

       - Nayna

