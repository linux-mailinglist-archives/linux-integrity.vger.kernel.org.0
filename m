Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905BE38FD9C
	for <lists+linux-integrity@lfdr.de>; Tue, 25 May 2021 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhEYJVM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 May 2021 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhEYJVL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 May 2021 05:21:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA78C061574;
        Tue, 25 May 2021 02:19:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 27so20945586pgy.3;
        Tue, 25 May 2021 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jqgS5hOOCnrxfxw3txYWGbPk+A9RnEI7ms619U7Wij0=;
        b=jVoleAI93hCi7j69YiQhtqOpswmx2gRSpBdXQxoPQowE3LY/6n7+YVPmkjkDrKkY4H
         dHzKlTN2jx+kGoPTJiRzOm7IZbJtkN15dqiUZEEtgPWTzC9+05de4QhflqsZitbwbtQv
         hWxCe0QzeZvpjoXuojNngJ+ejql4KOIgohmcXt3Rwj44VMliduQuflFu7lQPlIZgckba
         psEacD7bT+TeQi+ctVI5YYKZSvqRJhO+jGc54xA1rKNNf95Qi/+70Oj65TaVmEoFjsES
         yuMsK8ri+OR6HDUUZFsZ6hLolnbIKEd+UjAskH4A/tmslk/8l5hbHF5Kda/RTYBjobah
         b/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jqgS5hOOCnrxfxw3txYWGbPk+A9RnEI7ms619U7Wij0=;
        b=Gy8NzzUD42TxRZtmj0Dt/VQZGC0D/SDbepHj1p6e9LHZGqiS4hS+r3Cd9JypdyYteP
         9A/uDmBMjuxWB60mcYXxCrd/5xrVoQHXcffvIDJmSIohbcQ7uxox7AnuXdNCo1h6w3Ot
         KQ5JhYVqe66hTGzIbwGs8xmP65RjkwLkIol7wETM4KYC3YQrRscLBQ6hth8m+/9mgkS4
         YE12DmcOlDVNYDqp4hjCbqgO9Hmha3a2VF70GuMlcxAGsuXQvsIVyY8/4MfpOMOYFEjP
         B0rdpmTgt+eITNrJ9LDoLqLAqQlWe3IgmLbv5nl7ylA2HeuFXHXpdn+xuG8u7G/8a27n
         guKA==
X-Gm-Message-State: AOAM531XH9Jxkqr9WSZ3SvPg3/welWIauAfjXAHdaMzDRap0AL0jdbeO
        rpJZx4IXV4FIoiy/7m/wSjFlb8QVtnbimRfg86k40LK6/0g=
X-Google-Smtp-Source: ABdhPJxarqaelTslui5sKiyGR3I3pCxPz/ELOR3Um3XyzH/wKqfcvDWv8s18Iu+FPTyJbXZeFMQnT0p5vzVNP9gqkk8=
X-Received: by 2002:a65:564c:: with SMTP id m12mr18657193pgs.298.1621934380529;
 Tue, 25 May 2021 02:19:40 -0700 (PDT)
MIME-Version: 1.0
From:   Bighead Wang <ex200208049@gmail.com>
Date:   Tue, 25 May 2021 17:19:29 +0800
Message-ID: <CADG95vuR1=dvgsf6bvNCRNsvDEJ=YwFgfvqJWRkNvD=rrYUaYA@mail.gmail.com>
Subject: EVM gives no_label error due to security_kernfs_init_security
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In cgroup filesystem, security_kernfs_init_security() will initialize
the security data for newly created kernfs node after kernel 5.2.,
however, new EVM xattr value is not initialized, and the no_label
error appears when evm_verify_hmac() is triggered.


The detailed description:
When system boots up with IMA/EVM and SELinux enabled, we get:
" May 25 14:13:01 raspberrypi audit[1212]: INTEGRITY_METADATA pid=1212
uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t
op=appraise_metadata cause=no_label comm="(systemd)"
name="cgroup.procs" dev="cgroup2" ino=1360 res=0 errno=0 "

The root cause is that our customized SELinux file_contexts file does
not contain the line "/sys/fs/cgroup/.*     <<none>>".
When systemd relabels directories under /sys/fs/cgroup/ during
booting, it will set SELinux label inside the iattr member of kernfs
node, and then security_kernfs_init_security() will initialize the
security data at the time new kernfs node created.
After systemd executes something to trigger evm_verify_hmac(), we get
this no_label error.

In evm_verify_hmac(), if there is no EVM xattr value, it will check
any other xattr values protected by EVM exist or not.
In this situation, there is no EVM xattr value (got from the iattr
member of kernfs node in cgroup filesystem), but SELinux label (also
got from the iattr member of kernfs node instead of from inode)
exists.
To sum up, the error seems to me is EVM mechanism doesn't initialize
EVM xattr value in kernfs node.

The environment:
/proc/version: Linux version 5.13.0-rc3-v7l+ (bighead@52-0453463-02)
(arm-linux-gnueabi-gcc (GCC) 9.1.0, GNU ld (GNU Binutils) 2.32) #1 SMP
Tue May 25 12:33:01 CST 2021
/proc/sys/kernel/tainted: 0
Operating System: Raspbian GNU/Linux 10 (buster)
Architecture: armv7l
systemd version: systemd 241 (241) +PAM +AUDIT +SELINUX +IMA +APPARMOR
+SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4
+SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2
default-hierarchy=hybrid
IMA/EVM kernel parameter: ima_policy=appraise_tcb ima_appraise=fix
SELinux kernel parameter: security=selinux selinux=1 (permissive mode)

How to reproduce the error in Raspbian:
1. Prepare an environment which SELinux and IMA/EVM are enabled and
boot up with kernel parameters: security=selinux selinux=1
ima_policy=appraise_tcb ima_appraise=fix evm=fix
2. Remove the line "/sys/fs/cgroup/.*     <<none>>" in file_contexts
file, and fully relabel all system with SELinux official reference
policy
3. Walk through all regular files and generate ima/evm hash:
/usr/bin/find / -type f -uid 0 -exec sh -c "< '{}'" \;
4. Reboot with kernel parameters: security=selinux selinux=1
ima_policy=appraise_tcb ima_appraise=fix
5. After boot up, you will get this EVM no_label error message

Reproduce the error directly:
1. Prepare an environment which SELinux and IMA/EVM are enabled and
boot up with kernel parameters: security=selinux selinux=1
ima_policy=appraise_tcb ima_appraise=fix evm=fix
2. Fully relabel all system with SELinux official reference policy
3. Walk through all regular files and generate ima/evm hash:
/usr/bin/find / -type f -uid 0 -exec sh -c "< '{}'" \;
4. Reboot with kernel parameters: security=selinux selinux=1
ima_policy=appraise_tcb ima_appraise=fix
5. sudo setfattr -n security.selinux -v system_u:object_r:cgroup_t
/sys/fs/cgroup/unified
6. sudo mkdir /sys/fs/cgroup/unified/testevm
7. sudo chmod +x /sys/fs/cgroup/unified/testevm/cgroup.procs: you will
get this EVM error message

Reference:
Kernel config: https://140.96.154.7:5001/sharing/9cPNowmhK
Journal log: https://140.96.154.7:5001/sharing/sRISz6IPt
Patch for security_kernfs_init_security() :
https://lore.kernel.org/selinux/20190130114150.27807-1-omosnace@redhat.com/

-- 
Best Regards,
Hank Wang
