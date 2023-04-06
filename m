Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A676EBFDD
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjDWOLA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWOK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 10:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4554AB9
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 07:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D342A60F0A
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 14:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7452C433EF
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 14:10:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="key not found in DNS" (0-bit key) header.d=dmarto.com header.i=@dmarto.com header.b="hsLVHup6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dmarto.com; s=20210105;
        t=1682259053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=16GrWFsXFtLcLcuCYz6AyZR5lgmkhngK3uBfm36OlS0=;
        b=hsLVHup6qgASrxy52tljvYoXCd+YbPu35t2ojRonmi3eeSq1In6cmeGgTpFh8hGGDycA8r
        4RTrlpFWC3iqAdTdMaEegjQwJLMXdUvyBYpR4xOUJqMvzD5gAulkPAHvMzpEj4E75vy2LI
        wSV0pHr1fXzN5DETjZE7T3SCUttfxQI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 752d6d67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-integrity@vger.kernel.org>;
        Sun, 23 Apr 2023 14:10:53 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 06 Apr 2023 22:51:39 +0000
Content-Type: text/plain; charset="utf-8"
From:   "Martin Dimov" <martin@dmarto.com>
Message-ID: <3d1d7e9dbfb8c96125bc93b6b58b90a7@dmarto.com>
Subject: bug in "tpm_chip_unregister"
To:     jarkko@kernel.org, Jason@zx2c4.com
Cc:     linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello and excuse me if I am not following the proper steps while
reporting this.

I believe "tpm_chip_unregister" needs to call
"tpm_amd_is_rng_defective", as introduced and used in
commit f1324bbc4011ed8aef3f4552210fc429bcd616da.

[ 1950.279393] list_del corruption, ffff99560d485790->next is NULL
[ 1950.279400] ------------[ cut here ]------------
[ 1950.279401] kernel BUG at lib/list_debug.c:49!
[ 1950.279405] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 1950.279407] CPU: 11 PID: 5886 Comm: modprobe Tainted: G O 6.2.8_1 #1
[ 1950.279409] Hardware name: Gigabyte Technology Co., Ltd. B550M AORUS PRO-P/B550M AORUS PRO-P,
BIOS F15c 05/11/2022
[ 1950.279410] RIP: 0010:__list_del_entry_valid+0x59/0xc0
[ 1950.279415] Code: 48 8b 01 48 39 f8 75 5a 48 8b 72 08 48 39 c6 75 65 b8 01 00 00 00 c3 cc cc cc
cc 48 89 fe 48 c7 c7 08 a8 13 9e e8 b7 0a bc ff <0f> 0b 48 89 fe 48 c7 c7 38 a8 13 9e e8 a6 0a bc
ff 0f 0b 48 89 fe
[ 1950.279416] RSP: 0018:ffffa96d05647e08 EFLAGS: 00010246
[ 1950.279418] RAX: 0000000000000033 RBX: ffff99560d485750 RCX: 0000000000000000
[ 1950.279419] RDX: 0000000000000000 RSI: ffffffff9e107c59 RDI: 00000000ffffffff
[ 1950.279420] RBP: ffffffffc19c5168 R08: 0000000000000000 R09: ffffa96d05647cc8
[ 1950.279421] R10: 0000000000000003 R11: ffffffff9ea2a568 R12: 0000000000000000
[ 1950.279422] R13: ffff99560140a2e0 R14: ffff99560127d2e0 R15: 0000000000000000
[ 1950.279422] FS: 00007f67da795380(0000) GS:ffff995d1f0c0000(0000) knlGS:0000000000000000
[ 1950.279424] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1950.279424] CR2: 00007f67da7e65c0 CR3: 00000001feed2000 CR4: 0000000000750ee0
[ 1950.279426] PKRU: 55555554
[ 1950.279426] Call Trace:
[ 1950.279428] <TASK>
[ 1950.279430] hwrng_unregister+0x28/0xe0 [rng_core]
[ 1950.279436] tpm_chip_unregister+0xd5/0xf0 [tpm]
[ 1950.279441] acpi_device_remove+0x52/0x90
[ 1950.279445] device_release_driver_internal+0x1b2/0x230
[ 1950.279449] driver_detach+0x44/0x90
[ 1950.279451] bus_remove_driver+0x55/0xe0
[ 1950.279453] __do_sys_delete_module+0x1a9/0x2f0
[ 1950.279456] ? fpregs_assert_state_consistent+0x22/0x50
[ 1950.279459] ? exit_to_user_mode_prepare+0x3c/0x1a0
[ 1950.279462] ? syscall_exit_to_user_mode+0x17/0x40
[ 1950.279465] ? do_syscall_64+0x67/0x80
[ 1950.279467] do_syscall_64+0x5b/0x80
[ 1950.279468] ? do_syscall_64+0x67/0x80
[ 1950.279470] entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1950.279474] RIP: 0033:0x7f67da8a59c7
[ 1950.279475] Code: 73 01 c3 48 8b 0d 59 f4 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00
00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 f4 0c 00
f7 d8 64 89 01 48
[ 1950.279476] RSP: 002b:00007ffde7a53bf8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[ 1950.279478] RAX: ffffffffffffffda RBX: 0000563607acca80 RCX: 00007f67da8a59c7
[ 1950.279479] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000563607accae8
[ 1950.279479] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1950.279480] R10: 00007f67da91aac0 R11: 0000000000000206 R12: 0000000000000000
[ 1950.279481] R13: 0000000000000000 R14: 00007ffde7a53c30 R15: 0000563607ad44d0
[ 1950.279482] </TASK>
[ 1950.279483] Modules linked in: joydev hid_magicmouse hidp snd_seq_dummy snd_hrtimer cmac
algif_hash algif_skcipher af_alg bnep snd_hda_codec_realtek intel_rapl_msr intel_rapl_common
snd_hda_codec_generic edac_mce_amd ledtrig_audio snd_hda_codec_hdmi kvm_amd snd_hda_intel btusb
snd_intel_dspcfg snd_intel_sdw_acpi btrtl kvm snd_hda_codec snd_hda_core btbcm snd_hwdep irqbypass
btintel input_leds rapl cdc_acm r8169 pcspkr btmtk wmi_bmof gigabyte_wmi k10temp snd_pcm i2c_piix4
realtek thermal tpm_crb(-) evdev gpio_amdpt mac_hid tpm gpio_generic acpi_cpufreq tiny_power_button
vboxnetflt(O) vboxnetadp(O) vboxdrv(O) snd_seq snd_seq_device snd_timer snd soundcore vhost_vsock
vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost_iotlb tap uhid hci_vhci bluetooth
ecdh_generic rfkill ecc vfio_iommu_type1 vfio iommufd uinput userio ppp_generic slhc tun loop nvram
cuse fuse amdgpu iommu_v2 drm_buddy gpu_sched video i2c_algo_bit ext4 drm_display_helper sd_mod cec
hid_generic crc16 rc_core
[ 1950.279518] usbmouse mbcache usbkbd usbhid hid jbd2 drm_kms_helper syscopyarea sysfillrect
crct10dif_pclmul crc32_pclmul sysimgblt ahci polyval_clmulni drm_ttm_helper polyval_generic libahci
gf128mul xhci_pci ghash_clmulni_intel ttm sha512_ssse3 xhci_pci_renesas libata xhci_hcd aesni_intel
crypto_simd drm cryptd ccp usbcore scsi_mod sp5100_tco rng_core agpgart usb_common scsi_common wmi
button dm_mirror dm_region_hash dm_log dm_mod btrfs blake2b_generic xor raid6_pq libcrc32c
crc32c_generic crc32c_intel [last unloaded: tpm_tis_core]
[ 1950.279540] ---[ end trace 0000000000000000 ]---
