Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C29251C95
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Aug 2020 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHYPq7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Aug 2020 11:46:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41560 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHYPq5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Aug 2020 11:46:57 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B6F5220B4908;
        Tue, 25 Aug 2020 08:46:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6F5220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598370415;
        bh=cG0PU1AiCXqIk4eMHJUWBNM5pgMeFVP8Pc2YAFUO1Lo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mSj8+R+HyTWTccdCmaX3nwvs/qC1Imig3edjrJgu4HulycBCUbGm+F3HHf/nae1yY
         IHq+ic0DuDVeei+Ezy6lmnMP89du0Dok1QeKMez78ncPIJYfxf3WGtCc88IlTa4RAE
         /IzxlHbvHQp02qxCLmLTQfN2YaXczm/r9xcZei0g=
Subject: Re: [PATCH] IMA: Handle early boot data measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200821231230.20212-1-nramas@linux.microsoft.com>
 <a7ea2da1f895ee3db4697c00804160acb6db656e.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <307617de-b42d-ac52-6e9e-9e0d16bbc20e@linux.microsoft.com>
Date:   Tue, 25 Aug 2020 08:46:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a7ea2da1f895ee3db4697c00804160acb6db656e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/25/20 8:40 AM, Mimi Zohar wrote:
> On Fri, 2020-08-21 at 16:12 -0700, Lakshmi Ramasubramanian wrote:
>> The current implementation of early boot measurement in
>> the IMA subsystem is very specific to asymmetric keys. It does not
>> handle early boot measurement of data from other subsystems such as
>> Linux Security Module (LSM), Device-Mapper, etc. As a result data,
>> provided by these subsystems during system boot are not measured by IMA.
>>
>> Update the early boot key measurement to handle any early boot data.
>> Refactor the code from ima_queue_keys.c to a new file ima_queue_data.c.
>> Rename the kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS to
>> CONFIG_IMA_QUEUE_EARLY_BOOT_DATA so it can be used for enabling any
>> early boot data measurement. Since measurement of asymmetric keys is
>> the first consumer of early boot measurement, this kernel configuration
>> is enabled if IMA_MEASURE_ASYMMETRIC_KEYS and SYSTEM_TRUSTED_KEYRING are
>> both enabled.
>>
>> Update the IMA hook ima_measure_critical_data() to utilize early boot
>> measurement support.
> 
> Please limit the changes in this patch to renaming the functions and/or
> files.  For example, adding "measure_payload_hash" should be a separate
> patch, not hidden here.
> 

Thanks for the feedback Mimi.

I'll split this into 2 patches:

PATCH 1: Rename files + rename CONFIG
PATCH 2: Update IMA hook to utilize early boot data measurement.

  -lakshmi



