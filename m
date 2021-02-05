Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9803110FA
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 20:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhBERhu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 12:37:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57852 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhBEP5d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 10:57:33 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 72E6C20B6C40;
        Fri,  5 Feb 2021 09:39:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72E6C20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612546755;
        bh=HhOAZD2n7Y5nUjPEAl7h3S686KemCI0DTcFZcZkv6EE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pPLebMnDJH4+oF4Wosz3wKn0HGUpcCKpETnQ1382bqaeKGAtD2BOGcDKevTLA55e1
         OsELd4GAKcCiA8pcT8fsjjgjrB1yeYfQGMhblNCu/1Du7oGfzkI/SrvdaYJ40LueW4
         55pH9N2No/AMCipLzCvfMU/IaRxxL8Mlth5qxzbU=
Subject: Re: [PATCH v2 1/2] ima: Free IMA measurement buffer on error
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210204174951.25771-1-nramas@linux.microsoft.com>
 <YB0YdqbbdAdbEOQw@kroah.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7000d128-272e-3654-8480-e46bf7dfad74@linux.microsoft.com>
Date:   Fri, 5 Feb 2021 09:39:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YB0YdqbbdAdbEOQw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/5/21 2:05 AM, Greg KH wrote:
> On Thu, Feb 04, 2021 at 09:49:50AM -0800, Lakshmi Ramasubramanian wrote:
>> IMA allocates kernel virtual memory to carry forward the measurement
>> list, from the current kernel to the next kernel on kexec system call,
>> in ima_add_kexec_buffer() function.  In error code paths this memory
>> is not freed resulting in memory leak.
>>
>> Free the memory allocated for the IMA measurement list in
>> the error code paths in ima_add_kexec_buffer() function.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
>> ---
>>   security/integrity/ima/ima_kexec.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>
> 

Thanks for the info Greg.

I will re-submit the two patches in the proper format.

  -lakshmi

