Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A60B32F211
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 19:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCESCU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 13:02:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhCESCT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 13:02:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125HYm3Q134311;
        Fri, 5 Mar 2021 13:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vA3gk2DanwGTF2Onwczf03QQRxf8P3h787WW2pyBFaw=;
 b=mPRywqmqSFKTR4okp+DXR07QR4+ykTqSxOKL5wkMzY4hd5N4jnnEJo5AeElaaUzmoTou
 5uvG0TnmPw7zwobv5mJeJTl0w66zbRb25gRGHAnLNblDSxCzE6Zl8OHhYKDu8Er86PMB
 18+oSlkxjrLekghxSKoraRUWfJVig0dbRmo0mdMSc+6ZY0SFEZ+slKqKmTH2ZkS/NFwA
 S1N+RwLGcTKj/1O6OMluJN0PO/3sxA5WbBmMkjO4lrO6cyl6AVeVZJCC5k39lyhuB4fO
 D0Vx3poho3FLqLJYrOlmcPGn4SFKez/5BLXWXdPRvXmfqyfDL0aX5QVCFGhL5CxCDoxV dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373k57mp38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 13:02:12 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 125HZ45Q136361;
        Fri, 5 Mar 2021 13:02:11 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373k57mp2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 13:02:11 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125Hl9Mj024267;
        Fri, 5 Mar 2021 18:02:10 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 371qmv7pa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 18:02:10 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125I296F42992034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 18:02:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E132112066;
        Fri,  5 Mar 2021 18:02:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79B5D112065;
        Fri,  5 Mar 2021 18:02:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 18:02:09 +0000 (GMT)
Subject: Re: [PATCH v10 5/9] x509: Detect sm2 keys by their parameters OID
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-6-stefanb@linux.vnet.ibm.com>
 <YEJnYOvFnWr7YcJK@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <85b2cdaa-52e1-f519-db85-2ba95dc42b3b@linux.ibm.com>
Date:   Fri, 5 Mar 2021 13:02:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YEJnYOvFnWr7YcJK@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_13:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/21 12:16 PM, Jarkko Sakkinen wrote:
> On Thu, Mar 04, 2021 at 07:51:59PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Detect whether a key is an sm2 type of key by its OID in the parameters
>> array rather than assuming that everything under OID_id_ecPublicKey
>> is sm2, which is not the case.
>>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: keyrings@vger.kernel.org
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   crypto/asymmetric_keys/x509_cert_parser.c | 12 +++++++++++-
>>   include/linux/oid_registry.h              |  1 +
>>   lib/oid_registry.c                        | 13 +++++++++++++
>>   3 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
>> index 52c9b455fc7d..1621ceaf5c95 100644
>> --- a/crypto/asymmetric_keys/x509_cert_parser.c
>> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
>> @@ -459,6 +459,7 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>>   			  const void *value, size_t vlen)
>>   {
>>   	struct x509_parse_context *ctx = context;
>> +	enum OID oid;
> enum is not a real type, and it is hard to recall how much it allocates
> from stack. I would replace this with plain int.


That would be worse considering existing code: 
https://elixir.bootlin.com/linux/latest/source/lib/oid_registry.c#L25


>
>>   
>>   	ctx->key_algo = ctx->last_oid;
>>   	switch (ctx->last_oid) {
>> @@ -470,7 +471,16 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>>   		ctx->cert->pub->pkey_algo = "ecrdsa";
>>   		break;
>>   	case OID_id_ecPublicKey:
>> -		ctx->cert->pub->pkey_algo = "sm2";
>> +		if (parse_OID(ctx->params, ctx->params_size, &oid) != 0)
>> +			return -EBADMSG;
>> +
>> +		switch (oid) {
>> +		case OID_sm2:
>> +			ctx->cert->pub->pkey_algo = "sm2";
>> +			break;
>> +		default:
>> +			return -ENOPKG;
>> +		}
>>   		break;
>>   	default:
>>   		return -ENOPKG;
>> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
>> index b504e2f36b25..f32d91895e4d 100644
>> --- a/include/linux/oid_registry.h
>> +++ b/include/linux/oid_registry.h
>> @@ -121,6 +121,7 @@ enum OID {
>>   };
>>   
>>   extern enum OID look_up_OID(const void *data, size_t datasize);
>> +extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
>>   extern int sprint_oid(const void *, size_t, char *, size_t);
>>   extern int sprint_OID(enum OID, char *, size_t);
>>   
>> diff --git a/lib/oid_registry.c b/lib/oid_registry.c
>> index f7ad43f28579..508e0b34b5f0 100644
>> --- a/lib/oid_registry.c
>> +++ b/lib/oid_registry.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/errno.h>
>>   #include <linux/bug.h>
>> +#include <linux/asn1.h>
>>   #include "oid_registry_data.c"
>>   
>>   MODULE_DESCRIPTION("OID Registry");
>> @@ -92,6 +93,18 @@ enum OID look_up_OID(const void *data, size_t datasize)
>>   }
>>   EXPORT_SYMBOL_GPL(look_up_OID);
>>   
>> +int parse_OID(const void *data, size_t datasize, enum OID *oid)
> An exported function without kdoc.
>
>> +{
>> +	const unsigned char *v = data;
>> +
>> +	if (datasize < 2 || v[0] != ASN1_OID || v[1] != datasize - 2)
>> +		return -EBADMSG;
> '1' and '2' are magic numbers unless you either have constants defining
> them, or at least an inline comment with explanation.


I can add those.


