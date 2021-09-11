Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC6F407617
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Sep 2021 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhIKKi2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Sep 2021 06:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIKKi1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Sep 2021 06:38:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130C0C061574;
        Sat, 11 Sep 2021 03:37:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h16so9595976lfk.10;
        Sat, 11 Sep 2021 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zYH/PMRuODI2BTz4xaOUGZa1cagj47MpPzQ9hxDQv5U=;
        b=fVgWrEcvTendfUOiqPPY303Llvrpc6t7y0/vi2GrZPObvaI7qM1jzFfZDs5VhIkIg/
         8qZ6aMOQD76UYEhMnEfVnANl6YPLvZlqC9EMMzGfUm7FMuGX7at2m6ILzzMcdNuVM1zT
         RCD6vAaJ9+Ki4x1H+jWzSfeaFb9AbTmNHuAmC8KnPMpTtw2nEbu9Xy6f6Ro/O1Paam7I
         pDA0UF4gnnw3svwrQE/FuBNwF8qwQOuL4E92wk8u2nxfPRfbytqBSgGzZnB0Pas50+6z
         gtUtM6/faxmwGPe7Mv4Caux1YyCN5IoB1ZmO3rDLHMoBCgyQm+FgewlQ8F3qqk/ef3W1
         gpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zYH/PMRuODI2BTz4xaOUGZa1cagj47MpPzQ9hxDQv5U=;
        b=oawaNM+NoKIw+kuQXgy/2e6PLyAdJgQLSs/AkHPY4xar49x8D6RsnnVtxQ7AKW1NAW
         l19ImsJqc/r3UzLRR+L80ydTwoxHtxxcAunk/w5xdm2EDULaQSOtnyb0VgDidF4IC5bU
         wI8RFKjoHF9MXz5wZYxwNaIkXFw7lONpctQA/iZ40LZ775bsRhgIbB8uVTJYb0Nwpitx
         cOrCF63/UrqJSW0n9jT2SlO7dB0fmwphHRX/E01tKjDm9+NmLMd4VP1Q9c71lZHm46rp
         Hl5rOTx5+DI4Dq/oG5upAKVzAdsc769dJlFvWOBLDJgxBrNvc71e4D/yAb6Ghncuq3xe
         lsEQ==
X-Gm-Message-State: AOAM530Yp0z5sk1fp5kvwUkGR6ZsfMOT1AG6T+M76mxVQVZfJf8zNN/M
        dWpWLULJiC3ayHUnx8F6i3FohWBQEmGTiQ==
X-Google-Smtp-Source: ABdhPJzJkb3GBKYArpyzPh1vyExzN4QgXwAT+lYMdfUeMKgOmI0mmPZR6SAeMkaD9pAAtnniE0Q0/w==
X-Received: by 2002:ac2:5456:: with SMTP id d22mr1601265lfn.139.1631356632929;
        Sat, 11 Sep 2021 03:37:12 -0700 (PDT)
Received: from [192.168.0.150] (0855025014.static.corbina.ru. [89.179.245.198])
        by smtp.gmail.com with ESMTPSA id r3sm162666lfc.169.2021.09.11.03.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 03:37:12 -0700 (PDT)
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        J Freyensee <why2jjj.linux@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Igor Zhbanov <izh1979@gmail.com>
Subject: [PATCH v6 0/1] NAX (No Anonymous Execution) LSM
Message-ID: <cb5276ea-d345-54ae-4ba4-646403789388@gmail.com>
Date:   Sat, 11 Sep 2021 13:37:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
for the processes. The LSM intercepts mmap() and mprotect() system calls
and handles it similarly to SELinux handlers.

The module allows to block the violating system call or to kill the
violating process, depending on the settings, along with rate-limited
logging.

Currently, the module restricts ether all processes or only the
privileged processes, depending on the settings. The privileged process
is a process for which any of the following is true:
+ uid   == 0 && !issecure(SECURE_NOROOT)
+ euid  == 0 && !issecure(SECURE_NOROOT)
+ suid  == 0 && !issecure(SECURE_NOROOT)
+ cap_effective has any capability except of kernel.nax.allowed_caps
+ cap_permitted has any capability except of kernel.nax.allowed_caps

Checking of uid/euid/suid is important because a process may call
seteuid(0) to gain privileges (if SECURE_NO_SETUID_FIXUP secure bit
is not set).

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
  basis and protect them with EVM.
- Store NAX attributes in the per-task LSM blob to implement special
  launchers for the privileged processes, so all of the children processes
  of such a launcher would be allowed to have anonymous executable pages
  (but not to grandchildren).
- Add /proc/self/mem writing ptrace protection.

[Links]

[1] https://blog.fbkcs.ru/elf-in-memory-execution/
[2] https://magisterquis.github.io/2018/03/31/in-memory-only-elf-execution.html
[3] https://www.prodefence.org/fireelf-fileless-linux-malware-framework/

[Credits]

Thanks to Mimi Zohar for consulting and to Simon Thoby and Randy Dunlap for
thorough review.

[Changelog]

V6
- Allow to set command-line options in arbitrary order.
- Replace strlen() with strnlen() in command-line parameter parsing.

V5
- Move max_mode out of #ifdef scope to fix build.

V4
- Fix indentation issues and typos in Kconfig.

V3
- Fix memory leak in allowed_caps assigning code.
- Protect allowed_caps updating with a spinlock.
- Fix Kconfig options description.
- Add example for allowed_caps value.
- Fix typo in documentation.

V2
- Fixed typo in Kconfig.
- Fixed "cap_effective" and "cap_permitted" parameters description in NAX.rst.
- Added "nax_allowed_caps" setup parameter. Factored out capabilities parsing
  logic.
- Added parameter for checking all processes (not only privileged).
- Added Kconfig parameter for setting allowed capabilities.
- Updated nax_file_mprotect() to avoid calling of nax_mmap_file() to avoid
  duplicated checks.
- Protect allowed_caps with RCU.
- Fixed all errors and most warning found by checkpatch.pl.
- Updated the module documentation. Added description of the boot parameters to
  kernel-parameters.
- Updated commit message.

V1:
- Initial implementation.

Igor Zhbanov (1):
  NAX LSM: Add initial support

 Documentation/admin-guide/LSM/NAX.rst         |  69 +++
 Documentation/admin-guide/LSM/index.rst       |   1 +
 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |  32 ++
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/nax/Kconfig                          | 113 +++++
 security/nax/Makefile                         |   4 +
 security/nax/nax-lsm.c                        | 469 ++++++++++++++++++
 9 files changed, 696 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/NAX.rst
 create mode 100644 security/nax/Kconfig
 create mode 100644 security/nax/Makefile
 create mode 100644 security/nax/nax-lsm.c


base-commit: a3fa7a101dcff93791d1b1bdb3affcad1410c8c1
-- 
2.26.2

