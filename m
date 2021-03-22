Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824EC344976
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Mar 2021 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCVPnL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 11:43:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230340AbhCVPmq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 11:42:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MFXJkO087703;
        Mon, 22 Mar 2021 11:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Be/8jzfNAsAOvRtIz1Gjl8IbLBAyHccy2qh9qtGmq6Y=;
 b=HJtNAlJxQ4hPgwpJYlupyaszhvX8L1z0opXunLxgeRxaEETsVBgQ5bVrrghmb0JxTFWv
 L3xr5tMhADnTsUo55SbBzlT+vN4NV0NMhHq6uPj9bFW8fdpVlw4KJwyVdA8GJf620jwj
 +73Vmly/kDMHlJJbBVDC5DnsyIUde8JX1O5Z+Ndt8IN8+KO+gcO/p8DR0bO+C9tVQxyb
 XHmEXV6ta2PujUVNye2tqwrYcZvY3cMDNqKp/N3ikPf0IfbMxt7RW2tf8LFvW9BdMZJT
 wEKRA3dNKtyfJJCSsqpZL2X63SzAoDzezfyo1jg3AhNRkug61jZnWzIV5NxNvlOzvkBz NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37eb1pha7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 11:42:36 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12MFXqiO089234;
        Mon, 22 Mar 2021 11:42:35 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37eb1pha6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 11:42:35 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12MFdDU0015798;
        Mon, 22 Mar 2021 15:42:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 37d9bps9sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 15:42:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12MFgV4w11272578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 15:42:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3C1F4C046;
        Mon, 22 Mar 2021 15:42:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65B034C044;
        Mon, 22 Mar 2021 15:42:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.211.152.56])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Mar 2021 15:42:29 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] integrity: double check iint_cache was initialized
Date:   Mon, 22 Mar 2021 11:42:07 -0400
Message-Id: <20210322154207.6802-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210322154207.6802-1-zohar@linux.ibm.com>
References: <20210322154207.6802-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_07:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=834 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel may be built with multiple LSMs, but only a subset may be
enabled on the boot command line by specifying "lsm=".  Not including
"integrity" on the ordered LSM list may result in a NULL deref.

As reported by Dmitry Vyukov:
in qemu:
qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
 -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
   -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
nic,model=virtio-net-pci   -object
memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
  -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
vm_pid -m 2G -cpu host

But it crashes on NULL deref in integrity_inode_get during boot:

Run /sbin/init as init process
BUG: kernel NULL pointer dereference, address: 000000000000001c
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2+ #97
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
RIP: 0010:kmem_cache_alloc+0x2b/0x370 mm/slub.c:2920
Code: 57 41 56 41 55 41 54 41 89 f4 55 48 89 fd 53 48 83 ec 10 44 8b
3d d9 1f 90 0b 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 <8b> 5f
1c 4cf
RSP: 0000:ffffc9000032f9d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888017fc4f00 RCX: 0000000000000000
RDX: ffff888040220000 RSI: 0000000000000c40 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888019263627
R10: ffffffff83937cd1 R11: 0000000000000000 R12: 0000000000000c40
R13: ffff888019263538 R14: 0000000000000000 R15: 0000000000ffffff
FS:  0000000000000000(0000) GS:ffff88802d180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000001c CR3: 000000000b48e000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 integrity_inode_get+0x47/0x260 security/integrity/iint.c:105
 process_measurement+0x33d/0x17e0 security/integrity/ima/ima_main.c:237
 ima_bprm_check+0xde/0x210 security/integrity/ima/ima_main.c:474
 security_bprm_check+0x7d/0xa0 security/security.c:845
 search_binary_handler fs/exec.c:1708 [inline]
 exec_binprm fs/exec.c:1761 [inline]
 bprm_execve fs/exec.c:1830 [inline]
 bprm_execve+0x764/0x19a0 fs/exec.c:1792
 kernel_execve+0x370/0x460 fs/exec.c:1973
 try_to_run_init_process+0x14/0x4e init/main.c:1366
 kernel_init+0x11d/0x1b8 init/main.c:1477
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
CR2: 000000000000001c
---[ end trace 22d601a500de7d79 ]---

Since LSMs and IMA may be configured at build time, but not enabled at
run time, panic the system if "integrity" was not initialized before use.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/iint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 1d20003243c3..0ba01847e836 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -98,6 +98,14 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	struct rb_node *node, *parent = NULL;
 	struct integrity_iint_cache *iint, *test_iint;
 
+	/*
+	 * The integrity's "iint_cache" is initialized at security_init(),
+	 * unless it is not included in the ordered list of LSMs enabled
+	 * on the boot command line.
+	 */
+	if (!iint_cache)
+		panic("%s: lsm=integrity required.\n", __func__);
+
 	iint = integrity_iint_find(inode);
 	if (iint)
 		return iint;
-- 
2.27.0

