Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8758D3F4F5E
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhHWRTH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 13:19:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52430 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhHWRTB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 13:19:01 -0400
Received: from [192.168.86.34] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9C64920C343B;
        Mon, 23 Aug 2021 10:18:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C64920C343B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1629739098;
        bh=b0Yigcye6x9PckOjQXnav3ly17jTY49ZQgPT88RzpRI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YnNehXXE8TKYIMJTI/ahXPkjuvEcN2HtSoELgpzwaEPy0TaBbvTGpNKDq1QFE3uI9
         1fBmmO3mv9kkRDODj/ZPFio4WcEwmr4Pq9Ce4rSHEumDqyYI08a344zCSdm+SBWilZ
         rPfypVUb0XeffWEgKuc9znWCFArgBFw2ym3rAhr4=
Subject: Re: [PATCH 0/6] updates to device mapper target measurement using ima
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, agk@redhat.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, sfr@canb.auug.org.au,
        public@thson.de, nramas@linux.microsoft.com,
        linux-block@vger.kernel.org
References: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
 <YSAOTX+TQwaCUeCn@redhat.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <d68666b2-7ae7-3932-e86e-abab0a2255ee@linux.microsoft.com>
Date:   Mon, 23 Aug 2021 10:18:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSAOTX+TQwaCUeCn@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mike,

On 8/20/21 1:19 PM, Mike Snitzer wrote:
> On Fri, Aug 13 2021 at  5:37P -0400,
> Tushar Sugandhi <tusharsu@linux.microsoft.com> wrote:
> 
>>
>> There were several improvements suggested for the original device mapper
>> target measurement patch series [1].
>>
>> Those improvement suggestions include:
>>   - Prefixing hashes for the DM tables being measured in ima log with the
>>     hash algorithm.
>>   - Adding version information for DM related events being measured in the
>>     ima log.
>>   - Prefixing DM related event names with "dm_".
>>   - Including the verity target attribute - "root_hash_sig_key_desc"
>>     in the ima measurement log.
>>
>> This series incorporates the above suggestions.
>>
>> This series also has the following fixes:
>>   - Adding a one-time warning to dmesg during dm_init if
>>     CONFIG_IMA_DISABLE_HTABLE is set to 'n'.
>>   - Updating 'integrity' target to remove the duplicate measurement of
>>     the attribute "mode=%c".
>>   - Indexing various attributes in 'multipath' target, and adding
>>     "nr_priority_groups=%u" attribute to the measurements.
>>   - Fixing 'make htmldocs' warnings in dm-ima.rst.
>>   - Adding missing documentation for the targets - 'cache', 'integrity',
>>     'multipath', and 'snapshot' in dm-ima.rst.
>>   - Updating dm-ima.rst documentation with the grammar for various DM
>>     events and targets in Backus Naur form.
>>   - Updating dm-ima.rst documentation to be consistent with the code
>>     changes described above.
>>
>> This series is based on top of the following git repo/branch/commit:
>>   Repo: https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
>>   Branch: dm-5.15
>>   Commit: commit 5a2a33884f0b ("dm crypt: Avoid percpu_counter spinlock contention in crypt_page_alloc()")
>>
>>
>> [1] https://patchwork.kernel.org/project/dm-devel/cover/20210713004904.8808-1-tusharsu@linux.microsoft.com/
>>
>> Tushar Sugandhi (6):
>>    dm ima: prefix dm table hashes in ima log with hash algorithm
>>    dm ima: add version info to dm related events in ima log
>>    dm ima: prefix ima event name related to device mapper with dm_
>>    dm ima: add a warning in dm_init if duplicate ima events are not
>>      measured
>>    dm ima: update dm target attributes for ima measurements
>>    dm ima: update dm documentation for ima measurement support
> 
> Hi,
> 
> I reviewed and staged these changes in dm-5.15 (and for-next) with
> minimal tweaks. Really just some whitespace and a simplification of
> the conditional for the warning in dm_init().
> 
> Please make sure that you manually apply Christoph's fix for the issue
> you reported earlier in the week, you were cc'd on the ultimate fix
> which has a different patch header than this patch but on a code level
> it is identical (and only patch that landed on a public mailing list
> due to typo in linux-block email address when hch sent the final fix):
> https://listman.redhat.com/archives/dm-devel/2021-August/msg00154.html
> 
> It is an issue that'll linger in the dm-5.15 because I cannot rebase
> at this late hour even once Jens picks the fix up into the
> linux-block tree.
> 
Thank you. I will apply Christoph's fix at my end and test the scenario 
again.

Thanks,
Tushar
> Thanks,
> Mike
> 
