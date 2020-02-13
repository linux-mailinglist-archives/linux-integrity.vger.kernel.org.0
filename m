Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3D15CCD5
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgBMVBl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 16:01:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43008 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgBMVBl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 16:01:41 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9E23C20B9C02;
        Thu, 13 Feb 2020 13:01:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E23C20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581627700;
        bh=RlVWb6B2Yj5GqYRUZdm6taeMRNIqKiey+W202nGiIi8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sEQ+8hWw3mCob7DpFUrzstr0mHNKXIzgk7YCHHKxnad3EuL1PSvJ4/EcAn1fifSV4
         e9DBmztMMlimpTymNMkLXIKDWemAl1hmLs3FCnMQ1As1aazzoK/UalcVXqAsLWWCOK
         6yf3Faot+AUezvwkOFfltihcEeoEM0ONhClB3vj4=
Subject: Re: [PATCH v3 2/3] IMA: Add log statements for failure conditions.
To:     Mimi Zohar <zohar@linux.ibm.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
 <20200211231414.6640-3-tusharsu@linux.microsoft.com>
 <1581518823.8515.49.camel@linux.ibm.com>
 <ce89d382-8e8b-71d0-5271-4db83d324f94@linux.microsoft.com>
 <1581553311.8515.96.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <c224c5a7-6e77-4ebf-7c91-2ec0c078a6f8@linux.microsoft.com>
Date:   Thu, 13 Feb 2020 13:01:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581553311.8515.96.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-02-12 4:21 p.m., Mimi Zohar wrote:
> On Wed, 2020-02-12 at 14:30 -0800, Tushar Sugandhi wrote:
>>
>> On 2020-02-12 6:47 a.m., Mimi Zohar wrote:
>>> Hi Tushar,
>>>
>>> Please remove the period at the end of the  Subject line.
>> Thanks. I will fix it in the next iteration.
>>>
>>> On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
>>>> process_buffer_measurement() does not have log messages for failure
>>>> conditions.
>>>>
>>>> This change adds a log statement in the above function.
>>>
>>> I agree some form of notification needs to be added.  The question is
>>> whether the failure should be audited or a kernel message emitted.
>>>    IMA emits audit messages (integrity_audit_msg) for a number of
>>> reasons - on failure to calculate a file hash, invalid policy rules,
>>> failure to communicate with the TPM, signature verification errors,
>>> etc.
>> I believe both IMA audit messages and kernel message should be emitted -
>> for better discoverability and diagnosability.
> 
> Like file measurement failures, failure to measure a key or the boot
> command line should be audited as well.  For debugging purposes, you
> could make this message pr_devel.
Ok. I will change this to pr_devel in next iteration.
> 
> Mimi
> 
