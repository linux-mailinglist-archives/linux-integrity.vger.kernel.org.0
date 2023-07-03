Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6235745F72
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGCPHa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 11:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCPH2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 11:07:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C2E49
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 08:07:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd200d354so115555e9.1
        for <linux-integrity@vger.kernel.org>; Mon, 03 Jul 2023 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688396840; x=1690988840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Yi73LNZtiJVtdv9XwcLHpbVmu5fGLj+HQkOyGONQFg=;
        b=nNLdtYLhT36EufRkpLv7ca6KV7NAAZgN9RHacCq/L6iFOvy47lS0Jtv965Pogb/qL4
         VxabMsMZuttYx2zc72BwOZdqEEv7R+4AL2E44+Ph/vn7lhek+4iddm/sETqfl2XYlQeR
         J+vySOqsZ5LRqFBT9cPIm2Pmu1HBOM0zkCXgvhQuph8X20jRqvsu1VTDFceEQFbHYCYJ
         5CgP4NseOo3j/3ZVP0wYcPlcBkFGO6BdRiJM/UwtfJ3fYbsyg78AplEsjvEKI3DMxH2+
         KBtrbQ4sd3cjcYmN79W0y6fMq3+aT81/iMF5RTkM3cIBrj1/zdi+9VzkgjmDLIhcu5iL
         fvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396840; x=1690988840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Yi73LNZtiJVtdv9XwcLHpbVmu5fGLj+HQkOyGONQFg=;
        b=AhDgudoxtciTTwCXkjCH3WgjnIDToy7YM/hOVfH00+YPfM+UgQQeybv7izi2q2HVw7
         1EDwW6IxC/eGHmj68TKyAusQGmmNLa6NTX6O1uQkL7S/ZHuSVPV2r7sEqdjsUp5XE67W
         52TQyvK8lIL+b+2qv34NUKwW4fH3P4NM3PcrS0PI76TL5yLau6oylV2CKpTD+YcJZ3dB
         KgdEYOVEQ9fnwzeRBaI1vP6dtFjjGk/DG3SC9wHQg1ekdrVWWCGimnW2iP+Y5yG5DWPt
         8g4JJqh9fX97o/KzY7xud4jJhd6RO9NiONXGZv0/oBiAlq/9zDOJuSvFzvZYyYPGTzZi
         iZBQ==
X-Gm-Message-State: ABy/qLayIYJyrztEO4FHdl2HQCJxgmELGLzDZJOG7H+h6DoT9XgHjWSn
        juoQd6uvd8viBxTa3/vi4NGALX1nco7tC78z7YjyZQ==
X-Google-Smtp-Source: APBJJlErLYbKhG362h11ORTRwVJGnuMRUrvtq/Y89AtBohzfF9IqoDlTx3PR/gLXPUH5GATUu8k8ZqKi1AZSHsYpChk=
X-Received: by 2002:a05:600c:1e1d:b0:3f7:3654:8d3 with SMTP id
 ay29-20020a05600c1e1d00b003f7365408d3mr190166wmb.2.1688396839544; Mon, 03 Jul
 2023 08:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
In-Reply-To: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 3 Jul 2023 17:06:42 +0200
Message-ID: <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
Subject: Re: [QUESTION] Full user space process isolation?
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        LuisChamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 22, 2023 at 4:45=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> I wanted to execute some kernel workloads in a fully isolated user
> space process, started from a binary statically linked with klibc,
> connected to the kernel only through a pipe.

FWIW, the kernel has some infrastructure for this already, see
CONFIG_USERMODE_DRIVER and kernel/usermode_driver.c, with a usage
example in net/bpfilter/.

> I also wanted that, for the root user, tampering with that process is
> as hard as if the same code runs in kernel space.

I believe that actually making it that hard would probably mean that
you'd have to ensure that the process doesn't use swap (in other
words, it would have to run with all memory locked), because root can
choose where swapped pages are stored. Other than that, if you mark it
as a kthread so that no ptrace access is allowed, you can probably get
pretty close. But if you do anything like that, please leave some way
(like a kernel build config option or such) to enable debugging for
these processes.

But I'm not convinced that it makes sense to try to draw a security
boundary between fully-privileged root (with the ability to mount
things and configure swap and so on) and the kernel - my understanding
is that some kernel subsystems don't treat root-to-kernel privilege
escalation issues as security bugs that have to be fixed.
