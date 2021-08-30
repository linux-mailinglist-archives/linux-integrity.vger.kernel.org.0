Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C03FBF71
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Aug 2021 01:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbhH3Xat (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Aug 2021 19:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhH3Xat (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Aug 2021 19:30:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17981C061575;
        Mon, 30 Aug 2021 16:29:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w7so13823822pgk.13;
        Mon, 30 Aug 2021 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Bl/EqOGe8tHTjO+T/8ceqa0CAuVYTtMirEWf4GGQqsk=;
        b=LY9671ygDXbS2QGJtlkn+KFcHrzueY+fAjbEU6axnW/D66moMRFxqAaLaxyZTMuzJo
         8rFkjL+YR5PMqHqGDfEkbKxzBlQbQ9VbktECJCRub1ithQx3ezRyBcTZcdpgiDm0YFY/
         pXNQGDeItgRv+MkNl0Y8qHC6fZD+KjaGaQF4thrLjpZpcsD61j3elCGix1AP1mhd9VDE
         /pon9sr/SKN9xuXHVV52mJYFuK4PGq7yk9Zw/YAKklBVdTsb3PYzzat5pTWdqFKcywyP
         ryTKHX4sIfzKGtOFOjtjSkZ2RHYDN2aLBR9OTPYNTnuKin2L7cWtRnBIzb5Hfb7e/o1a
         x2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Bl/EqOGe8tHTjO+T/8ceqa0CAuVYTtMirEWf4GGQqsk=;
        b=XGuUHNrkBPQXc3vK/dARFclloau+EKp4bEtG1gXptpTkeghsynYN+n5fQl/UiQuHvb
         dU13ALFPlZ+6X8XGxujePXJPHJ4TUiQsGwG0s/nve4+7sxJMem7xhRwjLqK/oOxbK28m
         mXqBqUKnJRaYH9ltaliM1mvBTbUegrF1MKuR4Ap/czhwPYPz4wj8ZnoWwis5BuHNdAr+
         nBUEDCvBjfrVh0G0grYKFeO6N4tHH20NJuYa7d51UdADPKtU7H3QtBRRe/ZAv7t9Xey8
         ixS4u+pksRYJ7zImfzFln97a2tORWtx/zYSHrbLw6ja+/fjUFPGu54bE0dDcqG7Ce/Ou
         Nf4Q==
X-Gm-Message-State: AOAM531zA9MbGxCnhze0GyloyaKhJcqAkQO9T1OXgo3eg6ltXFh8mL9J
        NoLBvSNX4RjN7H+wRDN8mN3JmrjgCWc=
X-Google-Smtp-Source: ABdhPJybzo656ysr1JRItaopY7MDX9+DbzGKU1I3mFij6OGILrfGprBjCsiONZXn3c7iPfTHWhj0PA==
X-Received: by 2002:a63:f241:: with SMTP id d1mr23621896pgk.424.1630366194366;
        Mon, 30 Aug 2021 16:29:54 -0700 (PDT)
Received: from [192.168.1.194] ([50.39.237.102])
        by smtp.gmail.com with ESMTPSA id c23sm18417102pgb.74.2021.08.30.16.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 16:29:54 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] NAX LSM: Add initial support
To:     Igor Zhbanov <izh1979@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        linux-kernel@vger.kernel.org
References: <281927a3-7d3e-7aac-509d-9d3b1609b02b@gmail.com>
 <624ae20f-b520-5b68-06a6-d0fa3713b9a1@gmail.com>
From:   J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <219ed9d8-9711-dfe0-c620-070976c1daac@gmail.com>
Date:   Mon, 30 Aug 2021 16:29:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <624ae20f-b520-5b68-06a6-d0fa3713b9a1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/21/21 2:47 AM, Igor Zhbanov wrote:
> Add initial support for NAX (No Anonymous Execution), which is a Linux
> Security Module that extends DAC by making impossible to make anonymous
> and modified pages executable for privileged processes.
>
> Intercepts anonymous executable pages created with mmap() and mprotect()
> system calls.
>
> Log violations (in non-quiet mode) and block the action or kill the
> offending process, depending on the enabled settings.
>
> See Documentation/admin-guide/LSM/NAX.rst.
>
> Signed-off-by: Igor Zhbanov <izh1979@gmail.com>
> ---
>   Documentation/admin-guide/LSM/NAX.rst         |  72 +++
>   Documentation/admin-guide/LSM/index.rst       |   1 +
>   .../admin-guide/kernel-parameters.rst         |   1 +
>   .../admin-guide/kernel-parameters.txt         |  32 ++
>   security/Kconfig                              |  11 +-
>   security/Makefile                             |   2 +
>   security/nax/Kconfig                          | 113 +++++
>   security/nax/Makefile                         |   4 +
>   security/nax/nax-lsm.c                        | 472 ++++++++++++++++++
>   9 files changed, 703 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/admin-guide/LSM/NAX.rst
>   create mode 100644 security/nax/Kconfig
>   create mode 100644 security/nax/Makefile
>   create mode 100644 security/nax/nax-lsm.c
>
> diff --git a/Documentation/admin-guide/LSM/NAX.rst b/Documentation/admin-guide/LSM/NAX.rst
> new file mode 100644
> index 000000000000..da54b3be4cda
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/NAX.rst
> @@ -0,0 +1,72 @@
> +=======
> +NAX LSM
> +=======
> +
> +:Author: Igor Zhbanov
> +
> +NAX (No Anonymous Execution) is a Linux Security Module that extends DAC
> +by making impossible to make anonymous and modified pages executable for
> +processes. The module intercepts anonymous executable pages created with
> +mmap() and mprotect() system calls.
> +
> +To select it at boot time, add ``nax`` to ``security`` kernel command-line
> +parameter.
> +
> +The following sysctl parameters are available:
> +
> +* ``kernel.nax.check_all``:
> + - 0: Check all processes.
> + - 1: Check only privileged processes. The privileged process is a process
> +      for which any of the following is true:
> +      - ``uid  == 0``
> +      - ``euid == 0``
> +      - ``suid == 0``
> +      - ``cap_effective`` has any capability except for the ones allowed
> +        in ``kernel.nax.allowed_caps``
> +      - ``cap_permitted`` has any capability except for the ones allowed
> +        in ``kernel.nax.allowed_caps``
> +
> + Checking of uid/euid/suid is important because a process may call seteuid(0)
> + to gain privileges (if SECURE_NO_SETUID_FIXUP secure bit is not set).
> +
> +* ``kernel.nax.allowed_caps``:
> +
> + Hexadecimal number representing the set of capabilities a non-root
> + process can possess without being considered "privileged" by NAX LSM.
> +
> + For the meaning of the capabilities bits and their value, please check
> + ``include/uapi/linux/capability.h`` and ``capabilities(7)`` manual page.
> +
> + For example, ``CAP_SYS_PTRACE`` has a number 19. Therefore, to add it to
> + allowed capabilities list, we need to set 19'th bit (2^19 or 1 << 19)
> + or 80000 in hexadecimal form. Capabilities can be bitwise ORed.
> +
> +* ``kernel.nax.mode``:
> +
> + - 0: Only log errors (when enabled by ``kernel.nax.quiet``) (default mode)
> + - 1: Forbid unsafe pages mappings (and log when enabled)
> + - 2: Kill the violating process (and log when enabled)
> +
> +* ``kernel.nax.quiet``:
> +
> + - 0: Log violations (default)
> + - 1: Be quiet
> +
> +* ``kernel.nax.locked``:
> +
> + - 0: Changing of the module's sysctl parameters is allowed
> + - 1: Further changing of the module's sysctl parameters is forbidden
> +
> + Setting this parameter to ``1`` after initial setup during the system boot
> + will prevent the module disabling at the later time.
> +
> +There are matching kernel command-line parameters (with the same values):
> +
> +- ``nax_allowed_caps``
> +- ``nax_check_all``
> +- ``nax_mode``
> +- ``nax_quiet``
> +- ``nax_locked``
> +
> +The ``nax_locked`` command-line parameter must be specified last to avoid
> +premature setting locking.


Is it common to have these types of restrictions for kernel command-line 
parameters, in this case, kernel command-line parameter ordering?  Seems 
like that would be prone for a lot of avoidable troubleshooting issues 
and unnecessary usage questions.

<big snip>
.
.
.

> +
> +static void __init
> +nax_init_sysctl(void)
> +{
> +	if (!register_sysctl_paths(nax_sysctl_path, nax_sysctl_table))
> +		panic("NAX: sysctl registration failed.\n");
> +}
> +
> +#else /* !CONFIG_SYSCTL */
> +
> +static inline void
> +nax_init_sysctl(void)
> +{
> +
> +}
> +
> +#endif /* !CONFIG_SYSCTL */
> +
> +static int __init setup_allowed_caps(char *str)
> +{
> +	if (locked)
> +		return 1;
> +
> +	/* Do not allow trailing garbage or excessive length */
> +	if (strlen(str) > ALLOWED_CAPS_HEX_LEN) {

  a little nitpick, could strnlen() be used instead to define a max 
length of the input 'str'?


Regards,
Jay
