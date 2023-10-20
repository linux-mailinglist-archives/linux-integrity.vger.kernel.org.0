Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CF7D17FE
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 23:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjJTVYN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 17:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjJTVYN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 17:24:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419CCD6D
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 14:24:03 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLEbwT015717;
        Fri, 20 Oct 2023 21:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CUokmqxKU3PfBeOPzyC3AKM7Mqq6SelGUPR1Cbl0Rmg=;
 b=qOQbfSHfYUHF5umyy21DCGrYc38aHtAEhCRukiE2Fh810nqRCfetAJh5OWnPYDdb5L4D
 E6QlncYtETn8GEIy8nYora/apjqtJAN1jIa9rY5Bt97/bmClQasSkszAg06jptNk4Clv
 DE/rvuLyEpJPeUARoNwr7GfiqfAe3e/RqdkCEPLTIT7Aiw+/XkTgQDOZBQ0MUzGqChc1
 40cHVpA5tFh3uXnYj625+/fc8rU7cA+uDWPQuQzBk/FnUnNnjupyXWXQcH71BxtoeYuH
 VqxhsBo1JyebUxBEBYK1jFyKQF7ePBR3yxXco8WCJV8TyEgnD836p3br2VQscvh2Fngh FA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tv19q8797-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 21:21:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39KKFqST032119;
        Fri, 20 Oct 2023 21:16:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc35qd51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 21:16:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39KLGoEV9896614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 21:16:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 134CA5804B;
        Fri, 20 Oct 2023 21:16:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC25458055;
        Fri, 20 Oct 2023 21:16:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 20 Oct 2023 21:16:48 +0000 (GMT)
Message-ID: <15a12e79-2e90-28f7-ffa3-ff470c673099@linux.ibm.com>
Date:   Fri, 20 Oct 2023 17:16:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/7] ima: make the memory for events between kexec load
 and exec configurable
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-7-tusharsu@linux.microsoft.com>
 <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
 <55585644-2170-d462-4d64-ca3a963b30fe@linux.microsoft.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <55585644-2170-d462-4d64-ca3a963b30fe@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qgBnFOqmL16kPZCF_vL_q8KHnykf5QUL
X-Proofpoint-GUID: qgBnFOqmL16kPZCF_vL_q8KHnykf5QUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=968 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200180
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/20/23 16:39, Tushar Sugandhi wrote:

>
>
> On 10/12/23 17:27, Stefan Berger wrote:
>>
>> On 10/5/23 14:26, Tushar Sugandhi wrote:
>>> IMA currently allocates half a PAGE_SIZE for the extra events that 
>>> would
>>> be measured between kexec 'load' and 'execute'.  Depending on the IMA
>>> policy and the system state, that memory may not be sufficient to hold
>>> the extra IMA events measured after kexec 'load'.  The memory
>>> requirements vary from system to system and they should be 
>>> configurable.
>>>
>>> Define a Kconfig option, IMA_KEXEC_EXTRA_PAGES, to configure the number
>>> of extra pages to be allocated for IMA measurements added in the window
>>> from kexec 'load' to kexec 'execute'.
>>>
>>> Update ima_add_kexec_buffer() function to allocate memory based on the
>>> Kconfig option value, rather than the currently hardcoded one.
>>>
>>> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
>>> ---
>>>   security/integrity/ima/Kconfig     |  9 +++++++++
>>>   security/integrity/ima/ima_kexec.c | 13 ++++++++-----
>>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/Kconfig 
>>> b/security/integrity/ima/Kconfig
>>> index 60a511c6b583..1b55cd2bcb36 100644
>>> --- a/security/integrity/ima/Kconfig
>>> +++ b/security/integrity/ima/Kconfig
>>> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>>>       default n
>>>       help
>>>          This option disables htable to allow measurement of 
>>> duplicate records.
>>> +
>>> +config IMA_KEXEC_EXTRA_PAGES
>>> +    int
>>> +    depends on IMA && IMA_KEXEC
>>> +    default 16
>>> +    help
>>> +      IMA_KEXEC_EXTRA_PAGES determines the number of extra
>>> +      pages to be allocated for IMA measurements added in the
>>> +      window from kexec 'load' to kexec 'execute'.
>>
>>
>> On ppc64 a page is 64kb. I would ask for additional kb here.
>>
>>
> Not sure I understand.  Do you mean I should make the default value of
> the config IMA_KEXEC_EXTRA_PAGES 64 or something?


No, what I mean is you should ask the user for how many extra kilobytes 
(kb) to allocate - not ask for pages.


    Stefan

>
> In code, I multiply the config value with PAGE_SIZE.  So more memory
> would be allocated on ppc64 for given default config value. Could you
> please clarify what change you are suggesting here?
>
>
> +        binary_runtime_size = ima_get_binary_runtime_size() +
> +                               sizeof(struct ima_kexec_hdr) +
> +                               (CONFIG_IMA_KEXEC_EXTRA_PAGES *
> PAGE_SIZE);
>
> ~Tushar
>
>>> diff --git a/security/integrity/ima/ima_kexec.c 
>>> b/security/integrity/ima/ima_kexec.c
>>> index 13fbbb90319b..6cd5f46a7208 100644
>>> --- a/security/integrity/ima/ima_kexec.c
>>> +++ b/security/integrity/ima/ima_kexec.c
>>> @@ -150,15 +150,18 @@ void ima_add_kexec_buffer(struct kimage *image)
>>>       int ret;
>>>       /*
>>> -     * Reserve an extra half page of memory for additional 
>>> measurements
>>> -     * added during the kexec load.
>>> +     * Reserve extra memory for measurements added in the window from
>>> +     * kexec 'load' to kexec 'execute'.
>>>        */
>>> -    binary_runtime_size = ima_get_binary_runtime_size();
>>> +    binary_runtime_size = ima_get_binary_runtime_size() +
>>> +                  sizeof(struct ima_kexec_hdr) +
>>> +                  (CONFIG_IMA_KEXEC_EXTRA_PAGES * PAGE_SIZE);
>>> +
>>>       if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>>>           kexec_segment_size = ULONG_MAX;
>>>       else
>>> -        kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
>>> -                       PAGE_SIZE / 2, PAGE_SIZE);
>>> +        kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
>>> +
>>>       if ((kexec_segment_size == ULONG_MAX) ||
>>>           ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 
>>> 2)) {
>>>           pr_err("Binary measurement list too large.\n");
