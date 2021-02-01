Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ABC30B2F8
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 23:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBAWyI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 17:54:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:37092 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBAWyG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 17:54:06 -0500
Received: from [192.168.1.13] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4196720B7192;
        Mon,  1 Feb 2021 14:53:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4196720B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612220005;
        bh=yqV50G3gCJQ9KJx6tX9IRaUPmw+ZPrONG7hXWnY87DA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=NcWJFodY+8AxTqP4dskz8r+IAlfzMNyRAQ1tm7lSnbK6lTqm5tWn3BL8fUFupjkUe
         Ho2Vvn5a9Cev4w/hywzKQhuZzQh9a1QWINY8gOPRPkhPldiLlIgvXaKjubvCKlmcqc
         x4EPeXMVir2ioZSFQehkAm7f6z3tO+GRficR111E=
Subject: Re: [RFC] Persist ima logs to disk
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
 <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
 <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
 <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
 <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
 <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
 <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
 <734adc26-0050-ce8f-4c8c-c8a907b569a6@linux.microsoft.com>
 <8c78437d0e9a4968996b834030661b6f567f87eb.camel@linux.ibm.com>
 <fc9a5d48-dc29-0d5d-55dd-bacac346da10@linux.microsoft.com>
Message-ID: <3f76d250-6aa7-65c1-b903-5bc82f6f8845@linux.microsoft.com>
Date:   Mon, 1 Feb 2021 14:53:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <fc9a5d48-dc29-0d5d-55dd-bacac346da10@linux.microsoft.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/8/2021 9:58 AM, Raphael Gianotti wrote:
>
> On 1/8/2021 4:38 AM, Mimi Zohar wrote:
>> On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
>>>>>>> But this doesn't address where the offloaded measurement list
>>>>>>> will be stored, how long the list will be retained, nor who
>>>>>>> guarantees the integrity of the offloaded list.  In addition,
>>>>>>> different form factors will have different requirements.
>>> For how long the list would be retained, or in the case of a log 
>>> segments, it
>>> might make sense to have that be an admin decision, something that 
>>> can be
>>> configured to satisfy the needs of a specific system, as mentioned 
>>> below by
>>> James, does that seem correct?
>> For the discussion on exporting and truncating the IMA measurement
>> list, refer to:
>> https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/ 
>>
>>
>>> Given the possibility of keeping the logs around for an indefinite 
>>> amount of
>>> time, would using an expansion of the method present in this RFC be 
>>> more
>>> appropriate than going down the vfs_tmpfile route? Forgive my lack 
>>> on expertise
>>> on mm, but would the vfs_tmpfile approach work for keeping several 
>>> log segments
>>> across multiple kexecs?
>> With the "vfs_tmpfile" mechanism, breaking up and saving the log in
>> segments isn't needed.  The existing mechanism for carrying the
>> measurement list across kexec would still be used.  Currently, if the
>> kernel cannot allocate the memory needed for carrying the measurement
>> across kexec, it simply emits an error message, but continues with the
>> kexec.
>
> In this change I had introduced "exporting" the log to disk when the size
> of the measurement list was too large. Given part of the motivation 
> behind
> moving the measurement list is the possibility of it growing too large
> and taking up too much of the kernel memory, that case would likely lead
> to kexec not being able to carry over the logs. Do you believe it's 
> better
> to use the "vfs_tmpfile" mechanism for moving the logs to disk and worry
> about potential issues with kexec not being able to carry over the logs
> separately, given the "vfs_tempfile" approach seems to be preferred and
> also simplifies worries regarding truncating the logs?

After a chat with Mimi I went ahead and did some investigative
work in the vfs_tmpfile approach suggested, and I wanted to
restart this thread with some thoughts/questions that came up
from that.
For the work I did I simply created a tmp file during ima's
initialization and then tried to use vm_mmap to map it to memory,
with the goal of using that memory mapping to generate return
pointers to the code that writes the measurement entries to memory.
What I found out is that vm_mmap creates a user space address
mapping, which can't be directly written to/read by kernel code,
am I missing something here ? I looked throughout the code and
read the implementation of vm_mmap and the functions it calls,
but I couldn't figure out if there's a version of this type of
mapping that returns a kernel space address.
Out of curiosity, I also tried (simply to test the approach),
translating the mapped address into a valid kernel address
by using find_vma(),  follow_page() and kmap(). I was able
to get a return value from kmap() that passed an IS_ERR() check,
however I couldn't get that to work properly when trying to
access it to read to/write from it. Again, I feel like the
mapping should be done directly to a valid kernel address,
but I wanted tried this to at least be able to prototype the
overall flow of the change.

Raph

>
>>
>> Mimi
