Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC73A2AB2
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFJLwF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 07:52:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5228 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230215AbhFJLwF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 07:52:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ABXaLF183501;
        Thu, 10 Jun 2021 07:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sOsx0by8qj910X989Lv9ljQz1oCfdyYidDzCaLjOnTg=;
 b=ijtqNJmOo2TDpS0meMgb+r59PqcV9M6g+HpaZPdIMEwipmECcEOZl/aVRUR/6vj5JPRI
 vW1gaVxWSLaDxLkQDvGeIIJ3ZCDnOIWtUvMfBZbZi0pUqBf4mkmCXElxg22HMx9sPx7c
 VQ9HzmWlTh6hfl7YPrK7GmH7XKBd0/RGJMij1BTUrPt7g3GxtCWA/uLFKyJuEUaiEcc8
 sbvo+OgOTySTqLMBlxVNkbeqXQr1TvT0KvGJCluAYHEoBldzvh7kPrUBPCA1tJY5Q9J1
 lG3w5Tj9w6y8jE1VUNgOrngbDlhnvxoZcoj8AWdjJc+eni8xgAvbt00RYWluQYMo4Itu 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393guhah2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 07:50:03 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15ABYetF187223;
        Thu, 10 Jun 2021 07:50:03 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393guhah22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 07:50:03 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15ABlZDQ027823;
        Thu, 10 Jun 2021 11:50:01 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3900wa7qrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 11:50:01 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15ABo1SM38273324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 11:50:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E4F9AE063;
        Thu, 10 Jun 2021 11:50:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58FBCAE060;
        Thu, 10 Jun 2021 11:50:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 11:50:01 +0000 (GMT)
Subject: Re: [PATCH v5 0/2] Add support for ECDSA-signed kernel modules
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210602143537.545132-1-stefanb@linux.ibm.com>
 <20210603064738.pwfq3n7erzmncdmw@kernel.org>
 <8b79651b-1fe4-48c0-3498-529344ac6243@linux.ibm.com>
 <20210609124412.engcrbo3fezuzyoq@kernel.org>
 <f22e7ae1-8779-e995-091c-8a899fd7fd76@linux.ibm.com>
 <20210610090323.f7b47xqxbkwnm5cx@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <66d4a4be-c01c-7f33-9a7f-20cfdb5dcf96@linux.ibm.com>
Date:   Thu, 10 Jun 2021 07:50:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610090323.f7b47xqxbkwnm5cx@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dlR1wW0VT6VLBzpDlzMqUeHn6uKE9cdf
X-Proofpoint-ORIG-GUID: FL6cxQpNyhmm27US8oOx8axdF_GmBkMr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100072
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/10/21 5:03 AM, Jarkko Sakkinen wrote:
> On Wed, Jun 09, 2021 at 09:58:29AM -0400, Stefan Berger wrote:
>> On 6/9/21 8:44 AM, Jarkko Sakkinen wrote:
>>> On Thu, Jun 03, 2021 at 08:32:59AM -0400, Stefan Berger wrote:
>>>> On 6/3/21 2:47 AM, Jarkko Sakkinen wrote:
>>>>>> -- 
>>>>>> 2.29.2
>>>>>>
>>>>>>
>>>>> Please instead send a fix.
>>>> We have a Fixes tag in 1/2, so we want this to propagate to older kernels
>>>> and need the fix in 1/2 for that reason.
>>>>
>>>>      Stefan
>>> So please do an additional fix and send it.
>> 1/2 is supposed to propagate to older kernels and needs to change as posted
>> here in v5 (assuming that this does indeed fix what the build bot was
>> complaining about). 2/2 also changes. A fix on top of v4 would fix 2/2 but
>> won't apply cleanly to 1/2 as cannot easily propagate to older kernels. Is
>> that what we want? Why can you not remove v4 from your queue and replace it
>> with v5?
>>
>>     Stefan
> What you can do is to send fix or fixes with appropriate fixes tags and
> I can then squash them for appropriate patches. That's less work for me.


Once you squash a fix on top of existing 1/2 , existing 2/2 will not 
apply anymore. I am not sure what to send you. I think it would take 
less time to remove the existing 2 patches and replace them with v5.

    Stefan


