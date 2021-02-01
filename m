Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB430A839
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 14:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBANDK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 08:03:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231407AbhBANDI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 08:03:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111D1QCm081851;
        Mon, 1 Feb 2021 08:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZigMs+1+OGFbFSIyjvMcFvWe6jq3VvhSgTQtQqwSDi0=;
 b=atNROLZxC41VitSLou85LOJRynReYFXzJYQNGOD2fZv81OTgynnPPA5Xq370d/Alqgr5
 TDRaKHA3W+9jtFfqYH8hqw8XBPqdrTpCpZL88X0aSEEB6bmuEmkNug++RVXwVJYiEHYP
 +RXK8t6DbPSnO9ivxzYckpBh62swtsMns1To1HSMgdKXmh/2alty4l/974d6OUYMrK5V
 5eOEvUwtHz+J763ZF0iMIyEs5yIJC+nRsi0sYApAnDo75weGEWTx3CHe6aj3k4xvRGYV
 s3ZcE3kGWgugbrvXVjekDqNIRxadVGmSUEzcjGKZH3u+lm/XmtaukBd9Pkaym+syoUjR ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ehe81bpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 08:02:24 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111D1j6Q083550;
        Mon, 1 Feb 2021 08:02:22 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ehe81bp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 08:02:22 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111Cv49C029932;
        Mon, 1 Feb 2021 13:02:21 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 36cy38pfkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 13:02:21 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111D2LoF6882014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 13:02:21 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69050AC05E;
        Mon,  1 Feb 2021 13:02:21 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59DC6AC059;
        Mon,  1 Feb 2021 13:02:21 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 13:02:21 +0000 (GMT)
Subject: Re: [PATCH v6 2/4] x509: Detect sm2 keys by their parameters OID
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>
References: <20210131233301.1301787-1-stefanb@linux.ibm.com>
 <20210131233301.1301787-3-stefanb@linux.ibm.com>
 <75a8ff37-3c23-6cf1-f844-cf692eb8adfc@linux.alibaba.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <ace09744-e6c9-32da-27d8-accadd5d0252@linux.ibm.com>
Date:   Mon, 1 Feb 2021 08:02:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <75a8ff37-3c23-6cf1-f844-cf692eb8adfc@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010065
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/1/21 5:39 AM, Tianjia Zhang wrote:
>
>> index f7ad43f28579..508e0b34b5f0 100644
>> --- a/lib/oid_registry.c
>> +++ b/lib/oid_registry.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/errno.h>
>>   #include <linux/bug.h>
>> +#include <linux/asn1.h>
>>   #include "oid_registry_data.c"
>>     MODULE_DESCRIPTION("OID Registry");
>> @@ -92,6 +93,18 @@ enum OID look_up_OID(const void *data, size_t 
>> datasize)
>>   }
>>   EXPORT_SYMBOL_GPL(look_up_OID);
>>   +int parse_OID(const void *data, size_t datasize, enum OID *oid)
>> +{
>> +    const unsigned char *v = data;
>> +
>> +    if (datasize < 2 || v[0] != ASN1_OID || v[1] != datasize - 2)
>> +        return -EBADMSG;
>> +
>> +    *oid = look_up_OID(data + 2, datasize - 2);
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(parse_OID);
>> +
>>   /*
>>    * sprint_OID - Print an Object Identifier into a buffer
>>    * @data: The encoded OID to print
>>
>
> Great job, I'm just curious why we need to add a new function, this 
> seems unnecessary, if possible, please add


Thanks. I call this function in two places now. I thought it was 'worth it'.


>
> Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>
> Best regards,
> Tianjia


