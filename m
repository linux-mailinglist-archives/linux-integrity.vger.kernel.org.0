Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F61A772B
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Sep 2019 00:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfICWkm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 18:40:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44470 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICWkl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 18:40:41 -0400
Received: from [10.91.6.157] (unknown [167.220.2.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2559920B7186;
        Tue,  3 Sep 2019 15:40:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2559920B7186
Subject: Re: TPM 2.0 Linux sysfs interface
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     =?UTF-8?Q?Piotr_Kr=c3=b3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <20190827010559.GA31752@ziepe.ca> <1567007592.6115.58.camel@linux.ibm.com>
 <20190828161502.GC933@ziepe.ca>
 <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
 <20190902192632.GB5393@ziepe.ca> <1567460118.10024.316.camel@linux.ibm.com>
 <20190903055523.GA4500@ziepe.ca>
 <bc9ab35e-997c-b107-3073-d5150de063d0@intel.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <fe908209-3752-19b2-2652-79fb75f69e2b@linux.microsoft.com>
Date:   Tue, 3 Sep 2019 15:40:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bc9ab35e-997c-b107-3073-d5150de063d0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/3/19 9:23 AM, Tadeusz Struk wrote:
> On 9/2/19 10:55 PM, Jason Gunthorpe wrote:
>> On Mon, Sep 02, 2019 at 05:35:18PM -0400, Mimi Zohar wrote:
>>> On Mon, 2019-09-02 at 16:26 -0300, Jason Gunthorpe wrote:
>>>> On Fri, Aug 30, 2019 at 02:20:54PM -0700, Tadeusz Struk wrote:
>>>>> On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
>>>>>>>> So exposing PCRs and things through sysfs is not going to happen.
>>>>>>>>
>>>>>>>> If you had some very narrowly defined things like version, then
>>>>>>>> *maybe* but I think a well defined use case is needed for why this
>>>>>>>> needs to be sysfs and can't be done in C as Jarkko explained.
>>>>>>> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
>>>>>>> TPM 2.0 is a reasonable request and probably could be implemented on
>>>>>>> TPM registration.
>>>>>>>
>>>>>>> If exposing the PCRs through sysfs is not acceptable, then perhaps
>>>>>>> suggest an alternative.
>>>>>> Use the char dev, this is exactly what is is for.
>>>>>
>>>>> What about a new /proc entry?
>>>>> Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
>>>>> What about adding a new /proc/tpminfo that would print info like
>>>>> version, number of enabled PCR banks, physical interface [tis|crb],
>>>>> vendor, etc.
>>>>
>>>> I thought we were not really doing new proc entries?
>>>>
>>>> Why this focus on making some textual output?
>>>
>>> I don't really care if we define procfs, sysfs, or securityfs file(s)
>>> or whether those files are ascii or binary.  Whatever is defined,
>>> should be defined for both TPM 1.2 and TPM 2.0 (eg. TPM version).
>>
>> Use an ioctl on the char dev?
> 
> The advantage of /proc/tpminfo would be that it can be a first
> entry point on a system, that would give general overview of the
> system TPM configuration, without the need of poking /dev/tpm<N>
> files, only to find out that the TPM doesn't understand the
> command, because it implements different version of TCG spec.
> It would be a single point of information in case of multiple TPMs.
> It can have some predefined format that could be read by a human
> as well as a machine, e.g.
> 
> tpm0:
>    version: 2.0
>    physical interface: CRB
>    supported PCR banks: SHA1, SHA256
>    ...
>    vendor: <Vendor Name>
>    vendor specific: <Vendor specific output>
>
To me it still feels trivial write an application to do this same thing
in userspace with ioctls to the char device (figure out what interface
the TPM is using, get basic capabilities, etc.). There isn't anything
here that the kernel can do that can't be done from userspace that I can
see. Is this not true? Maybe its less code in the kernel but I don't
know that that's a great reason.

I don't see a clear advantage to putting the code in the kernel, but I
do see disadvantages. Interfaces between kernel and userspace need to be
more rigid to avoid breakage.

Thanks,
Jordan
