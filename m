Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCC822B82D
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 22:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgGWUw1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 16:52:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48280 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGWUw0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 16:52:26 -0400
Received: from [192.168.1.21] (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9D38320B4908;
        Thu, 23 Jul 2020 13:52:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D38320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595537546;
        bh=MkJad2TJtcjCuvlskHWJdWE/0toajwPGQ4XvgUMrNhQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P2ChGz+GBFQ/0Aprhq7MGyO9UWO8BTCwT/WPH1aGV5z9chckoaV8TPqgJB0EX04Rr
         xcmg5yRmnnEbI2nbcffcEZE6OlLC9P+tjZgpF6V0elAAmE3on6FVmjKVQ73GpmWuDx
         6J95vnsPWls6PA3xrEO8xQagXuQC2QKwmE/6wPwM=
Subject: Re: [PATCH v3] IMA: Add test for kexec cmdline measurement
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
References: <20200722184739.19460-1-t-josne@linux.microsoft.com>
 <20200723114600.GB31591@dell5510>
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
Message-ID: <0a970e3c-a10f-f032-eb26-d738bc220458@linux.microsoft.com>
Date:   Thu, 23 Jul 2020 16:52:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200723114600.GB31591@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,
Thank you for reviewing

On 7/23/20 7:46 AM, Petr Vorel wrote:
> Hi,
>
> ...
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
>> @@ -0,0 +1,121 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2020 Microsoft Corporation
>> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
>> +#
>> +# Verify that kexec cmdline is measured correctly.
>> +
>> +TST_NEEDS_CMDS="kexec sed xargs printf grep tr"
>> +TST_CNT=1
>> +TST_NEEDS_DEVICE=1
>> +
>> +. ima_setup.sh
>> +
>> +# Since the test is executed inside some sort of
>> +# separate shell, *most* environment variables are
>> +# not accessible, so there's no way to set it from
>> +# the outside.
> Do you mean that using this will not work?
> IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
> I don't understand that as I'm able to set variables even I run some tests in
> dracut.
I tried doing this in the past, and couldn't get it to work, but I just 
tried it again
and was able to get it working. Essentially, what I tried before was
`SOME_VAR="..." sudo runltp ...`, which doesn't work, but `sudo 
SOME_VAR="..." runltp` does pass the variable
to the test. So, that should be added to this patch.
>
> Also writing same docs doc on 2 places is not good. High level info should go to
> README.md, implementation details to shell script.
This is a good point. I'll reorganize the documentation of this patch.
> Please hold on with posting new version. I have several fixes, thus I'd like to
> send it after we sort this (trying to save you time).
Okay :)
> Kind regards,
> Petr
Thanks,
Lachlan
