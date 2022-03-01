Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05E4C8D1A
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Mar 2022 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiCAN5X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Mar 2022 08:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiCAN5U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Mar 2022 08:57:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451129F6E6;
        Tue,  1 Mar 2022 05:56:39 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221DtWuK009207;
        Tue, 1 Mar 2022 13:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ch7UETvHrWiJBcu4FtpggKzUOWEKwGcWEA+rejepY3U=;
 b=I2MNff3fvM+nAKFuzpakrfXs8wrRNHODRYohoV/LFGFwFbgGy5HChmfeZtcUbzk/R+HU
 LSbaKnLc928GDr30sv+2jx3Y0dagPFxCtT9uyFxwyw9uFA8W9mqvVrkkvYqZLEgIOIEA
 4ZBZwwrwy8BbBAdTi9bFtU2+2AzYRN5tn5EWRakTwnCqVGrvC30zjRWh6S5Wh8AkoKIK
 bUlk2A7TBX7oT7BuEmnHx1RM3vShb95mEoarExKGKsjWYXIyukri62rJGRcds14iqmRS
 DZweS8MlAR2+LMWVUZd6IoXQxIEVW98WqfNdE/Kj7pRL9nG40Z5sKG2axtIx6tFIGl1V 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehjesuht6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 13:56:22 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 221D5gu2001332;
        Tue, 1 Mar 2022 13:56:22 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehjesuhsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 13:56:22 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221Du5tk026058;
        Tue, 1 Mar 2022 13:56:21 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3efbuac5aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 13:56:21 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221DuK4O37552448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 13:56:20 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 288FCAC066;
        Tue,  1 Mar 2022 13:56:20 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEFCBAC05E;
        Tue,  1 Mar 2022 13:56:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Mar 2022 13:56:19 +0000 (GMT)
Message-ID: <a7a2c56c-a82b-40a9-68e5-7e6d92427c70@linux.ibm.com>
Date:   Tue, 1 Mar 2022 08:56:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 0/1] tpm: fix reference counting for struct tpm_chip
Content-Language: en-US
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.rosenberger@kunbus.com
References: <20220301022108.30310-1-LinoSanfilippo@gmx.de>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220301022108.30310-1-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eePFo8Uyndi9xnVWC3BYCSwq05TFvONb
X-Proofpoint-GUID: K0HfPW3_MqUq73ar7yccwGOSveInK9-Z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/28/22 21:21, Lino Sanfilippo wrote:
> This patch fixes a reference count issue in the TPM core code.

We also need to apply this patch here to fix another crash:

https://lore.kernel.org/all/20210615091410.17007-2-vincent.whitchurch@axis.com/

A reproducer for the crash below is here:

t1:
# cd /tmp
# modprobe tpm_vtpm_proxy
# swtpm chardev --vtpm-proxy --tpmstate dir=.   --tpm2
New TPM device: /dev/tpm1 (major/minor = 253/1)

t2:
# exec 100<>/dev/tpm1
# exec 101<>/dev/tpmrm1

t1:
# terminate swtpm with ctrl-c
# rmmod tpm_vtpm_proxy

t2:
# echo -en '\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00' >&100

t1: [ may not be necessary ]
# modprobe tpm_vtpm_proxy
# swtpm chardev --vtpm-proxy --tpmstate dir=.   --tpm2
New TPM device: /dev/tpm2 (major/minor = 253/1)

t2:
exit -> crash



[ 1746.443429] 
==================================================================
[ 1746.447007] BUG: KASAN: null-ptr-deref in tpm_chip_start+0x2f/0x120
[ 1746.447856] Read of size 8 at addr 0000000000000060 by task bash/3307

[ 1746.448930] CPU: 129 PID: 3307 Comm: bash Not tainted 5.17.0-rc6+ #477
[ 1746.449818] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.13.0-1ubuntu1.1 04/01/2014
[ 1746.451064] Call Trace:
[ 1746.451399]  <TASK>
[ 1746.451689]  dump_stack_lvl+0x48/0x5e
[ 1746.452188]  ? tpm_chip_start+0x2f/0x120
[ 1746.452717]  kasan_report.cold+0x116/0x11b
[ 1746.453277]  ? tpm_chip_start+0x2f/0x120
[ 1746.453812]  tpm_chip_start+0x2f/0x120
[ 1746.454317]  tpm2_del_space+0x2a/0xa0
[ 1746.454816]  tpmrm_release+0x42/0x50
[ 1746.455297]  __fput+0x104/0x400
[ 1746.455733]  task_work_run+0x8b/0xc0
[ 1746.456218]  do_exit+0x59e/0x1200
[ 1746.456672]  ? handle_mm_fault+0x161/0x340
[ 1746.457254]  ? mm_update_next_owner+0x3d0/0x3d0
[ 1746.457878]  ? up_read+0x15/0x80
[ 1746.458318]  ? do_user_addr_fault+0x29c/0x890
[ 1746.458913]  do_group_exit+0x58/0x100
[ 1746.459406]  __x64_sys_exit_group+0x28/0x30
[ 1746.459974]  do_syscall_64+0x3b/0x90
[ 1746.460457]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1746.461157] RIP: 0033:0x7f211cf1a021
[ 1746.461647] Code: Unable to access opcode bytes at RIP 0x7f211cf19ff7.
[ 1746.462511] RSP: 002b:00007ffc9fd6f798 EFLAGS: 00000246 ORIG_RAX: 
00000000000000e7
[ 1746.463508] RAX: ffffffffffffffda RBX: 00007f211d012470 RCX: 
00007f211cf1a021
[ 1746.464448] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 
0000000000000082
[ 1746.465419] RBP: 0000000000000082 R08: ffffffffffffff88 R09: 
0000000000000001
[ 1746.466364] R10: 0000000000000004 R11: 0000000000000246 R12: 
00007f211d012470
[ 1746.467310] R13: 0000000000000001 R14: 00007f211d012948 R15: 
0000000000000000
[ 1746.468252]  </TASK>
[ 1746.468552] 
==================================================================
[ 1746.469522] Disabling lock debugging due to kernel taint
[ 1746.470367] BUG: kernel NULL pointer dereference, address: 
0000000000000060
[ 1746.471325] #PF: supervisor read access in kernel mode
[ 1746.472018] #PF: error_code(0x0000) - not-present page
[ 1746.472706] PGD 0 P4D 0
[ 1746.473060] Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
[ 1746.475951] CPU: 129 PID: 3307 Comm: bash Tainted: G B             
5.17.0-rc6+ #477
[ 1746.479218] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.13.0-1ubuntu1.1 04/01/2014
[ 1746.482636] RIP: 0010:tpm_chip_start+0x2f/0x120
[ 1746.485538] Code: 41 56 41 55 4c 8d af c8 06 00 00 41 54 55 48 89 fd 
4c 89 ef 53 e8 a1 18 7f ff 48 8b 9d c8 06 00 00 48 8d 7b 60 e8 91 18 7f 
ff <48> 8b 43 60 48 85 c0 74 1c be 01 00 00 00 48 89 ef 0f ae e8 ff d0
[ 1746.492530] RSP: 0018:ffff888109c07d48 EFLAGS: 00010286
[ 1746.495496] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 
0000000000000000
[ 1746.498708] RDX: 0000000000000001 RSI: 0000000000000282 RDI: 
ffffffffbbbf1ba0
[ 1746.501925] RBP: ffff8881ab138000 R08: ffffffffb8189884 R09: 
ffffffffbbba73e7
[ 1746.505098] R10: fffffbfff7774e7c R11: 0000000000000001 R12: 
ffff8881adf6bc00
[ 1746.508333] R13: ffff8881ab1386c8 R14: ffff8881adf6bc28 R15: 
ffffffffb9d9a0a0
[ 1746.511474] FS:  0000000000000000(0000) GS:ffff888abba80000(0000) 
knlGS:0000000000000000
[ 1746.514779] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1746.517799] CR2: 0000000000000060 CR3: 000000071c814003 CR4: 
0000000000370ee0
[ 1746.520987] Call Trace:
[ 1746.523627]  <TASK>
[ 1746.526210]  tpm2_del_space+0x2a/0xa0
[ 1746.528979]  tpmrm_release+0x42/0x50
[ 1746.531826]  __fput+0x104/0x400
[ 1746.534586]  task_work_run+0x8b/0xc0
[ 1746.537452]  do_exit+0x59e/0x1200
[ 1746.540259]  ? handle_mm_fault+0x161/0x340
[ 1746.543358]  ? mm_update_next_owner+0x3d0/0x3d0
[ 1746.546284]  ? up_read+0x15/0x80
[ 1746.549108]  ? do_user_addr_fault+0x29c/0x890
[ 1746.552037]  do_group_exit+0x58/0x100
[ 1746.554894]  __x64_sys_exit_group+0x28/0x30
[ 1746.557857]  do_syscall_64+0x3b/0x90
[ 1746.560725]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1746.563726] RIP: 0033:0x7f211cf1a021
[ 1746.566545] Code: Unable to access opcode bytes at RIP 0x7f211cf19ff7.
[ 1746.569915] RSP: 002b:00007ffc9fd6f798 EFLAGS: 00000246 ORIG_RAX: 
00000000000000e7
[ 1746.573289] RAX: ffffffffffffffda RBX: 00007f211d012470 RCX: 
00007f211cf1a021
[ 1746.576580] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 
0000000000000082
[ 1746.579881] RBP: 0000000000000082 R08: ffffffffffffff88 R09: 
0000000000000001
[ 1746.583140] R10: 0000000000000004 R11: 0000000000000246 R12: 
00007f211d012470
[ 1746.586446] R13: 0000000000000001 R14: 00007f211d012948 R15: 
0000000000000000
[ 1746.589720]  </TASK>
[ 1746.592422] Modules linked in: tpm_vtpm_proxy nft_objref 
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle 
ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw 
iptable_security ip_set rfkill nf_tables nfnetlink ip6table_filter 
ip6_tables iptable_filter sunrpc iTCO_wdt intel_pmc_bxt 
iTCO_vendor_support intel_rapl_msr intel_rapl_common kvm_amd ccp kvm 
joydev irqbypass virtio_balloon pcspkr i2c_i801 i2c_smbus lpc_ich 
tpm_crb tpm_tis tpm_tis_core ip_tables qxl drm_ttm_helper ttm 
drm_kms_helper cec crct10dif_pclmul crc32_pclmul crc32c_intel drm 
virtio_net ghash_clmulni_intel net_failover virtio_console virtio_scsi 
serio_raw failover qemu_fw_cfg ipmi_devintf ipmi_msghandler fuse [last 
unloaded: tpm_vtpm_proxy]
[ 1746.623961] CR2: 0000000000000060
[ 1746.627261] ---[ end trace 0000000000000000 ]---
[ 1746.630675] RIP: 0010:tpm_chip_start+0x2f/0x120
[ 1746.634161] Code: 41 56 41 55 4c 8d af c8 06 00 00 41 54 55 48 89 fd 
4c 89 ef 53 e8 a1 18 7f ff 48 8b 9d c8 06 00 00 48 8d 7b 60 e8 91 18 7f 
ff <48> 8b 43 60 48 85 c0 74 1c be 01 00 00 00 48 89 ef 0f ae e8 ff d0
[ 1746.642208] RSP: 0018:ffff888109c07d48 EFLAGS: 00010286
[ 1746.645658] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 
0000000000000000
[ 1746.649335] RDX: 0000000000000001 RSI: 0000000000000282 RDI: 
ffffffffbbbf1ba0
[ 1746.652984] RBP: ffff8881ab138000 R08: ffffffffb8189884 R09: 
ffffffffbbba73e7
[ 1746.656648] R10: fffffbfff7774e7c R11: 0000000000000001 R12: 
ffff8881adf6bc00
[ 1746.660314] R13: ffff8881ab1386c8 R14: ffff8881adf6bc28 R15: 
ffffffffb9d9a0a0
[ 1746.664008] FS:  0000000000000000(0000) GS:ffff888abba80000(0000) 
knlGS:0000000000000000
[ 1746.667850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1746.671352] CR2: 0000000000000060 CR3: 000000071c814003 CR4: 
0000000000370ee0
[ 1746.675082] Fixing recursive fault but reboot is needed!
[ 1746.678534] BUG: scheduling while atomic: bash/3307/0x00000000
[ 1746.682040] Modules linked in: tpm_vtpm_proxy nft_objref 
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle 
ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw 
iptable_security ip_set rfkill nf_tables nfnetlink ip6table_filter 
ip6_tables iptable_filter sunrpc iTCO_wdt intel_pmc_bxt 
iTCO_vendor_support intel_rapl_msr intel_rapl_common kvm_amd ccp kvm 
joydev irqbypass virtio_balloon pcspkr i2c_i801 i2c_smbus lpc_ich 
tpm_crb tpm_tis tpm_tis_core ip_tables qxl drm_ttm_helper ttm 
drm_kms_helper cec crct10dif_pclmul crc32_pclmul crc32c_intel drm 
virtio_net ghash_clmulni_intel net_failover virtio_console virtio_scsi 
serio_raw failover qemu_fw_cfg ipmi_devintf ipmi_msghandler fuse [last 
unloaded: tpm_vtpm_proxy]
[ 1746.717767] Preemption disabled at:
[ 1746.717769] [<0000000000000000>] 0x0
[ 1746.725600] CPU: 129 PID: 3307 Comm: bash Tainted: G    B D           
5.17.0-rc6+ #477
[ 1746.730099] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.13.0-1ubuntu1.1 04/01/2014
[ 1746.734880] Call Trace:
[ 1746.738768]  <TASK>
[ 1746.742585]  dump_stack_lvl+0x48/0x5e
[ 1746.746589]  __schedule_bug.cold+0xa3/0xb5
[ 1746.750618]  __schedule+0x19a6/0x1e30
[ 1746.754558]  ? preempt_count_sub+0x14/0xc0
[ 1746.758507]  ? wake_up_klogd.part.0+0x5d/0x80
[ 1746.762478]  ? vprintk_emit+0x130/0x280
[ 1746.766398]  ? _printk+0x96/0xb2
[ 1746.770202]  ? io_schedule_timeout+0xc0/0xc0
[ 1746.774173]  ? __cpuidle_text_end+0x8/0x8
[ 1746.778126]  do_task_dead+0x56/0x60
[ 1746.781980]  make_task_dead.cold+0x77/0xe9
[ 1746.785724]  rewind_stack_and_make_dead+0x17/0x17
[ 1746.789457] RIP: 0033:0x7f211cf1a021
[ 1746.792962] Code: Unable to access opcode bytes at RIP 0x7f211cf19ff7.
[ 1746.796809] RSP: 002b:00007ffc9fd6f798 EFLAGS: 00000246 ORIG_RAX: 
00000000000000e7
[ 1746.800730] RAX: ffffffffffffffda RBX: 00007f211d012470 RCX: 
00007f211cf1a021
[ 1746.804547] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 
0000000000000082
[ 1746.808300] RBP: 0000000000000082 R08: ffffffffffffff88 R09: 
0000000000000001
[ 1746.812049] R10: 0000000000000004 R11: 0000000000000246 R12: 
00007f211d012470
[ 1746.815798] R13: 0000000000000001 R14: 00007f211d012948 R15: 
0000000000000000
[ 1746.819553]  </TASK>



>
> Changes in v8:
> - adjust names of jump labels for error cases
>
> Changes in v7:
> - adjust naming of jump labels to fit better the used label naming scheme
>
> Changes in v6:
> - rename function tpm2_add_device() to tpm_devs_add() as requested by Jarko
> - add function descriptions
> - fix source code formatting
>
> Changes in v5:
> - move function tpm_add_tpm2_char_device() to tpm2-space.c and rename
> it to tpm2_add_device() as requested by Jarko
> - put "cc" tag before all other tags
> - ensure that the error path in tpm2_add_device() always calls
> the release() function of chip->devs as requested by Jason
> - reformat a code line as suggested by David Laight
>
> Changes in v4:
> - drop patch 2 (tpm: in tpm2_del_space check if ops pointer is still
> valid) since James Bottomley offered a cleaner solution for this
> - reimplement patch 1 to setup the /dev/tpmrm device only in case of TPM2
> and avoid the installation of another action handler. This is based on a
> suggestion and basic implementation done by Jason Gunthorpe.
> - added tag to CC stable
>
> Changes in v3:
> - drop the patch that introduces the new function tpm_chip_free()
> - rework the commit messages for the patches (style, typos, etc.)
> - add fixes tag to patch 2
> - add James Bottomley to cc list
> - add stable mailing list to cc list
>
> Changes in v2:
> - drop the patch that erroneously cleaned up after failed installation of
>    an action handler in tpmm_chip_alloc() (pointed out by Jarkko Sakkinen)
> - make the commit message for patch 1 more detailed
> - add fixes tags and kernel logs
>
>
> Lino Sanfilippo (1):
>    tpm: fix reference counting for struct tpm_chip
>
>   drivers/char/tpm/tpm-chip.c   | 48 +++++++-----------------------
>   drivers/char/tpm/tpm.h        |  1 +
>   drivers/char/tpm/tpm2-space.c | 55 +++++++++++++++++++++++++++++++++++
>   3 files changed, 66 insertions(+), 38 deletions(-)
>
>
> base-commit: 719fce7539cd3e186598e2aed36325fe892150cf
