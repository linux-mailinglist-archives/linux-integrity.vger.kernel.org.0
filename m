Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1870922CE3D
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGXTDE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgGXTDD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 15:03:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB3C0619E5
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 12:03:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so5825934pgv.9
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LYsHHvmbnOnKOT161wgYJ0QUn66UfJfCSOHkGeru+cM=;
        b=epxr0OVXttEVlXmK9gG8sngCnRWPyA1Tl8s5eFiDuptGA3XfZ7D42jzmy8C+dHex+z
         O4t0er5aVcVIeElSNW4xKoTusneqHOYH3qTX0imlgipraUmww8ZAz/FAdRhZ2XYidyPD
         DxcDODdQ821AGi0c+CClL91b4u9fYF+8edV0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LYsHHvmbnOnKOT161wgYJ0QUn66UfJfCSOHkGeru+cM=;
        b=ZiqN6FjL7A94xFo4WL0fO+Li7JMLSUhvPKbnUAYTg5r7xys48v6vZsyjo2wShUTGyJ
         8v4ZR7/NuMkSAoBNt4d3EhuRErFDO+He/nZzqTJ2vckzjE4gai16oz2Hlb6jEDJY6HRq
         kNlP1/IWwyA2iGRUWcRsUrRvsW0cf6/o0461JeSDtRsVuoIp5ED+hElZ4UE4GwE3zNRj
         UYxODkZHLq+ONEiXH+OE7hCPACw+geH7KA29qgGW/1ltliRuJl0TAUd/L8E1ga1cSAfK
         sN+bFyuj9YjaOZGVZYlBUFhAWHHC5xvB5GIcJEIZHCPp20eLy+7rR57+sC3s25RiV/iC
         bfyQ==
X-Gm-Message-State: AOAM531AdBltzQM1NHRjvx6nq6w+D7swBT+NilJYGmg4mRbNX7Tc+kWp
        Q05H6jArGS6UJnv7E1YO2CshYw==
X-Google-Smtp-Source: ABdhPJxe287CjvKc1vXBSsqo1vqhqr3H+/qMCmeOy+LCVrrgE2glpryiF3Hn9YFdOosrNz2I96GIrw==
X-Received: by 2002:a62:2bd0:: with SMTP id r199mr9978051pfr.160.1595617383058;
        Fri, 24 Jul 2020 12:03:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s89sm6440672pjj.28.2020.07.24.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 12:03:02 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:03:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
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
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: Re: [PATCH v7 4/7] fs: Introduce O_MAYEXEC flag for openat2(2)
Message-ID: <202007241202.8D07E1F276@keescook>
References: <20200723171227.446711-1-mic@digikod.net>
 <20200723171227.446711-5-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723171227.446711-5-mic@digikod.net>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 23, 2020 at 07:12:24PM +0200, Mickaël Salaün wrote:
> When the O_MAYEXEC flag is passed, openat2(2) may be subject to
> additional restrictions depending on a security policy managed by the
> kernel through a sysctl or implemented by an LSM thanks to the
> inode_permission hook.  This new flag is ignored by open(2) and
> openat(2) because of their unspecified flags handling.  When used with
> openat2(2), the default behavior is only to forbid to open a directory.
> 
> The underlying idea is to be able to restrict scripts interpretation
> according to a policy defined by the system administrator.  For this to
> be possible, script interpreters must use the O_MAYEXEC flag
> appropriately.  To be fully effective, these interpreters also need to
> handle the other ways to execute code: command line parameters (e.g.,
> option -e for Perl), module loading (e.g., option -m for Python), stdin,
> file sourcing, environment variables, configuration files, etc.
> According to the threat model, it may be acceptable to allow some script
> interpreters (e.g. Bash) to interpret commands from stdin, may it be a
> TTY or a pipe, because it may not be enough to (directly) perform
> syscalls.  Further documentation can be found in a following patch.
> 
> Even without enforced security policy, userland interpreters can set it
> to enforce the system policy at their level, knowing that it will not
> break anything on running systems which do not care about this feature.
> However, on systems which want this feature enforced, there will be
> knowledgeable people (i.e. sysadmins who enforced O_MAYEXEC
> deliberately) to manage it.  A simple security policy implementation,
> configured through a dedicated sysctl, is available in a following
> patch.
> 
> O_MAYEXEC should not be confused with the O_EXEC flag which is intended
> for execute-only, which obviously doesn't work for scripts.  However, a
> similar behavior could be implemented in userland with O_PATH:
> https://lore.kernel.org/lkml/1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net/
> 
> The implementation of O_MAYEXEC almost duplicates what execve(2) and
> uselib(2) are already doing: setting MAY_OPENEXEC in acc_mode (which can
> then be checked as MAY_EXEC, if enforced).
> 
> This is an updated subset of the patch initially written by Vincent
> Strubel for CLIP OS 4:
> https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> This patch has been used for more than 12 years with customized script
> interpreters.  Some examples (with the original O_MAYEXEC) can be found
> here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> 
> Co-developed-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
> Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
