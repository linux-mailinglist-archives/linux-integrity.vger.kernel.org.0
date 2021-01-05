Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE22EB42F
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 21:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbhAEU3C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 15:29:02 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45788 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbhAEU3C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 15:29:02 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id AB3FF20B7192;
        Tue,  5 Jan 2021 12:28:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB3FF20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609878501;
        bh=Z58yu87FAyCkZKigXOEa5lJQRbPu2cks7pH+f9r7+iY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bIoV0+sviH3URNl5bPeuGXrRKqg/xTdkHkUfyoXVkbeSz5jigQyFDc3oNUwXyXBy/
         giJvBDlS5gRncX+SWCCEBQVeOxCrpEKvjLowLXMyI4Fa7XudQ91Im/eDUQFL4qLVqy
         QNC1bULairXxMVe3eV1q96uzl9y1I2FHtwrHcIFw=
Subject: Re: [PATCH v9 5/8] IMA: limit critical data measurement based on a
 label
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-6-tusharsu@linux.microsoft.com>
 <56db41c08d625b8143454a2e0aaaef3ea2927442.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <2c1d83b6-e344-28ea-e387-01a0febbe391@linux.microsoft.com>
Date:   Tue, 5 Jan 2021 12:28:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <56db41c08d625b8143454a2e0aaaef3ea2927442.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-12-24 6:29 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
>> System administrators should be able to limit which kernel subsystems
>> they want to measure the critical data for. To enable that, an IMA policy
>> condition to choose specific kernel subsystems is needed. This policy
>> condition would constrain the measurement of the critical data based on
>> a label for the given subsystems.
> 
> Restricting which kernel integrity critical data is measured is not
> only of interest to system administrators.   Why single them out?
> 
system administrators are usually responsible for system 
policies/configurations.They own modifications in the config files like
ima-policy. That's why we wanted to address them to begin with. But you
are correct. This is not only of interest to sysadmins. I will make the 
description more generic.


> Limiting which critical data is measured is based on a label, making it
> flexible.  In your use case scenario, you're grouping the label based
> on kernel subsystem, but is that really necessary?  In the broader
> picture, there could be cross subsystem critical data being measured
> based on a single label.
> 
> Please think about the broader picture and re-write the patch
> descirption more generically.
> 
Makes sense. Will make the patch description more generic.
>>
>> Add a new IMA policy condition - "data_source:=" to the IMA func
> 
> What is with "add"?  You're "adding support for" or "defining" a new
> policy condition.  Remove the single hyphen, as explained in 3/8.
> 
> Please replace "data_source" with something more generic (e.g. label).
> 
Sounds good. Would you prefer "label" or something else like "data_label"?

In the policy file the "label" looks logical and more generic than 
"data_label".
    measure func=CRITICAL_DATA label=selinux

For the time being, I will stick with "label", please let me know if you
prefer something else.

Thanks,
Tushar

> thanks,
> 
> Mimi
> 
>> CRITICAL_DATA to allow measurement of various kernel subsystems. This
>> policy condition would enable the system administrators to restrict the
>> measurement to the labels listed in "data_source:=".
>>
>> Limit the measurement to the labels that are specified in the IMA
>> policy - CRITICAL_DATA+"data_source:=". If "data_sources:=" is not
>> provided with the func CRITICAL_DATA, the data from all the
>> supported kernel subsystems is measured.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
