Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA0D25F21B
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 05:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIGDiP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Sep 2020 23:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGDiO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Sep 2020 23:38:14 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC980C061573
        for <linux-integrity@vger.kernel.org>; Sun,  6 Sep 2020 20:38:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so9034618qtj.7
        for <linux-integrity@vger.kernel.org>; Sun, 06 Sep 2020 20:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8IR3G53zQ3y8u1XYdkYk3ZrjYtS4XF+loV0A4/gVSFM=;
        b=NrZwUXM5Pkq0jY8O0oyXHOlyNXwEHvJp9cs7QB483ykuqoqsfR60B5HMOHic/F9+ih
         wXC+Py1JMywugqs7eqc0J06jh/04sLTuNElBBEV+vMkb7B10eExUP+umZt9pOqEBIdu6
         ZIp48LVhwqkEqus+ODkb7VuLOfDzakOlD8Tb3sshfVmxzEsF8jim4ihbNNH84Rt7NXNR
         zMyF99my04hWdDJnHBTIR0mR8fiPZ9Qkv3lPshW4FvDev602t1YW7KUDPgdOEJhyl5/K
         BCsaOXaGTtCxYl1Z8lWc0zA+qqjbfdMPlUPS6PLSh9URV+SR6fiHzMwRAzgSdM1eAQWh
         8/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8IR3G53zQ3y8u1XYdkYk3ZrjYtS4XF+loV0A4/gVSFM=;
        b=OWEeRF+c5Sw+e2itRfAETt0qR7eUcAQVTnRTYwTp7/t/Y1a0SMTJjftQdmA8xiR147
         +PUibgqRKgIKsGHn4vbVdVmxFv1rDSMY8zqxjMdqqaapBRnFGNnYJOYxaVKGqFqgxP18
         paGMVYfyJrTN2eKWWkfbhVrfTU//bkvJvGVHqNl4hkYrlsvq31oswKUtZjlajND6lJ3a
         asIA+47AK8iglZPvcLHmJ/dt+59AFNAWM4GcR+9iKjijJRs9qZR5OshLBZ7AkUtyZOlv
         DtbIbWCFds5P1GlDXfSneOBbMSSu/FkxopVA44QPI0mgN/bPpBra8ow8eGhk3Bacpa3f
         124g==
X-Gm-Message-State: AOAM531PnB4GK3iANI+j+hfHHxXf7qolVl/riXelmKLQIujqueZ+4DjX
        cUTR4nifkCcClzmpBN2PoZlO/1WQyt5ZTw==
X-Google-Smtp-Source: ABdhPJyTIQgtpsdTda/u5BxvEhiTfuwJpso5xJEeTutSK/smGoxcBhD4zgEoUDrmDPyIKvYZAwEvrQ==
X-Received: by 2002:ac8:1ab3:: with SMTP id x48mr18607384qtj.153.1599449890479;
        Sun, 06 Sep 2020 20:38:10 -0700 (PDT)
Received: from [192.168.1.247] (104-163-162-219.qc.cable.ebox.net. [104.163.162.219])
        by smtp.googlemail.com with ESMTPSA id t11sm10520112qtp.32.2020.09.06.20.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 20:38:09 -0700 (PDT)
To:     linux-integrity@vger.kernel.org
From:   Ronan Jouchet <ronan.jouchet@gmail.com>
Subject: intel_iommu=on breaks resume from suspend on several Thinkpad models
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <06299499-45d0-23e7-45da-7dbe71ff7a53@gmail.com>
Date:   Sun, 6 Sep 2020 23:38:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi. This is a follow-up of [BUG] 
https://bugzilla.kernel.org/show_bug.cgi?id=197029 ,
where Jarkko Sakkinen asks in comment 31 to move discussion here.

[1.] One line summary of the problem:

intel_iommu=on breaks resume from suspend on several Thinkpad models

[2.] Full description of the problem/report:

With intel_iommu=on, on several Thinkpad models (my personal T560, and
the X1 Yoga / Yoga 460 of commenters over at [BUG]), suspend does work,
but pressing POWER / Enter / whatever key fails to resume from suspend.

Instead, the machine doesn't do anything: system remains suspended,
the glowing LED keeps glowing, and the only option is to force a
hard shutdown with a long press on POWER, and start the system again.

[3.] Keywords (i.e., modules, networking, kernel):

suspend, resume, power management, laptop, lenovo, ibm, thinkpad, intel

[4.] Kernel information

[4.1.] Kernel version (from /proc/version):

Linux version 5.8.7-arch1-1 (linux@archlinux)
       (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35) #1 SMP PREEMPT
       Sat, 05Sep 2020 12:31:32 +0000

This is the official `linux` package currently in Arch's `core` repo:
https://www.archlinux.org/packages/core/x86_64/linux/

[4.2.] Kernel .config file:

https://github.com/archlinux/svntogit-packages/blob/packages/linux/trunk/config

[5.] Most recent kernel version which did not have the bug:

Undetermined.

I witnessed the bug in Linux [ 4.13 , 5.8.7 ] but the bug predates 4.13.
I first noticed it in 4.13 because it's the first version where Arch
shipped a kernel enabling `intel_iommu=on` by default.

Since then, following the Arch Linux sister bug report linked below at
[ARCH-BUG], Arch kernel packagers switched back to `intel_iommu=off`.

[X. Other notes and bugzilla bug summary/chronology]

X.1. This is a follow-up to these threads:
      - [BUG] https://bugzilla.kernel.org/show_bug.cgi?id=197029
      - [ARCH-BBS] https://bbs.archlinux.org/viewtopic.php?pid=1737688
      - [ARCH-BUG] https://bugs.archlinux.org/task/55705

X.2. Over at [ARCH-BBS], someone suggested I try `intel_iommu=igfx_off`
      rather than full `intel_iommu=off`. It's not enough; even with
      `intel_iommu=igfx_off`, resume from suspend is broken.

X.3. The same commenter over at [ARCH-BBS] suggests this bug might be
      related to https://bugs.freedesktop.org/show_bug.cgi?id=89360

X.4. Problem was brought to the Linux IOMMU list:
 
https://lists.linuxfoundation.org/pipermail/iommu/2017-September/024382.html

X.5. Several Reddit commenters confirmed the problem:
 
https://www.reddit.com/r/archlinux/comments/72z2rv/linux_41331_is_in_core/dnmjaeo/

X.6. On 2017-09-30, buzilla commenter Albert wrote at
      https://bugzilla.kernel.org/show_bug.cgi?id=197029#c9 that:

      > I'm seeing this on my X1 Yoga (gen1) as well.
      >
      > When going to suspend (via systemctl suspend) with the default
      > (intel_iommu=on), the power light starts fading/"breathing",
      > but the audio mute LED stays on and the machine hangs.
      >
      > With intel_iommu=off, the power light breathes as well and the
      > auto mute LED turns off correctly. I can then resume it normally
      > (by pressing the Fn key).

X.7. On 2017-10-16, Lu Baolu from Intel wrote at
      https://bugzilla.kernel.org/show_bug.cgi?id=197029#c13 that:

      > This issue has been narrowed down to a hidden ME device which
      > is not OS aware. The main symptom is below error log message
      > and system fails to resume after being suspended.
      >
      >     DMAR: DRHD: handling fault status reg 3
      >     DMAR: [DMA Read] Request device [00:12.4] fault addr b7fff000
      >           [fault reason 02] Present bit in context entry is clear
      >
      > A quick workaround is make PTP OS aware in BIOS configuration.
      > It's likely at "PCH-FW Configuration"->"PTP aware OS".

      However, I couldn't find such an option in my T560's BIOS :-/

X.8. On 2017-11-13, Lu Baolu from Intel wrote at
      https://bugzilla.kernel.org/show_bug.cgi?id=197029#c18 that:

      > This bug is still under investigation. We have narrowed it
      > as a regression caused by a previous commit.
      > The commit owner is now working on a fix.

X.9. On 2020-02-03, to my followup requests, Lu Baolu wrote at
      https://bugzilla.kernel.org/show_bug.cgi?id=197029#c21 that:

      > It seems to be caused by below commit:
      >
      > commit 422eac3f7deae34dbaffd08e03e27f37a5394a56
      > Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
      > Date: Tue Apr 19 12:54:18 2016 +0300
      >
      > tpm_crb: fix mapping of the buffers
      >
      > On my Lenovo x250 the following situation occurs:
      >
      > [18697.813871] tpm_crb MSFT0101:00: can't request region for 
resource
      > [mem 0xacdff080-0xacdfffff]
      >
      > The mapping of the control area overlaps the mapping of the command
      > buffer. The control area is mapped over page, which is not right. It
      > should mapped over sizeof(struct crb_control_area).
      >
      > Fixing this issue unmasks another issue. Command and response 
buffers
      > can overlap and they do interleave on this machine. According to 
the PTP
      > specification the overlapping means that they are mapped to the same
      > buffer.
      >
      > The commit has been also on a Haswell NUC where things worked before
      > applying this fix so that the both code paths for response buffer
      > initialization are tested.
      >
      > Cc: stable@vger.kernel.org
      > Fixes: 1bd047be37d9 ("tpm_crb: Use devm_ioremap_resource")
      > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
      > Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

X.10. ... which was inconclusive to me, so to my followup, he replied
       at https://bugzilla.kernel.org/show_bug.cgi?id=197029#c23 with:

       > I have no idea about how this commit impacts the suspend/resume.
       > The fast way to make it work is to revert this commit,
       > or contact the commit author to rework it.

X.11. In the meantime, bugzilla commenter Albert attempted a revert,
       but was unsuccessful, as this patch no longer cleanly reverts.

X.12. On 2020-08-27, Alyssa Ross applied a patch functionally
       equivalent to reverting 422eac3f7deae34dbaffd08e03e27f37a5394a56 ,
       but this did not solve the problem for her, see
       https://bugzilla.kernel.org/show_bug.cgi?id=197029#c30

X.13. On 2020-08-28, Jarkko Sakkinen asked to bring the discussion to
       this mailing list, and here we are.

[>=8 detailed debug information] =======================================
========================================================================

[8.] Environment

[8.1.] Software (output of the ver_linux script)

Linux t 5.8.7-arch1-1 #1 SMP PREEMPT Sat, 05 Sep 2020 12:31:32 +0000 
x86_64 GNU/Linux

GNU C                 10.2.0
GNU Make              4.3
Binutils              2.35
Util-linux            2.36
Mount                 2.36
Module-init-tools     27
E2fsprogs             1.45.6
Jfsutils              1.1.15
Reiserfsprogs         3.6.27
Xfsprogs              5.7.0
PPP                   2.4.7
Bison                 3.6.4
Flex                  2.6.4
Linux C++ Library     6.0.28
Linux C Library       2.32
Dynamic linker (ldd)  2.32
Procps                3.3.16
Net-tools             2.10
Kbd                   2.3.0
Console-tools         2.3.0
Sh-utils              8.32
Udev                  246
Wireless-tools        30
Modules Loaded        ac ac97_bus acpi_call aesni_intel agpgart 
apple_mfi_fastcharge at24 atkbd battery bluetooth btbcm btintel btrtl 
btusb cbc ccm cec cfg80211 coretemp crc16 crc32c_generic crc32c_intel 
crc32_pclmul crct10dif_pclmul cryptd crypto_simd crypto_user dm_crypt 
dm_mod drm drm_kms_helper e1000e ecc ecdh_generic encrypted_keys evdev 
ext4 fb_sys_fops fuse ghash_clmulni_intel glue_helper hid hid_generic 
i2c_algo_bit i2c_dev i2c_i801 i2c_smbus i8042 i915 input_leds 
intel_cstate intel_gtt intel_pch_thermal intel_pmc_bxt intel_powerclamp 
intel_rapl_common intel_rapl_msr intel_uncore intel_xhci_usb_role_switch 
ipheth ip_tables irqbypass iTCO_vendor_support iTCO_wdt iwlmvm iwlwifi 
jbd2 joydev kvm kvm_intel ledtrig_audio libarc4 libps2 mac80211 mac_hid 
mbcache mc mei mei_hdcp mei_me mei_wdt mmc_core mousedev nvram pcspkr 
psmouse rapl rc_core rfkill rmi_core rmi_smbus rng_core roles rtsx_pci 
rtsx_pci_sdmmc serio serio_raw sg snd snd_compress snd_hda_codec 
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_codec_realtek 
snd_hda_core snd_hda_ext_core snd_hda_intel snd_hwdep snd_intel_dspcfg 
snd_pcm snd_pcm_dmaengine snd_rawmidi snd_seq_device snd_soc_acpi 
snd_soc_acpi_intel_match snd_soc_core snd_soc_skl snd_soc_sst_dsp 
snd_soc_sst_ipc snd_timer snd_usb_audio snd_usbmidi_lib soundcore 
syscopyarea sysfillrect sysimgblt thinkpad_acpi tpm tpm_crb tpm_tis 
tpm_tis_core trusted usbhid uvcvideo videobuf2_common videobuf2_memops 
videobuf2_v4l2 videobuf2_vmalloc videodev wmi wmi_bmof 
x86_pkg_temp_thermal xhci_hcd xhci_pci xhci_pci_renesas x_tables

[8.2.] Processor information (from /proc/cpuinfo):

17:08:33 ~ cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family  : 6
model   : 78
model name  : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
stepping  : 3
microcode : 0xdc
cpu MHz   : 498.445
cache size  : 4096 KB
physical id : 0
siblings  : 4
core id   : 0
cpu cores : 2
apicid    : 0
initial apicid  : 0
fpu   : yes
fpu_exception : yes
cpuid level : 22
wp    : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch cpuid_fault epb invpcid_single ssbd ibrs ibpb stibp 
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 
hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt 
intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp 
hwp_notify hwp_act_window hwp_epp md_clear flush_l1d
vmx flags : vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb 
flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple 
shadow_vmcs pml
bugs    : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs taa itlb_multihit srbds
bogomips  : 5602.18
clflush size  : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family  : 6
model   : 78
model name  : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
stepping  : 3
microcode : 0xdc
cpu MHz   : 499.977
cache size  : 4096 KB
physical id : 0
siblings  : 4
core id   : 1
cpu cores : 2
apicid    : 2
initial apicid  : 2
fpu   : yes
fpu_exception : yes
cpuid level : 22
wp    : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch cpuid_fault epb invpcid_single ssbd ibrs ibpb stibp 
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 
hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt 
intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp 
hwp_notify hwp_act_window hwp_epp md_clear flush_l1d
vmx flags : vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb 
flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple 
shadow_vmcs pml
bugs    : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs taa itlb_multihit srbds
bogomips  : 5602.18
clflush size  : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family  : 6
model   : 78
model name  : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
stepping  : 3
microcode : 0xdc
cpu MHz   : 497.356
cache size  : 4096 KB
physical id : 0
siblings  : 4
core id   : 0
cpu cores : 2
apicid    : 1
initial apicid  : 1
fpu   : yes
fpu_exception : yes
cpuid level : 22
wp    : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch cpuid_fault epb invpcid_single ssbd ibrs ibpb stibp 
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 
hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt 
intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp 
hwp_notify hwp_act_window hwp_epp md_clear flush_l1d
vmx flags : vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb 
flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple 
shadow_vmcs pml
bugs    : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs taa itlb_multihit srbds
bogomips  : 5602.18
clflush size  : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family  : 6
model   : 78
model name  : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
stepping  : 3
microcode : 0xdc
cpu MHz   : 499.991
cache size  : 4096 KB
physical id : 0
siblings  : 4
core id   : 1
cpu cores : 2
apicid    : 3
initial apicid  : 3
fpu   : yes
fpu_exception : yes
cpuid level : 22
wp    : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx 
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor 
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm 
abm 3dnowprefetch cpuid_fault epb invpcid_single ssbd ibrs ibpb stibp 
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 
hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt 
intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp 
hwp_notify hwp_act_window hwp_epp md_clear flush_l1d
vmx flags : vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb 
flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple 
shadow_vmcs pml
bugs    : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs taa itlb_multihit srbds
bogomips  : 5602.18
clflush size  : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

[8.3.] Module information (from /proc/modules):

ccm 20480 6 - Live 0x0000000000000000
snd_usb_audio 315392 1 - Live 0x0000000000000000
ipheth 16384 0 - Live 0x0000000000000000
snd_usbmidi_lib 40960 1 snd_usb_audio, Live 0x0000000000000000
snd_rawmidi 45056 1 snd_usbmidi_lib, Live 0x0000000000000000
apple_mfi_fastcharge 20480 0 - Live 0x0000000000000000
snd_seq_device 16384 1 snd_rawmidi, Live 0x0000000000000000
snd_hda_codec_hdmi 73728 1 - Live 0x0000000000000000
snd_hda_codec_realtek 139264 1 - Live 0x0000000000000000
snd_hda_codec_generic 98304 1 snd_hda_codec_realtek, Live 0x0000000000000000
btusb 65536 0 - Live 0x0000000000000000
btrtl 24576 1 btusb, Live 0x0000000000000000
btbcm 20480 1 btusb, Live 0x0000000000000000
btintel 32768 1 btusb, Live 0x0000000000000000
uvcvideo 114688 0 - Live 0x0000000000000000
bluetooth 720896 5 btusb,btrtl,btbcm,btintel, Live 0x0000000000000000
videobuf2_vmalloc 20480 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 20480 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_v4l2 28672 1 uvcvideo, Live 0x0000000000000000
videobuf2_common 57344 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
videodev 274432 3 uvcvideo,videobuf2_v4l2,videobuf2_common, Live 
0x0000000000000000
ecdh_generic 16384 1 bluetooth, Live 0x0000000000000000
mc 61440 5 
snd_usb_audio,uvcvideo,videobuf2_v4l2,videobuf2_common,videodev, Live 
0x0000000000000000
ecc 36864 1 ecdh_generic, Live 0x0000000000000000
joydev 28672 0 - Live 0x0000000000000000
mousedev 24576 0 - Live 0x0000000000000000
rmi_smbus 16384 0 - Live 0x0000000000000000
rmi_core 86016 1 rmi_smbus, Live 0x0000000000000000
snd_soc_skl 180224 0 - Live 0x0000000000000000
iwlmvm 462848 0 - Live 0x0000000000000000
snd_soc_sst_ipc 20480 1 snd_soc_skl, Live 0x0000000000000000
snd_soc_sst_dsp 40960 1 snd_soc_skl, Live 0x0000000000000000
snd_hda_ext_core 36864 1 snd_soc_skl, Live 0x0000000000000000
snd_soc_acpi_intel_match 45056 1 snd_soc_skl, Live 0x0000000000000000
intel_rapl_msr 20480 0 - Live 0x0000000000000000
mac80211 1048576 1 iwlmvm, Live 0x0000000000000000
snd_soc_acpi 16384 2 snd_soc_skl,snd_soc_acpi_intel_match, Live 
0x0000000000000000
intel_rapl_common 32768 1 intel_rapl_msr, Live 0x0000000000000000
snd_soc_core 323584 1 snd_soc_skl, Live 0x0000000000000000
i915 2641920 33 - Live 0x0000000000000000
libarc4 16384 1 mac80211, Live 0x0000000000000000
snd_compress 32768 1 snd_soc_core, Live 0x0000000000000000
x86_pkg_temp_thermal 20480 0 - Live 0x0000000000000000
intel_powerclamp 20480 0 - Live 0x0000000000000000
coretemp 20480 0 - Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
iwlwifi 405504 1 iwlmvm, Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
kvm_intel 323584 0 - Live 0x0000000000000000
snd_hda_intel 57344 3 - Live 0x0000000000000000
mei_hdcp 24576 0 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
mei_wdt 16384 0 - Live 0x0000000000000000
iTCO_wdt 16384 0 - Live 0x0000000000000000
intel_pmc_bxt 16384 1 iTCO_wdt, Live 0x0000000000000000
snd_intel_dspcfg 24576 2 snd_soc_skl,snd_hda_intel, Live 0x0000000000000000
iTCO_vendor_support 16384 1 iTCO_wdt, Live 0x0000000000000000
at24 24576 0 - Live 0x0000000000000000
snd_hda_codec 167936 4 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, 
Live 0x0000000000000000
drm_kms_helper 262144 1 i915, Live 0x0000000000000000
kvm 847872 1 kvm_intel, Live 0x0000000000000000
wmi_bmof 16384 0 - Live 0x0000000000000000
cfg80211 913408 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_hda_core 106496 7 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_skl,snd_hda_ext_core,snd_hda_intel,snd_hda_codec, 
Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
cec 73728 2 i915,drm_kms_helper, Live 0x0000000000000000
rapl 16384 0 - Live 0x0000000000000000
intel_cstate 16384 0 - Live 0x0000000000000000
fuse 139264 7 - Live 0x0000000000000000
snd_hwdep 16384 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
intel_uncore 163840 0 - Live 0x0000000000000000
e1000e 303104 0 - Live 0x0000000000000000
psmouse 184320 0 - Live 0x0000000000000000
rc_core 61440 1 cec, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
pcspkr 16384 0 - Live 0x0000000000000000
snd_pcm 147456 9 
snd_usb_audio,snd_hda_codec_hdmi,snd_soc_skl,snd_soc_core,snd_compress,snd_pcm_dmaengine,snd_hda_intel,snd_hda_codec,snd_hda_core, 
Live 0x0000000000000000
thinkpad_acpi 114688 0 - Live 0x0000000000000000
snd_timer 45056 1 snd_pcm, Live 0x0000000000000000
mei_me 49152 2 - Live 0x0000000000000000
nvram 16384 1 thinkpad_acpi, Live 0x0000000000000000
intel_gtt 24576 1 i915, Live 0x0000000000000000
i2c_i801 36864 0 - Live 0x0000000000000000
ledtrig_audio 16384 3 
snd_hda_codec_realtek,snd_hda_codec_generic,thinkpad_acpi, Live 
0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
i2c_smbus 20480 1 i2c_i801, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
intel_xhci_usb_role_switch 16384 0 - Live 0x0000000000000000
rfkill 28672 7 bluetooth,cfg80211,thinkpad_acpi, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
snd 114688 23 
snd_usb_audio,snd_usbmidi_lib,snd_rawmidi,snd_seq_device,snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_core,snd_compress,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpad_acpi,snd_timer, 
Live 0x0000000000000000
roles 16384 1 intel_xhci_usb_role_switch, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
mei 126976 5 mei_hdcp,mei_wdt,mei_me, Live 0x0000000000000000
intel_pch_thermal 16384 0 - Live 0x0000000000000000
wmi 36864 1 wmi_bmof, Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
battery 20480 1 thinkpad_acpi, Live 0x0000000000000000
evdev 28672 28 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
tpm_crb 20480 0 - Live 0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
tpm_tis_core 32768 1 tpm_tis, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
drm 585728 12 i915,drm_kms_helper, Live 0x0000000000000000
i2c_dev 24576 0 - Live 0x0000000000000000
sg 40960 0 - Live 0x0000000000000000
crypto_user 16384 0 - Live 0x0000000000000000
acpi_call 16384 0 - Live 0x0000000000000000 (OE)
agpgart 53248 2 intel_gtt,drm, Live 0x0000000000000000
ip_tables 36864 0 - Live 0x0000000000000000
x_tables 53248 1 ip_tables, Live 0x0000000000000000
ext4 802816 2 - Live 0x0000000000000000
crc32c_generic 16384 0 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
mbcache 16384 1 ext4, Live 0x0000000000000000
jbd2 139264 1 ext4, Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 65536 0 - Live 0x0000000000000000
hid 147456 2 hid_generic,usbhid, Live 0x0000000000000000
dm_crypt 53248 1 - Live 0x0000000000000000
cbc 16384 0 - Live 0x0000000000000000
encrypted_keys 24576 1 dm_crypt, Live 0x0000000000000000
dm_mod 163840 3 dm_crypt, Live 0x0000000000000000
trusted 32768 1 encrypted_keys, Live 0x0000000000000000
tpm 77824 4 tpm_crb,tpm_tis,tpm_tis_core,trusted, Live 0x0000000000000000
rng_core 16384 1 tpm, Live 0x0000000000000000
rtsx_pci_sdmmc 32768 0 - Live 0x0000000000000000
mmc_core 188416 1 rtsx_pci_sdmmc, Live 0x0000000000000000
serio_raw 20480 0 - Live 0x0000000000000000
atkbd 36864 0 - Live 0x0000000000000000
libps2 20480 2 psmouse,atkbd, Live 0x0000000000000000
crct10dif_pclmul 16384 1 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
crc32c_intel 24576 4 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
aesni_intel 372736 6 - Live 0x0000000000000000
crypto_simd 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,crypto_simd, Live 0x0000000000000000
xhci_pci 20480 0 - Live 0x0000000000000000
xhci_pci_renesas 20480 1 xhci_pci, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
xhci_hcd 286720 1 xhci_pci, Live 0x0000000000000000
rtsx_pci 90112 1 rtsx_pci_sdmmc, Live 0x0000000000000000
i8042 32768 0 - Live 0x0000000000000000
serio 28672 8 rmi_core,psmouse,serio_raw,atkbd,i8042, Live 
0x0000000000000000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports:

0000-0000 : PCI Bus 0000:00
   0000-0000 : dma1
   0000-0000 : pic1
   0000-0000 : timer0
   0000-0000 : timer1
   0000-0000 : keyboard
   0000-0000 : PNP0800:00
   0000-0000 : PNP0C09:00
     0000-0000 : EC data
   0000-0000 : keyboard
   0000-0000 : PNP0C09:00
     0000-0000 : EC cmd
   0000-0000 : rtc0
   0000-0000 : dma page reg
   0000-0000 : pic2
   0000-0000 : dma2
   0000-0000 : fpu
   0000-0000 : iTCO_wdt
     0000-0000 : iTCO_wdt
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
     0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
     0000-0000 : ACPI PM1a_EVT_BLK
     0000-0000 : ACPI PM1a_CNT_BLK
     0000-0000 : ACPI PM_TMR
     0000-0000 : ACPI CPU throttle
     0000-0000 : ACPI PM2_CNT_BLK
     0000-0000 : pnp 00:05
     0000-0000 : ACPI GPE0_BLK
   0000-0000 : 0000:00:02.0
   0000-0000 : 0000:00:17.0
     0000-0000 : ahci
   0000-0000 : 0000:00:17.0
     0000-0000 : ahci
   0000-0000 : 0000:00:17.0
     0000-0000 : ahci
   0000-0000 : 0000:00:1f.4
     0000-0000 : i801_smbus
   0000-0000 : pnp 00:07

/proc/iomem:

00000000-00000000 : Reserved
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : Video ROM
00000000-00000000 : pnp 00:00
00000000-00000000 : pnp 00:00
00000000-00000000 : pnp 00:00
00000000-00000000 : pnp 00:00
00000000-00000000 : Reserved
   00000000-00000000 : System ROM
00000000-00000000 : System RAM
00000000-00000000 : Reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : Reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : Reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : ACPI Tables
00000000-00000000 : Reserved
   00000000-00000000 : MSFT0101:00
     00000000-00000000 : MSFT0101:00
00000000-00000000 : Reserved
   00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : 0000:00:02.0
   00000000-00000000 : 0000:00:02.0
   00000000-00000000 : PCI Bus 0000:04
     00000000-00000000 : 0000:04:00.0
       00000000-00000000 : iwlwifi
   00000000-00000000 : PCI Bus 0000:02
     00000000-00000000 : 0000:02:00.0
       00000000-00000000 : rtsx_pci
   00000000-00000000 : 0000:00:1f.6
     00000000-00000000 : e1000e
   00000000-00000000 : 0000:00:14.0
     00000000-00000000 : xhci-hcd
       00000000-00000000 : intel_xhci_usb_sw
   00000000-00000000 : 0000:00:1f.3
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:1f.3
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:1f.2
   00000000-00000000 : 0000:00:17.0
     00000000-00000000 : ahci
   00000000-00000000 : 0000:00:08.0
   00000000-00000000 : 0000:00:14.2
     00000000-00000000 : Intel PCH thermal driver
   00000000-00000000 : 0000:00:16.0
     00000000-00000000 : mei_me
   00000000-00000000 : 0000:00:17.0
     00000000-00000000 : ahci
   00000000-00000000 : 0000:00:1f.4
   00000000-00000000 : 0000:00:17.0
     00000000-00000000 : ahci
   00000000-00000000 : pnp 00:01
   00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
     00000000-00000000 : Reserved
       00000000-00000000 : pnp 00:01
   00000000-00000000 : Reserved
     00000000-00000000 : pnp 00:06
     00000000-00000000 : pnp 00:06
     00000000-00000000 : pnp 00:06
       00000000-00000000 : iTCO_wdt
         00000000-00000000 : iTCO_wdt iTCO_wdt
     00000000-00000000 : pnp 00:06
     00000000-00000000 : pnp 00:06
     00000000-00000000 : pnp 00:06
     00000000-00000000 : pnp 00:06
   00000000-00000000 : pnp 00:01
00000000-00000000 : Reserved
   00000000-00000000 : IOAPIC 0
00000000-00000000 : Reserved
   00000000-00000000 : HPET 0
     00000000-00000000 : PNP0103:00
00000000-00000000 : Reserved
   00000000-00000000 : pnp 00:01
   00000000-00000000 : pnp 00:01
   00000000-00000000 : pnp 00:01
00000000-00000000 : pnp 00:01
00000000-00000000 : MSFT0101:00
00000000-00000000 : Reserved
00000000-00000000 : dmar0
00000000-00000000 : dmar1
00000000-00000000 : Local APIC
   00000000-00000000 : Reserved
00000000-00000000 : Reserved
00000000-00000000 : System RAM
   00000000-00000000 : Kernel code
   00000000-00000000 : Kernel rodata
   00000000-00000000 : Kernel data
   00000000-00000000 : Kernel bss
00000000-00000000 : RAM buffer

[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th 
Gen Core Processor Host Bridge/DRAM Registers (rev 08)
   Subsystem: Lenovo Device 2231
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Capabilities: [e0] Vendor Specific Information: Len=10 <?>
   Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller: Intel Corporation Skylake GT2 [HD 
Graphics 520] (rev 07) (prog-if 00 [VGA controller])
   Subsystem: Lenovo Device 2231
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 130
   Region 0: Memory at e0000000 (64-bit, non-prefetchable) [size=16M]
   Region 2: Memory at c0000000 (64-bit, prefetchable) [size=512M]
   Region 4: I/O ports at e000 [size=64]
   Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
   Capabilities: [40] Vendor Specific Information: Len=0c <?>
   Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
     DevCap: MaxPayload 128 bytes, PhantFunc 0
       ExtTag- RBE+ FLReset+
     DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
       MaxPayload 128 bytes, MaxReadReq 128 bytes
     DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
     DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
       10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
       EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
       FRS-
       AtomicOpsCap: 32bit- 64bit- 128bitCAS-
     DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF 
Disabled,
       AtomicOpsCtl: ReqEn-
   Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
     Address: fee00018  Data: 0000
   Capabilities: [d0] Power Management version 2
     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [100 v1] Process Address Space ID (PASID)
     PASIDCap: Exec+ Priv-, Max PASID Width: 14
     PASIDCtl: Enable- Exec- Priv-
   Capabilities: [200 v1] Address Translation Service (ATS)
     ATSCap: Invalidate Queue Depth: 00
     ATSCtl: Enable-, Smallest Translation Unit: 00
   Capabilities: [300 v1] Page Request Interface (PRI)
     PRICtl: Enable- Reset-
     PRISta: RF- UPRGI- Stopped-
     Page Request Capacity: 00008000, Page Request Allocation: 00000000
   Kernel driver in use: i915
   Kernel modules: i915

00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / 
E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
   Subsystem: Lenovo Device 2231
   Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Interrupt: pin A routed to IRQ 255
   Region 0: Memory at e124a000 (64-bit, non-prefetchable) [size=4K]
   Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
     Address: 00000000  Data: 0000
   Capabilities: [dc] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [f0] PCI Advanced Features
     AFCap: TP+ FLR+
     AFCtrl: FLR-
     AFStatus: TP-

00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI 
Controller (rev 21) (prog-if 30 [XHCI])
   Subsystem: Lenovo Device 2231
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 126
   Region 0: Memory at e1220000 (64-bit, non-prefetchable) [size=64K]
   Capabilities: [70] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
     Address: 00000000fee002b8  Data: 0000
   Kernel driver in use: xhci_hcd
   Kernel modules: xhci_pci

00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP 
Thermal subsystem (rev 21)
   Subsystem: Lenovo Device 2231
   Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Interrupt: pin C routed to IRQ 18
   Region 0: Memory at e124b000 (64-bit, non-prefetchable) [size=4K]
   Capabilities: [50] Power Management version 3
     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
     Address: 00000000  Data: 0000
   Kernel driver in use: intel_pch_thermal
   Kernel modules: intel_pch_thermal

00:16.0 Communication controller: Intel Corporation Sunrise Point-LP 
CSME HECI #1 (rev 21)
   Subsystem: Lenovo Device 2231
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 127
   Region 0: Memory at e124c000 (64-bit, non-prefetchable) [size=4K]
   Capabilities: [50] Power Management version 3
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Address: 00000000fee002d8  Data: 0000
   Kernel driver in use: mei_me
   Kernel modules: mei_me

00:17.0 SATA controller: Intel Corporation Sunrise Point-LP SATA 
Controller [AHCI mode] (rev 21) (prog-if 01 [AHCI 1.0])
   Subsystem: Lenovo Device 2231
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 124
   Region 0: Memory at e1248000 (32-bit, non-prefetchable) [size=8K]
   Region 1: Memory at e124f000 (32-bit, non-prefetchable) [size=256]
   Region 2: I/O ports at e080 [size=8]
   Region 3: I/O ports at e088 [size=4]
   Region 4: I/O ports at e060 [size=32]
   Region 5: Memory at e124d000 (32-bit, non-prefetchable) [size=2K]
   Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
     Address: fee00278  Data: 0000
   Capabilities: [70] Power Management version 3
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
   Kernel driver in use: ahci

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root 
Port #1 (rev f1) (prog-if 00 [Normal decode])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 122
   Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
   I/O behind bridge: 0000f000-00000fff [disabled]
   Memory behind bridge: e1100000-e11fffff [size=1M]
   Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled]
   Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
   BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
   Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
     DevCap: MaxPayload 256 bytes, PhantFunc 0
       ExtTag- RBE+
     DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
       MaxPayload 128 bytes, MaxReadReq 128 bytes
     DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
     LnkCap: Port #1, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <16us
       ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
     LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
     LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
       TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
       Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
     SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
       Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
     SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
       Changed: MRL- PresDet- LinkState+
     RootCap: CRSVisible-
     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
     RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
       10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
       EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
       FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
       AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
     DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF 
Disabled, ARIFwd-
       AtomicOpsCtl: ReqEn- EgressBlck-
     LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
     LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
       Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
       Compliance De-emphasis: -6dB
     LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
       EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
       Retimer- 2Retimers- CrosslinkRes: unsupported
   Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
     Address: fee00218  Data: 0000
   Capabilities: [90] Subsystem: Lenovo Device 2231
   Capabilities: [a0] Power Management version 3
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [100 v1] Advanced Error Reporting
     UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
     CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
     CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
     AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- 
ECRCChkEn-
       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
     HeaderLog: 00000000 00000000 00000000 00000000
     RootCmd: CERptEn- NFERptEn- FERptEn-
     RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
       FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
     ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
   Capabilities: [140 v1] Access Control Services
     ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- 
EgressCtrl- DirectTrans-
     ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- 
EgressCtrl- DirectTrans-
   Capabilities: [200 v1] L1 PM Substates
     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
        PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
     L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
         T_CommonMode=60us LTR1.2_Threshold=163840ns
     L1SubCtl2: T_PwrOn=60us
   Capabilities: [220 v1] Secondary PCI Express
     LnkCtl3: LnkEquIntrruptEn- PerformEqu-
     LaneErrStat: 0
   Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root 
Port #3 (rev f1) (prog-if 00 [Normal decode])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin C routed to IRQ 123
   Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
   I/O behind bridge: 0000f000-00000fff [disabled]
   Memory behind bridge: e1000000-e10fffff [size=1M]
   Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled]
   Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
   BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
   Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
     DevCap: MaxPayload 256 bytes, PhantFunc 0
       ExtTag- RBE+
     DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
       MaxPayload 128 bytes, MaxReadReq 128 bytes
     DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
     LnkCap: Port #3, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <1us, L1 <16us
       ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
     LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
     LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
       TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
       Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
     SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
       Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
     SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
       Changed: MRL- PresDet- LinkState+
     RootCap: CRSVisible-
     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
     RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
       10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
       EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
       FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
       AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
     DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF 
Disabled, ARIFwd-
       AtomicOpsCtl: ReqEn- EgressBlck-
     LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
     LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
       Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
       Compliance De-emphasis: -6dB
     LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
       EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
       Retimer- 2Retimers- CrosslinkRes: unsupported
   Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
     Address: fee00258  Data: 0000
   Capabilities: [90] Subsystem: Lenovo Device 2231
   Capabilities: [a0] Power Management version 3
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [100 v1] Advanced Error Reporting
     UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
     CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
     CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
     AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- 
ECRCChkEn-
       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
     HeaderLog: 00000000 00000000 00000000 00000000
     RootCmd: CERptEn- NFERptEn- FERptEn-
     RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
       FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
     ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
   Capabilities: [140 v1] Access Control Services
     ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- 
EgressCtrl- DirectTrans-
     ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- 
EgressCtrl- DirectTrans-
   Capabilities: [200 v1] L1 PM Substates
     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
        PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
     L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
         T_CommonMode=40us LTR1.2_Threshold=163840ns
     L1SubCtl2: T_PwrOn=44us
   Capabilities: [220 v1] Secondary PCI Express
     LnkCtl3: LnkEquIntrruptEn- PerformEqu-
     LaneErrStat: 0
   Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Sunrise Point-LP LPC Controller 
(rev 21)
   Subsystem: Lenovo Device 2231
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0

00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
   Subsystem: Lenovo Device 2231
   Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Region 0: Memory at e1244000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
   Subsystem: Lenovo Device 2231
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 64
   Interrupt: pin A routed to IRQ 138
   Region 0: Memory at e1240000 (64-bit, non-prefetchable) [size=16K]
   Region 4: Memory at e1230000 (64-bit, non-prefetchable) [size=64K]
   Capabilities: [50] Power Management version 3
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Address: 00000000fee00338  Data: 0000
   Kernel driver in use: snd_hda_intel
   Kernel modules: snd_hda_intel, snd_soc_skl

00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
   Subsystem: Lenovo Device 2231
   Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Interrupt: pin A routed to IRQ 16
   Region 0: Memory at e124e000 (64-bit, non-prefetchable) [size=256]
   Region 4: I/O ports at efa0 [size=32]
   Kernel driver in use: i801_smbus
   Kernel modules: i2c_i801

00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection 
I219-LM (rev 21)
   Subsystem: Lenovo Device 2233
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 128
   Region 0: Memory at e1200000 (32-bit, non-prefetchable) [size=128K]
   Capabilities: [c8] Power Management version 3
     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
   Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Address: 00000000fee002f8  Data: 0000
   Capabilities: [e0] PCI Advanced Features
     AFCap: TP+ FLR+
     AFCtrl: FLR-
     AFStatus: TP-
   Kernel driver in use: e1000e
   Kernel modules: e1000e

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A 
PCI Express Card Reader (rev 01)
   Subsystem: Lenovo Device 2233
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 125
   Region 0: Memory at e1100000 (32-bit, non-prefetchable) [size=4K]
   Capabilities: [40] Power Management version 3
     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Address: 00000000fee00298  Data: 0000
   Capabilities: [70] Express (v2) Endpoint, MSI 00
     DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, 
L1 unlimited
       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 
10.000W
     DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
       RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
       MaxPayload 128 bytes, MaxReadReq 512 bytes
     DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
     LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s unlimited, L1 <64us
       ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
     LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
     LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
     DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR+
       10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- 
EETLPPrefix-
       EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
       FRS- TPHComp- ExtTPHComp-
       AtomicOpsCap: 32bit- 64bit- 128bitCAS-
     DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF 
Disabled,
       AtomicOpsCtl: ReqEn-
     LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
       Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
       Compliance De-emphasis: -6dB
     LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
       EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
       Retimer- 2Retimers- CrosslinkRes: unsupported
   Capabilities: [100 v2] Advanced Error Reporting
     UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
     CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
     CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
     AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
     HeaderLog: 00000000 00000000 00000000 00000000
   Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
   Capabilities: [150 v1] Latency Tolerance Reporting
     Max snoop latency: 3145728ns
     Max no snoop latency: 3145728ns
   Capabilities: [158 v1] L1 PM Substates
     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
        PortCommonModeRestoreTime=60us PortTPowerOnTime=60us
     L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
         T_CommonMode=0us LTR1.2_Threshold=163840ns
     L1SubCtl2: T_PwrOn=60us
   Kernel driver in use: rtsx_pci
   Kernel modules: rtsx_pci

04:00.0 Network controller: Intel Corporation Wireless 8260 (rev 3a)
   Subsystem: Intel Corporation Device 1130
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 129
   Region 0: Memory at e1000000 (64-bit, non-prefetchable) [size=8K]
   Capabilities: [c8] Power Management version 3
     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Address: 00000000fee00318  Data: 0000
   Capabilities: [40] Express (v2) Endpoint, MSI 00
     DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 
unlimited
       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
     DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
       RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
       MaxPayload 128 bytes, MaxReadReq 128 bytes
     DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
     LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <8us
       ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
     LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
     LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
     DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
       10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
       EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
       FRS- TPHComp- ExtTPHComp-
       AtomicOpsCap: 32bit- 64bit- 128bitCAS-
     DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+ OBFF 
Disabled,
       AtomicOpsCtl: ReqEn-
     LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
       Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
       Compliance De-emphasis: -6dB
     LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
       EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
       Retimer- 2Retimers- CrosslinkRes: unsupported
   Capabilities: [100 v1] Advanced Error Reporting
     UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
     CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
     CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
     AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- 
ECRCChkEn-
       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
     HeaderLog: 00000000 00000000 00000000 00000000
   Capabilities: [140 v1] Device Serial Number 44-85-00-ff-ff-c8-79-d1
   Capabilities: [14c v1] Latency Tolerance Reporting
     Max snoop latency: 3145728ns
     Max no snoop latency: 3145728ns
   Capabilities: [154 v1] L1 PM Substates
     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
        PortCommonModeRestoreTime=30us PortTPowerOnTime=18us
     L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
         T_CommonMode=0us LTR1.2_Threshold=163840ns
     L1SubCtl2: T_PwrOn=44us
   Kernel driver in use: iwlwifi
   Kernel modules: iwlwifi

[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Samsung SSD 850  Rev: 2B6Q
   Type:   Direct-Access                    ANSI  SCSI revision: 05
