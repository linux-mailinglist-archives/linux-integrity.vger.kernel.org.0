Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5411AD3BD
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2020 02:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgDQAqd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 20:46:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54290 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgDQAqc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 20:46:32 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id AE0E62072958;
        Thu, 16 Apr 2020 17:46:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE0E62072958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1587084391;
        bh=gzkPutFS1i/06qhmzxgWIT+Ihkbyjr7xokxh7jTBefw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o3bvCKLQhLFezrL12rxy2wKyXNMId8v+bcj8gMYdMH23lTEZvGTkW188zO1+P7Ty5
         5gxJbliwCSh+XoRvs1CG4iX0okQN2ntADGIubVIWRJYfhcufp2VOqM19iMlVGw6yI7
         SqPvgZlSuH0uNAMutVlWGIFwrNqk9x+Po/3qH48M=
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     Milan Broz <gmazyland@gmail.com>, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, dm-devel@redhat.com
Cc:     jmorris@namei.org, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
 <76a9556d-b141-d26f-7b3c-3887d3a4ae16@gmail.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <c76e89f4-6f39-f2f0-6459-a723df67c75f@linux.microsoft.com>
Date:   Thu, 16 Apr 2020 17:46:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <76a9556d-b141-d26f-7b3c-3887d3a4ae16@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-04-08 9:28 a.m., Milan Broz wrote:
> On 08/04/2020 12:19, Tushar Sugandhi wrote:
<snip>
>> Proposal:
>> ---------
>> A. Measuring dmcrypt constructs:
>>       We can add an IMA hook in crypt_ctr() present in
>>       drivers/md/dm-crypt.c, so that IMA can start measuring the status of
>>       various dm-crypt targets (represented by crypt_target struct - also
>>       defined in dm-crypt.c).
> 
> Hi,
> 
> I do not think you should just cherry-pick dm-crypt here. What about other
> device-mapper targets? Apparently, dm-verity or dm-integrity are obvious
> candidates too.
> 
> But device-mapper logic is based on stacking devices, so in generic case
> (not just in some very special embedded configuration) you need to measure
> the whole stack of devices.
> (Just imagine a target stacked below dm-crypt that decrypts the device or so. :-)
> 
> Moreover, dm-crypt allows some specific actions like wiping and reloading
> of the encryption key through device-mapper dm-crypt message.
> If you check parameter only in crypt_ctr, this message path must be disabled,
> basically crippling dm-crypt functionality (it is intended to wipe key in-memory
> during hw suspend).
> 
> 
> IMO if you want implement something like IMA measurement, I think you should
> implement it in device-mapper core, and provide support for all targets.
I agree that this needs to be implemented in device-mapper core,
rather than highter applications like  dm-crypt, dm-verity, or dm-integrity.
Functions like dm_table_create(), dm_table_destroy(), 
dm_table_verify_integrity(),
dm_table_complete(), dm_table_add_target() etc. in drivers/md/dm-table.c 
look like good
candidates to add hooks for IMA.
Please let me know if you have any other recommendations.
> I guess some new target specific callback is needed and some flags that
> could enforce/disable stacking if a IMA measurement is in place etc.
> 
> Milan
> 
