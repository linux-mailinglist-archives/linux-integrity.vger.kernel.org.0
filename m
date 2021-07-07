Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634483BE07E
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 03:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhGGBNO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 21:13:14 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:37018 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGBNN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 21:13:13 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 21:13:13 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 83D782099DE9
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
CC:     Igor Zhbanov <izh1979@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>
From:   Igor Zhbanov <i.zhbanov@omp.ru>
Subject: [PATCH 0/1] NAX (No Anonymous Execution) LSM
Message-ID: <de5aed7d-e7bf-d9a7-1b30-c73939204ecb@omp.ru>
Date:   Wed, 7 Jul 2021 04:03:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1909.lancloud.ru (fd00:f066::79)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Overview]

Fileless malware attacks are becoming more and more popular, and even
ready-to-use frameworks are available [1], [2], [3]. They are based on
running of the malware code from anonymous executable memory pages (which
are not backed by an executable file or a library on a filesystem.) This
allows effectively hiding malware presence in a system, making filesystem
integrity checking tools unable to detect the intrusion.

Typically, the malware first needs to intercept the execution flow (e.g.,
by the means of ROP-based exploit). Then it needs to download the main
part (in the form of normal executable or library) from its server,
because it is hard to implement the entire exploit in ROP-based form.
There are a number of security mechanisms that can ensure the integrity
of the file-system, but we need to ensure the integrity of the code in
memory too, to be sure, that only authorized code is running in the
system.

The proposed LSM is preventing the creation of anonymous executable pages
for the privileged processes. The LSM intercepts mmap() and mprotect()
system calls and handles it similarly to SELinux handlers.

The module allows to block the violating system call or to kill the
violating process, along with rate-limited logging.

Currently, the module restricts only the privileged processes. The
privileged process is a process for which any of the following is true:
+ uid   == 0 && !issecure(SECURE_NOROOT)
+ euid  == 0 && !issecure(SECURE_NOROOT)
+ suid  == 0 && !issecure(SECURE_NOROOT)
+ fsuid == 0 && !issecure(SECURE_NOROOT)
+ cap_effective has any capability except of kernel.nax.allowed_caps
+ cap_permitted has any capability except of kernel.nax.allowed_caps

The sysctl parameter kernel.nax.allowed_caps allows to define safe
capabilities set for the privileged processes.

[JIT]

Because of blocked anonymous code execution, JIT-compiled code, some
interpreters (which are using JIT) and libffi-based projects can be
broken.

Our observation shows that such processes are typically running by a
user, so they will not be privileged, so they will be allowed to use
anonymous executable pages.

But for small embedded set-ups it could be possible to get rid of such
processes at all, so the module could be enabled without further
restrictions to protect both privileged and non-privileged processes.

In addition, libffi can be modified not to use anonymous executable
pages.

[Similar implementations]

Although SELinux could be used to enable similar functionality, this LSM
is simpler. It could be used in set-ups, where SELinux would be overkill.

There is also SARA LSM module, which solves similar task, but it is more
complex.

[Cooperation with other security mechanisms]

NAX LSM is more useful in conjunction with IMA. IMA would be responsible
for integrity checking of file-based executables and libraries, and
NAX LSM would be responsible for preventing of anonymous code execution.

Alternatively, NAX LSM can be used with read-only root file system,
protected by dm-verity/fs-verity.

[TODO]
- Implement xattrs support for marking privileged binaries on a per-file
  basis.
- Store NAX attributes in the per-task LSM blob to implement special
  launchers for the privileged processes, so all of the children processes
  of such a launcher would be allowed to have anonymous executable pages
  (but not to grandchildren).

[Links]

[1] https://blog.fbkcs.ru/elf-in-memory-execution/
[2] https://magisterquis.github.io/2018/03/31/in-memory-only-elf-execution.html
[3] https://www.prodefence.org/fireelf-fileless-linux-malware-framework/

P.S. I may continue to work on this LSM from my personal e-mail
izh1979@gmail.com.

Igor Zhbanov (1):
  NAX LSM: Add initial support support

 Documentation/admin-guide/LSM/NAX.rst   |  48 ++++
 Documentation/admin-guide/LSM/index.rst |   1 +
 security/Kconfig                        |  11 +-
 security/Makefile                       |   2 +
 security/nax/Kconfig                    |  71 +++++
 security/nax/Makefile                   |   4 +
 security/nax/nax-lsm.c                  | 344 ++++++++++++++++++++++++
 7 files changed, 476 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/NAX.rst
 create mode 100644 security/nax/Kconfig
 create mode 100644 security/nax/Makefile
 create mode 100644 security/nax/nax-lsm.c

-- 
2.26.2

