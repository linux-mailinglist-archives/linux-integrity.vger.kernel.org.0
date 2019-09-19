Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1CB836D
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2019 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390890AbfISVbO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Sep 2019 17:31:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388191AbfISVbN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Sep 2019 17:31:13 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE9117FDF6
        for <linux-integrity@vger.kernel.org>; Thu, 19 Sep 2019 21:31:12 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id b67so5654907qkc.1
        for <linux-integrity@vger.kernel.org>; Thu, 19 Sep 2019 14:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4JHJdywACvhqkqTEfAqDPP5VgVLXQ24x2fPBDFinYY=;
        b=Hl5HhGQqFzt1JlJdmmTCh4YGB6stM69XGcWof3+YRWzq9Apbm5s1+7oZQEYZAoMWQ5
         cwcsKQ+1/BbQLKFTAM/rHeE6xSdfMu3RDHPZGgXe8WTaIKWbHGWioA4+1165mnyeGJQh
         RQ5jbXS181DjROpSrZK6WHZIoloDZ40CpuqxdP8lcL4jNkIzfAO6NXenwJjiXuFKYluQ
         ZoTj8PaFx31h1hk67nwbMBaE95Ka9OhIzaNzV2w2m5+jT102BNz9tBg1WoEHv2Lt/225
         cDUUc46e7vYqW/Wou3XqGkZEuEtIkgPioHIwqRNT7AUU4EqlCGaReP12Qry0sRRGhTQk
         DGug==
X-Gm-Message-State: APjAAAVyTJv0DvriUTpkL//AvRxe77vpRs71Sg/pBmmynVR0pHPhE50Q
        DzZKvUSYNnWNSrANr7U1ULrq+L5R7sIoRlZnZ+Of4XDh5EbzK7GTXNxHi5qm89HIPVxEOUP6Y3X
        l+S96SsBG57DwA53zSYk1926D5Rxa
X-Received: by 2002:ae9:ee17:: with SMTP id i23mr5020195qkg.179.1568928671657;
        Thu, 19 Sep 2019 14:31:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwf5NXLO9VW8IyDQ7K95itMS4LfIzY5SAmAnnAZwRGaW432DyXGVsLHsxH09jchLfcU9myi3g==
X-Received: by 2002:ae9:ee17:: with SMTP id i23mr5020150qkg.179.1568928671252;
        Thu, 19 Sep 2019 14:31:11 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l7sm15156qke.67.2019.09.19.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 14:31:10 -0700 (PDT)
Date:   Thu, 19 Sep 2019 14:31:03 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Patrick Uiterwijk <puiterwijk@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Subject: Re: unable to handle page fault in 5.3-rc[12]
Message-ID: <20190919213103.ltijhkvs7etdzeul@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190801151314.f2tjk2b52mhxuc3x@cantor>
 <20190801201913.mwxqdfqb2a7c2zwn@cantor>
 <20190917232045.qgdomirhd7ll5sk3@cantor>
 <20190918053617.35i4yrbd5so5jvhr@cantor>
 <20190918082528.3chw6ro5max3jscv@cantor>
 <CAJmMGNuEVDW6q-F3bj=sdVWPfw6kiLcGFj=7wJrVU3TKyzEaUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJmMGNuEVDW6q-F3bj=sdVWPfw6kiLcGFj=7wJrVU3TKyzEaUg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Sep 18 19, Patrick Uiterwijk wrote:
>On Wed, 18 Sep 2019 at 09:25, Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>
>> On Tue Sep 17 19, Jerry Snitselaar wrote:
>> >On Tue Sep 17 19, Jerry Snitselaar wrote:
>> >>On Thu Aug 01 19, Jerry Snitselaar wrote:
>> >>>Hi Matthew, cc'ing as this might have something to do with the recent
>> >>>changes to tpm_read_log_efi.
>> >>>
>> >>>On Thu Aug 01 19, Jerry Snitselaar wrote:
>> >>>>I've had a couple reports emailed to me with a trace like the following
>> >>>>for 5.3-rc1 and 5.3-rc2. I'm just starting to dig into and look at recent
>> >>>>commits and mailing list, but is this already known?
>> >>>>
>> >>>>It's been reported on a couple different Lenovo laptop models (T470s and X1 carbon I believe).
>> >>>>
>> >>>>Full panic message:
>> >>>>[    0.774340] BUG: unable to handle page fault for address: ffffbc8fc00866ad
>> >>>>[    0.774788] #PF: supervisor read access in kernel mode
>> >>>>[    0.774788] #PF: error_code(0x0000) - not-present page
>> >>>>[    0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d38067 PTE 0
>> >>>>[    0.774788] Oops: 0000 [#1] SMP PTI
>> >>>>[    0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.rc2.1.elrdy.x86_64 #1
>> >>>>[    0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N1WET51W (1.30 ) 09/14/2018
>> >>>>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>> >>>>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>> >>>>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>> >>>>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffffffe962
>> >>>>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7c5b367
>> >>>>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000000063
>> >>>>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000003367
>> >>>>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000000002
>> >>>>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS:0000000000000000
>> >>>>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >>>>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000003606f0
>> >>>>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >>>>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >>>>[    0.774788] Call Trace:
>> >>>>[    0.774788]  tpm_read_log_efi+0x156/0x1a0
>> >>>>[    0.774788]  tpm_bios_log_setup+0xc8/0x190
>> >>>>[    0.774788]  tpm_chip_register+0x50/0x1c0
>> >>>>[    0.774788]  tpm_tis_core_init.cold.9+0x28c/0x466
>> >>>>[    0.774788]  tpm_tis_plat_probe+0xcc/0xea
>> >>>>[    0.774788]  platform_drv_probe+0x35/0x80
>> >>>>[    0.774788]  really_probe+0xef/0x390
>> >>>>[    0.774788]  driver_probe_device+0xb4/0x100
>> >>>>[    0.774788]  device_driver_attach+0x4f/0x60
>> >>>>[    0.774788]  __driver_attach+0x86/0x140
>> >>>>[    0.774788]  ? device_driver_attach+0x60/0x60
>> >>>>[    0.774788]  bus_for_each_dev+0x76/0xc0
>> >>>>[    0.774788]  ? klist_add_tail+0x3b/0x70
>> >>>>[    0.774788]  bus_add_driver+0x14a/0x1e0
>> >>>>[    0.774788]  ? tpm_init+0xea/0xea
>> >>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>> >>>>[    0.774788]  driver_register+0x6b/0xb0
>> >>>>[    0.774788]  ? tpm_init+0xea/0xea
>> >>>>[    0.774788]  init_tis+0x86/0xd8
>> >>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>> >>>>[    0.774788]  ? driver_register+0x94/0xb0
>> >>>>[    0.774788]  do_one_initcall+0x46/0x1e4
>> >>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>> >>>>[    0.774788]  kernel_init_freeable+0x199/0x242
>> >>>>[    0.774788]  ? rest_init+0xaa/0xaa
>> >>>>[    0.774788]  kernel_init+0xa/0x106
>> >>>>[    0.774788]  ret_from_fork+0x35/0x40
>> >>>>[    0.774788] Modules linked in:
>> >>>>[    0.774788] CR2: ffffbc8fc00866ad
>> >>>>[    0.774788] ---[ end trace 42930799f8d6eaea ]---
>> >>>>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>> >>>>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>> >>>>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>> >>>>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffffffe962
>> >>>>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7c5b367
>> >>>>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000000063
>> >>>>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000003367
>> >>>>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000000002
>> >>>>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS:0000000000000000
>> >>>>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >>>>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000003606f0
>> >>>>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >>>>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >>>>[    0.774788] Kernel panic - not syncing: Fatal exception
>> >>>>[    0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> >>>>[    0.774788] ---[ end Kernel panic - not syncing: Fatal exception ]---
>> >>
>> >>I finally was able to get a laptop model where this is being seen. efi_tpm_final_log_size is -1, which I'm guessing is coming from
>> >>tpm2_calc_event_log_size, and the sanity check in tpm_read_log_efi is checking if efi_tpm_final_log_size == 0. Building a test
>> >>kernel really quick to verify that tpm2_calc_event_log_size is where it originates, but I imagine there should be a check of tbl_size
>> >>after tpm2_calc_event_log_size call in efi_tpm_eventlog_init?
>> >
>> >Continuing to investigate, it is getting -1 back from tpm2_calc_event_log_size:
>> >
>> >[    0.000000] efi_tpm_eventlog_init: final_tbl->nr_events = 52
>> >[    0.000000] tpm2_calc_event_log_size: count: 52 event_size: 113
>> >[    0.000000] tpm2_calc_event_log_size: count: 51 event_size: 93
>> >[    0.000000] tpm2_calc_event_log_size: count: 50 event_size: 118
>> >[    0.000000] tpm2_calc_event_log_size: count: 49 event_size: 123
>> >[    0.000000] tpm2_calc_event_log_size: count: 48 event_size: 86
>> >[    0.000000] tpm2_calc_event_log_size: count: 47 event_size: 161
>> >[    0.000000] tpm2_calc_event_log_size: count: 46 event_size: 93
>> >[    0.000000] tpm2_calc_event_log_size: count: 45 event_size: 106
>> >[    0.000000] tpm2_calc_event_log_size: count: 44 event_size: 108
>> >[    0.000000] tpm2_calc_event_log_size: count: 43 event_size: 86
>> >[    0.000000] tpm2_calc_event_log_size: count: 42 event_size: 105
>> >[    0.000000] tpm2_calc_event_log_size: count: 41 event_size: 93
>> >[    0.000000] tpm2_calc_event_log_size: count: 40 event_size: 104
>> >[    0.000000] tpm2_calc_event_log_size: count: 39 event_size: 95
>> >[    0.000000] tpm2_calc_event_log_size: count: 38 event_size: 99
>> >[    0.000000] tpm2_calc_event_log_size: count: 37 event_size: 99
>> >[    0.000000] tpm2_calc_event_log_size: count: 36 event_size: 100
>> >[    0.000000] tpm2_calc_event_log_size: count: 35 event_size: 100
>> >[    0.000000] tpm2_calc_event_log_size: count: 34 event_size: 91
>> >[    0.000000] tpm2_calc_event_log_size: count: 33 event_size: 91
>> >[    0.000000] tpm2_calc_event_log_size: count: 32 event_size: 100
>> >[    0.000000] tpm2_calc_event_log_size: count: 31 event_size: 122
>> >[    0.000000] tpm2_calc_event_log_size: count: 30 event_size: 93
>> >[    0.000000] tpm2_calc_event_log_size: count: 29 event_size: 86
>> >[    0.000000] tpm2_calc_event_log_size: count: 28 event_size: 95
>> >[    0.000000] tpm2_calc_event_log_size: count: 27 event_size: 119
>> >[    0.000000] tpm2_calc_event_log_size: count: 26 event_size: 97
>> >[    0.000000] tpm2_calc_event_log_size: count: 25 event_size: 92
>> >[    0.000000] tpm2_calc_event_log_size: count: 24 event_size: 93
>> >[    0.000000] tpm2_calc_event_log_size: count: 23 event_size: 158
>> >[    0.000000] tpm2_calc_event_log_size: count: 22 event_size: 97
>> >[    0.000000] tpm2_calc_event_log_size: count: 21 event_size: 92
>> >[    0.000000] tpm2_calc_event_log_size: count: 20 event_size: 93
>> >[    0.000000] tpm2_calc_event_log_size: count: 19 event_size: 131
>> >[    0.000000] tpm2_calc_event_log_size: count: 18 event_size: 95
>> >[    0.000000] tpm2_calc_event_log_size: count: 17 event_size: 88
>> >[    0.000000] tpm2_calc_event_log_size: count: 16 event_size: 118
>> >[    0.000000] tpm2_calc_event_log_size: count: 15 event_size: 90
>> >[    0.000000] tpm2_calc_event_log_size: count: 14 event_size: 136
>> >[    0.000000] tpm2_calc_event_log_size: count: 13 event_size: 0
>> >[    0.000000] efi_tpm_eventlog_init: tpm2_calc_event_log_size returned: -1
>> >...
>> >[    1.282313] tpm_read_log_efi: efi_tpm_final_log_size is negative value: -1 (ffffffff)
>> >
>> >Then it will also subtract log_tbl->final_events_preboot_size, and
>> >this value gets passed to memcpy as the number of bytes to copy.
>> >
>> >Is this comment correct for __calc_tpm2_event_size?
>> >
>> >"Return: size of the event on success, <0 on failure"
>> >
>> >There are a number of spots where it will set size to 0. It looks like the
>> >only way it could potentially be less than 0 is where it does:
>> >
>> >size = marker - marker_start;
>>
>> Am I reading the spec correctly that the event types should have values in the range 0x80000000-0x800000ff?
>> If that is the case it looks like only the first event has a valid type, all the rest have 0xd.
>>
>
>The TPM specifications list many valid event values, but 0xd was
>EV_IPL in the TPM1.2 specification[0].
>This has been deprecated in the PC Client Platform Firmware Profile
>Specification for TPM2.0[1].
>Shim and grub at this moment do indeed log values under this event ID.
>
>[0]: https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Implementation-for-BIOS.pdf
>[1]: https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientSpecPlat_TPM_2p0_1p04_pub.pdf


Looking at it some more this afternoon it fails to parse the event
because it can't find the hash algorithm id from the event in the
TCG_EfiSpecIdEventAlgorithmSize array.

