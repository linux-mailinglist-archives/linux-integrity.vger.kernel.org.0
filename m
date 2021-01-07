Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23F82ED6BB
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbhAGSc4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 13:32:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45292 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbhAGScz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 13:32:55 -0500
Received: from [192.168.1.13] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7ADFC20B7192;
        Thu,  7 Jan 2021 10:32:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7ADFC20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610044334;
        bh=hv1csEVf+WwJPYlnFf93UAKu7q896uj3luuXOKlcrPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sZJ05c7kFN2Epb07QFqSHVw27OETnOGIM2ny1ycZzl8Es7wYfrwWYehGcQ0i7ecvU
         3IkZoW1M4kWx9yjl7EO5tIsA8WUvQrNu92WcfvHrxzgUU4BUQOvvZdT315/QsJLpAb
         u8gsc23Z/fXL2ynTQj1SdNo4M9UGMMeR1ePCQb/c=
Subject: Re: [RFC] Persist ima logs to disk
To:     Mimi Zohar <zohar@linux.ibm.com>, janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
 <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
Message-ID: <3425fcf5-8735-f1ba-8b4a-03b5b49a79e7@linux.microsoft.com>
Date:   Thu, 7 Jan 2021 10:32:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/7/2021 7:06 AM, Mimi Zohar wrote:
> [Cc: Amir Goldstein]
>
> On Tue, 2021-01-05 at 11:57 -0800, Raphael Gianotti wrote:
>> IMA measures files and buffer data and some systems may end up
>> generating lots of entries in the IMA measurement list. This list is
>> kept in kernel memoryc and as it grows in size it could end up taking
>> too many resources, causing the system to run out of available
>> memory. During kexec, the IMA measurement list can be carried over in
>> memory, but it's possible for the list to become too large for that
>> to happen.
>>
>> The Kconfig introduced in this series enables admins to configure a
>> maximum number of entries and a file to export the IMA measurement
>> list to whenever the set limit is reached.
>>
>> The list is written out in append mode, so the system will keep
>> writing new entries as long as it stays running or runs out of
>> space. Whenever the export file is set, it's truncated. If writing
>> to the export list fails, a flag is set to prevent further exports,
>> as the file is likely in a bad state. Setting a new export file
>> resets this flag, allowing exports to resume and giving admins a way
>> to recover from this state if necessary.
>>
>> In the case of kexec, if the list is too large too be carried over in
>> memory and an export file is configured, the list will be exported,
>> preventing the measurements from being lost during kexec.
>>
>> This code is based off of a previous RFC sent by Janne Karhunen[1],
>> and is intended to pick up where that was left off.
>>
>> In a thread with Janne Karhunen[2], it was mentioned that another
>> approach, using mm had been considered. Upon some investigation the
>> approach used in this RFC still seemed adequate for solving this
>> problem.
>>
>> [1] https://patchwork.kernel.org/project/linux-integrity/patch/201912
>> 20074929.8191-1-janne.karhunen@gmail.com/
>> [2] https://lore.kernel.org/linux-integrity/CAE=NcrbdS-3gVvnnEwdNSOLO
>> vTenLjyppDz2aJACGRgBYSh=Gw@mail.gmail.com/
>>
>> Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>
> My original concerns of truncating the IMA measurement list have not
> been addressed.  Once the IMA measurement list has been truncated,
> quoting and then verifying any of the PCRs contained in the measurement
> list will fail, unless the measurements have been preserved and are
> readily accessible.
>
> Amir's suggestion addresses kernel memory constraints without
> truncating the IMA measurement list.
>
> Mimi
I actually wasn't aware of what the exact concerns were since I couldn't 
find the
original discussion around it, I only knew that had been suggested and 
thought
it was mostly due to it being a more elegant solution. In my in looking 
into it I might
have overcomplicated, from looking at a reply from Janne. I will revisit 
that with this
in mind as it seems then this solution won't be able to address the PCR 
concerns.

Raph

