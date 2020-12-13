Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EFF2D8ADB
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Dec 2020 02:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501969AbgLMBWl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Dec 2020 20:22:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48300 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439971AbgLMBWe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Dec 2020 20:22:34 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id AC71F20B717B;
        Sat, 12 Dec 2020 17:21:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC71F20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607822513;
        bh=bsEiZa8Vfo5H0oWB7jXyVaGOel8pSGlEk1zPI0doZwM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TD+1r/d40HbYXZlDWkY6k22sVtz0hLH8vPpjji4tFTQYaShfynyzT20wi8OGWvQSR
         xs2A5JkUf/+Mrny7ABF3mpEMABzedLXlbmX1ltyMa8MZODHZuy1ElmfcYRCSXfa0Ja
         iLWh973lkLayk5ueJNF6wJjofFDrJmphL2lMw65U=
Subject: Re: [PATCH v9 5/8] IMA: limit critical data measurement based on a
 label
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-6-tusharsu@linux.microsoft.com>
 <20201212192049.GJ4951@sequoia>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <7c90e5e5-6408-6f9b-2eed-6fa45cc92806@linux.microsoft.com>
Date:   Sat, 12 Dec 2020 17:21:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212192049.GJ4951@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-12-12 11:20 a.m., Tyler Hicks wrote:
> On 2020-12-12 10:02:48, Tushar Sugandhi wrote:
>> System administrators should be able to limit which kernel subsystems
>> they want to measure the critical data for. To enable that, an IMA policy
>> condition to choose specific kernel subsystems is needed. This policy
>> condition would constrain the measurement of the critical data based on
>> a label for the given subsystems.
>>
>> Add a new IMA policy condition - "data_source:=" to the IMA func
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
> 
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Tyler
> 
Thanks again Tyler.

~Tushar
