Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40AF3F22D2
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 00:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhHSWNM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 18:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhHSWNM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 18:13:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00535C061575;
        Thu, 19 Aug 2021 15:12:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u22so15997038lfq.13;
        Thu, 19 Aug 2021 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0yCjIJExgQQYVjbdaN5b3gOfsGCqzkpLljx8eQh1o1Q=;
        b=GMsBd3h7f6Z9cS8nn1r9s7ORbPrCo46fFuRHkOLi7SnwfhbG60XloTvOcI97685r6l
         tEXCB7eupOEwftbsSEQjizi741djKtV9iNceTb+W2rS9XBNObkdYtSVz5LCKatQ6uh/E
         9jAzeyLyofWqP2MOagMX9Rgf7AEsFnM90ewypEZ/fWzBNRsVFcQKpwbd/wV9Rwa6xHjQ
         bv/LU9bo+JtCVmRFgEmxG0Plt1fgawBn56lY1vmc9M9fUtTBOxG9imQkVSdpwc4CVVSb
         loEto9BY/qJCv6TLCsItVqrSsebW5JOTNyoo037l1aVa97nMYbB6hMPU/ONuK+qkBTc9
         RW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0yCjIJExgQQYVjbdaN5b3gOfsGCqzkpLljx8eQh1o1Q=;
        b=cfjEPEySX16kLWBtBu2o7H2vGtEUAvpZ4tc5Rfo0OVsWpBPjpYtblsOPyVccXxYfKZ
         WVkMzsux1BYL6NebgMtJIG9q0YPeuqWfyAyWFYZA2rkIvDCEnmYxQAqfLFPGOGJ2Yv4Z
         bUU7zhqFT8gdDjn/T3pdd2OqAvoSxrSN4ghnVqx83SlDKWizDEsAnJdt4UCYT5BOlD0x
         gjFjrt+X5yHKF8uLYAJy4hXnVHrVstxmW1V7fNPzGUb+jSse7jsa5f6uTMqDMMPmeWRF
         aPe2WVwSxeIt+ZShh/euS8mJIS2sX9nGuygwgXrBaix3fGJgLw+1U5YxB5+wmtXqnPji
         ntCQ==
X-Gm-Message-State: AOAM5306KvS7oCw1mNvgy88aYAu3ku2w7jsdI7D5z9xrKSPC5fHye+pz
        s5y9b/g27RVn09nZog4jaHzr4wEb5vALdg==
X-Google-Smtp-Source: ABdhPJxH5DFEDI1sc/2CWkqUrVIu874nMF1nkxVFFHn9sRxM3MfRcKAW98/vZbYbe0NUPseE2+9goQ==
X-Received: by 2002:ac2:46e1:: with SMTP id q1mr12566075lfo.250.1629411153257;
        Thu, 19 Aug 2021 15:12:33 -0700 (PDT)
Received: from [192.168.8.182] ([109.197.205.90])
        by smtp.gmail.com with ESMTPSA id j2sm381362ljc.49.2021.08.19.15.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 15:12:32 -0700 (PDT)
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        linux-kernel@vger.kernel.org
From:   Igor Zhbanov <izh1979@gmail.com>
Subject: [PATCH v3 0/1] NAX (No Anonymous Execution) LSM
Message-ID: <adc0e031-f02d-775c-1148-e808013c1b97@gmail.com>
Date:   Fri, 20 Aug 2021 01:12:37 +0300
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
  basis.
- Store NAX attributes in the per-task LSM blob to implement special
  launchers for the privileged processes, so all of the children processes
  of such a launcher would be allowed to have anonymous executable pages
  (but not to grandchildren).

[Links]

[1] https://blog.fbkcs.ru/elf-in-memory-execution/
[2] https://magisterquis.github.io/2018/03/31/in-memory-only-elf-execution.html
[3] https://www.prodefence.org/fireelf-fileless-linux-malware-framework/

[Credits]

Thanks to Mimi Zohar for consulting and to Simon Thoby for thorough review.

[Changelog]

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

 Documentation/admin-guide/LSM/NAX.rst         |  72 +++
 Documentation/admin-guide/LSM/index.rst       |   1 +
 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |  32 ++
 security/Kconfig                              |  11 +-
 security/Makefile                             |   2 +
 security/nax/Kconfig                          | 114 +++++
 security/nax/Makefile                         |   4 +
 security/nax/nax-lsm.c                        | 472 ++++++++++++++++++
 9 files changed, 704 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/NAX.rst
 create mode 100644 security/nax/Kconfig
 create mode 100644 security/nax/Makefile
 create mode 100644 security/nax/nax-lsm.c

-- 
2.26.2

