Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895F5B5AF7
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 07:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfIRFgZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 01:36:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727152AbfIRFgZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 01:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568784982;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qvp1cljbKiYc6JZ7ASovVYkcHNeE7rfkIgBN+kectPk=;
        b=iohd+qq7vGdyjAy4XcmXc+A4o0YhK0BWpceipz5TrYaDZ8zlg35FddCPVsX/y5eKPy2N4n
        PqreSY9FDjw8q+XtFZblgN5uNtCZWLQC5pvoohfPP78NJrHOzmsQ1344137SlQfCms3mvB
        n49OQXKtKi2kBJRFS75BuZ+zlGj1Zfw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-YebmoAVKM8KzJyqJuqEP7g-1; Wed, 18 Sep 2019 01:36:20 -0400
Received: by mail-qt1-f199.google.com with SMTP id p56so6801334qtj.14
        for <linux-integrity@vger.kernel.org>; Tue, 17 Sep 2019 22:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxpdfwp7uBR5NvESCT5Ng0dNV8mbIS26KONjSFVo90A=;
        b=ifJQWs0Q60xrxqXPZUVdgIA1oyUagKmXJd3WkUzjffIHtGo4KVvfF1k/BOwsDbj8tp
         uFftk/PG4Q3N41QKM6Z6D7UyQyP0JbRkCrBHVDpNBH8djwlN9R0m0cOsp3LzZQbGYLKc
         X45ZA1kyIYLnNbM1UrGmMO4iApzLQY9VI3HUPdKvH7qqzhp/3RsD3WpBQKZoMmeSKBIz
         pVstegnQu8nimcPKCaqR5xllPWD7VkZUezzS/qI2M4ElQVCYo5QO4c5AjQnAII+11bSQ
         Q5YItZIOnixH1JAQAFSEF8pgDj7Rrziz7lTNnDn9LnO0/9Cqys1lwWhrlSd6jEfXj8qe
         3gFg==
X-Gm-Message-State: APjAAAVDqWXe/rjc4fbbAB9cUI3ryh02G+gqDv0r0dvl1Ejxy5J0jbax
        ogltqhXBo4nMoOReZrniSS+youTazBfW5ugRMzlK7qfxeEfaPj//faUHMkD7EusSInMq9vwRi28
        c6l3lxK7sbzKnEP4+yRQ6yb8kTFHf
X-Received: by 2002:ac8:75cd:: with SMTP id z13mr2389338qtq.87.1568784980176;
        Tue, 17 Sep 2019 22:36:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAvTvbe24mpnYA1NKKGYEJUPFFaA0vcEf00b/KCZQq+I2koSOrnI8AKgP6vlv0pm4Ud4i1+w==
X-Received: by 2002:ac8:75cd:: with SMTP id z13mr2389324qtq.87.1568784979842;
        Tue, 17 Sep 2019 22:36:19 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id v2sm3150088qtv.22.2019.09.17.22.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 22:36:18 -0700 (PDT)
Date:   Tue, 17 Sep 2019 22:36:17 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Matthew Garrett <mjg59@google.com>
Subject: Re: unable to handle page fault in 5.3-rc[12]
Message-ID: <20190918053617.35i4yrbd5so5jvhr@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190801151314.f2tjk2b52mhxuc3x@cantor>
 <20190801201913.mwxqdfqb2a7c2zwn@cantor>
 <20190917232045.qgdomirhd7ll5sk3@cantor>
MIME-Version: 1.0
In-Reply-To: <20190917232045.qgdomirhd7ll5sk3@cantor>
User-Agent: NeoMutt/20180716
X-MC-Unique: YebmoAVKM8KzJyqJuqEP7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Sep 17 19, Jerry Snitselaar wrote:
>On Thu Aug 01 19, Jerry Snitselaar wrote:
>>Hi Matthew, cc'ing as this might have something to do with the recent
>>changes to tpm_read_log_efi.
>>
>>On Thu Aug 01 19, Jerry Snitselaar wrote:
>>>I've had a couple reports emailed to me with a trace like the following
>>>for 5.3-rc1 and 5.3-rc2. I'm just starting to dig into and look at recen=
t
>>>commits and mailing list, but is this already known?
>>>
>>>It's been reported on a couple different Lenovo laptop models (T470s and=
 X1 carbon I believe).
>>>
>>>Full panic message:
>>>[    0.774340] BUG: unable to handle page fault for address: ffffbc8fc00=
866ad
>>>[    0.774788] #PF: supervisor read access in kernel mode
>>>[    0.774788] #PF: error_code(0x0000) - not-present page
>>>[    0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d38067 P=
TE 0
>>>[    0.774788] Oops: 0000 [#1] SMP PTI
>>>[    0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.rc2.1.e=
lrdy.x86_64 #1
>>>[    0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N1WET51=
W (1.30 ) 09/14/2018
>>>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>>>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 =
e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 =
<f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>>>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>>>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffff=
ffffe962
>>>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1f=
c7c5b367
>>>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 80000000=
00000063
>>>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 00000000=
00003367
>>>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 00000000=
00000002
>>>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knl=
GS:0000000000000000
>>>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000=
003606f0
>>>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
>>>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
>>>[    0.774788] Call Trace:
>>>[    0.774788]  tpm_read_log_efi+0x156/0x1a0
>>>[    0.774788]  tpm_bios_log_setup+0xc8/0x190
>>>[    0.774788]  tpm_chip_register+0x50/0x1c0
>>>[    0.774788]  tpm_tis_core_init.cold.9+0x28c/0x466
>>>[    0.774788]  tpm_tis_plat_probe+0xcc/0xea
>>>[    0.774788]  platform_drv_probe+0x35/0x80
>>>[    0.774788]  really_probe+0xef/0x390
>>>[    0.774788]  driver_probe_device+0xb4/0x100
>>>[    0.774788]  device_driver_attach+0x4f/0x60
>>>[    0.774788]  __driver_attach+0x86/0x140
>>>[    0.774788]  ? device_driver_attach+0x60/0x60
>>>[    0.774788]  bus_for_each_dev+0x76/0xc0
>>>[    0.774788]  ? klist_add_tail+0x3b/0x70
>>>[    0.774788]  bus_add_driver+0x14a/0x1e0
>>>[    0.774788]  ? tpm_init+0xea/0xea
>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>>[    0.774788]  driver_register+0x6b/0xb0
>>>[    0.774788]  ? tpm_init+0xea/0xea
>>>[    0.774788]  init_tis+0x86/0xd8
>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>>[    0.774788]  ? driver_register+0x94/0xb0
>>>[    0.774788]  do_one_initcall+0x46/0x1e4
>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>>[    0.774788]  kernel_init_freeable+0x199/0x242
>>>[    0.774788]  ? rest_init+0xaa/0xaa
>>>[    0.774788]  kernel_init+0xa/0x106
>>>[    0.774788]  ret_from_fork+0x35/0x40
>>>[    0.774788] Modules linked in:
>>>[    0.774788] CR2: ffffbc8fc00866ad
>>>[    0.774788] ---[ end trace 42930799f8d6eaea ]---
>>>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>>>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 =
e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 =
<f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>>>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>>>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffff=
ffffe962
>>>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1f=
c7c5b367
>>>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 80000000=
00000063
>>>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 00000000=
00003367
>>>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 00000000=
00000002
>>>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knl=
GS:0000000000000000
>>>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000=
003606f0
>>>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
>>>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
>>>[    0.774788] Kernel panic - not syncing: Fatal exception
>>>[    0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (reloca=
tion range: 0xffffffff80000000-0xffffffffbfffffff)
>>>[    0.774788] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
>I finally was able to get a laptop model where this is being seen. efi_tpm=
_final_log_size is -1, which I'm guessing is coming from
>tpm2_calc_event_log_size, and the sanity check in tpm_read_log_efi is chec=
king if efi_tpm_final_log_size =3D=3D 0. Building a test
>kernel really quick to verify that tpm2_calc_event_log_size is where it or=
iginates, but I imagine there should be a check of tbl_size
>after tpm2_calc_event_log_size call in efi_tpm_eventlog_init?

Continuing to investigate, it is getting -1 back from tpm2_calc_event_log_s=
ize:

[    0.000000] efi_tpm_eventlog_init: final_tbl->nr_events =3D 52
[    0.000000] tpm2_calc_event_log_size: count: 52 event_size: 113
[    0.000000] tpm2_calc_event_log_size: count: 51 event_size: 93
[    0.000000] tpm2_calc_event_log_size: count: 50 event_size: 118
[    0.000000] tpm2_calc_event_log_size: count: 49 event_size: 123
[    0.000000] tpm2_calc_event_log_size: count: 48 event_size: 86
[    0.000000] tpm2_calc_event_log_size: count: 47 event_size: 161
[    0.000000] tpm2_calc_event_log_size: count: 46 event_size: 93
[    0.000000] tpm2_calc_event_log_size: count: 45 event_size: 106
[    0.000000] tpm2_calc_event_log_size: count: 44 event_size: 108
[    0.000000] tpm2_calc_event_log_size: count: 43 event_size: 86
[    0.000000] tpm2_calc_event_log_size: count: 42 event_size: 105
[    0.000000] tpm2_calc_event_log_size: count: 41 event_size: 93
[    0.000000] tpm2_calc_event_log_size: count: 40 event_size: 104
[    0.000000] tpm2_calc_event_log_size: count: 39 event_size: 95
[    0.000000] tpm2_calc_event_log_size: count: 38 event_size: 99
[    0.000000] tpm2_calc_event_log_size: count: 37 event_size: 99
[    0.000000] tpm2_calc_event_log_size: count: 36 event_size: 100
[    0.000000] tpm2_calc_event_log_size: count: 35 event_size: 100
[    0.000000] tpm2_calc_event_log_size: count: 34 event_size: 91
[    0.000000] tpm2_calc_event_log_size: count: 33 event_size: 91
[    0.000000] tpm2_calc_event_log_size: count: 32 event_size: 100
[    0.000000] tpm2_calc_event_log_size: count: 31 event_size: 122
[    0.000000] tpm2_calc_event_log_size: count: 30 event_size: 93
[    0.000000] tpm2_calc_event_log_size: count: 29 event_size: 86
[    0.000000] tpm2_calc_event_log_size: count: 28 event_size: 95
[    0.000000] tpm2_calc_event_log_size: count: 27 event_size: 119
[    0.000000] tpm2_calc_event_log_size: count: 26 event_size: 97
[    0.000000] tpm2_calc_event_log_size: count: 25 event_size: 92
[    0.000000] tpm2_calc_event_log_size: count: 24 event_size: 93
[    0.000000] tpm2_calc_event_log_size: count: 23 event_size: 158
[    0.000000] tpm2_calc_event_log_size: count: 22 event_size: 97
[    0.000000] tpm2_calc_event_log_size: count: 21 event_size: 92
[    0.000000] tpm2_calc_event_log_size: count: 20 event_size: 93
[    0.000000] tpm2_calc_event_log_size: count: 19 event_size: 131
[    0.000000] tpm2_calc_event_log_size: count: 18 event_size: 95
[    0.000000] tpm2_calc_event_log_size: count: 17 event_size: 88
[    0.000000] tpm2_calc_event_log_size: count: 16 event_size: 118
[    0.000000] tpm2_calc_event_log_size: count: 15 event_size: 90
[    0.000000] tpm2_calc_event_log_size: count: 14 event_size: 136
[    0.000000] tpm2_calc_event_log_size: count: 13 event_size: 0
[    0.000000] efi_tpm_eventlog_init: tpm2_calc_event_log_size returned: -1
...
[    1.282313] tpm_read_log_efi: efi_tpm_final_log_size is negative value: =
-1 (ffffffff)

Then it will also subtract log_tbl->final_events_preboot_size, and
this value gets passed to memcpy as the number of bytes to copy.

Is this comment correct for __calc_tpm2_event_size?

"Return: size of the event on success, <0 on failure"

There are a number of spots where it will set size to 0. It looks like the
only way it could potentially be less than 0 is where it does:

size =3D marker - marker_start;

