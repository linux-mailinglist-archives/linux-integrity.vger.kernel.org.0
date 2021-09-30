Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28341DCC1
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351915AbhI3O4k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 10:56:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3903 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbhI3O4k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 10:56:40 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKx5r2TZtz67j7Z
        for <linux-integrity@vger.kernel.org>; Thu, 30 Sep 2021 22:51:44 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:54:55 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.008;
 Thu, 30 Sep 2021 16:54:55 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: DIGLIM demo
Thread-Topic: DIGLIM demo
Thread-Index: Ade2CqzI+X/Y8CsWSXG0J+ba4sw+oQ==
Date:   Thu, 30 Sep 2021 14:54:55 +0000
Message-ID: <48cd737c504d45208377daa27d625531@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.214.88]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi everyone

recently I published some patch sets about a new kernel
component called Digest Lists Integrity Module (DIGLIM),
which has the ability to store reference values of files
from Linux distributions (currently only RPM-based ones
are supported), and to use them for measurement and
appraisal with IMA.

I prepared a demo, to show how easy is to change an
existing distribution (I tested Fedora 34 and openSUSE
Leap 15.3) to check the integrity of executables and
shared libraries.

The basic changes are (I suggest to test them in a VM):
- install a new kernel which includes the patches I sent to
   the kernel mailing lists plus some not yet published (mainly
   for supporting PGP appended signatures)
- write RPM headers and PGP appended signatures to files
- regenerate initial ram disk to include the RPM headers
- reconfigure the boot loader to add IMA-specific options

I would discourage to test in on a real system, as IMA would
prevent execution of anything that has not been shipped
with the Linux distribution.

Instructions:

1) Add my repository with the modified kernel and
     DIGLIM-specific package:

(Fedora) # dnf copr enable robertosassu/DIGLIM
(openSUSE) # zypper addrepo https://download.opensuse.org/repositories/home:/roberto.sassu:/branches:/Kernel:/stable/15.3/home:roberto.sassu:branches:Kernel:stable.repo

2) Install required packages:

(Fedora) # dnf install kernel-5.14.8-300.local.fc34.x86_64 kernel-diglim-5.14.8-300.local.fc34.x86_64
(openSUSE) # zypper in kernel-default kernel-default-diglim

3) Write RPM headers and PGP appended signatures to
     the /etc/digest_lists directory:

# /usr/libexec/diglim/rpm_gen -d /etc/digest_lists

4) Tell DIGLIM to upload to the kernel only the digests
     of immutable files:

# touch /etc/digest_lists/.immutable

5) Modify dracut configuration to include DIGLIM-related files:

# echo "install_optional_items+=\" /etc/digest_lists/* /etc/digest_lists/.immutable \"" >> /etc/dracut.conf
# echo "install_optional_items+=\" /usr/libexec/diglim/upload_digest_lists \"" >> /etc/dracut.conf
# echo "install_optional_items+=\" /usr/libexec/diglim/rpm_parser \"" >> /etc/dracut.conf
# echo "do_strip=\"no\"" >> /etc/dracut.conf

6) Regenerate the initial ram disk:

(Fedora) # dracut -f --kver 5.14.8-300.local.fc34.x86_64
(openSUSE) # dracut -f --kver 5.14.8-lp153.11.g4ae263c-default

7) Add IMA-specific options to the kernel command line
     (WARNING: it turns on IMA appraisal in enforcing mode,
      other kernels may become unbootable)

(Fedora) # echo "GRUB_CMDLINE_LINUX_DEFAULT=\"\$GRUB_CMDLINE_LINUX_DEFAULT slab_nomerge ima_template=ima-modsig ima_policy=\\\\\\\"exec_tcb|tmpfs|diglim|appraise_exec_tcb|appraise_tmpfs|appraise_diglim|secure_boot\\\\\\\" module.sig_enforce\"" >> /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
(openSUSE)  # echo "GRUB_CMDLINE_LINUX_DEFAULT=\"\$GRUB_CMDLINE_LINUX_DEFAULT slab_nomerge ima_template=ima-modsig ima_policy=\\\"exec_tcb|tmpfs|diglim|appraise_exec_tcb|appraise_tmpfs|appraise_diglim|secure_boot\\\" module.sig_enforce\"" >> /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

8) Update the boot loader configuration:

# grub2-mkconfig -o /boot/grub2/grub.cfg

9) Reboot

After reboot, IMA will deny execution of files not from
the distribution. For example, it is possible to execute:

# cp /usr/bin/cat .
# ./cat
# echo test >> cat
# ./cat
bash: ./cat: Permission denied


With the following command, it is possible to see which
RPM headers have been measured by IMA:

# cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements


The execution policy enforced by IMA can be seen with:

# cat /sys/kernel/security/integrity/ima/policy


DIGLIM statistics can be obtained with:

# cat /sys/kernel/security/integrity/diglim/digests_count
Parser digests: 1
File digests: 11365
Metadata digests: 0
Digest list digests: 508


Memory usage by DIGLIM (indexes) can be seen with:

# slabtop --once |grep digest
 13056  13056 100%    0.03K    102      128       408K digest_list_item_ref_cache
 12032  12032 100%    0.03K     94      128       376K digest_item_cache
   546    546 100%    0.09K     13       42        52K digest_list_item_cache


Uploaded digest lists (binary and ASCII format) can be seen
in the /sys/kernel/security/integrity/diglim/digest_lists_loaded.

Finally, all the applied patches are available at:

https://github.com/robertosassu/linux/tree/digest-lists-full-ima-pgp-v1-devel-v3


The sources used to create the RPMs are available at:

https://src.fedoraproject.org/fork/robertosassu/rpms/kernel/tree/diglim
https://build.opensuse.org/package/show/home:roberto.sassu:branches:Kernel:stable/kernel-source

Any suggestion or feedback is very appreciated. If you have
troubles trying the demo, let me know.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua

