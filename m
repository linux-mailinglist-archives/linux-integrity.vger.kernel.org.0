Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D373A6F00
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhFNTbH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 15:31:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233965AbhFNTbG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 15:31:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EJJjGd172736;
        Mon, 14 Jun 2021 15:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=S1C9PaL2FANFdSoalMsDBpIAGXLNMwfDGhZvYfL1o1k=;
 b=m2wRow3xiPipkRebSAyhaKeiY8wJgAnlKr6YyWYDVNZIKTsTBH0TJW8U5VoHFJ5VwdQL
 zB0/GdFCjZ9mU3H+zWiSPlHsIhN16Z0hwyCAJq5Rg1KtlVEEKUdllL+1MJlBUFT4nfHU
 dJvPETruyqjBxheILO+A48l9lFUm1Xbt5WJaHR1HatmQBOjMRX8gc0tGaKVf8UID62Vi
 REm1ReBWPlJXF3YH20xnfJ4MJ6TAe1CL58a83KqiDThQsXIfw2Le0kHwWbtpK7YOAHNT
 rBQTM1tHcS6cduNRJpylSMVJKql8DYWyKwk5UsG4QECmfoR6LllF3H/76B7CbJtLYPhf 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 396cnbs35a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 15:29:00 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15EJKiMF175234;
        Mon, 14 Jun 2021 15:29:00 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 396cnbs351-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 15:28:59 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EJI2JS002754;
        Mon, 14 Jun 2021 19:28:59 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 394mj9eg3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 19:28:59 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EJSvFJ19333502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 19:28:57 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CBC7136059;
        Mon, 14 Jun 2021 19:28:57 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E96CD13604F;
        Mon, 14 Jun 2021 19:28:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 19:28:56 +0000 (GMT)
Subject: Re: [PATCH v6 4/4] certs: Adjustment due to 'Check whether openssl
 tool is available'
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
 <20210610125623.1553792-5-stefanb@linux.ibm.com>
 <20210614192329.dhhahvi5gtnlgbln@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b355a2f2-78e7-61b4-2040-9ea3f8de0f73@linux.ibm.com>
Date:   Mon, 14 Jun 2021 15:28:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210614192329.dhhahvi5gtnlgbln@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zNvKrpGv_S0lqmCxySekG_ThffJnXx4S
X-Proofpoint-ORIG-GUID: JPG7VFWSp-SR89SY10l8zSnxfxwqIux1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_13:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/14/21 3:23 PM, Jarkko Sakkinen wrote:
> On Thu, Jun 10, 2021 at 08:56:23AM -0400, Stefan Berger wrote:
>> Adjust the previous patch due to fixes applied to the first patch
>> in the series.
>>
>> Fixes: 46449892e6e5 ("certs: Add support for using elliptic curve keys for signing modules")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   certs/Makefile | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/certs/Makefile b/certs/Makefile
>> index dc9f354dd5f8..4eb69bdadc79 100644
>> --- a/certs/Makefile
>> +++ b/certs/Makefile
>> @@ -66,16 +66,21 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
>>   
>>   ifeq ($(openssl_available),yes)
>>   X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
>> +endif
>>   
>>   # Support user changing key type
>>   ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
>>   keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
>> +ifeq ($(openssl_available),yes)
>>   $(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
>>   endif
>> +endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
>>   
>>   ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
>> +ifeq ($(openssl_available),yes)
>>   $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
>>   endif
>> +endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
>>   
>>   $(obj)/signing_key.pem: $(obj)/x509.genkey
>>   	@$(kecho) "###"
>> -- 
>> 2.29.2
>>
>>
> Please check that they are applied correctly, thanks.

No, they are not applied correctly. 2/2 shows this here:


  ifeq ($(openssl_available),yes)
  X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
+endif
+


This endif is in 2/4 in v6 and should appear on your git in 1/2. How did 
it get into 2/2?

https://lkml.org/lkml/2021/6/10/493


   Stefan


>
> /Jarkko
