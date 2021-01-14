Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECC2F688D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 19:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbhANR6K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 12:58:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45194 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbhANR6K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 12:58:10 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7E4720B6C40;
        Thu, 14 Jan 2021 09:57:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7E4720B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610647049;
        bh=A4xGRwtz6F/ItvEdkk7Mb8VZ62q+X4ffVSeGTPCYbj0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ms+8Ksq1OiZWytgF1KBjTZpUlM/Mljo9UN9DsX4FbPYkGZEwDl5l+ublRojq3l+De
         onLI2IsuQjAtzreV8nfOQy2Nu+zA1sGousMbny+4FLoyhNB6TfSDRuDcSX3k/nSKp0
         9dODlIIkdzCGk3Y9ixlK26nnvqfpz21QyroeBZDk=
Subject: Re: [PATCH v10 5/8] IMA: limit critical data measurement based on a
 label
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
 <20210108040708.8389-6-tusharsu@linux.microsoft.com>
 <73a82dff7be151298f51c0db6f3c4996ccf44a19.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <3105b0b9-4e74-691c-56ab-6ca183cb2038@linux.microsoft.com>
Date:   Thu, 14 Jan 2021 09:57:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <73a82dff7be151298f51c0db6f3c4996ccf44a19.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2021-01-13 6:09 p.m., Mimi Zohar wrote:
> On Thu, 2021-01-07 at 20:07 -0800, Tushar Sugandhi wrote:
>> Integrity critical data may belong to a single subsystem or it may
>> arise from cross subsystem interaction.  Currently there is no mechanism
>> to group or limit the data based on certain label.  Limiting and
>> grouping critical data based on a label would make it flexible and
>> configurable to measure.
>>
>> Define "label:=", a new IMA policy condition, for the IMA func
>> CRITICAL_DATA to allow grouping and limiting measurement of integrity
>> critical data.
>>
>> Limit the measurement to the labels that are specified in the IMA
>> policy - CRITICAL_DATA+"label:=".  If "label:=" is not provided with
>> the func CRITICAL_DATA, measure all the input integrity critical data.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> This is looking a lot better.
> 
> thanks,
> 
> Mimi
> 
Thanks a lot for the feedback Mimi.
Appreciate it. :)

~Tushar
