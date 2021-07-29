Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658B23DAC4A
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 21:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhG2T6i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 15:58:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54958 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhG2T6i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 15:58:38 -0400
Received: from [192.168.86.34] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 51A0C20B36E0;
        Thu, 29 Jul 2021 12:58:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51A0C20B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627588714;
        bh=iLGbwp6wfjndlgTVvVE92NUr2Nkz1vhwtosUiQDnfeM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bYrcH4pYTsoANpuYvkGfvj0UQ7q/brAtTC2CL50ocWuyiwDFbOo/Azt5U7wbP7J3I
         92krgpkGuq3Mw8YDU6VyL5jx9Sdg0ct0oZxwgpz6nkVAvkq1nepYRaD4R4OUThZCEg
         4LiX58NZra09LKNj/rosFcUTFRR5HqW8TeNtrOBw=
Subject: Re: [PATCH 1/7] dm: measure data on table load
To:     Mimi Zohar <zohar@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, agk@redhat.com,
        linux-integrity@vger.kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
 <20210713004904.8808-2-tusharsu@linux.microsoft.com>
 <713d22788b678c612c5b18edfb8cf849af61ace5.camel@linux.ibm.com>
 <YPhAaAyo8fKXzu5c@redhat.com>
 <a6887d022d3943e0ca1efb845270fa715a60b925.camel@linux.ibm.com>
 <758a4a85e0fb92e8cbc62b218c12b02f9123f640.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <32086dac-97e0-471c-2dc6-938e4fbc7d02@linux.microsoft.com>
Date:   Thu, 29 Jul 2021 12:58:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <758a4a85e0fb92e8cbc62b218c12b02f9123f640.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 7/21/21 2:17 PM, Mimi Zohar wrote:
> On Wed, 2021-07-21 at 12:07 -0400, Mimi Zohar wrote:
>> On Wed, 2021-07-21 at 11:42 -0400, Mike Snitzer wrote:
>>> On Tue, Jul 20 2021 at 10:12P -0400,
>>> Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>
>>>> Hi Tushar, Mike,
>>>>
>>>> On Mon, 2021-07-12 at 17:48 -0700, Tushar Sugandhi wrote:
>>>>> +struct dm_ima_device_table_metadata {
>>>>> +       /*
>>>>> +        * Contains data specific to the device which is common across
>>>>> +        * all the targets in the table.e.g. name, uuid, major, minor etc.
>>>>> +        * The values are stored in comma separated list of key1=val1,key2=val2; pairs
>>>>> +        * delimited by a semicolon at the end of the list.
>>>>> +        */
>>>>> +       char *device_metadata;
>>>>> +       unsigned int device_metadata_len;
>>>>> +       unsigned int num_targets;
>>>>> +
>>>>> +       /*
>>>>> +        * Contains the sha256 hashs of the IMA measurements of the
>>>>> +        * target attributes key-value pairs from the active/inactive tables.
>>>>> +        */
>>>>
>>>>  From past experience hard coding the hash algorithm is really not a
>>>> good idea.
>>>>
>>>> Mimi
>>>>
>>>>> +       char *hash;
>>>>> +       unsigned int hash_len;
>>>>> +
>>>>> +};
>>>
>>> Hi Mimi,
>>>
>>> The dm-ima.c code is using SHASH_DESC_ON_STACK and then storing the
>>> more opaque result via 'hash' and 'hash_len'.
>>>
>>> So if/when the dm-ima.c hash algorithm were to change this detail
>>> won't change the dm_ima_device_table_metadata structure at all right?
>>> But even if changes were needed this is purely an implementation
>>> detail correct?  Why might users care which algorithm is used by
>>> dm-ima to generate the hashes?
>>>
>>> Assuming there is a valid reason for users to care about this, we can
>>> improve this aspect as follow-on work.. so I don't consider this a
>>> blocker for this patchset at this point.  Please clarify if you feel
>>> it should be a blocker.
>>
>> This goes back to my question as to if or how the template data in
>> these DM critical data records are to be validated by the attestation
>> server.   Asumming the hash/hash_len is being stored in the IMA
>> measurement list, the less the attestation should need to know about
>> the specific kernel version the better.
> 
> Hi Mike, Tushar,  Laskshmi,
> 
> Perhaps, when defining a new IMA "critical data" record, especially if
> you know it's going to change, the critical data should contain a
> version number.
>
Just to close the loop on this thread:

As I explained on the other thread in this patch series -

@the hash verification:
the clear-text for the active/inactive table hashes is already logged in
the 'table_load' event. And we will prefix the active/inactive table
hashes with hash_algo.  (e.g. sha256:<hash>) in the remaining events.
Together it should be sufficient for the attestation server to verify
the active/inactive table hashes without maintaining any list of
expected hashes or referring to kernel version etc.

@versioning:
We are already logging versions for individual targets. What was missing
was some versioning at device level. So thanks again for the suggestion.
We will add a version at device level in each of the events. Together
that should help attestation server to determine what attributes to 
expect in the event data - without relying on specific kernel version.

Thanks again for your feedback.

Regards,
Tushar

> thanks,
> 
> Mimi
> 

