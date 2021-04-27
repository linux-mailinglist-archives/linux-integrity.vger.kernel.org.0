Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3863336CA92
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Apr 2021 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhD0Rrw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 13:47:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230219AbhD0Rru (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 13:47:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RHYJS8030811;
        Tue, 27 Apr 2021 13:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qIhsawBM6mKruLARllAlg9Yx7YxFPpr373XCBESRen0=;
 b=dqlZ+MXx2qndqSf5TIYifKltkJe7snqgK7Z/8lFsuSHfAobyGvtrWW7hO6r/tobwQqXR
 q/tlSqqUup1xSKkXFC38XSAgo9AUGUY+fCdyPcJyzD7YSQWWRY/YZZpzlrrLbfn7XVRf
 zmfpDk6b8XA989+3Z/AFPMbWKfU6JxMAdB+0WddeZUoaubgQwu8yUINft+728CC3rZKL
 /9XmZ8BpsKKjARy/05yFmh3v4yZN/a66BVJuhbo/1i2QoNxirv0ZNgMGmENlThf/AULp
 zfGhNzTTRyJFhifTs5oWSlfxlNWYugvvv/ZOqfNHkqSrt80LkwmRNnwzA6qfhUakIwQ+ yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386kec08kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 13:47:03 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RHZNAf033572;
        Tue, 27 Apr 2021 13:47:03 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386kec08k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 13:47:03 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RHhJrW018403;
        Tue, 27 Apr 2021 17:47:03 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 384ay9f3nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 17:47:03 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RHl2V029753698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 17:47:02 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A2C06E05D;
        Tue, 27 Apr 2021 17:47:02 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B22556E04C;
        Tue, 27 Apr 2021 17:47:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 17:47:01 +0000 (GMT)
Subject: Re: [PATCH 1/3] libimaevm: Implement imaevm_create_ima_signature
To:     Colin Walters <walters@verbum.org>, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
References: <20210420183015.861644-1-stefanb@linux.ibm.com>
 <20210420183015.861644-2-stefanb@linux.ibm.com>
 <4a4d068b-569c-4ffd-ba32-8656f761a3b5@www.fastmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1add81aa-85e6-68b1-4a48-b19ad33683c6@linux.ibm.com>
Date:   Tue, 27 Apr 2021 13:47:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <4a4d068b-569c-4ffd-ba32-8656f761a3b5@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gBm9enjdatBiFVFWQHyof8I0gw7eMzk4
X-Proofpoint-ORIG-GUID: P8RQ0KV_xUO2ct6TAd76YnMQvVxktNcn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_10:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/26/21 8:02 PM, Colin Walters wrote:
>
> On Tue, Apr 20, 2021, at 2:30 PM, Stefan Berger wrote:
>
>> + fd = open(filename, O_RDONLY);
> Missing O_CLOEXEC.


Will do.

>
>> +int imaevm_create_ima_signature(const char *filename, EVP_PKEY *pkey,
> It'd maximize flexibility for the caller to pass a file descriptor, and not a file name.


We could do this with a callback where the user implements the callback 
function and providers buffer, size of buffer, and eof indicator, and 
gets called for providing the data to hash. That would maybe be even 
more flexible..


>
>> +	if (statbuf.st_size > 0) {
>> +		addr = mmap(NULL, statbuf.st_size, PROT_READ, MAP_SHARED, fd, 0);
>> +		if (addr == MAP_FAILED) {
>> +			asprintf(error, "Failed to mmap file: %s", strerror(errno));
>> +			goto err_close;
>> +		}
>> +	}
> Tangentially related to this, I think we should consider doing the same optimization here:
> https://github.com/ostreedev/ostree/blob/36693f064c63dad550ebcfed33bf9b95806ddef9/src/libotutil/ot-fs-utils.c#L171
>
> Or alternatively, just have the caller provide a (mmap'd or copied-via-read()) buffer?
>
> Though clearly the most flexible is a streaming API.  But eh, I am not really concerned about that level of performance.


I think using a callback would allow for the streaming as well...

    Stefan


