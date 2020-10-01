Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4961C280657
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgJASPg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 14:15:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729493AbgJASPg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 14:15:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091IBj9i124795;
        Thu, 1 Oct 2020 14:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4CuQZr+68iAVWcloaoBF6n2n8IoW7VPhY5p98GFbbuE=;
 b=ESidk9iI0jX4IGvXzTz7GEWK49OyHkXyAXAHfBRdH898OtJFi927rqZRCNDGmiGfrxeS
 Z/FfTr5vhu3UjeS9nhGRd04zA2L0PlA1nkQiiMAKEBl/av6L4OSinRVpy1B27DANzQeq
 PBY9torNbWSJkgqHnX4mbcoE/EFDxTslKAQgwTwfzBC4Y8Xz/WM/B/JSzaKRaF1X38XQ
 /4YqFNI0rOzHP+z+YHxzgUby+NkewiS2/8nO7p9oiKgAO1u9VY7u2GZC/+YjHmvGW6JL
 Xomn1YeoE92kx3EH1KyjCDEF6XTTlAiJXKHftIm3mBJ51pYTqwhk18KhfB2tPEG1OZdd 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33wm6182nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 14:15:18 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 091ICjjE127283;
        Thu, 1 Oct 2020 14:15:17 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33wm6182mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 14:15:17 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 091I2ObT016596;
        Thu, 1 Oct 2020 18:15:17 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 33sw99rhnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 18:15:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 091IFGqg55181720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Oct 2020 18:15:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 712CEAE063;
        Thu,  1 Oct 2020 18:15:16 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB98AE05C;
        Thu,  1 Oct 2020 18:15:14 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.211.120.215])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Oct 2020 18:15:14 +0000 (GMT)
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Hao Wu <hao.wu@rubrik.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
References: <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
 <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
 <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
 <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
 <20200930021637.GF808399@linux.intel.com>
 <a97706be196e2e02ca815b3011d3731684905737.camel@HansenPartnership.com>
 <20200930153715.GC52739@linux.intel.com>
 <95aafaa1e3037cb7b99ae0e76c02a419d366a407.camel@HansenPartnership.com>
 <20200930210956.GC65339@linux.intel.com>
 <6e7b54c268d25a86f8f969bcc01729eaadef6530.camel@HansenPartnership.com>
 <20201001015051.GA5971@linux.intel.com>
 <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <19de5527-2d56-6a07-3ce7-ba216b208090@linux.vnet.ibm.com>
Date:   Thu, 1 Oct 2020 14:15:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_06:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010147
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/1/20 12:53 AM, James Bottomley wrote:
> On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
>> On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley wrote:
>>> On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
>>>> On Wed, Sep 30, 2020 at 01:48:15PM -0700, James Bottomley wrote:
>>>>> On Wed, 2020-09-30 at 18:37 +0300, Jarkko Sakkinen wrote:
>>>>>> On Wed, Sep 30, 2020 at 07:54:58AM -0700, James Bottomley
>>>>>> wrote:
>>>>>>> On Wed, 2020-09-30 at 05:16 +0300, Jarkko Sakkinen wrote:
>>>>>>>> On Mon, Sep 28, 2020 at 03:11:39PM -0700, James Bottomley
>>>>>>>> wrote:
>>>>>>>>> On Sun, 2020-09-27 at 22:59 -0700, Hao Wu wrote:
>>>>>>>>> [...]
>>>>>>>>>>> However, there is another possibility: it's
>>>>>>>>>>> something to do with the byte read; I notice you
>>>>>>>>>>> don't require the same slowdown for the burst count
>>>>>>>>>>> read, which actually reads the status register and
>>>>>>>>>>> burst count as a read32.  If that really is the
>>>>>>>>>>> case, for the atmel would substituting a read32 and
>>>>>>>>>>> just throwing the upper bytes away in
>>>>>>>>>>> tpm_tis_status() allow us to keep the current
>>>>>>>>>>> timings?  I can actually try doing this and see if
>>>>>>>>>>> it fixes my nuvoton.
>>>>>>>>>> If would be helpful if you can find the solution
>>>>>>>>>> without reducing performance. I think it is a
>>>>>>>>>> separate problem to address though. Maybe not worth
>>>>>>>>>> to mix them in the same fix.
>>>>>>>>> Well, if it works, no other fix is needed.
>>>>>>>>>
>>>>>>>>> This is what I'm currently trying out on my nuvoton
>>>>>>>>> with the timings reverted to being those in the vanilla
>>>>>>>>> kernel.  So far it hasn't crashed, but I haven't run it
>>>>>>>>> for long enough to be sure yet.
>>>>>>>>>
>>>>>>>>> James
>>>>>>>> OK, so the bus does not like one byte reads but prefers
>>>>>>>> full (32-bit) word reads? I.e. what's the context?
>>>>>>> It's not supported by anything in the spec just empirical
>>>>>>> observation.  However, the spec says the status register is
>>>>>>> 24 bits: the upper 16 being the burst count.  When we read
>>>>>>> the whole status register, including the burst count, we do
>>>>>>> a read32. I observed that the elongated timing was only
>>>>>>> added for the read8 code not the read32 which supports the
>>>>>>> theory that the former causes the Atmel to crash but the
>>>>>>> latter doesn't.  Of course it's always possible that
>>>>>>> probabilistically the Atmel is going to crash on the burst
>>>>>>> count read, but that's exercised far less than the status
>>>>>>> only read.
>>>>>> This paragraph is good enough explanation for me. Can you
>>>>>> include it to the final commit as soon as we hear how your
>>>>>> fix works for Hao?
>>>>> Sure.  I'm afraid I have to report that it didn't work for
>>>>> me.  My Nuvoton is definitely annoyed by the frequency of the
>>>>> prodding rather than the register width.
>>>> Sorry, this might have been stated at some point but what type of
>>>> bus is it connected with?
>>> It's hard to tell: this is my Dell Laptop, but I'd have to bet LPC.
>>>
>>>> Does it help in any way to tune the frequency?
>>> specific memory mapped address and all the conversion to the LPC
>>> back end is done by memory read/write operations.  The TPM itself
>>> has a clock but doesn't give the TIS interface software control.
>> Some TPM's use tpm_tis_spi instead of MMIO.
> Yes, but I'm fairly certain mine's not SPI.
>
>>>> I also wonder if we could adjust the frequency dynamically. I.e.
>>>> start with optimistic value and lower it until finding the sweet
>>>> spot.
>>> The problem is the way this crashes: the TPM seems to be
>>> unrecoverable. If it were recoverable without a hard reset of the
>>> entire machine, we could certainly play around with it.  I can try
>>> alternative mechanisms to see if anything's viable, but to all
>>> intents and purposes, it looks like my TPM simply stops responding
>>> to the TIS interface.
>> A quickly scraped idea probably with some holes in it but I was
>> thinking something like
>>
>> 1. Initially set slow value for latency, this could be the original
>> 15 ms.
>> 2. Use this to read TPM_PT_VENDOR_STRING_*.
>> 3. Lookup based vendor string from a fixup table a latency that works
>>     (the fallback latency could be the existing latency).
> Well, yes, that was sort of what I was thinking of doing for the Atmel
> ... except I was thinking of using the TIS VID (16 byte assigned vendor
> ID) which means we can get the information to set the timeout before we
> have to do any TPM operations.


I wonder if the timeout issue exists for all TPM commands for the same 
manufacturer.  For example, does the ATMEL TPM also crash when 
extending  PCRs ?

In addition to defining a per TPM vendor based lookup table for timeout, 
would it be a good idea to also define a Kconfig/boot param option to 
allow timeout setting.  This will enable to set the timeout based on the 
specific use.

I was also thinking how will we decide the lookup table values for each 
vendor ?

Thanks & Regards,

       - Nayna

