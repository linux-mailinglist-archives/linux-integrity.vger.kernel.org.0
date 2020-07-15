Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8244221541
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGOTiV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 15:38:21 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47144 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGOTiV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 15:38:21 -0400
Received: from [192.168.1.21] (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 98EA320B4909;
        Wed, 15 Jul 2020 12:38:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98EA320B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594841901;
        bh=6+Oy96GDeWcYO3bA6soGvFgHrrxXgSLwlsMbiPmwJHk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lxbO83fnCbJ7WMpt0a2w837LV51kVRK3aNhqnekQCNI2bQmO8XIe6Hnwjzz/m+5sk
         89YSkibntsmYm8PPgwy7cdOLoB3hJ6MyUQb4Rcv9aQlPfx5s3P1Sm9uXSjCxcOAH2i
         2vCx1o3BUsD6lNSs5DeI1AElILAxpMdpjuH5WolM=
Subject: Re: [PATCH 1/2] IMA: Verify that the kernel cmdline is passed and
 measured correctly through the kexec barrier.
To:     Mimi Zohar <zohar@linux.ibm.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
 <1594774692.12900.220.camel@linux.ibm.com>
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
Message-ID: <53323968-55b9-68ae-dc3f-de9cbd223ff1@linux.microsoft.com>
Date:   Wed, 15 Jul 2020 15:38:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1594774692.12900.220.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/14/20 8:58 PM, Mimi Zohar wrote:
> On Thu, 2020-07-02 at 11:35 -0400, Lachlan Sneff wrote:
>> Add a testcase that verifies that kexec correctly logs the
>> kernel command line to the IMA buffer and that the command
>> line is then correctly measured.
>>
>> This test must be run standalone, since it runs kexec
>> multiple times (and therefore reboots several times).
> Verifying the kexec boot command line doesn't require rebooting.  Just
> loading the kexec kernel image should be enough (kexec -s -l).
>   Verifying that the measurement list, including the kexec boot command
> line, is carried across kexec could be a separate test.

This is true. However, it only appends to the IMA log once, even if you 
unload (`kexec -u`) the kexec kernel after `kexec -s -l ...`.

Therefore, the test would only be able to check kexec with the cmdline 
supplied in one way.

I will have to check internally if that's the right way to go. If it 
didn't need to reboot, then the test could be integrated into the normal 
IMA tests,
which would definitely be a good thing.

Regards,

Lachlan

