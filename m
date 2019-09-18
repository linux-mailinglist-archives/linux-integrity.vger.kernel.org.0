Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F23B5F18
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfIRIZh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 04:25:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726131AbfIRIZh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 04:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568795135;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxOIZQ/pz30ux4aWexhfVirfma8saG/nBmhonkH7DTs=;
        b=ACRT9r/yIz2farE1nm9nA6apxK5C2qnmkwzwJzL6x0l0qKDydBmZGtSxiAQdBung4GFVox
        SQ8o7cAF4KLNaZzd8JPQ7e7lc1kzllyLg5KoMEcG6qe7vpAWEzqiQE5ZJXz7W0s2Y2B7B+
        8+pUH5VpoyoKWmLmG8tG/2kHSfjwze8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-tVZrNlNrN9Oaz33toZjtlw-1; Wed, 18 Sep 2019 04:25:31 -0400
Received: by mail-qk1-f199.google.com with SMTP id 10so7493831qka.2
        for <linux-integrity@vger.kernel.org>; Wed, 18 Sep 2019 01:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ELRAU69E61AHvhiZIW3L2ezhjg83ICxZ95DYV2Goz58=;
        b=FosAHOZ57sz8TarUNx0GxGnwwAEuHfi0Wdi4WBU9BxpJM1CeqnoJLfPwLrnC//mUmn
         GHVr3xLduZ+bF/+KPFcfwKPH25GXSf0HzZxF/XCzag01k4aBSntqgSfEODBDN4Qit1SJ
         ZSFt1EkhIo4pR22pUlFJz5ShLBYtAirDFGu8h42JWcYQNCxQWezlMe9Cv6PPwsIBz0rS
         4i8e5UPryFCaMfABiBFpoWhKwFaMcgDlHbogwAqwkkIU2oERY3MMc1AV+WyBDqLxLznD
         hbofItJxJgY+FKISEIhUddze7s0tRHupOJ3NlBpgXaBqQPcKWWoe9924RoTfQBMU5Nxw
         QVhQ==
X-Gm-Message-State: APjAAAXC50yjgzS8zbzd6DsPbB03cfRiPybYpir9dCoQX434HEdnSbZi
        TE3o5y4mFE9jwGllgUJnXRVzZDH1GliqGZlEBKDidJDHcDp3DAyOw4tSjlDcOYsvvbieskoO20h
        oV9gzLUkDQiP/fHK6QO98X1OV/SqS
X-Received: by 2002:a37:4e48:: with SMTP id c69mr2736956qkb.182.1568795130720;
        Wed, 18 Sep 2019 01:25:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzcIkF0iUlekSMAiBdysOsiS70YB84vh0ryT7WmJ1lSs6Qi/HmpxEzRWJmtC/74WEDPgCVXg==
X-Received: by 2002:a37:4e48:: with SMTP id c69mr2736934qkb.182.1568795130331;
        Wed, 18 Sep 2019 01:25:30 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l48sm2815772qtb.50.2019.09.18.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 01:25:29 -0700 (PDT)
Date:   Wed, 18 Sep 2019 01:25:28 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Matthew Garrett <mjg59@google.com>
Subject: Re: unable to handle page fault in 5.3-rc[12]
Message-ID: <20190918082528.3chw6ro5max3jscv@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190801151314.f2tjk2b52mhxuc3x@cantor>
 <20190801201913.mwxqdfqb2a7c2zwn@cantor>
 <20190917232045.qgdomirhd7ll5sk3@cantor>
 <20190918053617.35i4yrbd5so5jvhr@cantor>
MIME-Version: 1.0
In-Reply-To: <20190918053617.35i4yrbd5so5jvhr@cantor>
User-Agent: NeoMutt/20180716
X-MC-Unique: tVZrNlNrN9Oaz33toZjtlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Sep 17 19, Jerry Snitselaar wrote:
>On Tue Sep 17 19, Jerry Snitselaar wrote:
>>On Thu Aug 01 19, Jerry Snitselaar wrote:
>>>Hi Matthew, cc'ing as this might have something to do with the recent
>>>changes to tpm_read_log_efi.
>>>
>>>On Thu Aug 01 19, Jerry Snitselaar wrote:
>>>>I've had a couple reports emailed to me with a trace like the following
>>>>for 5.3-rc1 and 5.3-rc2. I'm just starting to dig into and look at rece=
nt
>>>>commits and mailing list, but is this already known?
>>>>
>>>>It's been reported on a couple different Lenovo laptop models (T470s an=
d X1 carbon I believe).
>>>>
>>>>Full panic message:
>>>>[    0.774340] BUG: unable to handle page fault for address: ffffbc8fc0=
0866ad
>>>>[    0.774788] #PF: supervisor read access in kernel mode
>>>>[    0.774788] #PF: error_code(0x0000) - not-present page
>>>>[    0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d38067 =
PTE 0
>>>>[    0.774788] Oops: 0000 [#1] SMP PTI
>>>>[    0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.rc2.1.=
elrdy.x86_64 #1
>>>>[    0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N1WET5=
1W (1.30 ) 09/14/2018
>>>>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>>>>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1=
 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1=
 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>>>>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>>>>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: fffffff=
fffffe962
>>>>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1=
fc7c5b367
>>>>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000=
000000063
>>>>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000=
000003367
>>>>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000=
000000002
>>>>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) kn=
lGS:0000000000000000
>>>>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 0000000=
0003606f0
>>>>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
>>>>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
>>>>[    0.774788] Call Trace:
>>>>[    0.774788]  tpm_read_log_efi+0x156/0x1a0
>>>>[    0.774788]  tpm_bios_log_setup+0xc8/0x190
>>>>[    0.774788]  tpm_chip_register+0x50/0x1c0
>>>>[    0.774788]  tpm_tis_core_init.cold.9+0x28c/0x466
>>>>[    0.774788]  tpm_tis_plat_probe+0xcc/0xea
>>>>[    0.774788]  platform_drv_probe+0x35/0x80
>>>>[    0.774788]  really_probe+0xef/0x390
>>>>[    0.774788]  driver_probe_device+0xb4/0x100
>>>>[    0.774788]  device_driver_attach+0x4f/0x60
>>>>[    0.774788]  __driver_attach+0x86/0x140
>>>>[    0.774788]  ? device_driver_attach+0x60/0x60
>>>>[    0.774788]  bus_for_each_dev+0x76/0xc0
>>>>[    0.774788]  ? klist_add_tail+0x3b/0x70
>>>>[    0.774788]  bus_add_driver+0x14a/0x1e0
>>>>[    0.774788]  ? tpm_init+0xea/0xea
>>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>>>[    0.774788]  driver_register+0x6b/0xb0
>>>>[    0.774788]  ? tpm_init+0xea/0xea
>>>>[    0.774788]  init_tis+0x86/0xd8
>>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>>>[    0.774788]  ? driver_register+0x94/0xb0
>>>>[    0.774788]  do_one_initcall+0x46/0x1e4
>>>>[    0.774788]  ? do_early_param+0x8e/0x8e
>>>>[    0.774788]  kernel_init_freeable+0x199/0x242
>>>>[    0.774788]  ? rest_init+0xaa/0xaa
>>>>[    0.774788]  kernel_init+0xa/0x106
>>>>[    0.774788]  ret_from_fork+0x35/0x40
>>>>[    0.774788] Modules linked in:
>>>>[    0.774788] CR2: ffffbc8fc00866ad
>>>>[    0.774788] ---[ end trace 42930799f8d6eaea ]---
>>>>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>>>>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1=
 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1=
 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>>>>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>>>>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: fffffff=
fffffe962
>>>>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1=
fc7c5b367
>>>>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000=
000000063
>>>>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000=
000003367
>>>>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000=
000000002
>>>>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) kn=
lGS:0000000000000000
>>>>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 0000000=
0003606f0
>>>>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
>>>>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
>>>>[    0.774788] Kernel panic - not syncing: Fatal exception
>>>>[    0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (reloc=
ation range: 0xffffffff80000000-0xffffffffbfffffff)
>>>>[    0.774788] ---[ end Kernel panic - not syncing: Fatal exception ]--=
-
>>
>>I finally was able to get a laptop model where this is being seen. efi_tp=
m_final_log_size is -1, which I'm guessing is coming from
>>tpm2_calc_event_log_size, and the sanity check in tpm_read_log_efi is che=
cking if efi_tpm_final_log_size =3D=3D 0. Building a test
>>kernel really quick to verify that tpm2_calc_event_log_size is where it o=
riginates, but I imagine there should be a check of tbl_size
>>after tpm2_calc_event_log_size call in efi_tpm_eventlog_init?
>
>Continuing to investigate, it is getting -1 back from tpm2_calc_event_log_=
size:
>
>[    0.000000] efi_tpm_eventlog_init: final_tbl->nr_events =3D 52
>[    0.000000] tpm2_calc_event_log_size: count: 52 event_size: 113
>[    0.000000] tpm2_calc_event_log_size: count: 51 event_size: 93
>[    0.000000] tpm2_calc_event_log_size: count: 50 event_size: 118
>[    0.000000] tpm2_calc_event_log_size: count: 49 event_size: 123
>[    0.000000] tpm2_calc_event_log_size: count: 48 event_size: 86
>[    0.000000] tpm2_calc_event_log_size: count: 47 event_size: 161
>[    0.000000] tpm2_calc_event_log_size: count: 46 event_size: 93
>[    0.000000] tpm2_calc_event_log_size: count: 45 event_size: 106
>[    0.000000] tpm2_calc_event_log_size: count: 44 event_size: 108
>[    0.000000] tpm2_calc_event_log_size: count: 43 event_size: 86
>[    0.000000] tpm2_calc_event_log_size: count: 42 event_size: 105
>[    0.000000] tpm2_calc_event_log_size: count: 41 event_size: 93
>[    0.000000] tpm2_calc_event_log_size: count: 40 event_size: 104
>[    0.000000] tpm2_calc_event_log_size: count: 39 event_size: 95
>[    0.000000] tpm2_calc_event_log_size: count: 38 event_size: 99
>[    0.000000] tpm2_calc_event_log_size: count: 37 event_size: 99
>[    0.000000] tpm2_calc_event_log_size: count: 36 event_size: 100
>[    0.000000] tpm2_calc_event_log_size: count: 35 event_size: 100
>[    0.000000] tpm2_calc_event_log_size: count: 34 event_size: 91
>[    0.000000] tpm2_calc_event_log_size: count: 33 event_size: 91
>[    0.000000] tpm2_calc_event_log_size: count: 32 event_size: 100
>[    0.000000] tpm2_calc_event_log_size: count: 31 event_size: 122
>[    0.000000] tpm2_calc_event_log_size: count: 30 event_size: 93
>[    0.000000] tpm2_calc_event_log_size: count: 29 event_size: 86
>[    0.000000] tpm2_calc_event_log_size: count: 28 event_size: 95
>[    0.000000] tpm2_calc_event_log_size: count: 27 event_size: 119
>[    0.000000] tpm2_calc_event_log_size: count: 26 event_size: 97
>[    0.000000] tpm2_calc_event_log_size: count: 25 event_size: 92
>[    0.000000] tpm2_calc_event_log_size: count: 24 event_size: 93
>[    0.000000] tpm2_calc_event_log_size: count: 23 event_size: 158
>[    0.000000] tpm2_calc_event_log_size: count: 22 event_size: 97
>[    0.000000] tpm2_calc_event_log_size: count: 21 event_size: 92
>[    0.000000] tpm2_calc_event_log_size: count: 20 event_size: 93
>[    0.000000] tpm2_calc_event_log_size: count: 19 event_size: 131
>[    0.000000] tpm2_calc_event_log_size: count: 18 event_size: 95
>[    0.000000] tpm2_calc_event_log_size: count: 17 event_size: 88
>[    0.000000] tpm2_calc_event_log_size: count: 16 event_size: 118
>[    0.000000] tpm2_calc_event_log_size: count: 15 event_size: 90
>[    0.000000] tpm2_calc_event_log_size: count: 14 event_size: 136
>[    0.000000] tpm2_calc_event_log_size: count: 13 event_size: 0
>[    0.000000] efi_tpm_eventlog_init: tpm2_calc_event_log_size returned: -=
1
>...
>[    1.282313] tpm_read_log_efi: efi_tpm_final_log_size is negative value:=
 -1 (ffffffff)
>
>Then it will also subtract log_tbl->final_events_preboot_size, and
>this value gets passed to memcpy as the number of bytes to copy.
>
>Is this comment correct for __calc_tpm2_event_size?
>
>"Return: size of the event on success, <0 on failure"
>
>There are a number of spots where it will set size to 0. It looks like the
>only way it could potentially be less than 0 is where it does:
>
>size =3D marker - marker_start;

Am I reading the spec correctly that the event types should have values in =
the range 0x80000000-0x800000ff?
If that is the case it looks like only the first event has a valid type, al=
l the rest have 0xd.

