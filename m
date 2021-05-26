Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE55391FFE
	for <lists+linux-integrity@lfdr.de>; Wed, 26 May 2021 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhEZTFM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 May 2021 15:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235788AbhEZTFF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 May 2021 15:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622055812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FlQKpIfJ0NBtbfPQuhhbpqEv+Y9nwkYQmRN81LuOgk=;
        b=OgdX7IoNvBFhg5LLXuus5VjszX6CW6T4YFowZK62z864OJSBKYHddw2GjG6AdepnpH9Lnl
        G2apqVEFRZ76tKxotvW3ULV5vWs9euOU4O77wvPC+9P1MkqEriT/5DAxoJ0fR058xFOFHx
        MTGU87kX6XVkwYYrymJf7AXM2Nst8RA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-5tq3MnY1Pp-Uk8ivXyFKBA-1; Wed, 26 May 2021 15:03:30 -0400
X-MC-Unique: 5tq3MnY1Pp-Uk8ivXyFKBA-1
Received: by mail-ed1-f70.google.com with SMTP id cy15-20020a0564021c8fb029038d26976787so1141843edb.0
        for <linux-integrity@vger.kernel.org>; Wed, 26 May 2021 12:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1FlQKpIfJ0NBtbfPQuhhbpqEv+Y9nwkYQmRN81LuOgk=;
        b=fSYMV45ggwcOJ5iwNCFl/wuBXoCR88qfx8LMD+J07nw+HsAPWQkIAYYxcrk3D8givs
         mc0DptYryD5LTAh2hI2a5iJc1U/eKTUBcZBW/QNhZpjIiPMFP8Qg0pqr2nFHEveVgWuI
         u/MpsP55RGt5mWy5QKr6AuPWYv6jzGqk9YhktvShdOnRuc2vzpXEoUGPuTWYH5Pgdyu5
         qqX6oF4N+bNuJx0tv1KCk8m8sh3K/PTRuAgC8szk6mlfoswa29tINbLO3eLyOyVQk6O/
         82m3IGvz5gM2++pRg8WkUUKR3XCUleZDo0gtsVgZbiMHaCO66fbkX8wvyfnDdAji0Wd6
         Kvzg==
X-Gm-Message-State: AOAM533Rrl9EkV8nvZMTqPpI92MvNshkxoPdVvWDj/fBltjG7SWK68VG
        HUnY4OyUU6neSU8uZtLWwARKEaIT7zTFIsHN2G8NZ/uQby94YMM8coLJQwrjLNsyrDUFv9PXuHg
        ENGLmjt2Bb2/7h7MnqwA0wdzKohIjsZOJDqoVnPTa8KL9GtSBU6ezrQuYmBRxyBku6bYPgPkKGH
        YMbF5S
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr2558031edb.330.1622055808135;
        Wed, 26 May 2021 12:03:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEoYKOYYoHuCkrg4V87TaUOUxDEuJN8YzVQ9qBBjNPQz7EpP9b0uGvZNOZN1c9yy+bcodnlQ==
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr2557996edb.330.1622055807732;
        Wed, 26 May 2021 12:03:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n24sm13102013edv.51.2021.05.26.12.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 12:03:27 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
 <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
 <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
Message-ID: <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
Date:   Wed, 26 May 2021 21:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 5/11/21 10:37 AM, Hans de Goede wrote:
> Hi,
> 
> On 5/10/21 7:25 PM, Jarkko Sakkinen wrote:
>> On Sat, May 08, 2021 at 11:07:43AM +0200, Hans de Goede wrote:
>>> Hi Jarko,
>>>
>>> On 3/16/21 8:18 PM, Jarkko Sakkinen wrote:
>>>> On Tue, Mar 16, 2021 at 04:34:01PM +0100, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 2/11/21 2:09 PM, Hans de Goede wrote:
>>>>>> Hi Jerry,
>>>>>>
>>>>>> It looks like there still is an issue with the recent changes to the tpm_tis IRQ
>>>>>> handling. At least I think those are the cause I did not dive any deeper,
>>>>>> I just noticed that we (Fedora) have been receiving an aweful lot of
>>>>>> kernel tpm_tis_send_data backtraces with most starting with tpm_tis_probe_irq_...
>>>>>>
>>>>>> See for example:
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1912167
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1927610
>>>>>>
>>>>>> Those are just the 3 which landed in my inbox today, for much more see:
>>>>>> https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data
>>>>>> (this shows 18 bugs atm).
>>>>>>
>>>>>> These were reported through the Fedora ABRT tools which automatically
>>>>>> collects backtraces, the bugs have links to the ABRT reports, e.g. :
>>>>>> https://retrace.fedoraproject.org/faf/reports/28155/
>>>>>> https://retrace.fedoraproject.org/faf/reports/37107/
>>>>>>
>>>>>> The 28155 report says that so far there have been 308,412 (ouch) automatic
>>>>>> uploads of that particular variant of these backtraces
>>>>>>
>>>>>> Note the second (37107) retrace report is about this happening
>>>>>> on resume, rather then on probe/tpm_tis_probe_irq_... time.
>>>>>>
>>>>>> Did your work on this work land in 5.10 ? Or could it be that the
>>>>>> issue is an incomplete backport to the 5.10.y stable series ?
>>>>>
>>>>> Ping ?
>>>>>
>>>>> It is raining bug-reports about this:
>>>>>
>>>>> https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data
>>>>>
>>>>> Currently lists 25 bugs and that is excluding bugs which have already
>>>>> been marked as a duplicate.
>>>>>
>>>>> Can someone involved in the patch-series which is causing this regression
>>>>> please take a look at these kernel backtraces ?
>>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>>>
>>>> I incorporated two fixes to this issue to my last PR, which were taken
>>>> to the mainline. What is the situation with the mainline?
>>>
>>> Thank you for your reply and sorry for being slow to respond.
>>>
>>> Is this expected to be fixed in 5.11, or when you say mainline you
>>> main Linus' master branch / so the fixes are in 5.12 only ?
>>>
>>> The reason I'm asking is because we just received another bugreport
>>> about this against 5.11.17. The bug is marked private (our tool to
>>> automatically file bugs for kernel backtraces does this) so let me
>>> just copy and paste the trace here:
>>>
>>> WARNING: CPU: 0 PID: 3060 at drivers/char/tpm/tpm_tis_core.c:205
>>> tpm_tis_status+0x66/0x70
>>>
>>> CPU: 0 PID: 3060 Comm: systemd-sleep Not tainted 5.11.17-200.fc33.x86_64 #1
>>> Hardware name: Hewlett-Packard HP ProBook 6460b/161D, BIOS 68SCE Ver. F.63
>>> 05/27/2016
>>> RIP: 0010:tpm_tis_status+0x66/0x70
>>> Code: 23 75 05 48 83 c4 10 c3 31 c0 80 3d 38 02 56 01 00 75 f0 48 c7 c7 94 67
>>> 43 96 88 44 24 07 c6 05 24 02 56 01 01 e8 4a 53 3c 00 <0f> 0b 0f b6 44 24 07 eb
>>> d0 90 66 66 66 66 90 41 57 41 56 41 55 41
>>> RSP: 0018:ffffaac581427b10 EFLAGS: 00010282
>>> RAX: 000000000000001b RBX: ffff9dc800b93000 RCX: ffff9dc83b418ac8
>>> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9dc83b418ac0
>>> RBP: ffff9dc800b93000 R08: ffffffff96a64ec0 R09: ffffaac581427ab0
>>> R10: 0000000000000001 R11: 000000002d2d2d2d R12: ffff9dc80667c268
>>> R13: ffff9dc801fd1000 R14: 0000000000000000 R15: ffffaac581427bca
>>> FS:  00007f8f0f32c000(0000) GS:ffff9dc83b400000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000557044ec6c86 CR3: 0000000062e92001 CR4: 00000000000606f0
>>> Call Trace:
>>>  tpm_tis_send_data+0x2b/0x230
>>>  tpm_tis_send_main+0x1e/0xe0
>>>  tpm_transmit+0xd8/0x3d0
>>>  tpm_transmit_cmd+0x25/0x90
>>>  tpm1_do_selftest+0x88/0x130
>>>  ? _cond_resched+0x16/0x40
>>>  tpm_tis_resume+0x4d/0x120
>>>  ? pnpacpi_resume+0x1b/0xa0
>>>  ? pnp_bus_suspend+0x10/0x10
>>>  pnp_bus_resume+0x63/0x90
>>>  dpm_run_callback+0x4c/0x120
>>>  device_resume+0xa7/0x200
>>>  dpm_resume+0xce/0x2c0
>>>  dpm_resume_end+0xd/0x20
>>>  suspend_devices_and_enter+0x195/0x750
>>>  pm_suspend.cold+0x329/0x374
>>>  state_store+0x71/0xd0
>>>  kernfs_fop_write_iter+0x124/0x1b0
>>>  new_sync_write+0x108/0x180
>>>  vfs_write+0x1bc/0x270
>>>  ksys_write+0x4f/0xc0
>>>  do_syscall_64+0x33/0x40
>>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> RIP: 0033:0x7f8f102ec4e7
>>> Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64
>>> 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51
>>> c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>>> RSP: 002b:00007ffe87216bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f8f102ec4e7
>>> RDX: 0000000000000004 RSI: 00007ffe87216ce0 RDI: 0000000000000004
>>> RBP: 00007ffe87216ce0 R08: 000055c485d835e0 R09: 00007f8f103830c0
>>> R10: 00007f8f10382fc0 R11: 0000000000000246 R12: 0000000000000004
>>> R13: 000055c485d7f650 R14: 0000000000000004 R15: 00007f8f103bf720
>>>
>>> Regards,
>>>
>>> Hans
>>
>> I sent a couple fixes (cc'd to you).
> 
> I've seen the fixes, thank you.
> 
> I'll probably add these as downstream patches to the Fedora 5.12 kernels for now
> and see if that helps.

I'm afraid that we are still getting tpm irq kernel-backtrace reports with
5.12.6 which has the 2 fixes (AFAICT), here are 2 of them:

WARNING: CPU: 5 PID: 142 at drivers/char/tpm/tpm_tis_core.c:205
tpm_tis_status+0x66/0x70
Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp bridge stp
llc ccm michael_mic nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct cmac nft_chain_nat ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security
ip_set nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter
snd_soc_skl_hda_dsp snd_soc_hdac_hdmi qrtr_mhi bnep snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic snd_sof_pci_intel_tgl
snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation
soundwire_cadence sunrpc snd_sof_intel_hda snd_sof_pci iTCO_wdt snd_sof
intel_pmc_bxt iTCO_vendor_support snd_sof_xtensa_dsp snd_soc_hdac_hda
snd_hda_ext_core
 snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core mei_hdcp
x86_pkg_temp_thermal qrtr snd_compress intel_pmt_telemetry intel_powerclamp
intel_rapl_msr ns snd_pcm_dmaengine intel_pmt_class ac97_bus dell_laptop
ath11k_pci coretemp ledtrig_audio ath11k dell_smm_hwmon kvm_intel snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi qmi_helpers kvm snd_hda_codec mac80211
snd_hda_core snd_hwdep snd_seq snd_seq_device irqbypass intel_cstate dell_wmi
intel_uncore snd_pcm dell_smbios dcdbas cfg80211 snd_timer pcspkr snd wmi_bmof
dell_wmi_sysman dell_wmi_descriptor i2c_i801 soundcore i2c_smbus mhi uvcvideo
libarc4 hci_uart videobuf2_vmalloc videobuf2_memops mei_me videobuf2_v4l2 vfat
mei videobuf2_common fat btqca joydev hid_sensor_als btrtl idma64 btbcm
hid_sensor_trigger videodev hid_sensor_iio_common processor_thermal_device
btintel industrialio_triggered_buffer processor_thermal_rfim kfifo_buf
processor_thermal_mbox mc industrialio processor_thermal_rapl bluetooth
thunderbolt
 intel_rapl_common intel_pmt intel_soc_dts_iosf ecdh_generic ucsi_acpi rfkill
typec_ucsi typec ecc int3403_thermal intel_hid int340x_thermal_zone
sparse_keymap int3400_thermal acpi_pad acpi_tad acpi_thermal_rel zram ip_tables
dm_crypt trusted hid_sensor_hub intel_ishtp_loader intel_ishtp_hid
hid_multitouch i915 i2c_algo_bit rtsx_pci_sdmmc nvme drm_kms_helper mmc_core
nvme_core crct10dif_pclmul crc32_pclmul crc32c_intel cec drm
ghash_clmulni_intel rtsx_pci serio_raw intel_ish_ipc intel_ishtp vmd
i2c_hid_acpi i2c_hid wmi video pinctrl_tigerlake fuse
CPU: 5 PID: 142 Comm: kworker/5:1 Not tainted 5.12.6-300.fc34.x86_64 #1
Hardware name: Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021
Workqueue: tpm_dev_wq tpm_dev_async_work
RIP: 0010:tpm_tis_status+0x66/0x70
Code: 23 75 05 48 83 c4 10 c3 31 c0 80 3d ca a0 55 01 00 75 f0 48 c7 c7 b4 1c
44 a6 88 44 24 07 c6 05 b6 a0 55 01 01 e8 6b f3 3c 00 <0f> 0b 0f b6 44 24 07 eb
d0 90 0f 1f 44 00 00 41 57 41 56 41 55 41
RSP: 0018:ffffafc80037bd40 EFLAGS: 00010286
RAX: 000000000000001b RBX: ffff9c8c47cff000 RCX: 0000000000000027
RDX: ffff9c93af7585c8 RSI: 0000000000000001 RDI: ffff9c93af7585c0
RBP: ffff9c8c47cff000 R08: 0000000000000000 R09: ffffafc80037bb70
R10: ffffafc80037bb68 R11: ffffffffa6b45f28 R12: ffff9c8c47df5aa8
R13: ffff9c8c4d14e0ba R14: 0000000000000000 R15: ffffafc80037bdf2
FS:  0000000000000000(0000) GS:ffff9c93af740000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fadaa0bd490 CR3: 0000000170c42005 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 tpm_tis_send_data+0x2b/0x230
 ? tpm_tcg_read_bytes+0x30/0x50
 tpm_tis_send_main+0x1e/0xe0
 tpm_transmit+0xd6/0x3d0WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:205
tpm_tis_status+0x66/0x70
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.12.6-300.fc34.x86_64 #1
Hardware name: Dell Inc. XPS 13 9310/0GG9PT, BIOS 2.2.0 04/06/2021
RIP: 0010:tpm_tis_status+0x66/0x70
Code: 23 75 05 48 83 c4 10 c3 31 c0 80 3d ca a0 55 01 00 75 f0 48 c7 c7 b4 1c
44 a6 88 44 24 07 c6 05 b6 a0 55 01 01 e8 6b f3 3c 00 <0f> 0b 0f b6 44 24 07 eb
d0 90 0f 1f 44 00 00 41 57 41 56 41 55 41
RSP: 0018:ffffad554006bae0 EFLAGS: 00010282
RAX: 000000000000001b RBX: ffff96bf471d5000 RCX: ffffffffa6b15ee8
RDX: c0000000ffffdfff RSI: 00000000ffffdfff RDI: ffffffffa752ec6c
RBP: ffff96bf471d5000 R08: 0000000000000000 R09: ffffad554006b910
R10: ffffad554006b908 R11: ffffffffa6b45f28 R12: ffff96bf472f61a8
R13: ffff96bf47d87000 R14: 0000000000000000 R15: ffffad554006bb92
FS:  0000000000000000(0000) GS:ffff96c2bf680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff201c82958 CR3: 0000000010a10001 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 tpm_tis_send_data+0x2b/0x230
 tpm_tis_send_main+0x1e/0xe0
 tpm_transmit+0xd6/0x3d0
 tpm_transmit_cmd+0x25/0x90
 tpm2_pcr_extend+0x1f9/0x240
 tpm_pcr_extend+0xa1/0xb0
 ima_add_template_entry+0x16e/0x220
 ? ima_store_template+0x3a/0xb0
 ? hash_setup+0xc5/0xc5
 ima_add_boot_aggregate+0xd4/0x13e
 ima_init+0x51/0x94
 init_ima+0x23/0xb5
 ? hash_setup+0xc5/0xc5
 do_one_initcall+0x44/0x1d0
 kernel_init_freeable+0x1da/0x221
 ? rest_init+0xb4/0xb4
 kernel_init+0xa/0x11c
 ret_from_fork+0x1f/0x30

 tpm_dev_transmit.constprop.0+0x47/0xa0
 tpm_dev_async_work+0x62/0x90
 process_one_work+0x1ec/0x380
 worker_thread+0x53/0x3e0
 ? process_one_work+0x380/0x380
 kthread+0x11b/0x140
 ? kthread_associate_blkcg+0xa0/0xa0
 ret_from_fork+0x1f/0x30


Regards,

Hans




