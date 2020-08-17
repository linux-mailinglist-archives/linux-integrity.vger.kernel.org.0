Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78B8247A70
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgHQW1a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 18:27:30 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50626 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgHQW1a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 18:27:30 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9703220B4908;
        Mon, 17 Aug 2020 15:27:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9703220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597703249;
        bh=0j9a5IYqvWdvwDHB2tMC5qCJrvEU0qbBGTRjox7IGgI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L3Axt+7EscLZpBi96eFpEXhyclKDEoeWlloAH0gEvpIugbBhYQ9RrOS0ki9oYn2iv
         faH9ZKmIGhC9eGVRwlYIBnjI1FOJBBOzMIPfI3BXYVnE0fKWfI0Gvhp0pgEZmYYNzI
         riXqUkJHj9oq++P7fCZmAOy/v4HwglXA63OcE2uE=
Subject: Re: [PATCH 2/3] IMA: add policy to support measuring critical data
 from kernel components
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        nramas@linux.microsoft.com
References: <20200812193102.18636-1-tusharsu@linux.microsoft.com>
 <20200812193102.18636-3-tusharsu@linux.microsoft.com>
 <591b5f09c7df8ef0378866eaf3afde7a7cb4e82f.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <5275268e-2ce8-0129-b11d-8419ac384262@linux.microsoft.com>
Date:   Mon, 17 Aug 2020 15:27:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <591b5f09c7df8ef0378866eaf3afde7a7cb4e82f.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-08-17 1:43 p.m., Mimi Zohar wrote:
> On Wed, 2020-08-12 at 12:31 -0700, Tushar Sugandhi wrote:
>> There would be several candidate kernel components suitable for IMA
>> measurement. Not all of them would be enlightened for IMA measurement.
>> Also, system administrators may not want to measure data for all of
>> them, even when they are enlightened for IMA measurements. An IMA policy
>> specific to various kernel components is needed to measure their
>> respective critical data.
>>
>> Add a new IMA policy CRITICAL_DATA+data_sources to support measuring
>> various critical kernel components. This policy would enable the
>> system administrators to limit the measurement to the components,
>> if the components are enlightened for IMA measurement.
> 
> "enlightened", really?  Please find a different term, maybe something
> like "supported".
Thanks for the feedback Mimi. Will do.
> 
> Before posting a patch set, please look at the patches line by line,
> like anyone reviewing the code needs to do.  Please minimize code
> change.   Unnecessary formatting changes are unacceptible.   For
> example, like the "#define", below, or in 3/3 the
Thanks for the feedback Mimi.
We extensively reviewed the patches internally before submitting for
upstream review.
We believed adding an extra tab was necessary so that all the previous
values were aligned with the new one - #define IMA_DATA_SOURCES.
We can certainly revert back to only IMA_DATA_SOURCES to have an extra
tab.
> "process_buffer_measurement()" change from void to int.
> 
This was also intentional, and was reviewed internally.
The feedback was we should let the consumers of
process_buffer_measurement() decide whether to use the return
value or not. With void, we are not giving them any choice.

> scripts/Lindent isn't as prevalent as it used to be, but it's still
> included in Documentation/process/coding-style.rst.  Use it as a guide.
Thanks for the pointer. We'll use scripts/Lindent going forward.
> 
> Mimi
> 
