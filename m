Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DFA39326D
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 17:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhE0P32 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 11:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235993AbhE0P31 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 11:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622129274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWqXjrqJWC60EgdXoNpL6bq46hyiClBHIJPPT/lRC1w=;
        b=I6YCI+KLTy5/lDbgw4CMISr2pcUCWwxu9f7Q9QHd+JeyQ9zLSBOOYsiF2rkrMPDY5F5W9Z
        ot04Wm/d9MpAeIpPpx0EB5Ih9qnS5LwlZR9E5vzkOjdGDDtEMkFYR5zaUufxn+fTSWgfnb
        w8BH1O2QWjC6oIdpeCEztVGpxLJpyOY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-T8i5mIBePXCxYXPeHdlJbA-1; Thu, 27 May 2021 11:27:53 -0400
X-MC-Unique: T8i5mIBePXCxYXPeHdlJbA-1
Received: by mail-ed1-f69.google.com with SMTP id v18-20020a0564023492b029038d5ad7c8a8so501442edc.11
        for <linux-integrity@vger.kernel.org>; Thu, 27 May 2021 08:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZWqXjrqJWC60EgdXoNpL6bq46hyiClBHIJPPT/lRC1w=;
        b=n6CIK3Mk1l7fl37ZCa4coLDdTVPLMV7UstRH8oBGRkJSB7WD4PRn394veR7Qx/DNy+
         UEy9DgQ3xyIsztLUxUfSezQtJZYVa1fNbTjZeY2D1HROQu+Eevj/PKWHlfeoV7em/yH1
         zFHBg4lQEY7gK3/EMXayoU1YiuqSxQH8I9DHqD31qEfgQfPRH4DlPXv3cY3T1DhROKsl
         gnO8aQcLdDKmNMUM4bMijhb2wDRtSaE8JfuqPMVkwojxxEM8Tfkkg+L9mL/Z779oOpqt
         pdJeKI7VSCeNpBjKqziYIavTIg6S81r9U2Ot0cO9i7822YxFw4exvhlmWADmYjzQHIKs
         NbYQ==
X-Gm-Message-State: AOAM531M+OFkqvoHctwrW/+gjLfQXjjka6NMCYHopJJtcqzN5q+1f++O
        GO/VB67KDHCgsAt+nZEQxIdYZp++naWDUUwu4e7+oO62ypVB7AZEMGadyMl5yUvQ+Ml8zTolY3c
        5KKT2aAWLiaz+XSUG6VGEfYDv87f7InKygvNlqFrPtSujXS9dptCzkzPvSDGv1nhBnW5Sa3OXq+
        02DCbS
X-Received: by 2002:a50:9f23:: with SMTP id b32mr4867289edf.4.1622129270573;
        Thu, 27 May 2021 08:27:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysMXYV/lUxF5C0ky360nf/ItqOZTGFbIyavvx5h/sg+Pz1G1KkqMieD8xBL+vhF5n+T8cubA==
X-Received: by 2002:a50:9f23:: with SMTP id b32mr4867256edf.4.1622129270264;
        Thu, 27 May 2021 08:27:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id zg18sm1171396ejb.41.2021.05.27.08.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 08:27:49 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
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
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
Date:   Thu, 27 May 2021 17:27:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210527140025.vl3ply6wnn7rsygg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 5/27/21 4:00 PM, Jarkko Sakkinen wrote:
> On Wed, May 26, 2021 at 09:03:26PM +0200, Hans de Goede wrote:

<snip>

>> Call Trace:
>>  tpm_tis_send_data+0x2b/0x230
>>  ? tpm_tcg_read_bytes+0x30/0x50
>>  tpm_tis_send_main+0x1e/0xe0
>>  tpm_transmit+0xd6/0x3d0WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:205
>> tpm_tis_status+0x66/0x70
> 
> Does the stack trace stop here for the first one?

No, it goes on below the second one which I copy and pasted, it looks like my cursor was
not at the end when I pasted the second one, sorry, let me paste the first one again:

WARNING: CPU: 5 PID: 142 at drivers/char/tpm/tpm_tis_core.c:205 tpm_tis_status+0x66/0x70
Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp bridge stp llc ccm michael_mic nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct cmac nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter snd_soc_skl_hda_dsp snd_soc_hdac_hdmi qrtr_mhi bnep snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation soundwire_cadence sunrpc snd_sof_intel_hda snd_sof_pci iTCO_wdt snd_sof intel_pmc_bxt iTCO_vendor_support snd_sof_xtensa_dsp snd_soc_hdac_hda snd_hda_ext_core
 snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core mei_hdcp x86_pkg_temp_thermal qrtr snd_compress intel_pmt_telemetry intel_powerclamp intel_rapl_msr ns snd_pcm_dmaengine intel_pmt_class ac97_bus dell_laptop ath11k_pci coretemp ledtrig_audio ath11k dell_smm_hwmon kvm_intel snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi qmi_helpers kvm snd_hda_codec mac80211 snd_hda_core snd_hwdep snd_seq snd_seq_device irqbypass intel_cstate dell_wmi intel_uncore snd_pcm dell_smbios dcdbas cfg80211 snd_timer pcspkr snd wmi_bmof dell_wmi_sysman dell_wmi_descriptor i2c_i801 soundcore i2c_smbus mhi uvcvideo libarc4 hci_uart videobuf2_vmalloc videobuf2_memops mei_me videobuf2_v4l2 vfat mei videobuf2_common fat btqca joydev hid_sensor_als btrtl idma64 btbcm hid_sensor_trigger videodev hid_sensor_iio_common processor_thermal_device btintel industrialio_triggered_buffer processor_thermal_rfim kfifo_buf processor_thermal_mbox mc industrialio processor_thermal_rapl bluetooth thunderbolt
 intel_rapl_common intel_pmt intel_soc_dts_iosf ecdh_generic ucsi_acpi rfkill typec_ucsi typec ecc int3403_thermal intel_hid int340x_thermal_zone sparse_keymap int3400_thermal acpi_pad acpi_tad acpi_thermal_rel zram ip_tables dm_crypt trusted hid_sensor_hub intel_ishtp_loader intel_ishtp_hid hid_multitouch i915 i2c_algo_bit rtsx_pci_sdmmc nvme drm_kms_helper mmc_core nvme_core crct10dif_pclmul crc32_pclmul crc32c_intel cec drm ghash_clmulni_intel rtsx_pci serio_raw intel_ish_ipc intel_ishtp vmd i2c_hid_acpi i2c_hid wmi video pinctrl_tigerlake fuse
CPU: 5 PID: 142 Comm: kworker/5:1 Not tainted 5.12.6-300.fc34.x86_64 #1
Hardware name: Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021
Workqueue: tpm_dev_wq tpm_dev_async_work
RIP: 0010:tpm_tis_status+0x66/0x70
Code: 23 75 05 48 83 c4 10 c3 31 c0 80 3d ca a0 55 01 00 75 f0 48 c7 c7 b4 1c 44 a6 88 44 24 07 c6 05 b6 a0 55 01 01 e8 6b f3 3c 00 <0f> 0b 0f b6 44 24 07 eb d0 90 0f 1f 44 00 00 41 57 41 56 41 55 41
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
 tpm_transmit+0xd6/0x3d0
 tpm_dev_transmit.constprop.0+0x47/0xa0
 tpm_dev_async_work+0x62/0x90
 process_one_work+0x1ec/0x380
 worker_thread+0x53/0x3e0
 ? process_one_work+0x380/0x380
 kthread+0x11b/0x140
 ? kthread_associate_blkcg+0xa0/0xa0
 ret_from_fork+0x1f/0x30

This is from:
https://bugzilla.redhat.com/show_bug.cgi?id=1964974   (private)
https://retrace.fedoraproject.org/faf/reports/74723/  (public)



>> Modules linked in:
>> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.12.6-300.fc34.x86_64 #1
>> Hardware name: Dell Inc. XPS 13 9310/0GG9PT, BIOS 2.2.0 04/06/2021
>> RIP: 0010:tpm_tis_status+0x66/0x70
>> Code: 23 75 05 48 83 c4 10 c3 31 c0 80 3d ca a0 55 01 00 75 f0 48 c7 c7 b4 1c
>> 44 a6 88 44 24 07 c6 05 b6 a0 55 01 01 e8 6b f3 3c 00 <0f> 0b 0f b6 44 24 07 eb
>> d0 90 0f 1f 44 00 00 41 57 41 56 41 55 41
>> RSP: 0018:ffffad554006bae0 EFLAGS: 00010282
>> RAX: 000000000000001b RBX: ffff96bf471d5000 RCX: ffffffffa6b15ee8
>> RDX: c0000000ffffdfff RSI: 00000000ffffdfff RDI: ffffffffa752ec6c
>> RBP: ffff96bf471d5000 R08: 0000000000000000 R09: ffffad554006b910
>> R10: ffffad554006b908 R11: ffffffffa6b45f28 R12: ffff96bf472f61a8
>> R13: ffff96bf47d87000 R14: 0000000000000000 R15: ffffad554006bb92
>> FS:  0000000000000000(0000) GS:ffff96c2bf680000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ff201c82958 CR3: 0000000010a10001 CR4: 0000000000770ee0
>> PKRU: 55555554
>> Call Trace:
>>  tpm_tis_send_data+0x2b/0x230
>>  tpm_tis_send_main+0x1e/0xe0
>>  tpm_transmit+0xd6/0x3d0
>>  tpm_transmit_cmd+0x25/0x90
>>  tpm2_pcr_extend+0x1f9/0x240
>>  tpm_pcr_extend+0xa1/0xb0
>>  ima_add_template_entry+0x16e/0x220
>>  ? ima_store_template+0x3a/0xb0
>>  ? hash_setup+0xc5/0xc5
>>  ima_add_boot_aggregate+0xd4/0x13e
>>  ima_init+0x51/0x94
>>  init_ima+0x23/0xb5
>>  ? hash_setup+0xc5/0xc5
>>  do_one_initcall+0x44/0x1d0
>>  kernel_init_freeable+0x1da/0x221
>>  ? rest_init+0xb4/0xb4
>>  kernel_init+0xa/0x11c
>>  ret_from_fork+0x1f/0x30
>>
>>  tpm_dev_transmit.constprop.0+0x47/0xa0
>>  tpm_dev_async_work+0x62/0x90
>>  process_one_work+0x1ec/0x380
>>  worker_thread+0x53/0x3e0
>>  ? process_one_work+0x380/0x380
>>  kthread+0x11b/0x140
>>  ? kthread_associate_blkcg+0xa0/0xa0
>>  ret_from_fork+0x1f/0x30
>>
>>
>> Regards,
>>
>> Hans
> 
> OK, this is a weird one, and *might* be something unrelated, even though
> it triggers the warning. tpm_pcr_extend() does pin the TPM chip and request
> the locality.
> 
> For the 2nd one I'd be interested about the hardware specifics.

Actually I just checked and both backtrace happen on a:

"Dell Inc. XPS 13 9310"

The second backtrace is from:

https://bugzilla.redhat.com/show_bug.cgi?id=1964735  (private)
https://retrace.fedoraproject.org/faf/reports/38209/ (public)

Note there is public bugzilla, with dmesg with the same backtrace
(on the same laptop), but then with 5.12.5 here:

https://bugzilla.redhat.com/show_bug.cgi?id=1963712

There are also 2 interesting comments on the public bugzilla:

"updated to linux kernel 5.12.5 performed 
sudo shutdown -r now"

"I installed Fedora 34 UEFI from USB on a Dell XPS 13 Developer Edition"

So it seems this is happening on the "Dell XPS 13 Developer
Edition".

I've also checked the BIOS versions involved in the 2 different
bugs and 1964735 has "BIOS 1.2.5 12/10/2020" where as
1963712 has "BIOS 2.2.0 04/06/2021" so this seems to be
independent of the BIOS version.

###

Interestingly enough the first backtrace is also happening on a:
"Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"

So it seems that at least with 5.12.6 (which has the last 2 fixes)
all reports are about the XPS 13 9310. I wonder if there is an
issue with the TPM interrupt line on the XPS 13 9310; I've asked the
reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.

Regards,

Hans

