Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F9221558
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 21:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGOTqk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 15:46:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48138 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgGOTqk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 15:46:40 -0400
Received: from [192.168.1.21] (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CE6B20B4909;
        Wed, 15 Jul 2020 12:46:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CE6B20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594842399;
        bh=d3CV4BL7ujSFiwhyOnB+HGNOe44sG+z8CNjbDopcBCc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ip6my/otIOnxnQ0GXpo01z1P/2A9T31qikBqEQf4K4I4UeuiMDHf1crTbQ+cpmwdv
         5CohA8ZVRhmtwN8sLln9Dft/7GvAzOzEQqVof05OaoQM/mB9OAESNfu8xbbLDE9GbF
         b89xdFfzqVRPRJ6Z0Dz2JeUjqQSUUqHA44KGtBLA=
Subject: Re: [PATCH 1/2] IMA: Verify that the kernel cmdline is passed and
 measured correctly through the kexec barrier.
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
 <20200715081857.GB10916@dell5510>
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
Message-ID: <3ec443ab-f9ed-a435-2a61-e1b7c8f513dd@linux.microsoft.com>
Date:   Wed, 15 Jul 2020 15:46:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200715081857.GB10916@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/15/20 4:18 AM, Petr Vorel wrote:
>> +++ b/testcases/kexec/utils.sh
>> @@ -0,0 +1,47 @@
>> +#!/bin/sh
>> +
>> +install() {
>> +    local arg="$1"
>> +
>> +    if [ ! -d "/etc/init.d" ]; then
>> +        mkdir /etc/init.d
>> +    fi
> I'm not sure if tests like this are suitable for LTP.
> Ideal LTP test is a normal test, which is able to run with runltp, cleanup after
> itself and use LTP C or/and shell API. LTP is full of tests which needs special
> handling and thus not being run, not sure if it's a good idea to introduce yet
> another one.
>
> Also test shouldn't not significantly modify SUT to make it unbootable, which
> I'm not sure in this case. This is a big difference to kselftests which are
> meant to help during kernel development which somehow expects some system
> modifications (as you install your custom build kernel).
>
> I wonder if using QEMU would help to implement this test while not touching SUT
> (thus be able to run this test with runltp). If you miss something in LTP API
> just let us know.
Using qemu is an interesting idea, but would be difficult to generalize.

I actually do agree with you that a test like this may not be 
appropriate for
LTP since it's so separate and alien to the rest of the LTP suite.

I need to confirm internally before I make a decision here, but is there
a better place to put a test like this?


Thanks for your review,

Lachlan :)

