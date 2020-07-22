Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C42229AEE
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgGVPDF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 11:03:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36534 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGVPDF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 11:03:05 -0400
Received: from [192.168.1.21] (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 701AC20B4908;
        Wed, 22 Jul 2020 08:03:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 701AC20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595430184;
        bh=E5dpxHVJbUQQifwFb/48uNvFmC9bkNwvV0fmoWR2OKo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EdP6rIvPwum83NID5fPaszCP8UWwuZnpy0mCiZ8kiGIFx/h9Dw/kxQQR7RgfmHllj
         V8axXI4NMy0ILiM5eWoZx2NFdxcqEBTQjWz8cntNku9TdZihnq/5/Qrf+ERfkhmHyV
         od/U+X8HVWyANx75wJHtkRuHBnf3uV6rueyeWsKw=
Subject: Re: [PATCH] IMA: Add test for kexec cmdline measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
References: <20200721182440.4169-1-t-josne@linux.microsoft.com>
 <1595426682.5311.83.camel@linux.ibm.com>
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
Message-ID: <1d11d0ab-45fc-a006-3594-d01eaed1a1f2@linux.microsoft.com>
Date:   Wed, 22 Jul 2020 11:03:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1595426682.5311.83.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thank you for the review, Mimi!

On 7/22/20 10:04 AM, Mimi Zohar wrote:
> On Tue, 2020-07-21 at 14:24 -0400, Lachlan Sneff wrote:
>
> <snip>
>
>> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
>> new file mode 100644
>> index 000000000..7d71557ee
>> --- /dev/null
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
>> @@ -0,0 +1,93 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2020 Microsoft Corporation
>> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
>> +#
>> +# Verify that kexec cmdline is measured correctly.
>> +
>> +TST_NEEDS_CMDS="kexec sed xargs printf grep"
>> +TST_CNT=1
>> +TST_NEEDS_DEVICE=1
>> +
>> +. ima_setup.sh
>> +
>> +# Since the test is executed inside some sort of
>> +# separate shell, *most* environment variables are
>> +# not accessible, so there's no way to set it from
>> +# the outside.
>> +#
>> +# `/boot/vmlinuz-$(uname-r)` is where the image is
>> +# located on many systems, but not all. Therefore,
>> +# if the image is not located there, require the
>> +# user to copy it to `/tmp/Image`.
>> +#
>> +# Ideally, this test shouldn't even require an image,
>> +# since it doesn't actually reboot, but the IMA cmdline
>> +# measurement occurs after the image is parsed and verified,
>> +# so we must pass a valid kernel image. There is a possiblity of
>> +# putting together a "faux" kernel image that has the right headers
>> +# and appears to be signed correctly, but doesn't actually contain any
>> +# code, but, after investigating that possiblity, it appears to be
>> +# quite difficult (and would require a new faux kernel for each arch).
> The comment formatting is inconsistent.  Please correct.
Oops, sorry, will fix!
>> +IMAGE="/boot/vmlinuz-$(uname -r)"
>> +if [ ! -f $IMAGE ]; then
>> +    IMAGE="/tmp/Image"
>> +fi
>> +
>> +measure() {
>> +    local found temp_file="file.txt" temp_file2="file2.txt" algorithm \
>> +        digest expected_digest
>> +
>> +    echo -n "$1" > $temp_file
>> +    grep "kexec-cmdline" $ASCII_MEASUREMENTS > $temp_file2
>> +
>> +    while read found
>> +    do
>> +        algorithm=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f1)
>> +        digest=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f2)
>> +
>> +        expected_digest=$(compute_digest $algorithm $temp_file)
>> +
>> +        if [ "$digest" = "$expected_digest" ]; then
>> +            return 0
>> +        fi
>> +    done < $temp_file2
>> +
>> +    return 1
>> +}
>> +
>> +# Test that the kexec cmdline is measured correctly.
>> +# NOTE: This does *not* actually reboot.
>> +test1() {
>> +    # Strip the `BOOT_IMAGE=...` part from the cmdline.
>> +    local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
>> +    if ! kexec -sl $IMAGE --reuse-cmdline; then
>> +        tst_brk TCONF "kexec failed: $?"
>> +    fi
> Most likely one of the reasons for the kexec to fail is that the
> kernel image isn't properly signed.  How about checking the secure-
> boot status to provide some contextual information.
Good call, I'll add that check if kexec fails. On some of the systems 
that this test
needs to run on, there is no `bootctl` or `mokutil` command, so I'll try 
running one of those
if they exist to check.
>
>> +
>> +    if ! measure "$cmdline"; then
>> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
>> +    fi
> This assumes that a kexec command line measurement was found.  The
> output needs to differentiate between no measurement and an invalid
> measurement.  In the case that the rule doesn't exist, at that point
> you have a choice of skipping the test or extending the IMA policy.
>
> The kernel kexec selftests checks both the Kconfig and the IMA runtime
> policy.  Different testing infrastructures have different policies
> about basing tests on them.
Okay, I can check if no measurement was found, or if it occurred 
incorrectly.
The kconfig is not available on the systems I need to run this test on, 
so I will read
the ima policy to check if the system is, in fact, set up to measure the 
kexec cmdline.
>> +
>> +    cmdline="foo"
> Wondering if unknown command line options could cause the kexec to
> fail.
I haven't had this fail, what do you suggest?
>
>> +    if ! kexec -sl $IMAGE --append=$cmdline; then
>> +        tst_brk TCONF "kexec failed: $?"
>> +    fi
> Should the first kernel image be unloaded first?
Probably a good thing to do, but it hasn't influenced the test so far.
I assume each kernel is unloaded once another attempts to be loaded.
>
> Mimi
>
>> +
>> +    if ! measure "$cmdline"; then
>> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
>> +    fi
>> +
>> +    cmdline="bar"
>> +    if ! kexec -sl $IMAGE --command-line=$cmdline; then
>> +        tst_brk TCONF "kexec failed: $?"
>> +    fi
>> +
>> +    if ! measure "$cmdline"; then
>> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
>> +    fi
>> +
>> +    tst_res TPASS "kexec cmldine was measured correctly"
>> +}
>> +
>> +tst_run
