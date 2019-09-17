Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD85B587B
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 01:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfIQXUv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Sep 2019 19:20:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728593AbfIQXUv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Sep 2019 19:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568762449;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93E18wmPDnWISw+WCxSngiCmtTN5YEZlrDezy3l38Gk=;
        b=couZs63Fg0Tp2CIvtlwf5ND1giwaltS5SjV6dsjaI+i/mDo++bMzUobvGEMWFipAc2y0T0
        UyFAGK5BK/psfoKcl3oBjr8OPy9ojJV8+I5uXPR5QRW1NeBfBUpyk4wAKV1xCeYLl+1Pu4
        kssgJSlcLKdWLjy9JA2HN2Uf/bcCWVM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-LdaHhzC8M8e8_Y3kGEeKWQ-1; Tue, 17 Sep 2019 19:20:48 -0400
Received: by mail-qt1-f200.google.com with SMTP id u8so6024470qtq.19
        for <linux-integrity@vger.kernel.org>; Tue, 17 Sep 2019 16:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7+WxHU8ygfk3h+I6FmzyR0qaXk6tSMIwN3i7ZC9x+Vc=;
        b=AxycKduA4cNbEpc2Pup+NkjQELTpIl1fZu29XfNtAKLYtHls1NKL3S/8KOEcA7T1Cy
         rmt7fJYikAhrEhQ6ZPZc8YzaC6ahXGzoKvZMrDuaHkF/0IDQTppD+LtgQ84BsqNFOyw8
         D5UhjK/MNcj4h40OVP8d5grlZW8fO9MNAmiLvO6Uio5wsD+xVV+L5GpK8y+oYlaRhkx2
         SwZw8gcz2xSCnTDUaSYVQfVJsD/L4PWA+mxPsrJIpSa+FCVIUc2YHnNMYDThUVZgOfwH
         ZFwCr7gBWLi7NHAaY3Aw0Iy/Cxb3jGjsmYygDkaNONGX3wXUbizsOcDYYrhrvfSyUwmO
         wtdA==
X-Gm-Message-State: APjAAAXGuXOQufbtIQfA9K89rVa1PrS2BsUc5k2Ivi8JHy9jRO/UICnI
        Kgr6uaOf+EQdJSyPdCO46O2o6VAItV/3a0z3jp/i+3w1lWKxk0pvdP0/ZYAnxUpDZmN1FUYSa+E
        MrktwPtmcrtlF4UVOZysYgxPdmrQK
X-Received: by 2002:ac8:5243:: with SMTP id y3mr1480366qtn.51.1568762447608;
        Tue, 17 Sep 2019 16:20:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwp0F+aEG1fWsAucZwpZA+kpCXViLPadwjlFc+b7X/2c9+Cz4HtEOjkcvR0QInYE1jHqo8VDg==
X-Received: by 2002:ac8:5243:: with SMTP id y3mr1480346qtn.51.1568762447265;
        Tue, 17 Sep 2019 16:20:47 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id i1sm1727204qkk.88.2019.09.17.16.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 16:20:46 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:20:45 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Matthew Garrett <mjg59@google.com>
Subject: Re: unable to handle page fault in 5.3-rc[12]
Message-ID: <20190917232045.qgdomirhd7ll5sk3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190801151314.f2tjk2b52mhxuc3x@cantor>
 <20190801201913.mwxqdfqb2a7c2zwn@cantor>
MIME-Version: 1.0
In-Reply-To: <20190801201913.mwxqdfqb2a7c2zwn@cantor>
User-Agent: NeoMutt/20180716
X-MC-Unique: LdaHhzC8M8e8_Y3kGEeKWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 01 19, Jerry Snitselaar wrote:
>Hi Matthew, cc'ing as this might have something to do with the recent
>changes to tpm_read_log_efi.
>
>On Thu Aug 01 19, Jerry Snitselaar wrote:
>>I've had a couple reports emailed to me with a trace like the following
>>for 5.3-rc1 and 5.3-rc2. I'm just starting to dig into and look at recent
>>commits and mailing list, but is this already known?
>>
>>It's been reported on a couple different Lenovo laptop models (T470s and =
X1 carbon I believe).
>>
>>Full panic message:
>>[    0.774340] BUG: unable to handle page fault for address: ffffbc8fc008=
66ad
>>[    0.774788] #PF: supervisor read access in kernel mode
>>[    0.774788] #PF: error_code(0x0000) - not-present page
>>[    0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d38067 PT=
E 0
>>[    0.774788] Oops: 0000 [#1] SMP PTI
>>[    0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.rc2.1.el=
rdy.x86_64 #1
>>[    0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N1WET51W=
 (1.30 ) 09/14/2018
>>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e=
9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <=
f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: fffffffff=
fffe962
>>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc=
7c5b367
>>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 800000000=
0000063
>>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 000000000=
0003367
>>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 000000000=
0000002
>>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlG=
S:0000000000000000
>>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 000000000=
03606f0
>>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
>>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
>>[    0.774788] Call Trace:
>>[    0.774788]  tpm_read_log_efi+0x156/0x1a0
>>[    0.774788]  tpm_bios_log_setup+0xc8/0x190
>>[    0.774788]  tpm_chip_register+0x50/0x1c0
>>[    0.774788]  tpm_tis_core_init.cold.9+0x28c/0x466
>>[    0.774788]  tpm_tis_plat_probe+0xcc/0xea
>>[    0.774788]  platform_drv_probe+0x35/0x80
>>[    0.774788]  really_probe+0xef/0x390
>>[    0.774788]  driver_probe_device+0xb4/0x100
>>[    0.774788]  device_driver_attach+0x4f/0x60
>>[    0.774788]  __driver_attach+0x86/0x140
>>[    0.774788]  ? device_driver_attach+0x60/0x60
>>[    0.774788]  bus_for_each_dev+0x76/0xc0
>>[    0.774788]  ? klist_add_tail+0x3b/0x70
>>[    0.774788]  bus_add_driver+0x14a/0x1e0
>>[    0.774788]  ? tpm_init+0xea/0xea
>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>[    0.774788]  driver_register+0x6b/0xb0
>>[    0.774788]  ? tpm_init+0xea/0xea
>>[    0.774788]  init_tis+0x86/0xd8
>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>[    0.774788]  ? driver_register+0x94/0xb0
>>[    0.774788]  do_one_initcall+0x46/0x1e4
>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>[    0.774788]  kernel_init_freeable+0x199/0x242
>>[    0.774788]  ? rest_init+0xaa/0xaa
>>[    0.774788]  kernel_init+0xa/0x106
>>[    0.774788]  ret_from_fork+0x35/0x40
>>[    0.774788] Modules linked in:
>>[    0.774788] CR2: ffffbc8fc00866ad
>>[    0.774788] ---[ end trace 42930799f8d6eaea ]---
>>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e=
9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <=
f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: fffffffff=
fffe962
>>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc=
7c5b367
>>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 800000000=
0000063
>>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 000000000=
0003367
>>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 000000000=
0000002
>>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlG=
S:0000000000000000
>>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 000000000=
03606f0
>>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
>>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
>>[    0.774788] Kernel panic - not syncing: Fatal exception
>>[    0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
>>[    0.774788] ---[ end Kernel panic - not syncing: Fatal exception ]---

I finally was able to get a laptop model where this is being seen. efi_tpm_=
final_log_size is -1, which I'm guessing is coming from
tpm2_calc_event_log_size, and the sanity check in tpm_read_log_efi is check=
ing if efi_tpm_final_log_size =3D=3D 0. Building a test
kernel really quick to verify that tpm2_calc_event_log_size is where it ori=
ginates, but I imagine there should be a check of tbl_size
after tpm2_calc_event_log_size call in efi_tpm_eventlog_init?

