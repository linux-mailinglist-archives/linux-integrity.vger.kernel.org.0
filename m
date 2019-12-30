Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40A12D36F
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2019 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfL3Shf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 13:37:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33424 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfL3Shf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 13:37:35 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1BB6720B4798;
        Mon, 30 Dec 2019 10:37:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BB6720B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1577731054;
        bh=poXSaoy0MgWUlq8+h6lljwkSbM6p9BtBLLhoUaT8cK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HOpxi7BeXrHZKEbX7P3vH8BAwscdv6zPC/2l5Ai+S5GSlTRHguLwZPPB3j6tg05Av
         fJEYdEzaV/iUDwjs3WSQZrTHb2gOcJ8i2wwYiFp7e4mo5fCoN2uMOX2cjYrcmfAKi8
         6jriM0oYxedpcSnZMUJSS8RsXEqu+7/R4tYtkprw=
Subject: Re: [IMA] 11b771ffff:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
To:     Mimi Zohar <zohar@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, lkp@lists.01.org
References: <20191227142335.GE2760@shao2-debian>
 <1577725301.5874.32.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ee98e3a4-8664-ea20-dd9a-eff5edbe8a9e@linux.microsoft.com>
Date:   Mon, 30 Dec 2019 10:37:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577725301.5874.32.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/30/19 9:01 AM, Mimi Zohar wrote:

Hi Mimi,

> Hi Lakshmi,
> 
> On Fri, 2019-12-27 at 22:23 +0800, kernel test robot wrote:
>> [  333.455345] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
>> [  333.457243] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12395, name: userfaultfd
>> [  333.458888] CPU: 1 PID: 12395 Comm: userfaultfd Not tainted 5.5.0-rc1-00011-g11b771ffff8fc #1
>> [  333.461096] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [  333.463893] Call Trace:
>> [  333.465287]  <IRQ>
>> [  333.466351]  dump_stack+0x66/0x8b
>> [  333.467346]  ___might_sleep+0x102/0x120
>> [  333.468385]  mutex_lock+0x1c/0x40
>> [  333.469421]  ima_process_queued_keys+0x24/0x110
>> [  333.470529]  ? ima_process_queued_keys+0x110/0x110
>> [  333.471656]  call_timer_fn+0x2d/0x140
>> [  333.472707]  run_timer_softirq+0x46f/0x4b0
>> [  333.473752]  ? enqueue_hrtimer+0x39/0xa0
>> [  333.474780]  __do_softirq+0xe3/0x2f8
>> [  333.475768]  irq_exit+0xd5/0xe0
>> [  333.476738]  smp_apic_timer_interrupt+0x74/0x140
>> [  333.477834]  apic_timer_interrupt+0xf/0x20
>> [  333.478858]  </IRQ>
> 
> I think this is an instance where defining timer_expired as atomic and
> then testing it using atomic_dec_and_test() would help.  Either the
> queued keys would be deleted in ima_timer_handler() or measured in
> ima_process_queued_keys().
> 
> Mimi

Would it be better to use a spinlock (instead of a mutex) to synchronize 
access to the queued keys list? That would work for timer callback 
function also.

Before submitting the patch for freeing the keys I had tested the case 
where queued keys are freed in timer callback. But I did not hit the 
above break.

I will follow the steps given by Rong and validate the fix.

thanks,
  -lakshmi


