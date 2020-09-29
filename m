Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADACA27D4F4
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgI2RwO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 13:52:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbgI2RwO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 13:52:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08THiNtv021340;
        Tue, 29 Sep 2020 13:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JGVKZbf9mZSauOOTOZozrfig+rxI4WJgh5l/ix+/+Mc=;
 b=onHPHdSVn0HJNKB46cQZtzjtP4tGm3rT9CZbi7hw0aGCIpbJbFfajBTlJp7Anic1TZMB
 xiLx+Qudzi1pjHe7z52UaNu0pVQIfWin3BrzYMW4DlocknaQMdvbVvmvskBxCTqNSya6
 wpq9wld1VpNVy8TfBCeOjBz0mx/42jy+UWmBIQsOv4llP5MtiOQvdLT/k0WhkoExBU7d
 Gsp84sWGTtX4LZ6e5AywmjzCdpKQtyLSZiSGUxloReJO2mQIPwp1AyezCV0joymI2Iwl
 Ai8Sn0Xo3Hew2e92J/xOk0jxO1rlVrVSsw6VmXfRqUyamE3qJzMhUUwlUjkFFAJUr9h8 CQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v9k2r6vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 13:52:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08THlXVA001391;
        Tue, 29 Sep 2020 17:52:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw983kqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 17:52:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08THq66422479334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 17:52:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37CB8A4053;
        Tue, 29 Sep 2020 17:52:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18B3CA4040;
        Tue, 29 Sep 2020 17:52:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.90.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Sep 2020 17:52:04 +0000 (GMT)
Message-ID: <846fe4da67d05f57fba33e38c9a6e394e657adc3.camel@linux.ibm.com>
Subject: Re: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     tyhicks@linux.microsoft.com, linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Sep 2020 13:52:04 -0400
In-Reply-To: <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
         <20200928140623.GA69515@linux.intel.com>
         <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_11:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290148
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-28 at 22:16 +0800, Kai-Heng Feng wrote:
> Hi Jarkko,
> 
> > On Sep 28, 2020, at 22:06, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > On Mon, Sep 28, 2020 at 08:31:04PM +0800, Kai-Heng Feng wrote:
> >> Commit 7f3d176f5f7e "tpm: Require that all digests are present in
> >> TCG_PCR_EVENT2 structures" causes a null pointer dereference on all
> >> laptops I have:
> > 
> > ...
> > 
> >> [   17.868849] BUG: kernel NULL pointer dereference, address: 000000000000002c
> >> [   17.868852] #PF: supervisor read access in kernel mode
> >> [   17.868854] #PF: error_code(0x0000) - not-present page
> >> [   17.868855] PGD 0 P4D 0 
> >> [   17.868858] Oops: 0000 [#1] SMP PTI
> >> [   17.868860] CPU: 0 PID: 1873 Comm: fwupd Not tainted 5.8.0-rc6+ #25
> >> [   17.868861] Hardware name: LENOVO 20LAZ3TXCN/20LAZ3TXCN, BIOS N27ET38W (1.24 ) 11/28/2019
> >> [   17.868866] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
> >> [   17.868868] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 25 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 00 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
> >> [   17.868869] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
> >> [   17.868871] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 0000000000000010
> >> [   17.868872] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ffff917c99b19438
> >> [   17.868873] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ffff917cbfeae4c0
> >> [   17.868874] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000010
> >> [   17.868875] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ffff917c99b19470
> >> [   17.868876] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(0000) knlGS:0000000000000000
> >> [   17.868877] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   17.868878] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 00000000003606f0
> >> [   17.868879] Call Trace:
> >> [   17.868884]  seq_read+0x95/0x470
> >> [   17.868887]  ? security_file_permission+0x150/0x160
> >> [   17.868889]  vfs_read+0xaa/0x190
> >> [   17.868891]  ksys_read+0x67/0xe0
> >> [   17.868893]  __x64_sys_read+0x1a/0x20
> >> [   17.868896]  do_syscall_64+0x52/0xc0
> >> [   17.868898]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> [   17.868900] RIP: 0033:0x7f9d83be91dc
> >> [   17.868901] Code: Bad RIP value.
> >> [   17.868902] RSP: 002b:00007fff7f5e0250 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> >> [   17.868903] RAX: ffffffffffffffda RBX: 00005651d262f420 RCX: 00007f9d83be91dc
> >> [   17.868904] RDX: 0000000000001000 RSI: 00007fff7f5e0350 RDI: 0000000000000010
> >> [   17.868905] RBP: 00007f9d83cc54a0 R08: 0000000000000000 R09: 00005651d26c1830
> >> [   17.868906] R10: 00005651d2582010 R11: 0000000000000246 R12: 0000000000001000
> >> [   17.868907] R13: 00007fff7f5e0350 R14: 0000000000000d68 R15: 00007f9d83cc48a0
> >> [   17.868909] Modules linked in: rfcomm ccm cmac algif_hash algif_skcipher af_alg snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic bnep joydev mei_hdcp wmi_bmof intel_rapl_msr intel_wmi_thunderbolt x86_pkg_temp_thermal intel_powerclamp coretemp nls_iso8859_1 kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel glue_helper crypto_simd cryptd rapl input_leds intel_cstate snd_hda_intel snd_intel_dspcfg rmi_smbus iwlmvm snd_hda_codec serio_raw snd_hwdep mac80211 rmi_core snd_hda_core libarc4 uvcvideo snd_pcm videobuf2_vmalloc btusb videobuf2_memops iwlwifi videobuf2_v4l2 btrtl btbcm videobuf2_common btintel thunderbolt i915 bluetooth mei_me videodev thinkpad_acpi nvram cfg80211 ledtrig_audio mei mc ecdh_generic ecc i2c_algo_bit processor_thermal_device snd_seq_midi drm_kms_helper snd_seq_midi_event intel_soc_dts_iosf syscopyarea sysfillrect snd_rawmidi intel_pch_thermal sysimgblt intel_rapl_common intel_xhci_usb_role_switch fb_sys_fops u
 cs
>  i_acpi r
>  o
> > les cec
> >> [   17.868935]  typec_ucsi typec nxp_nci_i2c snd_seq nxp_nci wmi nci nfc snd_timer snd_seq_device snd int3403_thermal soundcore int340x_thermal_zone video mac_hid int3400_thermal acpi_pad acpi_thermal_rel sch_fq_codel parport_pc ppdev lp parport drm ip_tables x_tables autofs4 btrfs blake2b_generic libcrc32c xor zstd_compress raid6_pq uas usb_storage psmouse e1000e nvme i2c_i801 i2c_smbus nvme_core intel_lpss_pci intel_lpss idma64 virt_dma pinctrl_sunrisepoint pinctrl_intel
> >> [   17.868951] CR2: 000000000000002c
> >> [   17.868953] ---[ end trace ee7716fff5dec2fb ]---
> >> [   17.868955] RIP: 0010:tpm2_bios_measurements_start+0x38/0x1f0
> >> [   17.868957] Code: 55 41 54 53 48 83 ec 30 4c 8b 16 65 48 8b 04 25 28 00 00 00 48 89 45 d0 48 8b 47 70 4c 8b a0 d0 06 00 00 48 8b 88 d8 06 00 00 <41> 8b 5c 24 1c 48 89 4d b0 48 89 d8 48 83 c3 20 4d 85 d2 75 31 4c
> >> [   17.868958] RSP: 0018:ffff9da500a9fde0 EFLAGS: 00010282
> >> [   17.868959] RAX: ffff917d03dc4000 RBX: 0000000000000000 RCX: 0000000000000010
> >> [   17.868960] RDX: 0000000000001000 RSI: ffff917c99b19460 RDI: ffff917c99b19438
> >> [   17.868961] RBP: ffff9da500a9fe38 R08: ffffbda4ffa33fc0 R09: ffff917cbfeae4c0
> >> [   17.868962] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000010
> >> [   17.868963] R13: ffff917c99b19438 R14: ffff917c99b19460 R15: ffff917c99b19470
> >> [   17.868964] FS:  00007f9d80988b00(0000) GS:ffff917d07400000(0000) knlGS:0000000000000000
> >> [   17.868965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   17.868966] CR2: 000000000000002c CR3: 0000000219b12004 CR4: 00000000003606f0
> > 
> > It is possible but initially feels a bit weird:
> > 
> > -                  sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
> > +                  sizeof(TCG_SPECID_SIG)) ||
> > +           !efispecid->num_algs || count != efispecid->num_algs) {
> > 
> > Assuming that check does not pass because of a more strict constraint,
> > __calc_tpm2_event_size() returns 0.
> > 
> > It is wrapped like this in drivers/char/tpm/eventlog/tpm2.c:
> > 
> > static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> > 				   struct tcg_pcr_event *event_header)
> > {
> > 	return __calc_tpm2_event_size(event, event_header, false);
> > }
> > 
> > I.e. TPM_MEMUNMAP will not get executed because "do_mapping == false".
> > tpm2_bios_measurements_start() checks for "size == 0" and returns NULL
> > whenever this happens.
> > 
> > Are you 100% sure that it is exactly this commit that triggers the bug?
> 
> Yes I am 100% sure. The issue happens all the time, and never happens
> if I checkout the previous commit.

I'm seeing this too on my test Ubuntu laptop.  Reverting the patch
fixes it, but there's no data.

Mimi

