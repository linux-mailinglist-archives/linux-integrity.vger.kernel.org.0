Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6C3EDD47
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhHPSoS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHPSoR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 14:44:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF20C061764
        for <linux-integrity@vger.kernel.org>; Mon, 16 Aug 2021 11:43:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w20so36387840lfu.7
        for <linux-integrity@vger.kernel.org>; Mon, 16 Aug 2021 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kprmKN2sKmmO250kgD/fgDyku/xZVhzn3WWDG6DQ+Rc=;
        b=d1+M9qdtbIoLHoVvmyU51KHyWACR7XX4wEIz3SvQ0uqlWuj8sDqKmzgKSF7VGy5z5T
         /jZgWnkLuwbGOSPxsIObJasxN/GRDqEMkim8sX61vBcvVsNsJMSAYlMMxZ5Y77EMpC+q
         lyxPchEgIcaIhTW4Kzn/Y72jUCK9kFaSd3TJ3epdysXEnMJReFGGG08jUY+At92zVs3N
         gIH9AJfyXWiPbXjol6ULDEYjFZj5MB8F1HqYK84PCTt18Mg2oKpYicrT6WpDn0fwB7VM
         5ZACWosRHtbS2WXY7IjYELfaVXpd2AGtvLhdOCPDQJVbdoQRFx7B/PQmHx9XlCzf2X0o
         aQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kprmKN2sKmmO250kgD/fgDyku/xZVhzn3WWDG6DQ+Rc=;
        b=Ih46W8jRdpOKO8JGcOPX4tMuIEhZn3co80XbSuptZqZ5nKMI33VewvP+eQcrd1LJrq
         +w3xI85PK8L6Mt7ZI0Z1clTACdeAz9Gk8O0yUuWXWJqSxx/a5Cp5qlNV/NrqI2HCy3dC
         mKQqWZSr+hLNAjG4W0ziQFtJUI+Ps6sPQlT5uagS6viMUZXJtL8JNV46QsV68lZyLqu7
         ZiqjOsnBeuQ1FKV8lw6jfE6uabbwv1CiYC/JVcoSMlei44PlUbIoM80x6K+2WyjV5+NX
         bJKC99S3CkAxoDXQLLNtqihSzbUt13JhCzTOTnb9kkR7QpDVgf/Lg1ddub/C7JccI6W9
         /fpw==
X-Gm-Message-State: AOAM53179M6gqjs26u8/qvKVFPA0V9sr90HsP4ZMtUzBiAwy6OTf2Twa
        oM0/QCoWwDoIblAKFQqfDYYyv5LYuPA1hOIf
X-Google-Smtp-Source: ABdhPJwo0XpVPN/3OX19z7eknvaz0kgaEL4sKpLT5YYmspWtHD/5YfRP0QOzI5eT1Z9F0MmdeV1b8w==
X-Received: by 2002:a19:f713:: with SMTP id z19mr6491lfe.238.1629139424135;
        Mon, 16 Aug 2021 11:43:44 -0700 (PDT)
Received: from [192.168.0.150] (0855025014.static.corbina.ru. [89.179.245.198])
        by smtp.gmail.com with ESMTPSA id y35sm14356lje.127.2021.08.16.11.43.43
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:43:43 -0700 (PDT)
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
From:   Igor Zhbanov <izh1979@gmail.com>
Subject: [PATCH v2 0/1] NAX (No Anonymous Execution) LSM
Message-ID: <40531c62-de73-873a-53dd-8692d02b39df@gmail.com>
Date:   Mon, 16 Aug 2021 21:43:42 +0300
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

[Changelog]

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
  NAX LSM: Add initial support support

 Documentation/admin-guide/LSM/NAX.rst         |  65 +++
 Documentation/admin-guide/LSM/index.rst       |   1 +
 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |  23 +
 security/Kconfig                              |  11 +-
 security/Makefile                             |   2 +
 security/nax/Kconfig                          | 115 +++++
 security/nax/Makefile                         |   4 +
 security/nax/nax-lsm.c                        | 461 ++++++++++++++++++
 9 files changed, 678 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/NAX.rst
 create mode 100644 security/nax/Kconfig
 create mode 100644 security/nax/Makefile
 create mode 100644 security/nax/nax-lsm.c

--
2.26.2
