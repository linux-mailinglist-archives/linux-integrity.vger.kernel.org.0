Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2E266729
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 19:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgIKRik (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 13:38:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41546 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIKRic (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 13:38:32 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id D2ECC20D4DAB;
        Fri, 11 Sep 2020 10:38:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2ECC20D4DAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599845911;
        bh=ToCW8sjoCQG57z0ML1xQpe4B6MTvl/nMxQSKeRgbf68=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qHC0tsWAXIQgNPeFgerE6o77naJdkZW7gYDTFSIG+WakHTScTnuv5PEBYj4dgUFJ7
         l1PuCuNjD8PXh+1m3iFvLwiL6yjb+PDQ0o2nDHAU0a7wUzh9jpYgA4VJZJGBpN3sih
         Ndn6kLYwMdpMAu38Fh/gG4YnpsU5zof7drq1Oqho=
Subject: Re: [PATCH v3 5/6] IMA: add hook to measure critical data from kernel
 components
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
 <20200828015704.6629-6-tusharsu@linux.microsoft.com>
 <6c80bdad49c72fa58b5a9fb7ce2d20c8cabe1324.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <01f5ea67-447e-c1c2-9c47-49fd3f6c16ec@linux.microsoft.com>
Date:   Fri, 11 Sep 2020 10:38:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6c80bdad49c72fa58b5a9fb7ce2d20c8cabe1324.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-08-31 11:23 a.m., Mimi Zohar wrote:
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 52cbbc1f7ea2..a889bf40cb7e 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -869,6 +869,30 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>>   	fdput(f);
>>   }
>>   
>> +/**
>> + * ima_measure_critical_data - measure critical data
>> + * @event_name: name for the given data
>> + * @event_data_source: name of the event data source
>> + * @buf: pointer to buffer containing data to measure
>> + * @buf_len: length of buffer(in bytes)
>> + * @measure_buf_hash: if set to true - will measure hash of the buf,
>> + *                    instead of buf
>> + *
>> + * Buffers can only be measured, not appraised.
>> + */
>> +int ima_measure_critical_data(const char *event_name,
>> +			      const char *event_data_source,
>> +			      const void *buf, int buf_len,
>> +			      bool measure_buf_hash)
>> +{
>> +	if (!event_name || !event_data_source || !buf || !buf_len)
>> +		return -EINVAL;
>> +
>> +	return process_buffer_measurement(NULL, buf, buf_len, event_name,
>> +					  CRITICAL_DATA, 0, event_data_source,
>> +					  measure_buf_hash);
> 
> This is exactly what I'm concerned about.  Failure to measure data may
> be audited, but should never fail.
> 
> Mimi
> 
As I responded in patch 2, I can ignore the result of 
process_buffer_measurement() in ima_measure_critical_data(), and make
ima_measure_critical_data() return type as "void".

But that’s the only place where the results of p_b_m() are being used.
So I might as well just revert the return type of p_b_m() to the
original "void".

>> +}
> 
