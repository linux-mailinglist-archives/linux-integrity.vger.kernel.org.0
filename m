Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAED627B1D6
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1Q0t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 12:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgI1Q0t (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 12:26:49 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E672080C;
        Mon, 28 Sep 2020 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601310407;
        bh=RZgZEQZ2Y+Q2uBAmtWLw8oR3zIwNMMFQeQqDf6MO+CQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EoXt0PxPIkqfcr/hV8zE/p4GT6blLlRf/8EVkcBtndrb1Fv35GCIh2/vCuEM/3mWb
         EJy0/idFE5PhTHw5FqYvg9Lko0Ms1OY/uXWq9P/RPo1KfbYmP7TC1MyL1SBqBo8tli
         JXOIGza3yDiqafp8CZE5B1tMuI21u4NiidPWtZfA=
Received: by mail-oo1-f41.google.com with SMTP id c4so466286oou.6;
        Mon, 28 Sep 2020 09:26:47 -0700 (PDT)
X-Gm-Message-State: AOAM530MNJwGrJp4DFWsfGU1d3SgYikG2ETWwJLBGRoBRvODjN/quDe4
        G7JtZNQJhF/025rgNyZ3wzL4rdVyqSRawPt5tsY=
X-Google-Smtp-Source: ABdhPJz8iTx6GdTrAJzVLHUCd9Gh2xki+ua5kbiJB0Y44VztM4RTsJ2imoqlKfoSYPsjWddjJfVEdeQFydQBy8tRfrE=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr1419071ooq.13.1601310406886;
 Mon, 28 Sep 2020 09:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20200928140623.GA69515@linux.intel.com> <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
 <20200928155215.GA92669@linux.intel.com> <CAMj1kXF-hOTZ62_Tf_GAN9_w7ztngdVp_atNrowH5Y0SwSjCAw@mail.gmail.com>
In-Reply-To: <CAMj1kXF-hOTZ62_Tf_GAN9_w7ztngdVp_atNrowH5Y0SwSjCAw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Sep 2020 18:26:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGJzYeSrqUG4KkU6WMwNzM55CWFRNVStFn3CpQJyLwW4w@mail.gmail.com>
Message-ID: <CAMj1kXGJzYeSrqUG4KkU6WMwNzM55CWFRNVStFn3CpQJyLwW4w@mail.gmail.com>
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

On Mon, 28 Sep 2020 at 18:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 28 Sep 2020 at 17:52, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 10:16:07PM +0800, Kai-Heng Feng wrote:
> > > Hi Jarkko,
> > >
> > > > On Sep 28, 2020, at 22:06, Jarkko Sakkinen <jarkko.sakkinen@linux.i=
ntel.com> wrote:
> > > >
> > > > On Mon, Sep 28, 2020 at 08:31:04PM +0800, Kai-Heng Feng wrote:
> > > >> Commit 7f3d176f5f7e "tpm: Require that all digests are present in
> > > >> TCG_PCR_EVENT2 structures" causes a null pointer dereference on al=
l
> > > >> laptops I have:
> > > >
> > > > ...
> > > >
> > > >> [   17.868849] BUG: kernel NULL pointer dereference, address: 0000=
00000000002c
> > > >> [   17.868852] #PF: supervisor read access in kernel mode
> > > >> [   17.868854] #PF: error_code(0x0000) - not-present page
> > > >> [   17.868855] PGD 0 P4D 0
> > > >> [   17.868858] Oops: 0000 [#1] SMP PTI
> > > >> [   17.868860] CPU: 0 PID: 1873 Comm: fwupd Not tainted 5.8.0-rc6+=
 #25
> > > >> [   17.868861] Hardware name: LENOVO 20LAZ3TXCN/20LAZ3TXCN, BIOS N=
27ET38W (1.24 ) 11/28/2019
> > > >> [   17.868866] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
> > > >> [   17.868868] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 =
25 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 =
00 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
> > > >> [   17.868869] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
> > > >> [   17.868871] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 00=
00000000000010
> > > >> [   17.868872] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ff=
ff917c99b19438
> > > >> [   17.868873] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ff=
ff917cbfeae4c0
> > > >> [   17.868874] R10: 0000000000000000 R11: 0000000000000002 R12: 00=
00000000000010
> > > >> [   17.868875] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ff=
ff917c99b19470
> > > >> [   17.868876] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(000=
0) knlGS:0000000000000000
> > > >> [   17.868877] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> [   17.868878] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 00=
000000003606f0
> > > >> [   17.868879] Call Trace:
> > > >> [   17.868884]  seq_read+0x95/0x470
> > > >> [   17.868887]  ? security_file_permission+0x150/0x160
> > > >> [   17.868889]  vfs_read+0xaa/0x190
> > > >> [   17.868891]  ksys_read+0x67/0xe0
> > > >> [   17.868893]  __x64_sys_read+0x1a/0x20
> > > >> [   17.868896]  do_syscall_64+0x52/0xc0
> > > >> [   17.868898]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >> [   17.868900] RIP: 0033:0x7f9d83be91dc
> > > >> [   17.868901] Code: Bad RIP value.
> > > >> [   17.868902] RSP: 002b:00007fff7f5e0250 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000000
> > > >> [   17.868903] RAX: ffffffffffffffda RBX: 00005651d262f420 RCX: 00=
007f9d83be91dc
> > > >> [   17.868904] RDX: 0000000000001000 RSI: 00007fff7f5e0350 RDI: 00=
00000000000010
> > > >> [   17.868905] RBP: 00007f9d83cc54a0 R08: 0000000000000000 R09: 00=
005651d26c1830
> > > >> [   17.868906] R10: 00005651d2582010 R11: 0000000000000246 R12: 00=
00000000001000
> > > >> [   17.868907] R13: 00007fff7f5e0350 R14: 0000000000000d68 R15: 00=
007f9d83cc48a0
> > > >> [   17.868909] Modules linked in: rfcomm ccm cmac algif_hash algif=
_skcipher af_alg snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_gen=
eric bnep joydev mei_hdcp wmi_bmof intel_rapl_msr intel_wmi_thunderbolt x86=
_pkg_temp_thermal intel_powerclamp coretemp nls_iso8859_1 kvm_intel kvm crc=
t10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel glue_helper cryp=
to_simd cryptd rapl input_leds intel_cstate snd_hda_intel snd_intel_dspcfg =
rmi_smbus iwlmvm snd_hda_codec serio_raw snd_hwdep mac80211 rmi_core snd_hd=
a_core libarc4 uvcvideo snd_pcm videobuf2_vmalloc btusb videobuf2_memops iw=
lwifi videobuf2_v4l2 btrtl btbcm videobuf2_common btintel thunderbolt i915 =
bluetooth mei_me videodev thinkpad_acpi nvram cfg80211 ledtrig_audio mei mc=
 ecdh_generic ecc i2c_algo_bit processor_thermal_device snd_seq_midi drm_km=
s_helper snd_seq_midi_event intel_soc_dts_iosf syscopyarea sysfillrect snd_=
rawmidi intel_pch_thermal sysimgblt intel_rapl_common intel_xhci_usb_role_s=
witch fb_sys_fops ucsi_acpi ro
> > > > les cec
> > > >> [   17.868935]  typec_ucsi typec nxp_nci_i2c snd_seq nxp_nci wmi n=
ci nfc snd_timer snd_seq_device snd int3403_thermal soundcore int340x_therm=
al_zone video mac_hid int3400_thermal acpi_pad acpi_thermal_rel sch_fq_code=
l parport_pc ppdev lp parport drm ip_tables x_tables autofs4 btrfs blake2b_=
generic libcrc32c xor zstd_compress raid6_pq uas usb_storage psmouse e1000e=
 nvme i2c_i801 i2c_smbus nvme_core intel_lpss_pci intel_lpss idma64 virt_dm=
a pinctrl_sunrisepoint pinctrl_intel
> > > >> [   17.868951] CR2: 000000000000002c
> > > >> [   17.868953] ---[ end trace ee7716fff5dec2fb ]---
> > > >> [   17.868955] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
> > > >> [   17.868957] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 =
25 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 =
00 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
> > > >> [   17.868958] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
> > > >> [   17.868959] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 00=
00000000000010
> > > >> [   17.868960] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ff=
ff917c99b19438
> > > >> [   17.868961] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ff=
ff917cbfeae4c0
> > > >> [   17.868962] R10: 0000000000000000 R11: 0000000000000002 R12: 00=
00000000000010
> > > >> [   17.868963] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ff=
ff917c99b19470
> > > >> [   17.868964] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(000=
0) knlGS:0000000000000000
> > > >> [   17.868965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> [   17.868966] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 00=
000000003606f0
> > > >
> > > > It is possible but initially feels a bit weird:
> > > >
> > > > -                  sizeof(TCG_SPECID_SIG)) || count > efispecid->nu=
m_algs) {
> > > > +                  sizeof(TCG_SPECID_SIG)) ||
> > > > +           !efispecid->num_algs || count !=3D efispecid->num_algs)=
 {
> > > >
> > > > Assuming that check does not pass because of a more strict constrai=
nt,
> > > > __calc_tpm2_event_size() returns 0.
> > > >
> > > > It is wrapped like this in drivers/char/tpm/eventlog/tpm2.c:
> > > >
> > > > static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *even=
t,
> > > >                                struct tcg_pcr_event *event_header)
> > > > {
> > > >     return __calc_tpm2_event_size(event, event_header, false);
> > > > }
> > > >
> > > > I.e. TPM_MEMUNMAP will not get executed because "do_mapping =3D=3D =
false".
> > > > tpm2_bios_measurements_start() checks for "size =3D=3D 0" and retur=
ns NULL
> > > > whenever this happens.
> > > >
> > > > Are you 100% sure that it is exactly this commit that triggers the =
bug?
> > >
> > > Yes I am 100% sure. The issue happens all the time, and never happens
> > > if I checkout the previous commit.
> >
> > OK, had to just "sanity check". Thank you. Just sounds extremely weird
> > because there are no new derefences in the path.
> >
> > Looking at the call sites in *_start:
> >
> >         if (*pos > 0) {
> >                 addr +=3D size;
> >                 event =3D addr;
> >                 size =3D calc_tpm2_event_size(event, event_header);
> >                 if ((addr + size >=3D  limit) || (size =3D=3D 0))
> >                         return NULL;
> >         }
> >
> >         for (i =3D 0; i < (*pos - 1); i++) {
> >                 event =3D addr;
> >                 size =3D calc_tpm2_event_size(event, event_header);
> >
> >                 if ((addr + size >=3D limit) || (size =3D=3D 0))
> >                         return NULL;
> >                 addr +=3D size;
> >         }
> >
> > we just essentially return NULL and efispecid is dereferenced two times
> > instead of one. Especially, if this happens on your all machines it
> > sounds weird.
> >
> > Kenneth [1] was experiencing a similar issue. Kenneth, can you try out
> > if going one commit before 7f3d176f5f7e sorts out the issue?
> >
> > This sounds serious enough that I rather revert the commit if it is not
> > rooted quickly but I added some people to the CC list who worked on thi=
s
> > in the past. Perhaps they spot something I'm blind to ATM.
> >
>
> In tpm2_bios_measurements_start(), we dereference tpm_bios_log to
> access bios_event_log and bios_event_log_end without checking tpm_bios
> for NULL. This is where the crash seems to occur.

It's one level down from there:

  18: 48 8b 47 70          mov    0x70(%rdi),%rax
  1c: 4c 8b a0 d0 06 00 00 mov    0x6d0(%rax),%r12
  23: 48 8b 88 d8 06 00 00 mov    0x6d8(%rax),%rcx
  2a: 41 8b 5c 24 1c       mov    0x1c(%r12),%ebx <-- trapping instruction

%rdi is is seq_file *m, so %rax is the tpm_chip pointer 'chip'.

The tpm_bios_log struct is embedded in the tpm_chip struct, but its
values are bogus.

So when we assign event_header to the value of
tpm_bios_log->bios_event_log and attempt to dereference it to get at
its event_size member, we crash. (0x1c is the offset of event_size in
struct tcg_pcr_event)
