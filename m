Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8634F2EB43A
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 21:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbhAEUbK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 15:31:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46066 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbhAEUbK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 15:31:10 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id D4EFD20B7192;
        Tue,  5 Jan 2021 12:30:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4EFD20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609878629;
        bh=d7fvwMXhNeLHAsVeLOIjrbHL9zgPEuqv7PB0Ukcw3L0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aNC/iX7/KEHCLBqfh8L5oj08bZPkDiarhorN0YjVvEX8lKkfDiooYibaGcRBYl/4J
         yXuRHJLBlFJDMFdzcl+qLhz9sHqJjF25KipIvKUjGcu3uRajI7nLpkbahB4Pbi0/QS
         tn+qCdsj54l0SU/F1yUIY4LITYycSRw+2Jr1xBdg=
Subject: Re: [PATCH v9 7/8] IMA: define a builtin critical data measurement
 policy
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-8-tusharsu@linux.microsoft.com>
 <93dc6912192df78026f8f98c8f6ab67608c188f0.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <aefe90e1-c133-fb5a-0e08-1d68fd950731@linux.microsoft.com>
Date:   Tue, 5 Jan 2021 12:30:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93dc6912192df78026f8f98c8f6ab67608c188f0.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-12-24 6:41 a.m., Mimi Zohar wrote:
> On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
>> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>
>> Define a new critical data builtin policy to allow measuring
>> early kernel integrity critical data before a custom IMA policy
>> is loaded.
>>
>> Add critical data to built-in IMA rules if the kernel command line
>> contains "ima_policy=critical_data".
> 
> This sentence isn't really necessary.
> 
Will remove.
>>
>> Update the documentation on kernel parameters to document
>> the new critical data builtin policy.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Otherwise,
> Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>
Thanks again for the "Reviewed-by" tag.

Thanks,
Tushar
> 
> thanks,
> 
> Mimi
> 
