Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF1A2B50
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 02:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfH3ALf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 20:11:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbfH3ALf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 20:11:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7U07Ovq079474;
        Thu, 29 Aug 2019 20:11:33 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upp2dd8jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 20:11:33 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7U0A5tB029665;
        Fri, 30 Aug 2019 00:11:32 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 2ujvv6yf8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 00:11:32 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7U0BVu048169460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 00:11:31 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42CAE13604F;
        Fri, 30 Aug 2019 00:11:31 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB0D0136053;
        Fri, 30 Aug 2019 00:11:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 00:11:28 +0000 (GMT)
Subject: Re: [PATCH] tpm_tis: Fix interrupt probing
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190820122517.2086223-1-stefanb@linux.vnet.ibm.com>
 <20190827131400.qchcwa2act24c47b@linux.intel.com>
 <20190827151915.hb4xwr2vik2i5ryb@linux.intel.com>
 <797ff54e-dceb-21d2-dd74-e5244f9c6dfd@linux.ibm.com>
 <20190829132021.6vfc535ecb62jokf@linux.intel.com>
 <20190829161057.22l72j55jy3dyib7@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <039601c6-e22a-d113-0eb2-ee2a206f5b73@linux.ibm.com>
Date:   Thu, 29 Aug 2019 20:11:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190829161057.22l72j55jy3dyib7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=566 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290242
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/29/19 12:10 PM, Jarkko Sakkinen wrote:
> On Thu, Aug 29, 2019 at 04:20:21PM +0300, Jarkko Sakkinen wrote:
>> On Tue, Aug 27, 2019 at 03:34:36PM -0400, Stefan Berger wrote:
>>> On 8/27/19 11:19 AM, Jarkko Sakkinen wrote:
>>>> On Tue, Aug 27, 2019 at 04:14:00PM +0300, Jarkko Sakkinen wrote:
>>>>> On Tue, Aug 20, 2019 at 08:25:17AM -0400, Stefan Berger wrote:
>>>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>
>>>>>> The interrupt probing of the TPM TIS was broken since we are trying to
>>>>>> run it without an active locality and without the TPM_CHIP_FLAG_IRQ set.
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> Need these:
>>>>>
>>>>> Cc: linux-stable@vger.kernel.org
>>>>> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
>>>>>
>>>>> Thank you. I'll apply this to my tree.
>>>>>
>>>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> The commit went in the following form:
>>>>
>>>> http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/9b558deab2c5d7dc23d5f7a4064892ede482ad32
>>> I saw you dropped the stetting of the IRQ flag - I needed it, otherwise it
>>> wouldn't execute certain code paths.
>> I explained why I removed that part. There was no any reasoning for
>> it. Also, it cannot be in the same commit if it fixes a diffent
>> issue.
> AFAIK they go with different fixes-tags.

I sent a separate patch for this. It looks like this bug goes back to 
when the TPM_CHIP_FLAG_IRQ was introduced in March 2019?!

    Stefan


