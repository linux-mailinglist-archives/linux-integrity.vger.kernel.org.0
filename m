Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E027B198
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 18:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1QPO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 12:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1QPO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 12:15:14 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A8F2184D;
        Mon, 28 Sep 2020 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601309713;
        bh=p5xjzYiwcXvsVM7aUADE4cTY6GO+m2v2Psf1Socv7P0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cd+RMgA2wgVrWly7RZKCx6iVUZJj0VOGRiuE75zCSvpQJkIzlxNFbhA2f91tEnec4
         ujSYA7n4nSOsOCxd2ulKRaaKi4ynoQHR/porvZnYRZpT20ZMBKJ0VWNsLYfvpOLiEG
         bmmy1veIHZrCpmBMYQmgm24DIDF0VJzzjId+SnhY=
Received: by mail-ot1-f46.google.com with SMTP id c2so1458573otp.7;
        Mon, 28 Sep 2020 09:15:13 -0700 (PDT)
X-Gm-Message-State: AOAM5327IyYNVupp7aynH6hZz+IHN3FWZkBYQ1P93dGlNk2bnYqZVzJS
        TylOlFBffGH4TckHGxCuRXUppz/cTQodb3H9qKE=
X-Google-Smtp-Source: ABdhPJz3qZomXNInDVLHAQjaYjrJ9QIGLS62tZyxmjcUF4C7BCpCPnvkvoFI2/fGIPJx/c08CYVgcRWm8FSl8ksZe40=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr1437665otk.108.1601309712907;
 Mon, 28 Sep 2020 09:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20200928140623.GA69515@linux.intel.com> <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
 <20200928155215.GA92669@linux.intel.com>
In-Reply-To: <20200928155215.GA92669@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Sep 2020 18:15:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF-hOTZ62_Tf_GAN9_w7ztngdVp_atNrowH5Y0SwSjCAw@mail.gmail.com>
Message-ID: <CAMj1kXF-hOTZ62_Tf_GAN9_w7ztngdVp_atNrowH5Y0SwSjCAw@mail.gmail.com>
Subject: Re: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 28 Sep 2020 at 17:52, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Sep 28, 2020 at 10:16:07PM +0800, Kai-Heng Feng wrote:
> > Hi Jarkko,
> >
> > > On Sep 28, 2020, at 22:06, Jarkko Sakkinen <jarkko.sakkinen@linux.int=
el.com> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 08:31:04PM +0800, Kai-Heng Feng wrote:
> > >> Commit 7f3d176f5f7e "tpm: Require that all digests are present in
> > >> TCG_PCR_EVENT2 structures" causes a null pointer dereference on all
> > >> laptops I have:
> > >
> > > ...
> > >
> > >> [   17.868849] BUG: kernel NULL pointer dereference, address: 000000=
000000002c
> > >> [   17.868852] #PF: supervisor read access in kernel mode
> > >> [   17.868854] #PF: error_code(0x0000) - not-present page
> > >> [   17.868855] PGD 0 P4D 0
> > >> [   17.868858] Oops: 0000 [#1] SMP PTI
> > >> [   17.868860] CPU: 0 PID: 1873 Comm: fwupd Not tainted 5.8.0-rc6+ #=
25
> > >> [   17.868861] Hardware name: LENOVO 20LAZ3TXCN/20LAZ3TXCN, BIOS N27=
ET38W (1.24 ) 11/28/2019
> > >> [   17.868866] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
> > >> [   17.868868] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 25=
 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 00=
 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
> > >> [   17.868869] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
> > >> [   17.868871] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 0000=
000000000010
> > >> [   17.868872] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ffff=
917c99b19438
> > >> [   17.868873] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ffff=
917cbfeae4c0
> > >> [   17.868874] R10: 0000000000000000 R11: 0000000000000002 R12: 0000=
000000000010
> > >> [   17.868875] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ffff=
917c99b19470
> > >> [   17.868876] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(0000)=
 knlGS:0000000000000000
> > >> [   17.868877] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [   17.868878] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 0000=
0000003606f0
> > >> [   17.868879] Call Trace:
> > >> [   17.868884]  seq_read+0x95/0x470
> > >> [   17.868887]  ? security_file_permission+0x150/0x160
> > >> [   17.868889]  vfs_read+0xaa/0x190
> > >> [   17.868891]  ksys_read+0x67/0xe0
> > >> [   17.868893]  __x64_sys_read+0x1a/0x20
> > >> [   17.868896]  do_syscall_64+0x52/0xc0
> > >> [   17.868898]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >> [   17.868900] RIP: 0033:0x7f9d83be91dc
> > >> [   17.868901] Code: Bad RIP value.
> > >> [   17.868902] RSP: 002b:00007fff7f5e0250 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000000
> > >> [   17.868903] RAX: ffffffffffffffda RBX: 00005651d262f420 RCX: 0000=
7f9d83be91dc
> > >> [   17.868904] RDX: 0000000000001000 RSI: 00007fff7f5e0350 RDI: 0000=
000000000010
> > >> [   17.868905] RBP: 00007f9d83cc54a0 R08: 0000000000000000 R09: 0000=
5651d26c1830
> > >> [   17.868906] R10: 00005651d2582010 R11: 0000000000000246 R12: 0000=
000000001000
> > >> [   17.868907] R13: 00007fff7f5e0350 R14: 0000000000000d68 R15: 0000=
7f9d83cc48a0
> > >> [   17.868909] Modules linked in: rfcomm ccm cmac algif_hash algif_s=
kcipher af_alg snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_gener=
ic bnep joydev mei_hdcp wmi_bmof intel_rapl_msr intel_wmi_thunderbolt x86_p=
kg_temp_thermal intel_powerclamp coretemp nls_iso8859_1 kvm_intel kvm crct1=
0dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel glue_helper crypto=
_simd cryptd rapl input_leds intel_cstate snd_hda_intel snd_intel_dspcfg rm=
i_smbus iwlmvm snd_hda_codec serio_raw snd_hwdep mac80211 rmi_core snd_hda_=
core libarc4 uvcvideo snd_pcm videobuf2_vmalloc btusb videobuf2_memops iwlw=
ifi videobuf2_v4l2 btrtl btbcm videobuf2_common btintel thunderbolt i915 bl=
uetooth mei_me videodev thinkpad_acpi nvram cfg80211 ledtrig_audio mei mc e=
cdh_generic ecc i2c_algo_bit processor_thermal_device snd_seq_midi drm_kms_=
helper snd_seq_midi_event intel_soc_dts_iosf syscopyarea sysfillrect snd_ra=
wmidi intel_pch_thermal sysimgblt intel_rapl_common intel_xhci_usb_role_swi=
tch fb_sys_fops ucsi_acpi ro
> > > les cec
> > >> [   17.868935]  typec_ucsi typec nxp_nci_i2c snd_seq nxp_nci wmi nci=
 nfc snd_timer snd_seq_device snd int3403_thermal soundcore int340x_thermal=
_zone video mac_hid int3400_thermal acpi_pad acpi_thermal_rel sch_fq_codel =
parport_pc ppdev lp parport drm ip_tables x_tables autofs4 btrfs blake2b_ge=
neric libcrc32c xor zstd_compress raid6_pq uas usb_storage psmouse e1000e n=
vme i2c_i801 i2c_smbus nvme_core intel_lpss_pci intel_lpss idma64 virt_dma =
pinctrl_sunrisepoint pinctrl_intel
> > >> [   17.868951] CR2: 000000000000002c
> > >> [   17.868953] ---[ end trace ee7716fff5dec2fb ]---
> > >> [   17.868955] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
> > >> [   17.868957] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 25=
 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 00=
 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
> > >> [   17.868958] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
> > >> [   17.868959] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 0000=
000000000010
> > >> [   17.868960] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ffff=
917c99b19438
> > >> [   17.868961] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ffff=
917cbfeae4c0
> > >> [   17.868962] R10: 0000000000000000 R11: 0000000000000002 R12: 0000=
000000000010
> > >> [   17.868963] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ffff=
917c99b19470
> > >> [   17.868964] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(0000)=
 knlGS:0000000000000000
> > >> [   17.868965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [   17.868966] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 0000=
0000003606f0
> > >
> > > It is possible but initially feels a bit weird:
> > >
> > > -                  sizeof(TCG_SPECID_SIG)) || count > efispecid->num_=
algs) {
> > > +                  sizeof(TCG_SPECID_SIG)) ||
> > > +           !efispecid->num_algs || count !=3D efispecid->num_algs) {
> > >
> > > Assuming that check does not pass because of a more strict constraint=
,
> > > __calc_tpm2_event_size() returns 0.
> > >
> > > It is wrapped like this in drivers/char/tpm/eventlog/tpm2.c:
> > >
> > > static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> > >                                struct tcg_pcr_event *event_header)
> > > {
> > >     return __calc_tpm2_event_size(event, event_header, false);
> > > }
> > >
> > > I.e. TPM_MEMUNMAP will not get executed because "do_mapping =3D=3D fa=
lse".
> > > tpm2_bios_measurements_start() checks for "size =3D=3D 0" and returns=
 NULL
> > > whenever this happens.
> > >
> > > Are you 100% sure that it is exactly this commit that triggers the bu=
g?
> >
> > Yes I am 100% sure. The issue happens all the time, and never happens
> > if I checkout the previous commit.
>
> OK, had to just "sanity check". Thank you. Just sounds extremely weird
> because there are no new derefences in the path.
>
> Looking at the call sites in *_start:
>
>         if (*pos > 0) {
>                 addr +=3D size;
>                 event =3D addr;
>                 size =3D calc_tpm2_event_size(event, event_header);
>                 if ((addr + size >=3D  limit) || (size =3D=3D 0))
>                         return NULL;
>         }
>
>         for (i =3D 0; i < (*pos - 1); i++) {
>                 event =3D addr;
>                 size =3D calc_tpm2_event_size(event, event_header);
>
>                 if ((addr + size >=3D limit) || (size =3D=3D 0))
>                         return NULL;
>                 addr +=3D size;
>         }
>
> we just essentially return NULL and efispecid is dereferenced two times
> instead of one. Especially, if this happens on your all machines it
> sounds weird.
>
> Kenneth [1] was experiencing a similar issue. Kenneth, can you try out
> if going one commit before 7f3d176f5f7e sorts out the issue?
>
> This sounds serious enough that I rather revert the commit if it is not
> rooted quickly but I added some people to the CC list who worked on this
> in the past. Perhaps they spot something I'm blind to ATM.
>

In tpm2_bios_measurements_start(), we dereference tpm_bios_log to
access bios_event_log and bios_event_log_end without checking tpm_bios
for NULL. This is where the crash seems to occur.
