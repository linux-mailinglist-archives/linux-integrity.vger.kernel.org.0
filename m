Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1921514397
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Apr 2022 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355292AbiD2IIN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Apr 2022 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350225AbiD2IIM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Apr 2022 04:08:12 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180EF6F481
        for <linux-integrity@vger.kernel.org>; Fri, 29 Apr 2022 01:04:50 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb18.dynamic.kabel-deutschland.de [95.90.235.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D261261EA1923;
        Fri, 29 Apr 2022 10:04:47 +0200 (CEST)
Message-ID: <476db1ba-2e5f-ead2-72c8-e1c671e096f8@molgen.mpg.de>
Date:   Fri, 29 Apr 2022 10:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Dell XPS 13 9310 2-in-1: tpm tpm0: invalid TPM_STS.x 0xff,
 dumping stack for forensics
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org
References: <a1d39c04-d0a4-4b0b-5e39-5330e79d5fc0@molgen.mpg.de>
In-Reply-To: <a1d39c04-d0a4-4b0b-5e39-5330e79d5fc0@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Resend as reply, as original message was blocked due to too big Linux 
log attachment]

Am 28.04.22 um 17:35 schrieb Paul Menzel:
> Dear Linux folks,
> 
> 
> On a Dell XPS 13 9310 2-in-1, Linux 5.17.3 on Debian sid/unstable logs 
> the trace below:
> 
> ```
> [    0.000000] Linux version 5.17.0-1-amd64 
> (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-20) 11.2.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT Debian 5.17.3-1 (2022-04-18)
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9310 2-in-1/02P55J, BIOS 2.7.0 12/11/2021
> […]
> [171059.677004] tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
> [171059.677012] CPU: 5 PID: 38885 Comm: kworker/5:0 Not tainted 5.17.0-1-amd64 #1  Debian 5.17.3-1
> [171059.677014] Hardware name: Dell Inc. XPS 13 9310 2-in-1/02P55J, BIOS 2.7.0 12/11/2021
> [171059.677016] Workqueue: tpm_dev_wq tpm_dev_async_work
> [171059.677022] Call Trace:
> [171059.677025]  <TASK>
> [171059.677028]  dump_stack_lvl+0x48/0x5e
> [171059.677032]  tpm_tis_status.cold+0x19/0x20
> [171059.677035]  tpm_tis_send_data+0x3f/0x250
> [171059.677037]  tpm_tis_send_main+0x2e/0xf0
> [171059.677039]  tpm_transmit+0xd3/0x3e0
> [171059.677041]  tpm_dev_transmit.constprop.0+0x67/0xc0
> [171059.677043]  ? tpm_try_get_ops+0x44/0x90
> [171059.677044]  tpm_dev_async_work+0x62/0x90
> [171059.677046]  process_one_work+0x1e2/0x3b0
> [171059.677049]  ? rescuer_thread+0x390/0x390
> [171059.677050]  worker_thread+0x50/0x3a0
> [171059.677051]  ? rescuer_thread+0x390/0x390
> [171059.677051]  kthread+0xe5/0x110
> [171059.677053]  ? kthread_complete_and_exit+0x20/0x20
> [171059.677055]  ret_from_fork+0x1f/0x30
> [171059.677059]  </TASK>
> ```
> 
> Please find the output of `dmesg` attached.
> 
> 
> Kind regards,
> 
> Paul
