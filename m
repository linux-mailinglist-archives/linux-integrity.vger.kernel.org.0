Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B57241178
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Aug 2020 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHJUME (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Aug 2020 16:12:04 -0400
Received: from smtp-42aa.mail.infomaniak.ch ([84.16.66.170]:54831 "EHLO
        smtp-42aa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbgHJUMD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Aug 2020 16:12:03 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BQRvN075bzlhWhs;
        Mon, 10 Aug 2020 22:12:00 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4BQRvG2BJvzlh8TS;
        Mon, 10 Aug 2020 22:11:54 +0200 (CEST)
Subject: Re: [PATCH v7 0/7] Add support for O_MAYEXEC
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200723171227.446711-1-mic@digikod.net>
 <202007241205.751EBE7@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <0733fbed-cc73-027b-13c7-c368c2d67fb3@digikod.net>
Date:   Mon, 10 Aug 2020 22:11:53 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202007241205.751EBE7@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It seems that there is no more complains nor questions. Do you want me
to send another series to fix the order of the S-o-b in patch 7?


On 24/07/2020 21:06, Kees Cook wrote:
> I think this looks good now.
> 
> Andrew, since you're already carrying my exec clean-ups (repeated here
> in patch 1-3), can you pick the rest of this series too?
> 
> Thanks!
> 
> -Kees
> 
> On Thu, Jul 23, 2020 at 07:12:20PM +0200, Micka�l Sala�n wrote:
>> Hi,
>>
>> This seventh patch series do not set __FMODE_EXEC for the sake of
>> simplicity.  A notification feature could be added later if needed.  The
>> handling of all file types is now well defined and tested: by default,
>> when opening a path, access to a directory is denied (with EISDIR),
>> access to a regular file depends on the sysctl policy, and access to
>> other file types (i.e. fifo, device, socket) is denied if there is any
>> enforced policy.  There is new tests covering all these cases (cf.
>> test_file_types() ).
>>
>> As requested by Mimi Zohar, I completed the series with one of her
>> patches for IMA.  I also picked Kees Cook's patches to consolidate exec
>> permission checking into do_filp_open()'s flow.
>>
>>
>> # Goal of O_MAYEXEC
>>
>> The goal of this patch series is to enable to control script execution
>> with interpreters help.  A new O_MAYEXEC flag, usable through
>> openat2(2), is added to enable userspace script interpreters to delegate
>> to the kernel (and thus the system security policy) the permission to
>> interpret/execute scripts or other files containing what can be seen as
>> commands.
>>
>> A simple system-wide security policy can be enforced by the system
>> administrator through a sysctl configuration consistent with the mount
>> points or the file access rights.  The documentation patch explains the
>> prerequisites.
>>
>> Furthermore, the security policy can also be delegated to an LSM, either
>> a MAC system or an integrity system.  For instance, the new kernel
>> MAY_OPENEXEC flag closes a major IMA measurement/appraisal interpreter
>> integrity gap by bringing the ability to check the use of scripts [1].
>> Other uses are expected, such as for magic-links [2], SGX integration
>> [3], bpffs [4] or IPE [5].
>>
>>
>> # Prerequisite of its use
>>
>> Userspace needs to adapt to take advantage of this new feature.  For
>> example, the PEP 578 [6] (Runtime Audit Hooks) enables Python 3.8 to be
>> extended with policy enforcement points related to code interpretation,
>> which can be used to align with the PowerShell audit features.
>> Additional Python security improvements (e.g. a limited interpreter
>> withou -c, stdin piping of code) are on their way [7].
>>
>>
>> # Examples
>>
>> The initial idea comes from CLIP OS 4 and the original implementation
>> has been used for more than 12 years:
>> https://github.com/clipos-archive/clipos4_doc
>> Chrome OS has a similar approach:
>> https://chromium.googlesource.com/chromiumos/docs/+/master/security/noexec_shell_scripts.md
>>
>> Userland patches can be found here:
>> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
>> Actually, there is more than the O_MAYEXEC changes (which matches this search)
>> e.g., to prevent Python interactive execution. There are patches for
>> Bash, Wine, Java (Icedtea), Busybox's ash, Perl and Python. There are
>> also some related patches which do not directly rely on O_MAYEXEC but
>> which restrict the use of browser plugins and extensions, which may be
>> seen as scripts too:
>> https://github.com/clipos-archive/clipos4_portage-overlay/tree/master/www-client
>>
>> An introduction to O_MAYEXEC was given at the Linux Security Summit
>> Europe 2018 - Linux Kernel Security Contributions by ANSSI:
>> https://www.youtube.com/watch?v=chNjCRtPKQY&t=17m15s
>> The "write xor execute" principle was explained at Kernel Recipes 2018 -
>> CLIP OS: a defense-in-depth OS:
>> https://www.youtube.com/watch?v=PjRE0uBtkHU&t=11m14s
>> See also an overview article: https://lwn.net/Articles/820000/
>>
>>
>> This patch series can be applied on top of v5.8-rc5 .  This can be tested
>> with CONFIG_SYSCTL.  I would really appreciate constructive comments on
>> this patch series.
>>
>> Previous version:
>> https://lore.kernel.org/lkml/20200505153156.925111-1-mic@digikod.net/
>>
>>
>> [1] https://lore.kernel.org/lkml/1544647356.4028.105.camel@linux.ibm.com/
>> [2] https://lore.kernel.org/lkml/20190904201933.10736-6-cyphar@cyphar.com/
>> [3] https://lore.kernel.org/lkml/CALCETrVovr8XNZSroey7pHF46O=kj_c5D9K8h=z2T_cNrpvMig@mail.gmail.com/
>> [4] https://lore.kernel.org/lkml/CALCETrVeZ0eufFXwfhtaG_j+AdvbzEWE0M3wjXMWVEO7pj+xkw@mail.gmail.com/
>> [5] https://lore.kernel.org/lkml/20200406221439.1469862-12-deven.desai@linux.microsoft.com/
>> [6] https://www.python.org/dev/peps/pep-0578/
>> [7] https://lore.kernel.org/lkml/0c70debd-e79e-d514-06c6-4cd1e021fa8b@python.org/
>>
>> Regards,
>>
>> Kees Cook (3):
>>   exec: Change uselib(2) IS_SREG() failure to EACCES
>>   exec: Move S_ISREG() check earlier
>>   exec: Move path_noexec() check earlier
>>
>> Micka�l Sala�n (3):
>>   fs: Introduce O_MAYEXEC flag for openat2(2)
>>   fs,doc: Enable to enforce noexec mounts or file exec through O_MAYEXEC
>>   selftest/openat2: Add tests for O_MAYEXEC enforcing
>>
>> Mimi Zohar (1):
>>   ima: add policy support for the new file open MAY_OPENEXEC flag
>>
>>  Documentation/ABI/testing/ima_policy          |   2 +-
>>  Documentation/admin-guide/sysctl/fs.rst       |  49 +++
>>  fs/exec.c                                     |  23 +-
>>  fs/fcntl.c                                    |   2 +-
>>  fs/namei.c                                    |  36 +-
>>  fs/open.c                                     |  12 +-
>>  include/linux/fcntl.h                         |   2 +-
>>  include/linux/fs.h                            |   3 +
>>  include/uapi/asm-generic/fcntl.h              |   7 +
>>  kernel/sysctl.c                               |  12 +-
>>  security/integrity/ima/ima_main.c             |   3 +-
>>  security/integrity/ima/ima_policy.c           |  15 +-
>>  tools/testing/selftests/kselftest_harness.h   |   3 +
>>  tools/testing/selftests/openat2/Makefile      |   3 +-
>>  tools/testing/selftests/openat2/config        |   1 +
>>  tools/testing/selftests/openat2/helpers.h     |   1 +
>>  .../testing/selftests/openat2/omayexec_test.c | 325 ++++++++++++++++++
>>  17 files changed, 470 insertions(+), 29 deletions(-)
>>  create mode 100644 tools/testing/selftests/openat2/config
>>  create mode 100644 tools/testing/selftests/openat2/omayexec_test.c
>>
>> -- 
>> 2.27.0
>>
> 
