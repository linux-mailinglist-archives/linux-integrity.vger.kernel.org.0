Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03F30E15C
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhBCRrX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 12:47:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53666 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhBCRrW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 12:47:22 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8B01220B7192;
        Wed,  3 Feb 2021 09:46:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B01220B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612374401;
        bh=3RICIW6ifzknABr+efjv9dnif1PvuEM7vXwzp3I9uVk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VnGV5Ki16nGyG3QUZJWQdHCAoC9+Yhc9TlgiDzQpGOKycF5QkederFZHOZYJJ8slr
         woSSRz8xuZhkVFjEzfi+5M9o3WEZIGtPWrDXd08IPVQVi4b+IUxQrpFIeNwXFDZT3x
         kQOB8ZbFSbPOREgVwvK77c8ZRNoycRwlegERH3RE=
Subject: Re: [PATCH 2/2] ima: Free IMA measurement buffer after kexec syscall
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, gregkh@linuxfoundation.org,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210121173003.18324-1-nramas@linux.microsoft.com>
 <20210121173003.18324-2-nramas@linux.microsoft.com>
 <87bldg1u3s.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <15fb8c53-2aa0-dc5e-123d-87fee78aacb5@linux.microsoft.com>
Date:   Wed, 3 Feb 2021 09:46:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87bldg1u3s.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/22/21 2:31 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> IMA allocates kernel virtual memory to carry forward the measurement
>> list, from the current kernel to the next kernel on kexec system call,
>> in ima_add_kexec_buffer() function.  This buffer is not freed before
>> completing the kexec system call resulting in memory leak.
>>
>> Add ima_buffer field in "struct kimage" to store the virtual address
>> of the buffer allocated for the IMA measurement list.
>> Free the memory allocated for the IMA measurement list in
>> kimage_file_post_load_cleanup() function.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
> 
> Good catch.
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 

Thanks Thiago.

  -lakshmi

