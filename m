Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1627EAE0
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgI3O0V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 10:26:21 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57534 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbgI3O0V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 10:26:21 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 879D720B7178;
        Wed, 30 Sep 2020 07:26:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 879D720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601475980;
        bh=/TmI+R+MOE67+Ea8E2HPwFjBBTPt64CHISo+2O7ANIE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iGoLWk5KJ76k+m1oEMSlCadtbYcyywe5jCu/x2Uji+76pVJugELXYyQDy9FDebRSq
         xRazxBIBqJa998WLBnl6IwUylU3FrFGZOc06pc2ZxzKxzrT9R2V6xPZ89TQjLF6QR6
         ns4au3ejy1olW3vPyoVz4iVvwEv3WuCQUAGBxD4s=
Subject: Re: [PATCH v1 0/1] ima: Add test for selinux measurement
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
References: <20200928194730.20862-1-nramas@linux.microsoft.com>
 <20200929052340.GA4976@dell5510>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <281c5fa0-8d3a-0812-9d20-a5c7ee4f7666@linux.microsoft.com>
Date:   Wed, 30 Sep 2020 07:26:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929052340.GA4976@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/28/20 10:23 PM, Petr Vorel wrote:
> Hi Lakshmi,
> 
> Thanks for your patch. FYI I'll try to have look ASAP, but as there is LTP
> freeze and work needed to review fixes before release I'll probably review this
> after the release (1, max. 2 weeks).
> 
> Could you please have a look at fix planned to be part of the release?
> https://patchwork.ozlabs.org/project/ltp/list/?series=204230
> 

Will do Petr.

> 
>> New functionality is being added to IMA to measure data provided by
>> kernel components. With this feature, IMA policy can be set to enable
>> measuring data provided by Linux Security Modules (LSM). Currently one
>> such LSM namely selinux is being updated to use this functionality.
>> This new functionality needs test automation in LTP.
> 
>> This patch set adds tests which verify that the IMA subsystem correctly
>> measures the data provided by selinux.
> 
>> This patch is based on
>> commit 286401a1c1f3 ("thp04: Add linux tag")
>> in "master" branch in https://github.com/linux-test-project/ltp
> 
>> This patch is dependent on the following patch series in LTP
>> https://patchwork.kernel.org/patch/11802771/
> I put link to LTP patchwork to avoid the confusion.
> https://patchwork.ozlabs.org/project/ltp/list/?series=204486

Thanks. On the next update I'll add the LTP patchwork URL.

> 
>> This series needs a kernel built on the following repo/branch/patches:
>> repo: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>> branch: next
>> commit 8861d0af642c ("selinux: Add helper functions to get and set checkreqprot")
> Thanks for adding this info. It'd be great if it were part of kernel commit
> message and also added as a comment in the test itself (we don't want to get it
> lost).
> 
> BTW LTP has 2 kind ways of handling of kernel versions:
> 
> * fixes which are meant to be backported to the stable trees:
> In C API it looks like (here also with CVE entry):
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/bpf/bpf_prog03.c#L187
> .tags = (const struct tst_tag[]) {
> 		{"linux-git", "95a762e2c8c9"},
> 		{"CVE", "2017-16995"},
> 		{}
> This is not part of shell API, but I'll add it after the release. Thus we don't
> want to loose this info.
> 
> * new kernel features, which are likely not to be backported
> You either have some way to detect this feature is presented (ideally) or you
> specify kernel version since it should be run
> This is used in shell API as:
> https://github.com/linux-test-project/ltp/blob/master/testcases/network/tcp_cc/bbr02.sh#L8
> TST_MIN_KVER="4.13"

Thanks for the info.

  -lakshmi

> 
>> And the following patch series should be applied in the following order:
>>    1, https://patchwork.kernel.org/patch/11709527/
>>    2, https://patchwork.kernel.org/patch/11795559/
>>    3, https://patchwork.kernel.org/patch/11801525/
>>    4, https://patchwork.kernel.org/patch/11801585/
> 

