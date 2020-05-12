Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3C81D015A
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbgELV5a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 17:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731419AbgELV53 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 17:57:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF757C061A0F
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 14:57:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so5986924plt.5
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e7QDP26KIcvXxlMBDMenIfkDI5g81klinZXY+V/2a0c=;
        b=EKNj4UhWvYLYC+esrF6wIPSlTbES/pi+t5+UQ0FZzqy/47ARXRNq0vx4AjTCa/AKXt
         6Xuy4ZU/p0Wwaf1GllvqRSgZfR+YY+Hc4i5fEDhbCj0JsbqDndK+ZVWdwzHmfT5O9IEG
         BGnWj2ANI1p6ggTHcQmlDREvxqMxzq37T3E0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e7QDP26KIcvXxlMBDMenIfkDI5g81klinZXY+V/2a0c=;
        b=KA5swLohO9w1iaHtZFV6OEDGH8r9OkHHwBrACrf3kswwA73D137e+/3ucIyQU0Tlif
         fbXVraFERwvo1p7zM3w0ph/zRYU9Z6ZOX5QWvwez/ec9TU+dYEeve7NsdG2Sgo8XE44l
         9HMPq0JpS5T40YBMk2qYQdruxolltdrEr5Kj4izR3nTG9hqvT3hgxL0c+xvq0r3VBiXG
         8337LfZA38NoLnmiqJoYlC1Z8ANtKpEzjzHkq319RaS7+o17G4CjggKug4900lteyx45
         BKtSijPHwrHRyS2Y6fGQWqj5fUzfODr7Amn24jCKzEwFExEyHcqBw5MiM1dspmPCzcD4
         /YtA==
X-Gm-Message-State: AGi0Puad+WTh3IemyRC/sscJaaIPKRtpm5G65DF3sqJNZQLOvTC5HEJw
        a9C+E8JNH9Q3pSXZ6yFAsHRlqg==
X-Google-Smtp-Source: APiQypIiqN1d23Fkal6XnfP7M0OVBHWWKQI6z1c+Lxm1tB4W6iJPBSoHHobQonUpZ1R5kSF3kW/fRg==
X-Received: by 2002:a17:902:ac87:: with SMTP id h7mr20712377plr.119.1589320649149;
        Tue, 12 May 2020 14:57:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 184sm13196569pfy.144.2020.05.12.14.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:57:28 -0700 (PDT)
Date:   Tue, 12 May 2020 14:57:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] selftest/openat2: Add tests for O_MAYEXEC
 enforcing
Message-ID: <202005121452.4DED41A@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-5-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505153156.925111-5-mic@digikod.net>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 05, 2020 at 05:31:54PM +0200, Mickaël Salaün wrote:
> Test propagation of noexec mount points or file executability through
> files open with or without O_MAYEXEC, thanks to the
> fs.open_mayexec_enforce sysctl.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>

Yay tests! :) Notes below...

> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> index 4b93b1417b86..cb98bdb4d5b1 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
>  CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
> -TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
> +LDLIBS += -lcap
> +TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test omayexec_test

I realize the others have _test in their name, but that feels intensely
redundant to me. :)

> [...]
> diff --git a/tools/testing/selftests/openat2/omayexec_test.c b/tools/testing/selftests/openat2/omayexec_test.c
> new file mode 100644
> index 000000000000..7052c852daf8
> --- /dev/null
> +++ b/tools/testing/selftests/openat2/omayexec_test.c
> [...]
> +FIXTURE_DATA(mount_exec_file_exec) { };

For each of these, Please use "FIXTURE" not "FIXTURE_DATA". See:
1ae81d78a8b2 ("selftests/seccomp: Adjust test fixture counts")

> +FIXTURE_SETUP(mount_exec_file_exec)
> +{
> +	create_workspace(_metadata, 1, 1);

Maybe save the system's original sysctl in create_workspace() instead
of always restoring it to 0 in delete_workspace()?

Otherwise, looks good!

-- 
Kees Cook
