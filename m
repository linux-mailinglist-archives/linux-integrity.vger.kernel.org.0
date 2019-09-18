Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CBDB6C58
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 21:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfIRTYD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 15:24:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728896AbfIRTYD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 15:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568834641;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bVZCplUP/Z94/uHIF97sFrdIR+vlGv51UwIdM++7G6c=;
        b=gP5y3A+nEdjgUjDmws0p5dWya96yMiXcs4b9CskGOtCyURJKf+6Zs8mMgLhVMVt4OQ++GB
        7Ca9s+1Vdj8oouicHQqc+kqEAifkr8X/uY6J0OPnwuf/VtaamPsZ/Sme3pX5zzfCIgjqIM
        h63UN1tIJwmLiM14MK3lCMCG75HIir0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-hRWeD0hnNeSQTTMGHh0zEg-1; Wed, 18 Sep 2019 15:23:59 -0400
Received: by mail-qt1-f198.google.com with SMTP id e13so1174168qto.18
        for <linux-integrity@vger.kernel.org>; Wed, 18 Sep 2019 12:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=C8SJW/Gs0hSQb47sCDzx9Pg/yHFuOgepOoayllBj52c=;
        b=qxmKYFYIb+nFCJP+HzTLvqoDIfMbqvhYpOG1LAayVJ3mqyDzabbwrCOuukjEy7kUPW
         PjZRFJ178HeQY49GK/w4BkHP8crAVAZYmVob7lZZ9eAuXEzeSD4oqDR0V3BiiJPuNQQ6
         Z/kLMfBGtq1Mrdmwodt6vmqbCiAt/437nFVRQYiqPQbSfE0zeK3kf5fDfRPigULRyDuS
         QhtvsDpZ0zU59ZlYWl5kx6TUCudYxHCC43UESCb7za4YlBBrlCG0U7n6922ym6Jp5/RX
         urnGtjerDqUB4EghgUa0AsnQu4z9LDeJg9DcyhY4dKEKvDlAZo2MH8BrhTVt7YuWEbX9
         urhQ==
X-Gm-Message-State: APjAAAWSL57JHjEU06Bw6wgNQuB6OAB+XSdviIAvDvKtVFa+UR/hk42Z
        OSE29WiDrbaQspszcWq4oEOHGwp+B/YzbvJQeGFbcl7mdh15imirniPrK55M/zr32X9sLFx+erp
        R2pUmoql99Fd/ILlW/5vD0CMVdvyJ
X-Received: by 2002:a37:b041:: with SMTP id z62mr5865747qke.94.1568834638971;
        Wed, 18 Sep 2019 12:23:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBpgqmp/sM1PC3ij4mL2TbTEWyZ5Dn/bt1ufqMeLVmNv8Pdi2Xes49ZzbqluYdZnUziJg8iA==
X-Received: by 2002:a37:b041:: with SMTP id z62mr5865723qke.94.1568834638631;
        Wed, 18 Sep 2019 12:23:58 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x55sm4057780qta.74.2019.09.18.12.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 12:23:57 -0700 (PDT)
Date:   Wed, 18 Sep 2019 12:23:55 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [RFC PATCH] tpm: only set efi_tpm_final_log_size after
 successful event log parsing
Message-ID: <20190918192355.bzsv7ct5nmtrv5nu@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20190918191626.5741-1-jsnitsel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190918191626.5741-1-jsnitsel@redhat.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: hRWeD0hnNeSQTTMGHh0zEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Sep 18 19, Jerry Snitselaar wrote:
>If __calc_tpm2_event_size fails to parse an event it will return 0,
>resulting tpm2_calc_event_log_size returning -1. Currently
>there is no check of this return value, and efi_tpm_final_log_size
>can end up being set to this negative value resulting
>in a panic like the following:
>
>[    0.774340] BUG: unable to handle page fault for address: ffffbc8fc0086=
6ad
>[    0.774788] #PF: supervisor read access in kernel mode
>[    0.774788] #PF: error_code(0x0000) - not-present page
>[    0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d38067 PTE=
 0
>[    0.774788] Oops: 0000 [#1] SMP PTI
>[    0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.rc2.1.elr=
dy.x86_64 #1
>[    0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N1WET51W =
(1.30 ) 09/14/2018
>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9=
 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f=
3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffff=
ffe962
>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7=
c5b367
>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000=
000063
>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000=
003367
>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000=
000002
>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS=
:0000000000000000
>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 0000000000=
3606f0
>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
>[    0.774788] Call Trace:
>[    0.774788]  tpm_read_log_efi+0x156/0x1a0
>[    0.774788]  tpm_bios_log_setup+0xc8/0x190
>[    0.774788]  tpm_chip_register+0x50/0x1c0
>[    0.774788]  tpm_tis_core_init.cold.9+0x28c/0x466
>[    0.774788]  tpm_tis_plat_probe+0xcc/0xea
>[    0.774788]  platform_drv_probe+0x35/0x80
>[    0.774788]  really_probe+0xef/0x390
>[    0.774788]  driver_probe_device+0xb4/0x100
>[    0.774788]  device_driver_attach+0x4f/0x60
>[    0.774788]  __driver_attach+0x86/0x140
>[    0.774788]  ? device_driver_attach+0x60/0x60
>[    0.774788]  bus_for_each_dev+0x76/0xc0
>[    0.774788]  ? klist_add_tail+0x3b/0x70
>[    0.774788]  bus_add_driver+0x14a/0x1e0
>[    0.774788]  ? tpm_init+0xea/0xea
>[    0.774788]  ? do_early_param+0x8e/0x8e
>[    0.774788]  driver_register+0x6b/0xb0
>[    0.774788]  ? tpm_init+0xea/0xea
>[    0.774788]  init_tis+0x86/0xd8
>[    0.774788]  ? do_early_param+0x8e/0x8e
>[    0.774788]  ? driver_register+0x94/0xb0
>[    0.774788]  do_one_initcall+0x46/0x1e4
>[    0.774788]  ? do_early_param+0x8e/0x8e
>[    0.774788]  kernel_init_freeable+0x199/0x242
>[    0.774788]  ? rest_init+0xaa/0xaa
>[    0.774788]  kernel_init+0xa/0x106
>[    0.774788]  ret_from_fork+0x35/0x40
>[    0.774788] Modules linked in:
>[    0.774788] CR2: ffffbc8fc00866ad
>[    0.774788] ---[ end trace 42930799f8d6eaea ]---
>[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9=
 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f=
3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffff=
ffe962
>[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7=
c5b367
>[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000=
000063
>[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000=
003367
>[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000=
000002
>[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS=
:0000000000000000
>[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 0000000000=
3606f0
>[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
>[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
>[    0.774788] Kernel panic - not syncing: Fatal exception
>[    0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
>[    0.774788] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
>Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
>Cc: Matthew Garrett <mjg59@google.com>
>Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---
> drivers/firmware/efi/tpm.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>index 1d3f5ca3eaaf..5cd00a7833c2 100644
>--- a/drivers/firmware/efi/tpm.c
>+++ b/drivers/firmware/efi/tpm.c
>@@ -40,8 +40,7 @@ int __init efi_tpm_eventlog_init(void)
> {
> =09struct linux_efi_tpm_eventlog *log_tbl;
> =09struct efi_tcg2_final_events_table *final_tbl;
>-=09unsigned int tbl_size;
>-=09int ret =3D 0;
>+=09int tbl_size, ret =3D 0;
>
> =09if (efi.tpm_log =3D=3D EFI_INVALID_TABLE_ADDR) {
> =09=09/*
>@@ -80,11 +79,17 @@ int __init efi_tpm_eventlog_init(void)
> =09=09=09=09=09    + sizeof(final_tbl->nr_events),
> =09=09=09=09=09    final_tbl->nr_events,
> =09=09=09=09=09    log_tbl->log);
>+=09if (tbl_size < 0) {
>+=09=09pr_err("Failed to parse event in TPM Final Event log\n");
>+=09=09goto calc_out;
>+=09}
>+
> =09memblock_reserve((unsigned long)final_tbl,
> =09=09=09 tbl_size + sizeof(*final_tbl));
>-=09early_memunmap(final_tbl, sizeof(*final_tbl));
> =09efi_tpm_final_log_size =3D tbl_size;
>
>+calc_out:
>+=09early_memunmap(final_tbl, sizeof(*final_tbl));
> out:
> =09early_memunmap(log_tbl, sizeof(*log_tbl));
> =09return ret;
>--=20
>2.23.0
>

I'm not sure what to set ret to, which currently isn't checked, or if anyth=
ing
should be done with efi.tpm_final_log.

