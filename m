Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE174F852
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 21:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGKTTZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 15:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGKTTY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 15:19:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755C610C2
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 12:19:23 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BJGxnu006315;
        Tue, 11 Jul 2023 19:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oXg14WD/aQZ2LgZSpBtJvS+fxAZFY2YkYYU24ba+58c=;
 b=BtpYL68CASY9S7794WGK2UFqOCi9Gj1YCUbQkFismNy8eGHs2SkLL5pgJIzehRtQBoPA
 sibxoiLxa43Ro1wjQvucc9x24xRdo6V9cL3lp7/c6xQU7T8USoeSBio/OsgCH43cA7qL
 BQ3nL6UTY2z9AxohLXCBYGFiYhz5u/knBsmZoR4NhOKNrvaXgV9gzkIWcVr7TOgRQTq+
 xbf2rNtv3QdJZBikBD6EtQUq446olTukxdVbEjJXncTWPvBdu2xH3QRlByggv0ltCbOd
 zmwCuX1uUXoPP7VNYz0w49pRqAB3Y0lq3J0chLkxwpMufup7Df0o5SkRHrNcsZgFNYVN Bw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rscx18ep7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 19:19:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36BEFhLu011267;
        Tue, 11 Jul 2023 19:19:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rqk4mgdq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 19:19:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BJJ1Ei59769300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 19:19:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D3335805F;
        Tue, 11 Jul 2023 19:19:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADD7558051;
        Tue, 11 Jul 2023 19:19:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jul 2023 19:19:00 +0000 (GMT)
Message-ID: <4ccfe980-3c71-fa06-59e4-56c85d798224@linux.ibm.com>
Date:   Tue, 11 Jul 2023 15:19:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/10] kexec: implement functions to map and unmap segment
 to kimage
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-6-tusharsu@linux.microsoft.com>
 <ab4c5f9a-5b70-5d45-80d9-2ec48ea49913@linux.ibm.com>
 <7f38366e-744e-78c8-cf05-acfeb59afd2e@linux.microsoft.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <7f38366e-744e-78c8-cf05-acfeb59afd2e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wmAJvMX1CPk8iauTbt6u4lwrYTXMyusH
X-Proofpoint-ORIG-GUID: wmAJvMX1CPk8iauTbt6u4lwrYTXMyusH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=921 clxscore=1011 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/11/23 14:41, Tushar Sugandhi wrote:
> Adding Eric to cc.
> 
> On 7/7/23 05:28, Stefan Berger wrote:
>>
>>
>> On 7/3/23 17:57, Tushar Sugandhi wrote:
>>> Currently, there's no mechanism to map and unmap segments to the kimage
>>> structure.  This functionality is needed when dealing with memory segments
>>> in the context of a kexec operation.
>>>
>>> The patch adds two new functions: kimage_map_segment() and
>>> kimage_unmap_segment().
>>>
>>> Implement kimage_map_segment() which takes a kimage pointer, an address,
>>> and a size.  Ensures that the entire segment is being mapped by comparing
>>> the given address and size to each segment in the kimage's segment array.
>>> Collect the source pages that correspond to the given address range,
>>> allocate an array of pointers to these pages, and map them to a contiguous
>>> range of virtual addresses.  If the mapping operation is successful, the
>>> function returns the start of this range.  Otherwise, it frees the page
>>> pointer array and returns NULL.
>>>
>>> Implement kimage_unmap_segment() that takes a pointer to a segment buffer
>>> and unmaps it using vunmap().
>>>
>>> Finally, move for_each_kimage_entry() macro to kexec.h.
>>>
>>> Note: Use kimage_map_segment() and kimage_unmap_segment() carefully to
>>> avoid memory leaks and ensure that all mapped segments are properly
>>> unmapped when they're no longer needed.
>>>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>
>>> +
>>> +    i = 0;
>>> +    for_each_kimage_entry(image, ptr, entry) {
>>> +        if (entry & IND_DESTINATION)
>>> +            dest_page_addr = entry & PAGE_MASK;
>>> +        else if (entry & IND_SOURCE) {
>>> +            if (dest_page_addr >= addr && dest_page_addr < eaddr) {
>>> +                src_page_addr = entry & PAGE_MASK;
>>> +                src_pages[i++] = phys_to_page(src_page_addr);
>>
>> Since phys_to_page is not defined on many/most architectures I change it for ppc64 and have successfully used the following:
>>
>> +                               src_pages[i++] = virt_to_page(__va(src_page_addr))
>>
>>
>> After several kexecs the following check still works:
>>
>> # evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/binary_runtime_measurements
>> Matched per TPM bank calculated digest(s).
>>
>>
>>    Stefan
> Thank you so much Stefan for reviewing this series, and catching this
> issue.  Are you suggesting I should use virt_to_page on all architectures
> unconditionally, or use it only when phys_to_page is not available?

I would try to used it on all architectures.

    Stefan

> 
> ~Tushar
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
