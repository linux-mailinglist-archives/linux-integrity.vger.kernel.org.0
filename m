Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5330B1D50CC
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgEOOhV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726719AbgEOOhT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 10:37:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04EC05BD09
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2020 07:37:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so1032352pgl.9
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2020 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GkgSQWYyEHrVohFFMSyphZgO4DDabSVNfncbmH3+PSA=;
        b=i7phLR6oslO+nKsuBoJMm/9bH/JqIgx0izgjVqNpzYrr5so+8tSWN9Yf5iu61KRlBK
         Udu9CbA+KyxU6EBm8+gDNGEL/mh1EmL9zpEH2ZzYj91LqaHO8SRqBPJ4m+Ti1YEJzzGA
         jofFicakkW+mtqfl3m559FLv+sFicL0eDLX0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GkgSQWYyEHrVohFFMSyphZgO4DDabSVNfncbmH3+PSA=;
        b=JMsG8OUAp1p//PuZCAGVkYdZwk6hUG0iFQbbtnLsEDrP1x4Alcxo+QmqmhKT06GaXS
         bqYwRrRWAJsiGz9YrpziYwXqyodYRJnRjKUB2F5aiEpr5RW193ga1JjoiB3R/N0IZ6qv
         dRiwC+8oZ/qXiXUh6AuAB8iAt1WsvzrHx4DI9yDaRd3fG7jHHDfQQgeatnSp7onMRi4t
         k93Ux4t3nFeLWm6g2/SI++7gmNk+Q5/ttCCoBQbqPfW7y5wc1yv9XpIwCFBDVskw7EbD
         CD6WcySWOxD4muRueiP1JchmgPi/HPtuKsn5MVBn7Wi1UOlgfFGjTP5eJWV9cvLksTTj
         KIYw==
X-Gm-Message-State: AOAM531+CwOY5/IX0UnugV9XnM9GevcRsd2rLn+l09+HwdFJo2qJmwrw
        lkMHT3YqZBM2B5ejN2t/GTIsNw==
X-Google-Smtp-Source: ABdhPJwe+mQWxHy+Y8MG1su17GDYNjf0sGvC5GumLd2b2yGuoh3drABp261K8+gyS8kDmn+Bp9fFfw==
X-Received: by 2002:a62:18c1:: with SMTP id 184mr3649253pfy.277.1589553438673;
        Fri, 15 May 2020 07:37:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q134sm2132257pfc.143.2020.05.15.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:37:17 -0700 (PDT)
Date:   Fri, 15 May 2020 07:37:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Lev R. Oshvang ." <levonshe@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: How about just O_EXEC? (was Re: [PATCH v5 3/6] fs: Enable to
 enforce noexec mounts or file exec through O_MAYEXEC)
Message-ID: <202005150732.17C5EE0@keescook>
References: <20200505153156.925111-4-mic@digikod.net>
 <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
 <202005131525.D08BFB3@keescook>
 <202005132002.91B8B63@keescook>
 <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
 <202005140830.2475344F86@keescook>
 <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
 <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
 <202005142343.D580850@keescook>
 <87a729wpu1.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a729wpu1.fsf@oldenburg2.str.redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 15, 2020 at 10:43:34AM +0200, Florian Weimer wrote:
> * Kees Cook:
> 
> > Maybe I've missed some earlier discussion that ruled this out, but I
> > couldn't find it: let's just add O_EXEC and be done with it. It actually
> > makes the execve() path more like openat2() and is much cleaner after
> > a little refactoring. Here are the results, though I haven't emailed it
> > yet since I still want to do some more testing:
> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/o_exec/v1
> 
> I think POSIX specifies O_EXEC in such a way that it does not confer
> read permissions.  This seems incompatible with what we are trying to
> achieve here.

I was trying to retain this behavior, since we already make this
distinction between execve() and uselib() with the MAY_* flags:

execve():
        struct open_flags open_exec_flags = {
                .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
                .acc_mode = MAY_EXEC,

uselib():
        static const struct open_flags uselib_flags = {
                .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
                .acc_mode = MAY_READ | MAY_EXEC,

I tried to retain this in my proposal, in the O_EXEC does not imply
MAY_READ:

+	/* Should execution permissions be checked on open? */
+	if (flags & O_EXEC) {
+		flags |= __FMODE_EXEC;
+		acc_mode |= MAY_EXEC;
+	}

-- 
Kees Cook
