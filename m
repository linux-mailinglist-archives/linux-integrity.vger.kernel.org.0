Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7303154E5
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhBIRU5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 12:20:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49958 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhBIRUx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 12:20:53 -0500
Received: from [192.168.1.13] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7A6AA20B6C40;
        Tue,  9 Feb 2021 09:20:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A6AA20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612891211;
        bh=L7qdjo9CczKS9N1PJ7zMoEuk5ZrMWDvmB7BRDv8ep7I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XzNhWQLRNLpHmvN6sNEOkBWnRW4FbkPuRP12uyrEirtH39UGDnN2/qhRZ7m4d976K
         053OWJzTHw7HJ9OfbakBp4OvQMuhdI3Ip/HImuh9biNsV2ysVxvdiGf0e53fg9EWsC
         VkqpzErlGh/bk7sSZ1+xJfVz0xVGRj4IC7YCjIUE=
Subject: Re: [RFC] Persist ima logs to disk
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        janne.karhunen@gmail.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
 <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
 <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
 <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
 <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
 <734adc26-0050-ce8f-4c8c-c8a907b569a6@linux.microsoft.com>
 <8c78437d0e9a4968996b834030661b6f567f87eb.camel@linux.ibm.com>
 <fc9a5d48-dc29-0d5d-55dd-bacac346da10@linux.microsoft.com>
 <3f76d250-6aa7-65c1-b903-5bc82f6f8845@linux.microsoft.com>
 <CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com>
 <3f1571d5b9f2fbb6a8ff9a5fad75b54e2b597904.camel@linux.ibm.com>
 <169af4d7-9f1a-69c9-44a8-9d30deab80cb@linux.microsoft.com>
 <2cab86154362ac145d3749d05a06a2d4340264f6.camel@linux.ibm.com>
 <CAOQ4uxiBAGKco1BKgyLOMY54r_Ck2jnvz8RCFODD-V87CGqLEw@mail.gmail.com>
 <854f65b13f3f742153c862d68823d4d69ddc1bcd.camel@linux.ibm.com>
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
Message-ID: <41e4222e-8daa-ff80-df6d-e546772faf59@linux.microsoft.com>
Date:   Tue, 9 Feb 2021 09:20:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <854f65b13f3f742153c862d68823d4d69ddc1bcd.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/3/2021 10:45 AM, Mimi Zohar wrote:
> On Wed, 2021-02-03 at 09:24 +0200, Amir Goldstein wrote:
>> On Wed, Feb 3, 2021 at 3:02 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>> On Tue, 2021-02-02 at 10:14 -0800, Raphael Gianotti wrote:
>>>> On 2/2/2021 5:07 AM, Mimi Zohar wrote:
>>>>> On Tue, 2021-02-02 at 07:54 +0200, Amir Goldstein wrote:
>>>>>> On Tue, Feb 2, 2021 at 12:53 AM Raphael Gianotti
>>>>>> <raphgi@linux.microsoft.com> wrote:
>>>>>>> On 1/8/2021 9:58 AM, Raphael Gianotti wrote:
>>>>>>>> On 1/8/2021 4:38 AM, Mimi Zohar wrote:
>>>>>>>>> On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
>>>>>>>>>>>>>> But this doesn't address where the offloaded measurement list
>>>>>>>>>>>>>> will be stored, how long the list will be retained, nor who
>>>>>>>>>>>>>> guarantees the integrity of the offloaded list.  In addition,
>>>>>>>>>>>>>> different form factors will have different requirements.
>>>>>>>>>> For how long the list would be retained, or in the case of a log
>>>>>>>>>> segments, it
>>>>>>>>>> might make sense to have that be an admin decision, something that
>>>>>>>>>> can be
>>>>>>>>>> configured to satisfy the needs of a specific system, as mentioned
>>>>>>>>>> below by
>>>>>>>>>> James, does that seem correct?
>>>>>>>>> For the discussion on exporting and truncating the IMA measurement
>>>>>>>>> list, refer to:
>>>>>>>>> https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Given the possibility of keeping the logs around for an indefinite
>>>>>>>>>> amount of
>>>>>>>>>> time, would using an expansion of the method present in this RFC be
>>>>>>>>>> more
>>>>>>>>>> appropriate than going down the vfs_tmpfile route? Forgive my lack
>>>>>>>>>> on expertise
>>>>>>>>>> on mm, but would the vfs_tmpfile approach work for keeping several
>>>>>>>>>> log segments
>>>>>>>>>> across multiple kexecs?
>>>>>>>>> With the "vfs_tmpfile" mechanism, breaking up and saving the log in
>>>>>>>>> segments isn't needed.  The existing mechanism for carrying the
>>>>>>>>> measurement list across kexec would still be used.  Currently, if the
>>>>>>>>> kernel cannot allocate the memory needed for carrying the measurement
>>>>>>>>> across kexec, it simply emits an error message, but continues with the
>>>>>>>>> kexec.
>>>>>>>> In this change I had introduced "exporting" the log to disk when the size
>>>>>>>> of the measurement list was too large. Given part of the motivation
>>>>>>>> behind
>>>>>>>> moving the measurement list is the possibility of it growing too large
>>>>>>>> and taking up too much of the kernel memory, that case would likely lead
>>>>>>>> to kexec not being able to carry over the logs. Do you believe it's
>>>>>>>> better
>>>>>>>> to use the "vfs_tmpfile" mechanism for moving the logs to disk and worry
>>>>>>>> about potential issues with kexec not being able to carry over the logs
>>>>>>>> separately, given the "vfs_tempfile" approach seems to be preferred and
>>>>>>>> also simplifies worries regarding truncating the logs?
>>>>>>> After a chat with Mimi I went ahead and did some investigative
>>>>>>> work in the vfs_tmpfile approach suggested, and I wanted to
>>>>>>> restart this thread with some thoughts/questions that came up
>>>>>>> from that.
>>>>>>> For the work I did I simply created a tmp file during ima's
>>>>>>> initialization and then tried to use vm_mmap to map it to memory,
>>>>>>> with the goal of using that memory mapping to generate return
>>>>>>> pointers to the code that writes the measurement entries to memory.
>>>>>> I don't understand why you would want to do that. I might have misunderstood
>>>>>> the requirements, but this was not how I meant for tmpfile to be used.
>>>>>>
>>>>>> Mimi explained to me that currently the IMA measurement list is entirely in
>>>>>> memory and that you are looking for a way to dump it into a file in order to
>>>>>> free up memory.
>>>>>>
>>>>>> What I suggested is this:
>>>>>>
>>>>>> - User opens an O_TMPFILE and passes fd to IMA to start export
>>>>>> - IMA starts writing (exporting) records to that file using *kernel* write API
>>>>>> - Every record written to the file is removed from the in-memory list
>>>>>> - While list is being exported, IMA keeps in-memory count of exported entries
>>>>>> - In ima_measurements_start, if export file exists, start iterator
>>>>>> starts reading
>>>>>>     records from the file
>>>>>> - In ima_measurements_next(), when next iterator reaches the export count,
>>>>>>     it switches over to iterate in-memory list
>>>>>>
>>>>>> This process can:
>>>>>> 1. Continue forever without maintaining any in-memory list
>>>>>> 2. Work in the background to periodically flush list to file
>>>>>> 3. Controlled by explicit user commands
>>>>>> 4. All of the above
>>>>>>
>>>>>> Is that understood? Did I understand the requirements correctly?
>>>> Thanks for the clarification Amir, I never actually saw your initial mails,
>>>> I apologize for the confusion, the use of mmap was something the original
>>>> author of the export ima logs to disk mentioned had been suggested, which
>>>> is why I went down that route.
>>>> Given the actual suggestion you originally had given, I believe the coding
>>>> of it is somewhat to the code I sent in the RFC in terms of approach (if we
>>>> were to have it do periodic flushes, for example). With the addition of
>>>> reads to the log starting with the file as the oldest logs will be there.
>>>> I believe the only difference there is whether the list is kept in a tmp
>>>> file or not, so with the tmp file approach it would be just to keep the
>>>> list out of memory (either partially or permanently), where with a permanent
>>>> file, the list would still be available after a cold boot for instance.
>>> With Amir's suggestion, userspace still accesses the entire measurement
>>> list via the existing securityfs interface.  Only the kernel should be
>>> able to append or access the file.
>>>
>> This user API is not an important part of the suggestion:
>>
>> - User opens an O_TMPFILE and passes fd to IMA to start export
>>
>> It is just how I understood the API should be.
>> Kernel could open the O_TMPFILE or named file for that matter just as well.
>> If the kernel opens an O_TMPFILE, userspace has no standard way to access
>> that file. There are, as always, ways for privileged users to learn about that
>> tmpfile and open it with open_by_handle_at().
>>
>> IMA is an LSM, so the best way to block unauthorized access to that file
>> would be via LSM hooks. IMA keeps a reference to that file, so it can
>> identify access to that file from userspace.
> Having the kernel open a O_TMPFILE and use/define additional LSM hooks,
> as needed, to limit access to the file sounds good.
>
> In terms of the rest of the userspace interface, I would probably
> define a new IMA securityfs file to control the frequency that the
> measurements are written to the file (e.g. 0 == never, 1 == enabled
> with default frequency, anything else frequency).
>
> thanks,
>
> Mimi

Regarding the comparison between the original approach in the RFC,
using permanent files, and the TMP file approach (with me having the
correct suggestion in mind now), I believe there are still some
benefits from having a file be permanent:
	- It provides a way to always keep the logs across the kexec
	  boundary, regardless of how much they've grown in size,
	  as the file will persist through it, where as with a tmp
	  file, the ability to persist the logs through kexec would
	  still be subject to the same memory restrictions it currently
	  is.
	- It provides a way for an attestation service to have a
	  history of measurements performed during previous cold boot
	  cycles.

The above, however, does introduce the requirements of persisting
PCR information that would allow verifying historical logs, and
that information would have to be verifiable in some way (for instance,
by having the TPM add a signature alongside the logs).

I think both solutions have their merits, and the TMP file approach
seems much simpler overall. What I have in mind is perhaps having this
be configurable, where a file can be defined to hold the logs, but
the persisting of logs to disk can still be turned on without that
file being configures, leading to a TMP file being used. That would
leave it up to the admin to decide whether a permanent file is needed.

The above is in addition to any other configurations that may be
applicable, such as one for the frequency as suggested by Mimi.

Thanks,
Raph

