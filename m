Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968BD29796B
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Oct 2020 00:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758364AbgJWWuy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Oct 2020 18:50:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35334 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758363AbgJWWuy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Oct 2020 18:50:54 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CF4220B4905;
        Fri, 23 Oct 2020 15:50:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CF4220B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603493453;
        bh=51mgwXigRi3atgRXO7/qeI9rkW4VOXGqrl7CREykoC8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oB1UhE8Mwjj2hC32U8VKu5Fv4YAqtmu14D18ybG6Ynbp4bjTodMVMCcO39GKwBF0e
         RsBMxDUxLt+kM4xGamw27sTktTv6GAKG143EYkFMQSxDkhaNEWNlVJGv5z/VXpMGVE
         03PbGPdTsRAs9TcgNoiaWXY8D7yOZLUdJBTC8bz8=
Subject: Re: [PATCH v4 4/6] IMA: add policy to measure critical data from
 kernel components
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
 <20200923192011.5293-5-tusharsu@linux.microsoft.com>
 <37aa4e6f5db6c53f4021f829ec09388d55d28208.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <87499f4e-d1d1-916c-24d2-0228bcacad26@linux.microsoft.com>
Date:   Fri, 23 Oct 2020 15:50:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <37aa4e6f5db6c53f4021f829ec09388d55d28208.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-10-22 2:15 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> The above Subject line should be truncated to "IMA: add policy to
> measure critical data".
> 
> On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
>> There would be several candidate kernel components suitable for IMA
>> measurement. Not all of them would have support for IMA measurement.
> 
> This intro is besides the point.  The patch description should describe
> what is meant by "critical data".
> 
Thanks. I will fix the description to address this.

>> Also, system administrators may not want to measure data for all of
>> them, even when they support IMA measurement.
>> An IMA policy option
>> specific to various kernel components is needed to measure their
>> respective critical data.
>>
>> This policy option needs to be constrained to measure data for
>> specific kernel components that are specified as input values to the
>> policy option.
>>
>> Add a new IMA policy option - "data_sources:=" to allow measuring
>> various critical kernel components. This policy option would enable the
>> system administrators to limit the measurement to the components
>> listed in "data_sources:=", if the components support IMA measurement.
>>
>> The new policy option "data_sources:=" is different from the existing
>> policy option "keyrings:=".
>>
>> In case of "keyrings:=", a policy may measure all keyrings (when
>> "keyrings:=" option is not provided for func KEY_CHECK), or may
>> constrain which keyrings need to be measured (when "keyrings:=" option
>> is provided for func KEY_CHECK).
>>
>> But unlike "keyrings:=", the entries in "data_sources:=" would have
>> different data format. Further, the components listed in
>> "data_sources:=" need to be modified to call IMA to measure their
>> data. Therefore, unlike "keyrings:=", IMA shouldn't measure all of the
>> components by default, when "data_sources:=" is not specified. Because
>> measuring non-vetted components just by specifying them as a policy
>> option value may impact the overall reliability of the system.
>>
>> To address this, "data_sources:=" should be a mandatory policy option
>> for func=CRITICAL_DATA. This func is introduced in the 5th patch in this
>> series). And the compile-time vetting functionality described above is
>> introduced in the 6th patch in this series.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> I don't understand what you mean by "non-vetted" components, nor how
> measuring critical data may impact the overall reliability of the
> system.
> 
Tushar: Before we introduced the mechanism to check supported
data-sources at compile time (patch 6/6 of this series), there was a
back-and-forth on whether “data_sources:=” should be a mandatory policy
option, or optional like “keyrings:=”. And we decided to make the
“data_sources:=” mandatory. But now that we have the compile time check
(patch 6/6 of this series), we can switch to make “data_sources:=”
optional (with the default to allow measuring all critical data – just 
like what you suggested below). I will make the code and description 
changes accordingly.
> The system owner or adminstrator defines what they want to measure,
> including "critical data", based on the policy rules.  They might
> decide that they want to constrain which "critical data" is measured by
> specifying "data_sources:=", but that decision is their perogative.
> The default should allow measuring all critical data.
> 
Makes sense.
To summarize, we will make the decision which sources to measure- based
on the sources defined in the allow list (in patch 6) and the sources
defined in “data_sources:=”. If “data_sources:=” is not present, we will
measure all sources defined in the allow list.
Hope my this understanding is correct based on your feedback.

>   A simple example of "critical data" could be some in memory structure,
> along the lines of __ro_after_init, or hash of the memory structure.
> Once the data structure is initialized, the "critical data" measurement
> shouldn't change.    From the attestation server perspective, the IMA
> measurement list would contain a single record unless the critical data
> changes.  The attestation server doesn't need to know anything about
> the initial value, just that it has changed in order to trigger some
> sort alert.
Yes agreed. After the updates (based on your feedback) I stated above,
the behavior should remain consistent with what you described here.
> 
> thanks,
> 
> Mimi
> 
