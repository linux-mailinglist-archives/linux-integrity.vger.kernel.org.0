Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314252EB3F7
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 21:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbhAEUNl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 15:13:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43928 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbhAEUNl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 15:13:41 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id A527520B7192;
        Tue,  5 Jan 2021 12:12:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A527520B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609877580;
        bh=EVc75e2pcyzUJYUa1pwKwEYc67I7LZZCYXHcE/6twSs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pSEf01qfw5N4YwxF49diw9lCEpw7NEroG9OpS2A7BH0DJB5yCKeHX6LmxXKxNuKUR
         jwH1L9IytifLtZFKKtVQOJ9gEk4tFU6a7G5lK5jui2QCL3EFx7xCRxDaeivWXFK8zg
         gIRjC4O5ISWuZn4aMF9pyVr75TLGMC6q3u5BRZRw=
Subject: Re: [PATCH v9 4/8] IMA: add policy rule to measure critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-5-tusharsu@linux.microsoft.com>
 <2e0baa1902b6f360e542f92906d077d44e53e59e.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <f1e3c1e6-07e1-2e8a-9824-208ccba28d17@linux.microsoft.com>
Date:   Tue, 5 Jan 2021 12:12:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2e0baa1902b6f360e542f92906d077d44e53e59e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2020-12-24 5:48 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> Please update the Subject line as, "Add policy rule support for
> measuring critical data".
> 
> On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
>> A new IMA policy rule is needed for the IMA hook
>> ima_measure_critical_data() and the corresponding func CRITICAL_DATA for
>> measuring the input buffer. The policy rule should ensure the buffer
>> would get measured only when the policy rule allows the action. The
>> policy rule should also support the necessary constraints (flags etc.)
>> for integrity critical buffer data measurements.
>>
>> Add a policy rule to define the constraints for restricting integrity
>> critical data measurements.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> This patch does not restrict measuring critical data, but adds policy
> rule support for measuring critical data.  please update the patch
> description accordingly.
> 
Will do. Will update the patch description accordingly.

> Other than that,
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
Thanks a lot for the Reviewed-by tag. :)
