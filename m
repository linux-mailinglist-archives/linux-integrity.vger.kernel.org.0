Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C127310F61
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 19:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBEQUC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 11:20:02 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60350 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhBEQSE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 11:18:04 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B10A620B6C40;
        Fri,  5 Feb 2021 09:59:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B10A620B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612547985;
        bh=R/hf6T7IfqycaEkvWUWCsy5KS7kYt+/f6lu60uKrZc4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VwTrdKn5QuH+ugavR1sYZ5ODTerDlLe18JCTYyCKTjteoD/lFzarEpsTQ4bbioy+G
         b4IYR48kTdBa6sQRz/NH/HOOJjWJAgaas5xt9LnO9E0hS525NHdqeLiswFlevo0QWi
         400UzuFEoDfX7Xiyhc8PQTw5A601cG/sMH4Cxwak=
Subject: Re: [PATCH v2 1/2] ima: Free IMA measurement buffer on error
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     bauerman@linux.ibm.com, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210204174951.25771-1-nramas@linux.microsoft.com>
 <YB0YdqbbdAdbEOQw@kroah.com>
 <7000d128-272e-3654-8480-e46bf7dfad74@linux.microsoft.com>
 <6a5b7a1767265122d21f185c81399692d12191f4.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b8573374-86d0-f679-6c9f-a61b2bc6f7ea@linux.microsoft.com>
Date:   Fri, 5 Feb 2021 09:59:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6a5b7a1767265122d21f185c81399692d12191f4.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/5/21 9:49 AM, Mimi Zohar wrote:

Hi Mimi,

> On Fri, 2021-02-05 at 09:39 -0800, Lakshmi Ramasubramanian wrote:
>> On 2/5/21 2:05 AM, Greg KH wrote:
>>> On Thu, Feb 04, 2021 at 09:49:50AM -0800, Lakshmi Ramasubramanian wrote:
>>>> IMA allocates kernel virtual memory to carry forward the measurement
>>>> list, from the current kernel to the next kernel on kexec system call,
>>>> in ima_add_kexec_buffer() function.  In error code paths this memory
>>>> is not freed resulting in memory leak.
>>>>
>>>> Free the memory allocated for the IMA measurement list in
>>>> the error code paths in ima_add_kexec_buffer() function.
>>>>
>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>>>> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
>>>> ---
>>>>    security/integrity/ima/ima_kexec.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>
>>> <formletter>
>>>
>>> This is not the correct way to submit patches for inclusion in the
>>> stable kernel tree.  Please read:
>>>       https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>> for how to do this properly.
>>>
>>> </formletter>
>>>
>>
>> Thanks for the info Greg.
>>
>> I will re-submit the two patches in the proper format.
> 
> No need.  I'm testing these patches now.  I'm not exactly sure what the
> problem is.  Stable wasn't Cc'ed.  Is it that you sent the patch
> directly to Greg or added "Fixes"?
> 
I had not Cced stable, but had "Fixes" tag in the patch.

Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")

The problem is that the buffer allocated for forwarding the IMA 
measurement list is not freed - at the end of the kexec call and also in 
an error path. Please see the patch description for

[PATCH v2 2/2] ima: Free IMA measurement buffer after kexec syscall

IMA allocates kernel virtual memory to carry forward the measurement
list, from the current kernel to the next kernel on kexec system call,
in ima_add_kexec_buffer() function.  This buffer is not freed before
completing the kexec system call resulting in memory leak.

thanks,
  -lakshmi
