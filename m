Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E083F56EC
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2019 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbfKHTNr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Nov 2019 14:13:47 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48001 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389324AbfKHTNq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Nov 2019 14:13:46 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 890153E4
        for <linux-integrity@vger.kernel.org>; Fri,  8 Nov 2019 14:13:45 -0500 (EST)
Received: from imap1 ([10.202.2.51])
  by compute2.internal (MEProxy); Fri, 08 Nov 2019 14:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fraction.io; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm2; bh=kG/csrh4omKU98BxRi3thRSF6JAbAZV7BCgip3dQeEQ=; b=PaA0vYr1
        CZGDs5qgNi6zi75YiIsJUC6A5aHz9onX2nrbgnRHu1ZZPznfaalOzYge4w3TlAJE
        MZJkxE7PJaUqxZ/BS9O2tCd/99vQTLYH3VMs2KjmqHlNq6EqStxAsz79oAUK7adH
        BKOQ66KMjQr1CbVlodxQ6EVjxEK+TrSR5GnfTvqxEKBw888O76hhdU+BHJdf68hs
        HZtBmxjBxfVYRe6tJBp7ImDTmmhNGxMV1xW/xRd+OkJ1sgUvbVi0H7qvvlcsMQ4U
        w22CfY/ROhMw4PnWNkBXDBXMIISF76zNmZ/JWvMseHQO5dI9UdXE118UlJWi97Z0
        sENu2DFXOsJ9tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=kG/csrh4omKU98BxRi3thRSF6JAbA
        ZV7BCgip3dQeEQ=; b=yE4cgzShxY9lziFvi+8a3AUavgKTLRVtmuPBlINbqcdpW
        /KzdsoKxOnA253vFNpgRBg56/+7hufSMoaUWggisKUeF12ZhGVkEozvYb7xG6SqW
        97oL8+9zwngctcE2EmqavShioQPDGlesuNn7LnRLQ2rzqTkNjGZDgAnZwYpiIvvW
        NAIWjbOqCmdKhJb838ObJrgEsVqeJhB/QZY6y873NOhDW8WcGeaPvm28gSu0QiHS
        xW/AGjpnkjR86vg2WxJ2fnDzSfkQ/V5dc6xyVKJ71Wtf4sGPn8GuSucAr9E4uYyd
        riQQVOgCQnoIWdbW76Uw03y4zuhYPm1RXEB9hKVSA==
X-ME-Sender: <xms:aL7FXaHGx16o4bINF1kiQXtfG_maDwirE1jWDJa-t6t6k-53FH58cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdevhhhrihhsthhirghnuceuuhhnugihfdcuoegthhhrihhs
    thhirghnsghunhguhiesfhhrrggtthhiohhnrdhioheqnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghdpghhithhhuhgsrdgtohhmpdgrrhgthhhlihhnuhigrdhorhhgnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegthhhrihhsthhirghnsghunhguhiesfhhrrggtthhioh
    hnrdhiohenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:aL7FXc1ikRfYdxZqqxes3ppcjS0HLCCwHheGOt_m6-SwipbLT8cxQQ>
    <xmx:aL7FXUP8vLfs9Ve1Ki5AiReB8exgj0lqlxLqGSvmVynLSbGnHdryAA>
    <xmx:aL7FXT7027GqsBpYj3wXWAf79iUGhpeFhahkro2LExuj7YwrYfpn3Q>
    <xmx:ab7FXex429HSPXU6WsVCFLwLFO2UIHzJDa-Xaqi57r_aS4rEyrQeDA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A7A5DC200A4; Fri,  8 Nov 2019 14:13:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-509-ge3ec61c-fmstable-20191030v1
Mime-Version: 1.0
Message-Id: <a60dadce-3650-44ce-8785-2f737ab9b993@www.fastmail.com>
Date:   Fri, 08 Nov 2019 11:13:11 -0800
From:   "Christian Bundy" <christianbundy@fraction.io>
To:     linux-integrity@vger.kernel.org
Subject: PROBLEM: TPM bug causes suspend to turn off device
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello! I've reported the bug in bugzilla 
(https://bugzilla.kernel.org/show_bug.cgi?id=205409) but didn't see any 
activity so I thought I should cross-post here. Apologies if I should be 
posting somewhere else instead.

[1.] One line summary of the problem: TPM bug causes suspend to turn off device
[2.] Full description of the problem/report:

After finding this bug in Linux 5.1 I've bisected the kernel and have 
identified that the regression started with commit 
a3fbfae82b4cb3ff9928e29f34c64d0507cad874.

Reading journalctl before this commit would always show this on boot:

    tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
    tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead

Starting with the above commit, instead I saw:

    tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
    tpm tpm0: tpm_try_transmit: send(): error -5
    tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
    tpm_tis 00:08: Could not get TPM timeouts and durations

I've tried removing the TPM module by adding blacklist commands 
/etc/modprobe.d/tpm.conf, but this doesn't seem to work. I can confirm that 
both `journalctl -b | grep -i tpm` and `cat /proc/modules | grep -i tpm` return 
no results when the module is disabled, but `systemctl suspend` still shuts 
down the computer.

Other discussions:

- https://github.com/raphael/linux-samus/issues/217
- https://bbs.archlinux.org/viewtopic.php?pid=1871717

[3.] Keywords (i.e., modules, networking, kernel): tpm, tpm_tis, tpm_tis_core, 
suspend, bisected
[4.] Kernel information
[4.1.] Kernel version (from /proc/version): 5.4-rc6
[4.2.] Kernel .config file: https://bugzilla.kernel.org/attachment.cgi?id=285767
[5.] Most recent kernel version which did not have the bug: 5.0.0
[8.] Environment
[8.1.] Software (add the output of the ver_linux script here) 
https://bugzilla.kernel.org/attachment.cgi?id=285765
[8.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 61
model name	: Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
stepping	: 4
microcode	: 0x2e
cpu MHz		: 1561.163
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 20
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch 
cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi 
flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms 
invpcid rdseed adx smap intel_pt xsaveopt dtherm ida arat pln pts md_clear 
flush_l1d
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs
bogomips	: 4788.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 61
model name	: Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
stepping	: 4
microcode	: 0x2e
cpu MHz		: 1875.696
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 20
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch 
cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi 
flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms 
invpcid rdseed adx smap intel_pt xsaveopt dtherm ida arat pln pts md_clear 
flush_l1d
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs
bogomips	: 4788.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 61
model name	: Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
stepping	: 4
microcode	: 0x2e
cpu MHz		: 1304.107
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 20
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch 
cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi 
flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms 
invpcid rdseed adx smap intel_pt xsaveopt dtherm ida arat pln pts md_clear 
flush_l1d
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs
bogomips	: 4788.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 61
model name	: Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
stepping	: 4
microcode	: 0x2e
cpu MHz		: 2283.470
cache size	: 4096 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 20
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch 
cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi 
flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms 
invpcid rdseed adx smap intel_pt xsaveopt dtherm ida arat pln pts md_clear 
flush_l1d
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs
bogomips	: 4788.78
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

[8.3.] Module information (from /proc/modules):

tun 49152 0 - Live 0x0000000000000000
fuse 118784 3 - Live 0x0000000000000000
ccm 20480 3 - Live 0x0000000000000000
rfcomm 86016 12 - Live 0x0000000000000000
xt_nat 16384 4 - Live 0x0000000000000000
xt_tcpudp 16384 4 - Live 0x0000000000000000
veth 24576 0 - Live 0x0000000000000000
xt_conntrack 16384 2 - Live 0x0000000000000000
ipt_MASQUERADE 16384 2 - Live 0x0000000000000000
nf_conntrack_netlink 49152 0 - Live 0x0000000000000000
nfnetlink 16384 2 nf_conntrack_netlink, Live 0x0000000000000000
xfrm_user 45056 1 - Live 0x0000000000000000
xfrm_algo 16384 1 xfrm_user, Live 0x0000000000000000
xt_addrtype 16384 2 - Live 0x0000000000000000
iptable_filter 16384 1 - Live 0x0000000000000000
iptable_nat 16384 2 - Live 0x0000000000000000
nf_nat_ipv4 16384 2 ipt_MASQUERADE,iptable_nat, Live 0x0000000000000000
nf_nat 36864 2 xt_nat,nf_nat_ipv4, Live 0x0000000000000000
nf_conntrack 172032 6 
xt_nat,xt_conntrack,ipt_MASQUERADE,nf_conntrack_netlink,nf_nat_ipv4,nf_nat, 
Live 0x0000000000000000
nf_defrag_ipv6 20480 1 nf_conntrack, Live 0x0000000000000000
nf_defrag_ipv4 16384 1 nf_conntrack, Live 0x0000000000000000
libcrc32c 16384 2 nf_nat,nf_conntrack, Live 0x0000000000000000
br_netfilter 24576 0 - Live 0x0000000000000000
bridge 188416 1 br_netfilter, Live 0x0000000000000000
stp 16384 1 bridge, Live 0x0000000000000000
llc 16384 2 bridge,stp, Live 0x0000000000000000
overlay 131072 1 - Live 0x0000000000000000
cmac 16384 8 - Live 0x0000000000000000
algif_hash 16384 4 - Live 0x0000000000000000
algif_skcipher 16384 4 - Live 0x0000000000000000
af_alg 28672 18 algif_hash,algif_skcipher, Live 0x0000000000000000
bnep 24576 2 - Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
intel_rapl 24576 0 - Live 0x0000000000000000
hid_logitech_hidpp 40960 0 - Live 0x0000000000000000
iwlmvm 450560 0 - Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
snd_soc_sst_bdw_rt5677_mach 20480 3 - Live 0x0000000000000000
mac80211 925696 1 iwlmvm, Live 0x0000000000000000
kvm_intel 237568 0 - Live 0x0000000000000000
ofpart 16384 0 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
snd_soc_sst_haswell_pcm 106496 2 snd_soc_sst_bdw_rt5677_mach, Live 
0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
cmdlinepart 16384 0 - Live 0x0000000000000000
btusb 53248 0 - Live 0x0000000000000000
intel_spi_platform 16384 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
pcbc 16384 0 - Live 0x0000000000000000
intel_spi 20480 1 intel_spi_platform, Live 0x0000000000000000
snd_soc_sst_firmware 32768 1 snd_soc_sst_haswell_pcm, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
hid_logitech_dj 24576 0 - Live 0x0000000000000000
btintel 24576 1 btusb, Live 0x0000000000000000
snd_soc_sst_ipc 16384 1 snd_soc_sst_haswell_pcm, Live 0x0000000000000000
spi_nor 36864 1 intel_spi, Live 0x0000000000000000
cros_ec_lpcs 16384 0 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
joydev 24576 0 - Live 0x0000000000000000
aesni_intel 200704 14 - Live 0x0000000000000000
iwlwifi 352256 1 iwlmvm, Live 0x0000000000000000
mousedev 24576 0 - Live 0x0000000000000000
cros_ec_core 16384 1 cros_ec_lpcs, Live 0x0000000000000000
iTCO_wdt 16384 0 - Live 0x0000000000000000
mtd 69632 5 ofpart,cmdlinepart,intel_spi, Live 0x0000000000000000
iTCO_vendor_support 16384 1 iTCO_wdt, Live 0x0000000000000000
snd_soc_sst_dsp 36864 1 snd_soc_sst_haswell_pcm, Live 0x0000000000000000
bluetooth 651264 41 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live 
0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
usbhid 57344 0 - Live 0x0000000000000000
crypto_simd 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec_hdmi 57344 1 - Live 0x0000000000000000
cryptd 28672 7 ghash_clmulni_intel,aesni_intel,crypto_simd, Live 
0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 49152 2 - Live 0x0000000000000000
chromeos_laptop 16384 0 - Live 0x0000000000000000
cfg80211 778240 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
hid 135168 4 hid_logitech_hidpp,hid_logitech_dj,hid_generic,usbhid, Live 
0x0000000000000000
intel_cstate 16384 0 - Live 0x0000000000000000
snd_hda_codec 151552 2 snd_hda_codec_hdmi,snd_hda_intel, Live 0x0000000000000000
ecdh_generic 24576 1 bluetooth, Live 0x0000000000000000
snd_soc_rt5677 229376 5 snd_soc_sst_bdw_rt5677_mach, Live 0x0000000000000000
intel_uncore 135168 0 - Live 0x0000000000000000
snd_soc_rt5677_spi 16384 1 snd_soc_rt5677, Live 0x0000000000000000
intel_rapl_perf 16384 0 - Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
snd_soc_rl6231 16384 1 snd_soc_rt5677, Live 0x0000000000000000
snd_soc_core 270336 3 
snd_soc_sst_bdw_rt5677_mach,snd_soc_sst_haswell_pcm,snd_soc_rt5677, Live 
0x0000000000000000
pcspkr 16384 0 - Live 0x0000000000000000
snd_hda_core 98304 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
tpm_tis_core 20480 1 tpm_tis, Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
acpi_als 16384 0 - Live 0x0000000000000000
tpm 65536 2 tpm_tis,tpm_tis_core, Live 0x0000000000000000
snd_compress 24576 1 snd_soc_core, Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
intel_pch_thermal 16384 0 - Live 0x0000000000000000
kfifo_buf 16384 1 acpi_als, Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
rfkill 28672 8 bluetooth,cfg80211, Live 0x0000000000000000
lpc_ich 28672 0 - Live 0x0000000000000000
industrialio 81920 2 acpi_als,kfifo_buf, Live 0x0000000000000000
pcc_cpufreq 16384 0 - Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
battery 24576 0 - Live 0x0000000000000000
rng_core 16384 1 tpm, Live 0x0000000000000000
snd_pcm 131072 8 
snd_soc_sst_haswell_pcm,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_soc_r
t5677,snd_soc_core,snd_hda_core,snd_pcm_dmaengine, Live 0x0000000000000000
uvcvideo 118784 0 - Live 0x0000000000000000
gpio_lynxpoint 16384 0 - Live 0x0000000000000000
snd_timer 36864 1 snd_pcm, Live 0x0000000000000000
evdev 24576 29 - Live 0x0000000000000000
snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
snd 106496 19 
snd_soc_sst_haswell_pcm,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_soc_c
ore,snd_hwdep,snd_compress,snd_pcm,snd_timer, Live 0x0000000000000000
snd_soc_acpi_intel_match 24576 1 snd_soc_sst_acpi, Live 0x0000000000000000
atmel_mxt_ts 45056 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 2 uvcvideo,atmel_mxt_ts, Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
cros_kbd_led_backlight 16384 0 - Live 0x0000000000000000
videobuf2_v4l2 28672 2 uvcvideo,atmel_mxt_ts, Live 0x0000000000000000
chromeos_pstore 16384 0 - Live 0x0000000000000000
snd_soc_acpi 16384 2 snd_soc_sst_acpi,snd_soc_acpi_intel_match, Live 
0x0000000000000000
videobuf2_common 53248 3 uvcvideo,atmel_mxt_ts,videobuf2_v4l2, Live 
0x0000000000000000
spi_pxa2xx_platform 28672 0 - Live 0x0000000000000000
videodev 217088 4 uvcvideo,atmel_mxt_ts,videobuf2_v4l2,videobuf2_common, Live 
0x0000000000000000
media 45056 2 uvcvideo,videodev, Live 0x0000000000000000
sg 40960 0 - Live 0x0000000000000000
crypto_user 16384 0 - Live 0x0000000000000000
ip_tables 28672 2 iptable_filter,iptable_nat, Live 0x0000000000000000
x_tables 45056 7 
xt_nat,xt_tcpudp,xt_conntrack,ipt_MASQUERADE,xt_addrtype,iptable_filter,ip_table
s, Live 0x0000000000000000
ext4 737280 1 - Live 0x0000000000000000
crc32c_generic 16384 0 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
mbcache 16384 1 ext4, Live 0x0000000000000000
jbd2 122880 1 ext4, Live 0x0000000000000000
sd_mod 61440 2 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
atkbd 32768 0 - Live 0x0000000000000000
libps2 16384 1 atkbd, Live 0x0000000000000000
ahci 40960 1 - Live 0x0000000000000000
libahci 40960 1 ahci, Live 0x0000000000000000
crc32c_intel 24576 3 - Live 0x0000000000000000
libata 270336 2 ahci,libahci, Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
scsi_mod 249856 3 sg,sd_mod,libata, Live 0x0000000000000000
xhci_hcd 266240 1 xhci_pci, Live 0x0000000000000000
i8042 32768 0 - Live 0x0000000000000000
serio 28672 4 serio_raw,atkbd,i8042, Live 0x0000000000000000
i915 2101248 18 - Live 0x0000000000000000
kvmgt 28672 0 - Live 0x0000000000000000
vfio_mdev 16384 0 - Live 0x0000000000000000
mdev 20480 2 kvmgt,vfio_mdev, Live 0x0000000000000000
vfio_iommu_type1 28672 0 - Live 0x0000000000000000
vfio 32768 3 kvmgt,vfio_mdev,vfio_iommu_type1, Live 0x0000000000000000
kvm 741376 2 kvm_intel,kvmgt, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
intel_gtt 24576 1 i915, Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
drm_kms_helper 208896 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
drm 507904 8 i915,drm_kms_helper, Live 0x0000000000000000
agpgart 49152 2 intel_gtt,drm, Live 0x0000000000000000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-0000 : PCI Bus 0000:00
  0000-0000 : dma1
  0000-0000 : pic1
  0000-0000 : timer0
  0000-0000 : timer1
  0000-0000 : keyboard
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
    0000-0000 : PNP0C04:00
  0000-0000 : pnp 00:05
  0000-0000 : pnp 00:05
  0000-0000 : vesafb
  0000-0000 : pnp 00:05
  0000-0000 : pnp 00:05
  0000-0000 : pnp 00:04
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
  0000-0000 : pnp 00:02
    0000-0000 : ACPI PM1a_EVT_BLK
    0000-0000 : ACPI PM1a_CNT_BLK
    0000-0000 : ACPI PM_TMR
    0000-0000 : iTCO_wdt.0.auto
      0000-0000 : iTCO_wdt
    0000-0000 : ACPI PM2_CNT_BLK
    0000-0000 : iTCO_wdt.0.auto
      0000-0000 : iTCO_wdt
    0000-0000 : ACPI GPE0_BLK
  0000-0000 : INT3437:00
    0000-0000 : lp-gpio
  0000-0000 : 0000:00:02.0
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci
  0000-0000 : 0000:00:1f.2
    0000-0000 : ahci

[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
	Subsystem: Intel Corporation Broadwell-U Host Bridge -OPI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: bdw_uncore

00:02.0 VGA compatible controller: Intel Corporation HD Graphics 5500 (rev 09) 
(prog-if 00 [VGA controller])
	Subsystem: Intel Corporation HD Graphics 5500
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at e0000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 1800 [size=64]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee01004  Data: 402d
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

00:03.0 Audio device: Intel Corporation Broadwell-U Audio Controller (rev 09)
	Subsystem: Intel Corporation Broadwell-U Audio Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at e1218000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee02004  Data: 4021
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:14.0 USB controller: Intel Corporation Wildcat Point-LP USB xHCI Controller 
(rev 03) (prog-if 30 [XHCI])
	Subsystem: Intel Corporation Wildcat Point-LP USB xHCI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at e1200000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee01004  Data: 4022
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root Port #3 
(rev e3) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 40
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff [empty]
	Memory behind bridge: e1100000-e11fffff [size=1M]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[empty]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF 
Not Supported ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, 
OBFF Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee01004  Data: 4021
	Capabilities: [90] Subsystem: Intel Corporation Wildcat Point-LP PCI 
Express Root Port
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn- NFERptEn- FERptEn-
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=40us LTR1.2_Threshold=163840ns
		L1SubCtl2: T_PwrOn=60us
	Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller (rev 03)
	Subsystem: Intel Corporation Wildcat Point-LP LPC Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA Controller 
[AHCI Mode] (rev 03) (prog-if 01 [AHCI 1.0])
	Subsystem: Intel Corporation Wildcat Point-LP SATA Controller [AHCI 
Mode]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: I/O ports at 1860 [size=8]
	Region 1: I/O ports at 1870 [size=4]
	Region 2: I/O ports at 1868 [size=8]
	Region 3: I/O ports at 1874 [size=4]
	Region 4: I/O ports at 1840 [size=32]
	Region 5: Memory at e1210000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee01004  Data: 402e
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1f.6 Signal processing controller: Intel Corporation Wildcat Point-LP 
Thermal Management Controller (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 17
	Region 0: Memory at e1225000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

01:00.0 Network controller: Intel Corporation Wireless 7260 (rev cb)
	Subsystem: Intel Corporation Dual Band Wireless-AC 7260
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at e1100000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee01004  Data: 4027
	Capabilities: [40] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, 
L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF 
Via WAKE#
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, 
OBFF Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 6c-29-95-ff-ff-72-0b-fa
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] Vendor Specific Information: ID=cafe Rev=1 
Len=014 <?>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: KINGSTON RBU-SUS Rev: 02.3
  Type:   Direct-Access                    ANSI  SCSI revision: 05

