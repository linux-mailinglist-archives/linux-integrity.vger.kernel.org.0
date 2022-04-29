Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00284514926
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Apr 2022 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359042AbiD2MZo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Apr 2022 08:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359035AbiD2MZn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Apr 2022 08:25:43 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14ABB82D8
        for <linux-integrity@vger.kernel.org>; Fri, 29 Apr 2022 05:22:19 -0700 (PDT)
Received: from [141.14.12.206] (g206.RadioFreeInternet.molgen.mpg.de [141.14.12.206])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA80B61EA1923;
        Fri, 29 Apr 2022 14:22:16 +0200 (CEST)
Message-ID: <17a22b43-573b-3406-0f4c-f687bc266a5a@molgen.mpg.de>
Date:   Fri, 29 Apr 2022 14:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Dell XPS 13 9310 2-in-1: tpm tpm0: invalid TPM_STS.x 0xff,
 dumping stack for forensics
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Laurent Bigonville <bigon@debian.org>
References: <a1d39c04-d0a4-4b0b-5e39-5330e79d5fc0@molgen.mpg.de>
 <476db1ba-2e5f-ead2-72c8-e1c671e096f8@molgen.mpg.de>
In-Reply-To: <476db1ba-2e5f-ead2-72c8-e1c671e096f8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Linux folks,


Am 29.04.22 um 10:04 schrieb Paul Menzel:
> [Resend as reply, as original message was blocked due to too big Linux 
> log attachment]
> 
> Am 28.04.22 um 17:35 schrieb Paul Menzel:

>> On a Dell XPS 13 9310 2-in-1, Linux 5.17.3 on Debian sid/unstable logs 
>> the trace below:
>>
>> ```
>> [    0.000000] Linux version 5.17.0-1-amd64 
>> (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-20) 11.2.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT Debian 5.17.3-1 (2022-04-18)
>> […]
>> [    0.000000] DMI: Dell Inc. XPS 13 9310 2-in-1/02P55J, BIOS 2.7.0 12/11/2021
>> […]
>> [171059.677004] tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
>> [171059.677012] CPU: 5 PID: 38885 Comm: kworker/5:0 Not tainted 5.17.0-1-amd64 #1  Debian 5.17.3-1
>> [171059.677014] Hardware name: Dell Inc. XPS 13 9310 2-in-1/02P55J, BIOS 2.7.0 12/11/2021

By the way, newer system firmware is available, but not over LVFS [1].

>> [171059.677016] Workqueue: tpm_dev_wq tpm_dev_async_work
>> [171059.677022] Call Trace:
>> [171059.677025]  <TASK>
>> [171059.677028]  dump_stack_lvl+0x48/0x5e
>> [171059.677032]  tpm_tis_status.cold+0x19/0x20
>> [171059.677035]  tpm_tis_send_data+0x3f/0x250
>> [171059.677037]  tpm_tis_send_main+0x2e/0xf0
>> [171059.677039]  tpm_transmit+0xd3/0x3e0
>> [171059.677041]  tpm_dev_transmit.constprop.0+0x67/0xc0
>> [171059.677043]  ? tpm_try_get_ops+0x44/0x90
>> [171059.677044]  tpm_dev_async_work+0x62/0x90
>> [171059.677046]  process_one_work+0x1e2/0x3b0
>> [171059.677049]  ? rescuer_thread+0x390/0x390
>> [171059.677050]  worker_thread+0x50/0x3a0
>> [171059.677051]  ? rescuer_thread+0x390/0x390
>> [171059.677051]  kthread+0xe5/0x110
>> [171059.677053]  ? kthread_complete_and_exit+0x20/0x20
>> [171059.677055]  ret_from_fork+0x1f/0x30
>> [171059.677059]  </TASK>
>> ```
>>
>> Please find the output of `dmesg` attached.

According to the system firmware menu it’s a TPM 2.0 device, and Linux 
confirms that:

     $ sudo grep -R . /sys/module/tpm
     grep: /sys/module/tpm/uevent: Permission denied
     /sys/module/tpm/parameters/suspend_pcr:0
     /sys/module/tpm/version:2.0
     $ cat /sys/devices/platform/STM0125\:00/tpm/tpm0/tpm_version_major
     2

The message is *not* logged at every boot/run, and it’s present three 
times in the log, already with Linux 5.16.7 from Debian sid/unstable 
(but not always). The second one below is different though:

```
[…]
tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
CPU: 4 PID: 84 Comm: kworker/4:1 Not tainted 5.16.0-1-amd64 #1  Debian 
5.16.7-1
Hardware name: Dell Inc. XPS 13 9310 2-in-1/02P55J, BIOS 2.7.0 12/11/2021
Workqueue: tpm_dev_wq tpm_dev_async_work
Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x5e
  tpm_tis_status.cold+0x19/0x20
  tpm_tis_send_data+0x3f/0x250
  tpm_tis_send_main+0x2e/0xf0
  tpm_transmit+0xd3/0x3e0
  tpm_dev_transmit.constprop.0+0x67/0xc0
  ? tpm_try_get_ops+0x44/0x90
  tpm_dev_async_work+0x62/0x90
  process_one_work+0x1e5/0x3c0
  worker_thread+0x50/0x3b0
  ? rescuer_thread+0x370/0x370
  kthread+0x169/0x190
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x1f/0x30
  </TASK>
[…]
```

```
[…]
ima: Allocated hash algorithm: sha256
tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.16.0-1-amd64 #1  Debian 5.16.7-2
Hardware name: Dell Inc. XPS 13 9310 2-in-1/02P55J, BIOS 2.7.0 12/11/2021
Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x5e
  tpm_tis_status.cold+0x19/0x20
  tpm_tis_send_data+0x3f/0x250
  tpm_tis_send_main+0x2e/0xf0
  tpm_transmit+0xd3/0x3e0
  tpm_transmit_cmd+0x25/0x90
  tpm2_pcr_read+0x177/0x300
  tpm_pcr_read+0x5a/0x70
  ima_calc_boot_aggregate_tfm+0xc3/0x190
  ? desc_read_finalized_seq+0x2f/0x90
  ? _prb_read_valid+0x235/0x2b0
  ? prb_read_valid+0x17/0x20
  ? console_unlock+0x2cc/0x4b0
  ima_calc_boot_aggregate+0xc3/0xf0
  ? hash_setup+0xc5/0xc5
  ima_add_boot_aggregate+0xaa/0x13e
  ima_init+0x5e/0xa9
  init_ima+0x23/0xb5
  ? hash_setup+0xc5/0xc5
  do_one_initcall+0x41/0x200
  kernel_init_freeable+0x21b/0x282
  ? rest_init+0xd0/0xd0
  kernel_init+0x16/0x120
  ret_from_fork+0x1f/0x30
  </TASK>
ima: No architecture policies found
[…]
```


Kind regards,

Paul


[1]: https://github.com/fwupd/firmware-dell/issues/124
