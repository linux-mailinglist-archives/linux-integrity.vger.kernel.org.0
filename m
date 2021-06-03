Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1751A3999F8
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 07:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhFCFap (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 01:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhFCFao (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 01:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9E5B613B4;
        Thu,  3 Jun 2021 05:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622698140;
        bh=xAfiOACfB1lhCFWBAbjR2amL5bfa3cVGV0Qv44oLCQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVATAidVIa1CXqniX77RP7CCUpjM+nCPdhS/RnPuTZK0YEHvLXwbR5zfis1c7sHGA
         4OS305blMJ6pSypDbfQmy1XMgmXEmJvEAfCsW8XIsghhfedr4crZo5KpO+IqdROVjR
         +sqa1/9Ii7u13RYCrUGHNj3Ihr3Qm2UMQFrolTwQHGJt4H9p/XRBPD4Cvu+Bwpi/wC
         b5HF1umI0qGg7nAhGgL+Mg6eI4xKp7/DnUZjqmSWzItcqYAh+Kdw0Ee6WMG+wZHD7z
         TGPtFgdviEIug680e9cUaAiEyY1lTYtswmJu/yXY73DH4uNa80rhGtvdv9L2x+6x2H
         1XlW5FYgyVHHw==
Date:   Thu, 3 Jun 2021 08:28:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in
 tpm_tis_gen_interrupt() and tpm_get_timeouts()
Message-ID: <20210603052857.44zppwdfz4aror34@kernel.org>
References: <20210216081750.191250-1-jarkko@kernel.org>
 <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
 <YCvv9wvj4jUIKpa7@kernel.org>
 <YCvyS6eVjZCKMAyJ@kernel.org>
 <YCv0KFIdtmG8F1kT@kernel.org>
 <d5fd8a6b-5eb9-0b50-d66c-e9f4cc84b215@debian.org>
 <YC2YyO7mJ7E73Voy@kernel.org>
 <ed73c137-373d-9767-25e6-309534652354@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed73c137-373d-9767-25e6-309534652354@debian.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 01, 2021 at 11:17:14PM +0200, Laurent Bigonville wrote:
> Le 17/02/21 à 23:29, Jarkko Sakkinen a écrit :
> > On Tue, Feb 16, 2021 at 08:06:04PM +0100, Laurent Bigonville wrote:
> > > Le 16/02/21 à 17:34, Jarkko Sakkinen a écrit :
> > > > On Tue, Feb 16, 2021 at 06:26:54PM +0200, Jarkko Sakkinen wrote:
> > > > > On Tue, Feb 16, 2021 at 06:16:58PM +0200, Jarkko Sakkinen wrote:
> > > > > > On Tue, Feb 16, 2021 at 12:02:24PM +0100, Laurent Bigonville wrote:
> > > > > > > Le 16/02/21 à 09:17, Jarkko Sakkinen a écrit :
> > > > > > > > From: Lukasz Majczak <lma@semihalf.com>
> > > > > > > > 
> > > > > > > > This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
> > > > > > > > (SLB 9670):
> > > > > > > > 
> > > > > > > > [    4.324298] TPM returned invalid status
> > > > > > > > [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
> > > > > > > > 
> > > > > > > > Background
> > > > > > > > ==========
> > > > > > > > 
> > > > > > > > TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 FIFO
> > > > > > > > Interface Locality Usage per Register, Table 39 Register Behavior Based on
> > > > > > > > Locality Setting for FIFO - a read attempt to TPM_STS_x Registers returns
> > > > > > > > 0xFF in case of lack of locality. The described situation manifests itself
> > > > > > > > with the following warning trace:
> > > > > > > > 
> > > > > > > > The fix
> > > > > > > > =======
> > > > > > > > 
> > > > > > > > Add the proper decorations to tpm_tis_gen_interrupt() and
> > > > > > > > tpm_get_timeouts().
> > > > > > > I tried that patch (alone on the top of the HEAD of Linus master) and I
> > > > > > > still get the same trace in dmesg
> > > > > > Can you give a shot to
> > > > > > 
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > > > > > 
> > > > > > It has couple of more fixes, and paste the log.
> > > > > And if possible a full stack trace :-)
> > > > And apply this patch on top. Cannot apply it there before it's reviewed.
> > > > 
> > > I get the following stacktrace with your branch and the patch here:
> > > 
> > > [   13.498925] ------------[ cut here ]------------
> > > [   13.498930] TPM returned invalid status
> > > [   13.498953] WARNING: CPU: 1 PID: 459 at
> > > drivers/char/tpm/tpm_tis_core.c:205 tpm_tis_status+0x86/0xa0 [tpm_tis_core]
> > > [   13.498963] Modules linked in: libiscsi_tcp(E) tpm_tis(E+)
> > > tpm_tis_core(E) libiscsi(E) snd_timer(E) tpm(E) joydev(E) snd(E)
> > > scsi_transport_iscsi(E) pcc_cpufreq(E-) fjes(E-) soundcore(E) i7core_edac(E)
> > > i5500_temp(E) asus_atk0110(E) rng_core(E) acpi_cpufreq(E-) evdev(E) loop(E)
> > > firewire_sbp2(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) fuse(E)
> > > configfs(E) sunrpc(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E)
> > > mbcache(E) jbd2(E) btrfs(E) blake2b_generic(E) zstd_compress(E) efivars(E)
> > > raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E)
> > > async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_generic(E)
> > > raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) dm_mod(E) sr_mod(E)
> > > sd_mod(E) cdrom(E) t10_pi(E) hid_generic(E) usbhid(E) hid(E) amdgpu(E)
> > > ahci(E) libahci(E) libata(E) gpu_sched(E) i2c_algo_bit(E) drm_ttm_helper(E)
> > > ttm(E) uhci_hcd(E) ehci_pci(E) firewire_ohci(E) crc32c_intel(E) ehci_hcd(E)
> > > drm_kms_helper(E) firewire_core(E) i2c_i801(E) psmouse(E)
> > > [   13.499044]  scsi_mod(E) cec(E) i2c_smbus(E) mxm_wmi(E) lpc_ich(E)
> > > crc_itu_t(E) sky2(E) usbcore(E) drm(E) mfd_core(E) wmi(E) button(E)
> > > [   13.499058] CPU: 1 PID: 459 Comm: systemd-udevd Tainted: G          I
> > > E     5.11.0+ #4
> > > [   13.499062] Hardware name: System manufacturer System Product Name/P6T
> > > DELUXE V2, BIOS 0406    04/24/2009
> > > [   13.499064] RIP: 0010:tpm_tis_status+0x86/0xa0 [tpm_tis_core]
> > > [   13.499069] Code: 00 75 30 48 83 c4 18 c3 31 c0 80 3d 83 48 00 00 00 75
> > > e0 48 c7 c7 4c 53 49 c1 88 44 24 07 c6 05 6f 48 00 00 01 e8 b2 24 ba cd <0f>
> > > 0b 0f b6 44 24 07 eb c0 e8 fc 99 bd cd 66 66 2e 0f 1f 84 00 00
> > > [   13.499072] RSP: 0018:ffffbaeb80fb3aa0 EFLAGS: 00010286
> > > [   13.499075] RAX: 0000000000000000 RBX: ffff9704034e5000 RCX:
> > > ffff9707ada58bc8
> > > [   13.499078] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI:
> > > ffff9707ada58bc0
> > > [   13.499080] RBP: 00000000ffff5d40 R08: 0000000000000000 R09:
> > > ffffbaeb80fb38c0
> > > [   13.499082] R10: ffffbaeb80fb38b8 R11: ffffffff8fac2588 R12:
> > > 0000000000000016
> > > [   13.499085] R13: ffff97040c38d000 R14: 0000000000001000 R15:
> > > ffffbaeb80fb3ada
> > > [   13.499087] FS:  00007fe1bcfeb8c0(0000) GS:ffff9707ada40000(0000)
> > > knlGS:0000000000000000
> > > [   13.499090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   13.499092] CR2: 000055e5f7048590 CR3: 00000001084fe000 CR4:
> > > 00000000000006e0
> > > [   13.499095] Call Trace:
> > > [   13.499099]  tpm_transmit+0x15f/0x3d0 [tpm]
> > > [   13.499113]  tpm_transmit_cmd+0x25/0x90 [tpm]
> > > [   13.499121]  tpm2_probe+0xe2/0x140 [tpm]
> > > [   13.499130]  tpm_tis_core_init+0x1d5/0x2b0 [tpm_tis_core]
> > > [   13.499135]  ? tpm_tis_init.part.0+0x130/0x130 [tpm_tis]
> > > [   13.499141]  tpm_tis_pnp_init+0xe1/0x110 [tpm_tis]
> > > [   13.499148]  pnp_device_probe+0xaf/0x140
> > > [   13.499154]  really_probe+0xf2/0x440
> > > [   13.499160]  driver_probe_device+0xe1/0x150
> > > [   13.499163]  device_driver_attach+0xa1/0xb0
> > > [   13.499167]  __driver_attach+0x8a/0x150
> > > [   13.499171]  ? device_driver_attach+0xb0/0xb0
> > > [   13.499174]  ? device_driver_attach+0xb0/0xb0
> > > [   13.499177]  bus_for_each_dev+0x78/0xc0
> > > [   13.499181]  bus_add_driver+0x12b/0x1e0
> > > [   13.499184]  driver_register+0x8b/0xe0
> > > [   13.499188]  ? 0xffffffffc1413000
> > > [   13.499191]  init_tis+0xa0/0x1000 [tpm_tis]
> > > [   13.499197]  do_one_initcall+0x44/0x1d0
> > > [   13.499202]  ? do_init_module+0x23/0x260
> > > [   13.499206]  ? kmem_cache_alloc_trace+0xf5/0x200
> > > [   13.499212]  do_init_module+0x5c/0x260
> > > [   13.499215]  __do_sys_finit_module+0xb1/0x110
> > > [   13.499225]  do_syscall_64+0x33/0x80
> > > [   13.499229]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [   13.499234] RIP: 0033:0x7fe1bd4a49b9
> > > [   13.499237] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48
> > > 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
> > > 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
> > > [   13.499240] RSP: 002b:00007ffca5bfa108 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000139
> > > [   13.499243] RAX: ffffffffffffffda RBX: 000055e5f7036920 RCX:
> > > 00007fe1bd4a49b9
> > > [   13.499245] RDX: 0000000000000000 RSI: 00007fe1bd62fe2d RDI:
> > > 0000000000000012
> > > [   13.499247] RBP: 0000000000020000 R08: 0000000000000000 R09:
> > > 000055e5f6e7a0b0
> > > [   13.499249] R10: 0000000000000012 R11: 0000000000000246 R12:
> > > 00007fe1bd62fe2d
> > > [   13.499251] R13: 0000000000000000 R14: 000055e5f7033420 R15:
> > > 000055e5f7036920
> > > [   13.499255] ---[ end trace 7e963e5c3647102e ]---
> > > 
> > > If I also apply the patch to change the WARN_ONCE in dev_warn_once, and grep
> > > on the string "tpm", I get the following:
> > > 
> > > Feb 16 19:51:22 fornost kernel: tpm tpm0: TPM returned invalid status: 0xa0
> > > Feb 16 19:51:22 fornost kernel: tpm_tis 00:06: 1.2 TPM (device-id 0x6871,
> > > rev-id 1)
> > > Feb 16 19:51:24 fornost kernel: tpm tpm0: tpm_try_transmit: send(): error
> > > -62
> > > Feb 16 19:51:24 fornost kernel: tpm tpm0: A TPM error (-62) occurred
> > > attempting to determine the timeouts
> > > Feb 16 19:51:24 fornost kernel: tpm_tis: probe of 00:06 failed with error
> > > -62
> > > Feb 16 19:51:24 fornost kernel: tpm_inf_pnp 00:06: Found TPM with ID IFX0102
> > > 
> > > 
> > No immediate idea why this happens as the code should take locality.
> > 
> > I noticed that the original patch bundles incorrectly two fixes, so I
> > send mu PT without the current fix and turn into a patch set. Let's
> > try to debug this for rc2/rc3.
> Hey, I'm coming back regarding this issue, I'm running 5.10 (from debian
> unstable) and still getting this issue

Many of the fixes are landing to 5.13, stable kernels do not acquire
out-of-tree fixes unless downstream maintainers decide to apply them
by hand.

/Jarkko
