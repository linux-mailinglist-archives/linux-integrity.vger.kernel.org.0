Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5565CA0EA9
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 02:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfH2AkI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 20:40:08 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:44779 "EHLO
        1.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfH2AkI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 20:40:08 -0400
X-Greylist: delayed 4626 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 20:40:07 EDT
Received: from player796.ha.ovh.net (unknown [10.108.57.140])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id A8C0C1081F3
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 01:22:59 +0200 (CEST)
Received: from 3mdeb.com (093105046241.oswiecim.vectranet.pl [93.105.46.241])
        (Authenticated sender: piotr.krol@3mdeb.com)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 635AA91D73D4;
        Wed, 28 Aug 2019 23:22:55 +0000 (UTC)
Subject: Re: TPM 2.0 Linux sysfs interface
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Ken Goldman <kgold@linux.ibm.com>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <1567004581.6115.33.camel@linux.ibm.com>
From:   =?UTF-8?Q?Piotr_Kr=c3=b3l?= <piotr.krol@3mdeb.com>
Openpgp: preference=signencrypt
Message-ID: <e8b2496b-7d53-f9d7-f2b7-779b87a4132a@3mdeb.com>
Date:   Thu, 29 Aug 2019 01:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567004581.6115.33.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 924082351426358420
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiuddgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/28/19 5:03 PM, Mimi Zohar wrote:
> [Cc'ing Petr Vorel]
> 
> Hi Piotr,

Hi Mimi,

> 
> On Tue, 2019-08-27 at 01:24 +0200, Piotr Król wrote:
>> Hi all,
>> I'm moving here discussion that I started with Jarkko and Peter on LinkedIn.
>>
>> I'm preparing for 2 talks during LPC 2019 System Boot MC and one of it
>> will discuss TPM 2.0 sysfs support [1]. This was discussed couple times
>> [2] and explained why it is not done yet by Jarkko [3].
>>
>> Why is this important?
>> - there seem to be no default method to distinguish if we dealing with
>> TPM 1.2 or 2.0 in the system. 
> 
> Agreed, this affects both the LTP IMA tests and ima-evm-utils package,
> which need to support both TPM 1.2 and 2.0 for the forseeable future.
> The LTP IMA tests check different sysfs files to determine if it is
> TPM 1.2 or TPM 2.0 (eg. /sys/class/tpm/tpm0/device/description,
> /sys/class/tpm/tpm0/device/pcrs and /sys/class/misc/tpm0/device/pcrs),
> but the "description" file is not defined by all TPM 2.0's.  It
> shouldn't be that difficult to define a single common sysfs file.

Thank you for that use cases I will point to that during LPC discussion.

Jarkko said that what he potential can cope with is:
/sys/class/tpm/tpm0/protocol_major

But maybe version file is also good to go, depends what it should return
and how that information should be obtained for various TPM versions.

> 
>> - distros use various tools to detect TPM based on sysfs (e.g. Qubes OS
>> scripts)
>> - tpm2-software has ton of dependencies, is not easy to build,
>> development is way faster then distros can manage and packages are often
>> out of date or even broken, so using it can be troublesome
>> - for deeply embedded systems adding fully-featured tpm2-software
>> doesn't make sense e.g. if we just need PCRs values
>>
>> Jarkko comment on detecting 1.2 vs 2.0:
>> "Detecting TPM 2.0 is dead easy: send any idempotent TPM 2.0 command and
>> check if the tag field matches 0x8002 (TPM_NO_SESSIONS). The sysfs
>> features for TPM 1.2 are for the large part useless as you can get the
>> same data by using TPM commands."
>>
>> Ok, but doesn't this mean I need TPM2 software stack?
>> Peter mentioned that it can be tricky to invoke such tools early in boot
>> process.
> 
> ima-evm-utils now uses the TPM 2.0 TSS[1] to read the PCRs.  I haven't
> tried using it during boot, but I don't forsee a problem. I guess it
> depends on how early you need to read the PCRs.

I'm still looking into use case to provide correct examples. I'm
thinking about edge computing devices e.g. Azure IoT Edge, AWS IoT and
Greengrass and its ability to perform trusted boot, but do not have
something well exercised yet.

Definitely there is automatic validation of hardware modules which is
time sensitive and faster access to basic functions verification, then
more savings to manufacturer.

For research purposes I tried couple queries on GitHub to check who use
pcrs throughs sysfs [1][2]. Among others you can find CoreOS, Android,
already mentioned LTP, some google projects. Quite a lot of user space
code to be fixed. Maybe if I will have enough time I will prepare
statistics about usage of given endpoints to quantify how those affect
system.

[1]
https://github.com/search?q=%22%2Fsys%2Fclass%2Ftpm%2Ftpm0%2Fdevice%2Fpcrs%22&type=Code
[2]
https://github.com/search?q=%22%2Fsys%2Fclass%2Fmisc%2Ftpm0%2Fdevice%2Fpcrs%22&type=Code

Best Regards,
-- 
Piotr Król
Embedded Systems Consultant
GPG: B2EE71E967AA9E4C
https://3mdeb.com | @3mdeb_com
