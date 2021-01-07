Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB52EE963
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 23:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbhAGW6b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 17:58:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50038 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbhAGW6b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 17:58:31 -0500
Received: from [192.168.1.13] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id CB56120B7192;
        Thu,  7 Jan 2021 14:57:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB56120B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610060269;
        bh=yJV32o1HNPGc/gsWC3ZpFC5ufUtEFyFOBB52u3lsOtY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZeidWdsn0pXTL7MmzDJnWjzHRq2nLm5zbSAHXttrNDGAqiF1alXa6bZ4vOTIZia+h
         MbQk3F+1B91TmcEBT3dsdS8j+cSzf46MLqPvv1Fu3BBjqE7WxdabejXNXmmN9ComQF
         ULLQ8zN8cwMQvOaKlF3lIGilbKB8MA7k5YEnvQGE=
Subject: Re: [RFC] Persist ima logs to disk
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, janne.karhunen@gmail.com
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
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
Message-ID: <734adc26-0050-ce8f-4c8c-c8a907b569a6@linux.microsoft.com>
Date:   Thu, 7 Jan 2021 14:57:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/7/2021 1:48 PM, James Bottomley wrote:
> On Thu, 2021-01-07 at 15:51 -0500, Mimi Zohar wrote:
>> On Thu, 2021-01-07 at 12:37 -0800, James Bottomley wrote:
>>> On Thu, 2021-01-07 at 15:02 -0500, Mimi Zohar wrote:
>>>> On Thu, 2021-01-07 at 08:42 -0800, James Bottomley wrote:
> [...]
>>>>> What about having a log entry that's the current PCR
>>>>> value?  Then stretches of the log starting with these entries
>>>>> would be independently verifiable provided you had a way of
>>>>> trusting the PCR value.  It might be possible to get the TPM to
>>>>> add a signed quote as an optional part of the log entry (of
>>>>> course this brings other problems like which key do you use for
>>>>> the signing and how does it get verified) which would provide
>>>>> the trust and would definitively allow you to archive log
>>>>> segments and still make the rest of the log useful.
>>>> The current PCR values are aggregated and stored in the
>>>> boot_aggregate record.  As part of the new boot_aggregate record
>>>> format, the individual PCR values could be included.
>>> I don't think we care about the boot aggregate ... it's just the
>>> initial log entry that ties the boot state to the initial runtime
>>> state.  All we need for the proposed entry is the current value of
>>> the IMA PCR so provided you trust that value it becomes a base on
>>> which the following measurements can build and be trusted.
>> The IMA measurement list may contain multiple PCRs, not just the
>> default IMA PCR.   Each kexec results in an additional boot_aggregate
>> record, but an equivalent record for after truncating the measurement
>> list might help.
> Right, this would specifically be only of the IMA PCR so you can use it
> as a base to begin the hash of the following log segment.  The log can
> still contain other boot aggregate entries, but the assumption is that
> boot aggregate entries in the prior log have already been evaluated.
>
>>>> But this doesn't address where the offloaded measurement list
>>>> will be stored, how long the list will be retained, nor who
>>>> guarantees the integrity of the offloaded list.  In addition,
>>>> different form factors will have different requirements.

For how long the list would be retained, or in the case of a log segments, it
might make sense to have that be an admin decision, something that can be
configured to satisfy the needs of a specific system, as mentioned below by
James, does that seem correct?

Given the possibility of keeping the logs around for an indefinite amount of
time, would using an expansion of the method present in this RFC be more
appropriate than going down the vfs_tmpfile route? Forgive my lack on expertise
on mm, but would the vfs_tmpfile approach work for keeping several log segments
across multiple kexecs?

For how to guarantee the integrity of the offloaded logs, James suggestion
of using TPM for adding a signature to the log entries brings the question
of what key would be used and how it would be verified, I am trying to give
this some thought.

>>> I'm not sure you need any store at all.  The basic idea is that the
>>> log is divided into individually verifiable segments.  For auditing
>>> purposes you could keep all segments, so you have the entire log,
>>> but if you've acted on the prior log entries and you don't have an
>>> audit reason to keep them, you could erase that segment of the log
>>> because you've placed all your trust in the prior log segments into
>>> the PCR entry that forms the base of your current segment.
>>>
>>> Essentially the question devolves to what mechanisms can give you
>>> this trust in the base PCR log entry.
>>
> Not retaining the entire measurement list would limit it's verification
> to a single server/system.
>
> Well, it would limit its verification to just that log segment, yes.
>
> I'm thinking in the cloud there are a couple of potential consumers:
>
>     1. The cloud monitor, which acts on the verified log, such as killing a
>        node for trying to execute an unverified binary or emailing the
>        guest owner.  This type of consumer doesn't need the historical log,
>        they just need to verify the entries they haven't already seen and
>        act on them according to whatever policy they're given.
>     2. The second type of cloud consumer is the audit case where the
>        aggregate hash is used to assure some auditor, some time after the
>        actual events, that the entire runtime of the VM was properly
>        monitored and the auditor wants to see the log  or a segment of it
>        to prove the hash.
>
> Case 1 doesn't need historical storage, case 2 definitely does.  I
> think we should support both use cases particularly in the long running
> scenario where we need to recover memory.  Having verifiable log
> segments seems to satisfy both cases, but what you do with the segments
> would vary.
>
> James
>
