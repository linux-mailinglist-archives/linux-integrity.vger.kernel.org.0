Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D6315634
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 19:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhBISln (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 13:41:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58424 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbhBIS2k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 13:28:40 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 898D520B57A9;
        Tue,  9 Feb 2021 10:23:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 898D520B57A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612895019;
        bh=BESXZxJvRTP0XJydFtfetXw9iD4M1DEAmYDOlwv+xSw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mBhWrHk/7wo96d8XqV4us9msLaz3LnWBSeb57sFI37e43wpqKedzdWnj8CcYoQS9i
         lP5/x06IxMwFGl+v5oaHHWMk4XiwjAGhwi+CWZNt8exLNX2UpZmVmDDyjwEC3W1/sO
         bgHouvKqXsPRXnM7j7VI3v+vO91TGzSquO7U0AbU=
Subject: Re: [PATCH 0/3] support for duplicate measurement of integrity
 critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
 <27f73411fc1d6ce6dd16a29344d729d9aa760250.camel@linux.ibm.com>
 <27a4592c3b75861d2b9c8fb1511f593aa987222c.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <c5ecccbe-9e23-f297-8a79-2a9dd62a40fb@linux.microsoft.com>
Date:   Tue, 9 Feb 2021 10:23:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <27a4592c3b75861d2b9c8fb1511f593aa987222c.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thank you Mimi for reviewing this series.

On 2021-02-08 1:10 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> 
> On Mon, 2021-02-08 at 15:22 -0500, Mimi Zohar wrote:
>> On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:
>>> IMA does not measure duplicate buffer data since TPM extend is a very
>>> expensive operation.  However, in some cases for integrity critical
>>> data, the measurement of duplicate data is necessary to accurately
>>> determine the current state of the system.  Eg, SELinux state changing
>>> from 'audit', to 'enforcing', and back to 'audit' again.  In this
>>> example, currently, IMA will not measure the last state change to
>>> 'audit'.  This limits the ability of attestation services to accurately
>>> determine the current state of the integrity critical data on the
>>> system.
>>>
>>> This series addresses this gap by providing the ability to measure
>>> duplicate entries for integrity critical data, driven by policy.
>>
>> The same reason for re-measuring buffer data is equally applicable to
>> files.  In both cases, the file or the buffer isn't re-measured if it
>> already exists in the htable.   Please don't limit this patch set to
>> just buffer data.
> 
Agreed.  I wasn't sure if you wanted the support for files, or other 
buffer measurement scenarios, except critical data.  So I started the 
implementation with supporting just critical data.  Happy to extend it 
to files and other buffer measurement scenarios as you suggested.

> Instead of making the change on a per measurement rule basis, disabling
> "htable" would be the simplest way of forcing re-measurements.  All
> that would be needed is a new Kconfig (e.g. CONFIG_IMA_DISABLE_HTABLE)
> and the associated test in ima_add_template_entry().
> 
Agreed.  Earlier I wasn't sure if you wanted allow_dup support for all 
the scenarios.  Now that it is clear,  I will implement it as you 
suggested.  Thank you so much for the pointers.  Appreciate it.

Thanks,
Tushar

> thanks,
> 
> Mimi
> 
