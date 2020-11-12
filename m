Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA62B128A
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 00:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgKLXQE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 18:16:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36580 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKLXQE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 18:16:04 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id C4B2820C287A;
        Thu, 12 Nov 2020 15:16:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4B2820C287A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605222963;
        bh=hQDTSAHQ4CTHrl7e/LqtszcuRrk7uQ1J1ltWBvuW4bk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j+pEoIzKc4gPLQl/SPiEFoCRCl+ASEGaUIgYYhWZMiJAtdjrO27n8Jq6ezcn7hCej
         4K6nMSMFIcvRUOXmN/S0tT1quBDOwTuiHekKnVOuN5MKeZZnEwgLtzY6/IcPXSDQeW
         3cvwzovO8CbxU6/8FChysngq5H5sEKm+2ypiyKzQ=
Subject: Re: [PATCH v5 2/7] IMA: update process_buffer_measurement to measure
 buffer hash
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
 <20201101222626.6111-3-tusharsu@linux.microsoft.com>
 <d0e96ccc49590c5ff11675661592b70b0f021636.camel@linux.ibm.com>
 <7034a775-cde6-1eae-132a-4cb84f310bca@linux.microsoft.com>
 <0fa1a12388681b49167b58e349cb7c9e996dcd05.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <42b967c4-7a95-6b5e-aaa8-88e649ea987e@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 15:16:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0fa1a12388681b49167b58e349cb7c9e996dcd05.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-11-12 2:19 p.m., Mimi Zohar wrote:
> On Thu, 2020-11-12 at 13:47 -0800, Tushar Sugandhi wrote:
>>> On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
>>>> process_buffer_measurement() currently only measures the input buffer.
>>>> In case of SeLinux policy measurement, the policy being measured could
>>>> be large (several MB). This may result in a large entry in IMA
>>>> measurement log.
>>>
>>> SELinux is an example of measuring large buffer data.  Please rewrite
>>> this patch description (and the other patch descriptions in this patch
>>> set) without using the example to describe its purpose [1].
>>>
>>> In this case, you might say,
>>>
>>> The original IMA buffer data measurement sizes were small (e.g. boot
>>> command line), but new buffer data measurement use cases are a lot
>>> larger.  Just as IMA measures the file data hash, not the file data,
>>> IMA should similarly support measuring the buffer data hash.
>>>
>> Sure. Thanks a lot for giving an example wording for us. Will update.
>>>>
>>>> Introduce a boolean parameter measure_buf_hash to support measuring
>>>> hash of a buffer, which would be much smaller, instead of the buffer
>>>> itself.
>>>
>>>> To use the functionality introduced in this patch, the attestation
>>>> client and the server changes need to go hand in hand. The
>>>> client/kernel would know what data is being measured as-is
>>>> (e.g. KEXEC_CMDLINE), and what data has it’s hash measured (e.g. SeLinux
>>>> Policy). And the attestation server should verify data/hash accordingly.
>>>>
>>>> Just like the data being measured in other cases, the attestation server
>>>> will know what are possible values of the large buffers being measured.
>>>> e.g. the possible valid SeLinux policy values that are being pushed to
>>>> the client. The attestation server will have to maintain the hash of
>>>> those buffer values.
>>>
>>> Each patch in the patch set builds upon the previous one.   (Think of
>>> it as a story, where each chapter builds upon the previous ones.)
>>> With rare exceptions, should patches reference subsequent patches. [2]
>>>
>>> [1] Refer to Documentation/process/submitting-patches.rst
>>> [2] Refer to the section "8) Commenting" in
>>> Documentation/process/coding-style.rst
>>>
>> I am not sure if you have any concerns about the last two paragraphs.
>> The description about the attestation client and server (the last two
>> paragraphs) was added for information/clarification purpose only, as per
>> your feedback on previous iterations. The subsequent patches don’t have
>> any code pertaining to attestation client/server.
>>
>> *Question*
>> Maybe the last two paragraphs are confusing/redundant. Could you please
>> let me know if I should remove the above two paragraphs altogether?
>> (starting with “To use the functionality introduced in this patch ...”)
>>
>> If we decide to keep the paragraphs, I will remove the specific examples
>> (KEXEC_CMDLINE, SeLinux etc.) as you mentioned elsewhere.
> 
> Instead of the above two paragraphs, perhaps explain how measuring the
> file data hash differs from measuring the buffer data hash.  Keep the
> explanation generic, short and simple.
> 
> Mimi
> 
Will do. Thanks for the quick response Mimi.
I also have some clarification questions on the other patches in this
series as well.

Would really appreciate if you could help us get clarification on those.

Thanks a lot again.

~Tushar
