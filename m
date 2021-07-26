Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6BF3D66B4
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 20:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhGZRsY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 13:48:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56786 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZRsX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 13:48:23 -0400
Received: from [192.168.86.34] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id C52AA20B36ED;
        Mon, 26 Jul 2021 11:28:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C52AA20B36ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627324132;
        bh=cF/GlNcNpPc0+Vfl7htiOar/iV0plOaBnRTpDNiW+3o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hIQildsB9dD+L1LoJliBgrURUtKTMOwhL42VxbQ1fXMZQs/TA2zKO6QES2Vup5Uxy
         lsKY5YvHtj1ciYiiku6KnNyaGU2QLIfPwJIABddY0jSDgdC757Q3r+9+my+wx1jyGK
         tjOWUJnnhQEe+LtMPfcqhb7geAtG5ENjH80RlgIE=
Subject: Re: [PATCH 7/7] dm: add documentation for IMA measurement support
To:     Mimi Zohar <zohar@linux.ibm.com>, dm-devel@redhat.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-integrity@vger.kernel.org, nramas@linux.microsoft.com
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
 <20210713004904.8808-8-tusharsu@linux.microsoft.com>
 <205b5336d60aee6b3f33ad67b2d0250e104d6779.camel@linux.ibm.com>
 <6b81b92f-7d7b-d198-5056-bab1bcbac522@linux.microsoft.com>
 <8cea95cdc1349ae60c690c45ddabcd676c5774d2.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <74451a59-d029-239c-4519-da10c7957c22@linux.microsoft.com>
Date:   Mon, 26 Jul 2021 11:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8cea95cdc1349ae60c690c45ddabcd676c5774d2.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 7/26/21 9:33 AM, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Sat, 2021-07-24 at 00:25 -0700, Tushar Sugandhi wrote:
>> Hi Mimi,
>>
>>
>>> Missing from the document is a way of validating the template data.
>>> For example, in the original case of file measurements, the template
>>> data contains the file hash, which can be recalculated or verified
>>> against an allow list.
>>>
>>> Other than re-calculating the template data digest based on the
>>> template data, and verifying it against the template data digest in the
>>> measurement list, would an attestation server be able to verify the
>>> template data itself?
>>>
>> Yes.
>> In the context of device-mapper, EVENT_DATA for 'table_load' would
>> contain the key-value pairs for various targets in the table
>> (crypt, verity, integrity etc.) which the attestation servers
>> should be able to verify against the allowed/expected
>> key-value pairs specified in the attestation policy.
>>
>> To avoid bloating the IMA log with same data from table_load again,
>> we only measure hash of the loaded table in the EVENT_DATA -
>> when there is a state change for DM device.
>> e.g. when EVENT_NAME is 'device_resume', 'table_clear',
>> 'device_remove' etc.
>>
>> Since the table clear-text is already present in the EVENT_DATA
>> buffer for 'table_load', and is available to attestation servers,
>> verifying the corresponding hash values in the
>> EVENT_DATA in the subsequent DM events should be possible for
>> the attestation servers.
>>
>> Please let us know if you need further info.
> 
> For regular files with signatures, the file signature is verified
> against the file hash, both contained within the template data.  For
> the SELinux "critical-data",
> commit 2554a48f4437 ("selinux: measure state and policy capabilities")
> contains that information.  Missing from this patch set is information
> on how the attestation server could verify the DM critical data.
> 
> Does the DM record contain everything needed for the attestion server
> to verify the template record?  Are things like the hash algorithm hard
> coded?
> 
Thanks for the feedback.
I think you have a point (on documenting hash algo and version in the
IMA record).

For the individual targets (crypt/linear etc.) the target version
is already recorded during table_load [1].
So for new attribute add/update/delete to those targets in future,
they should be accompanied by bumping the relevant target version.
So that the attestation servers would know what attributes to expect,
based on the target's version number.
So individual targets are already taken care of.

But for overall DM records I think some versioning would be useful
to the attestation servers, to determine what to expect for the
attributes that are at device level (i.e. not part of any individual
targets e.g. "minor_count", "num_targets" etc.).

Further, for the DM records that are not "table_load" - what hashing
algo is used to hash active/inactive table is the implementation detail
specific to DM, as Mike called out; and it is orthogonal to IMA's hash
algo.

But I think it would be useful to record the active/inactive table's
hash algo as part of the overall DM record template, so that attestation 
servers would know to how to interpret the relevant data.
(i.e. "active_table_hash", "inactive_table_hash" in [2]).

Both the changes are simple enough.

I will prototype and propose them as incremental patches along with
other changes (pointed to dm-5.15 branch as per Mike's suggestion.)

Thanks for your suggestions again.

Regards,
Tushar

[1]
+10 a8c5ff755561c7a28146389d1514c318592af49a ima-buf 
sha256:4d73481ecce5eadba8ab084640d85bb9ca899af4d0a122989252a76efadc5b72
+table_load
+name=linear1,uuid=,major=253,minor=0,minor_count=1,num_targets=1;
+target_index=0,target_begin=0,target_len=2,target_name=linear,target_version=1.4.0,device_name=7:0,start=512;


+table_load
+name=test-crypt,uuid=,major=253,minor=0,minor_count=1,num_targets=1;
+target_index=0,target_begin=0,target_len=1953125,target_name=crypt,target_version=1.23.0,


[2]
+device_remove
+device_active_metadata=name=linear1,uuid=,major=253,minor=0,minor_count=1,num_targets=4;
+device_inactive_metadata=name=linear1,uuid=,major=253,minor=0,minor_count=1,num_targets=2;
+active_table_hash=4d73481ecce5eadba8ab084640d85bb9ca899af4d0a122989252a76efadc5b72,
+inactive_table_hash=5596cc857b0e887fd0c5d58dc6382513284596b07f09fd37efae2da224bd521d,remove_all=n;
+current_device_capacity=8;
> thanks,
> 
> Mimi
> 
> 
