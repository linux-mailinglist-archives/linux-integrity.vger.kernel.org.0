Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0622B108E
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKLVr3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 16:47:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53474 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKLVr2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 16:47:28 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id C6CEE20C2872;
        Thu, 12 Nov 2020 13:47:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6CEE20C2872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605217648;
        bh=IYRQbMtYBZ7qgPiPGwnVjY8YEci9yTL8glUotKnXc/k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=akCFzKtaivx6Ishh+tDLpQiWEGlNvCRC3PYSQhJuYeiR4/8FrafD5T2rL10xIVsfl
         TQa2RppfkMs4t7OiBnv1zoZXrZFiydrYrhWaE3lWlrBbLiGnTqG3fWZb32E3ztD1F9
         DaMA+eMfYasQCfhzyx9VlYJyY3M+hkEKZ4g0HVGM=
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
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <7034a775-cde6-1eae-132a-4cb84f310bca@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 13:47:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0e96ccc49590c5ff11675661592b70b0f021636.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi,

On 2020-11-05 6:30 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> Please don't include the filename in the Subject line[1].   The Subject
> line should be a summary phrase describing the patch.   In this case,
> it is adding support for measuring the buffer data hash.
> 
Thanks. Will update the subject line accordingly.

> On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
>> process_buffer_measurement() currently only measures the input buffer.
>> In case of SeLinux policy measurement, the policy being measured could
>> be large (several MB). This may result in a large entry in IMA
>> measurement log.
> 
> SELinux is an example of measuring large buffer data.  Please rewrite
> this patch description (and the other patch descriptions in this patch
> set) without using the example to describe its purpose [1].
> 
> In this case, you might say,
> 
> The original IMA buffer data measurement sizes were small (e.g. boot
> command line), but new buffer data measurement use cases are a lot
> larger.  Just as IMA measures the file data hash, not the file data,
> IMA should similarly support measuring the buffer data hash.
> 
Sure. Thanks a lot for giving an example wording for us. Will update.
>>
>> Introduce a boolean parameter measure_buf_hash to support measuring
>> hash of a buffer, which would be much smaller, instead of the buffer
>> itself.
> 
>> To use the functionality introduced in this patch, the attestation
>> client and the server changes need to go hand in hand. The
>> client/kernel would know what data is being measured as-is
>> (e.g. KEXEC_CMDLINE), and what data has it’s hash measured (e.g. SeLinux
>> Policy). And the attestation server should verify data/hash accordingly.
>>
>> Just like the data being measured in other cases, the attestation server
>> will know what are possible values of the large buffers being measured.
>> e.g. the possible valid SeLinux policy values that are being pushed to
>> the client. The attestation server will have to maintain the hash of
>> those buffer values.
> 
> Each patch in the patch set builds upon the previous one.   (Think of
> it as a story, where each chapter builds upon the previous ones.)
> With rare exceptions, should patches reference subsequent patches. [2]
> 
> [1] Refer to Documentation/process/submitting-patches.rst
> [2] Refer to the section "8) Commenting" in
> Documentation/process/coding-style.rst
> 
> thanks,
> 
> Mimi
> 
I am not sure if you have any concerns about the last two paragraphs.
The description about the attestation client and server (the last two
paragraphs) was added for information/clarification purpose only, as per
your feedback on previous iterations. The subsequent patches don’t have
any code pertaining to attestation client/server.

*Question*
Maybe the last two paragraphs are confusing/redundant. Could you please
let me know if I should remove the above two paragraphs altogether? 
(starting with “To use the functionality introduced in this patch ...”)

If we decide to keep the paragraphs, I will remove the specific examples
(KEXEC_CMDLINE, SeLinux etc.) as you mentioned elsewhere.
