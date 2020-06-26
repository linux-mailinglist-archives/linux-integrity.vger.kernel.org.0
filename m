Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE920B158
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgFZM0W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 08:26:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728256AbgFZM0V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 08:26:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QC3TfG027744;
        Fri, 26 Jun 2020 08:26:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vws9haaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 08:26:00 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05QC3iHT029094;
        Fri, 26 Jun 2020 08:26:00 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vws9haa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 08:25:59 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05QCKN3I020912;
        Fri, 26 Jun 2020 12:25:58 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 31uurykuac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 12:25:58 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05QCPw0L51904800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 12:25:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4202C112061;
        Fri, 26 Jun 2020 12:25:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2B02112065;
        Fri, 26 Jun 2020 12:25:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Jun 2020 12:25:57 +0000 (GMT)
Subject: Re: Enabling interrupts in QEMU TPM TIS
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
 <20200625172802.GS6578@ziepe.ca>
 <0a524093-e744-e266-6087-ddc17b5c598c@linux.ibm.com>
 <5b3267b7-57d5-badf-6664-9d47bc9909e7@linux.ibm.com>
 <20200625231934.GU6578@ziepe.ca>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <a2e38eea-a137-ffea-ecf1-98f1e3ba1036@linux.ibm.com>
Date:   Fri, 26 Jun 2020 08:25:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200625231934.GU6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_06:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=816
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 cotscore=-2147483648 spamscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260085
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/25/20 7:19 PM, Jason Gunthorpe wrote:
> On Thu, Jun 25, 2020 at 06:48:09PM -0400, Stefan Berger wrote:
>> On 6/25/20 5:26 PM, Stefan Berger wrote:
>>> On 6/25/20 1:28 PM, Jason Gunthorpe wrote:
>>>> On Thu, Jun 25, 2020 at 10:56:43AM -0400, Stefan Berger wrote:
>>>>> Hello!
>>>>>
>>>>>    I want to enable IRQs now in QEMU's TPM TIS device model and I
>>>>> need to work
>>>>> with the following patch to Linux TIS. I am wondering whether
>>>>> the changes
>>>>> there look reasonable to you? Windows works with the QEMU modifications
>>>>> as-is, so maybe it's a bug in the TIS code (which I had not run into
>>>>> before).
>>>>>
>>>>>
>>>>> The point of the loop I need to introduce in the interrupt
>>>>> handler is that
>>>>> while the interrupt handler is running another interrupt may
>>>>> occur/be posted
>>>>> that then does NOT cause the interrupt handler to be invoked again but
>>>>> causes a stall, unless the loop is there.
>>>> That seems like a qemu bug, TPM interrupts are supposed to be level
>>>> interrupts, not edge.
>>>
>>> Following this document here the hardware may choose to support
>>> different types of interrutps:
>>>
>>> https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p04_r0p37_pub-1.pdf
>>>
>>>
>>> Table 23. Edge falling or rising, level low or level high.
>>>
>>> So with different steps in the driver causing different types of
>>> interrupts, we may get into such situations where we process some
>>> interrupt 'reasons' but then another one gets posted, I guess due to
>>> parallel processing.
>>
>> Another data point: I had the TIS driver working on IRQ 5 (festeoi) without
>> the introduction of this loop. There are additional bits being set while the
>> interrupt handler is running, but the handler deals with them in the next
>> invocation. On IRQ 13 (edge), it does need the loop since the next interrupt
>> handler invocation is not happening.
> A loop like that is never the correct way to handle edge interrupts.

Right, we can just miss the update of the interrupt flags and miss the 
loop and then afterwards the new flag gets set and we'd stall.


>
> I don't think the tpm driver was ever designed for edge, so most
> likely the structure and order of the hard irq is not correct.

Right. For edge support I think we would need to avoid causing another 
interrupt (like locality change interrupt) before the interrupt handler 
hasn't finished dealing with an existing interrupt. Considering that 
Windows works on IRQ 13 (egde) and Linux driver cannot, I guess this is 
a good reason not to move QEMU TIS to IRQ 13 and try to support 
interrupts via ACPI table declaration.


     Stefan


>
> Jason


