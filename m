Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584CE2B110D
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 23:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKLWJb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 17:09:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56352 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgKLWJb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 17:09:31 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id F2E2220C2877;
        Thu, 12 Nov 2020 14:09:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F2E2220C2877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605218970;
        bh=+K+BtIDhTV9Ivac9LmNJpqVeNvuYixjagXLIJ2abKpo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q56yVPRySGgKWN1B/uhkEAS+baWIEekWvsuLhHdIbtlSnCbj77NAMuWAmqPRW7ZAz
         jH3p02AIPCUmcoL8jlSWUjqH2cyQ6zWEgoHx1daRwCSBOZqQOqiFOx9ldNJjIEtSml
         Ra8+MHltYegvY1heqhS+j05RYE5NYTcNNrppnPck=
Subject: Re: [PATCH v5 5/7] IMA: validate supported kernel data sources before
 measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
 <20201101222626.6111-6-tusharsu@linux.microsoft.com>
 <bef97a69db37d358db21668b179fd8821430b1b4.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <5826d3df-c263-f6c8-cac0-094b3c5a9395@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 14:09:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bef97a69db37d358db21668b179fd8821430b1b4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-11-06 6:01 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
>> Currently, IMA does not restrict random data sources from measuring
>> their data using ima_measure_critical_data(). Any kernel data source can
>> call the function, and it's data will get measured as long as the input
>> event_data_source is part of the IMA policy - CRITICAL_DATA+data_sources.
>>
>> To ensure that only data from supported sources are measured, the kernel
>> subsystem name needs to be added to a compile-time list of supported
>> sources (an "allowed list of components"). IMA then validates the input
>> parameter - "event_data_source" passed to ima_measure_critical_data()
>> against this allowed list at run-time.
>>
>> This compile-time list must be updated when kernel subsystems are
>> updated to measure their data using IMA.
>>
>> Provide an infrastructure for kernel data sources to be added to
>> IMA's supported data sources list at compile-time. Update
>> ima_measure_critical_data() to validate, at run-time, that the data
>> source is supported before measuring the data coming from that source.
> 
> For those interested in limiting which critical data to measure, the
> "data sources" IMA policy rule option already does that.   Why is this
> needed?
> 
> thanks,
> 
> Mimi
> 

This wasn’t part of the initial series. And I wasn’t convinced if it was
really needed. :) I added it based on the feedback in v2 of this
series. (pasted below for reference[1]).

Maybe I misunderstood your feedback at that time.

*Question*
Could you please let me know if you want us to remove this patch?


[1] From v2 of this series:
https://patchwork.kernel.org/project/linux-integrity/patch/20200821182107.5328-3-tusharsu@linux.microsoft.com/ 


 >>>> "keyrings=" isn't bounded because keyrings can be created by 
userspace.
 >>>> Perhaps keyring names has a minimum/maximum length.  IMA isn't
 >>>> measuring userspace construsts.  Shouldn't the list of critical data
 >>>> being measured be bounded and verified?
 >>> The comment is not entirely clear.
 >>> Do you mean there should be some sort of allow_list in IMA, against
 >>> which the values in "data_sources=" should be vetted? And if the
 >>> value is present in the IMA allow_list, then only the measurements for
 >>> that data source are allowed?
 >>>
 >>> Or do you mean something else?
 >>
 >> Yes, something along those lines.  Does the list of critical data need
 >> to be vetted?  And if so, against what?
 > I am thinking of having an enum and string array - just like ima_hooks
 > and ima_hooks_measure_str in ima.h.
 > And any new kernel component that would support generic IMA measurements
 > in future would have to add itself to the enum/array.
 > And the param *event_data_source in ima_measure_critical_data() will be
 > vetted against the above enum/string array.
 >
 > I will implement it in the next iteration, and hopefully the vetting
 > workflow will be more clear.
 >
 > ~Tushar
 >>
 >> Mimi
