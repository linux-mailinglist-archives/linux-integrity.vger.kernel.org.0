Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE034269E
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Mar 2021 21:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSUE6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Mar 2021 16:04:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhCSUE0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Mar 2021 16:04:26 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JK2m6r039592;
        Fri, 19 Mar 2021 16:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VQUD4EeWcha/VtA8fn0+ri1PGYKy2heQhdvdPogGXPs=;
 b=DuHzJ42nzB+NwvpciVqEMdx5apDB7EY82K0TUxJ+VuDOKAdVFnxPkeCQj2XlhgUAKcWp
 DN8BUQB2PKbKWL3Wy0NPqtVtca/K+g2ZE35g8TvMtrWvkImUiFjuG2P3zl1x2N+N78K1
 mkHbW7M+iA78Z3FnNuvzvu3MdEWYcaNR+utjsaED6ZKJgYH1gzOWPaJu2Fewrb2H8uDp
 2C1Tb/GOxDfyEzIHdikqw+OrZ8CnSPt4XDmXehk/P9Dh5EfBXB7yM1Gq2N7/FjbgCXOx
 7hQOtmBFrQWrDbrd83NukKTuNQ4bpqgh3DnnKKXo/n1d1kvJI2m5tYIN5GDdI5WyTiB0 qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37cw5asmnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 16:04:16 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12JK3FUQ041020;
        Fri, 19 Mar 2021 16:04:16 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37cw5asmn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 16:04:15 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12JJxIYB016949;
        Fri, 19 Mar 2021 20:04:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 378n18b6gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 20:04:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12JK3rqo22938016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 20:03:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 110D552052;
        Fri, 19 Mar 2021 20:04:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.211.66.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id ACDE852050;
        Fri, 19 Mar 2021 20:04:08 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-integrity@vger.kernel.org, Test <test@localhost.localdomain>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 2/2] integrity: double check iint_cache was initialized
Date:   Fri, 19 Mar 2021 16:03:58 -0400
Message-Id: <20210319200358.22816-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319200358.22816-1-zohar@linux.ibm.com>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=907
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103190135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Test <test@localhost.localdomain>

The integrity's "iint_cache" is initialized at security_init().  Only
after an IMA policy is loaded, which is initialized at late_initcall,
is a file's integrity status stored in the "iint_cache".

All integrity_inode_get() callers first verify that the IMA policy has
been loaded, before calling it.  Yet for some reason, it is still being
called, causing a NULL pointer dereference.

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

Before calling kmem_cache_alloc(), check that the iint_cache has
been initialized.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/iint.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 1d20003243c3..80b5ae7bb712 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -97,6 +97,15 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	struct rb_node **p;
 	struct rb_node *node, *parent = NULL;
 	struct integrity_iint_cache *iint, *test_iint;
+	static int once = 0;
+
+	if (!iint_cache) { /* shouldn't get here */
+		if (!once) {
+			dump_stack();
+			once = 1;
+		}
+		return NULL;
+	}
 
 	iint = integrity_iint_find(inode);
 	if (iint)
-- 
2.27.0

