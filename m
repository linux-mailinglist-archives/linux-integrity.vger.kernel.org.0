Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26A64F1E60
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 00:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346567AbiDDVzW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 17:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386507AbiDDVmp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 17:42:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2027140F3
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 14:34:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so14665173ljb.6
        for <linux-integrity@vger.kernel.org>; Mon, 04 Apr 2022 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1bAt6TBAHHEmy348lJLTOOvTLaiSv+TPTdYgy4I0MYg=;
        b=E1NpQ4P1JCYLIm1H9ndx7S+bR3N92nar4xieVmugUkT6Cx5jg1i6+kdx6U9ToEInPx
         DlMzWwsy0K1TW1TUuLGfn9IByiIXEgm4qoKAaF9cTvDdVu4Py81nrFtW2CvjxbTluuDS
         cQcatiB/Kd2loHgbmaSShiD8lq4pMIa5yFk/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1bAt6TBAHHEmy348lJLTOOvTLaiSv+TPTdYgy4I0MYg=;
        b=SBCF2CRcTVNP6Ztn7zTfxSWG2Pbt2hx86M5V0jXwbp/zF8cBieB+OqiNtiklPZPino
         dvvy7hqt8mz3FofJvJirgv+IeJ+B8eTW/WatrwTHqiiTPcapTt0hPKvxqHVMERKN4dts
         7saAYlXPgoJvKUhEhMuguoO0fGu9/RoldG2wWqRRfOXwG6jPws0f/aUcuCUR1EUx+9OZ
         fp+3tNxpaePSyHXkUATZ+jiTSD5G6Zb7Zc/za1bC4f4odyCgcE1SQAlDKxbQ9HArSgl4
         tt/gLtqmxZg2lzUyty+nHJQvvZjkHov5xCN0PWh2D4UwHys1T4AgKtJDVAdMBlhjMLNJ
         w9mg==
X-Gm-Message-State: AOAM530vbiQyoe9tf9fxm6KB4oaVVOY4dv6wq8aaUHv7GH5eJCoatUG2
        mLrAS6EPOKiGSWeHWgOxfjppHI8ileO8uaqmwdk=
X-Google-Smtp-Source: ABdhPJyu07RoXMCvC3NLPJFZ3PiJn+FoXCALSwg2X0SImeHWB26bPCGDVg5Hw8mzEBr2m9obYSP12g==
X-Received: by 2002:a05:651c:248:b0:245:5b3d:9abb with SMTP id x8-20020a05651c024800b002455b3d9abbmr67325ljn.366.1649108064695;
        Mon, 04 Apr 2022 14:34:24 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p41-20020a05651213a900b00443fac7d6ffsm1271647lfa.108.2022.04.04.14.34.24
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 14:34:24 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id bu29so19853974lfb.0
        for <linux-integrity@vger.kernel.org>; Mon, 04 Apr 2022 14:34:24 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr195601lfh.687.1649107715765; Mon, 04 Apr
 2022 14:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com> <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
In-Reply-To: <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 14:28:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
Message-ID: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 4, 2022 at 1:29 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> This initial proposal was using a new faccessat2(2) flag:
> AT_INTERPRETED, see
> https://lore.kernel.org/all/20200908075956.1069018-2-mic@digikod.net/
> What do you think about that? I'm happy to get back to this version if
> everyone is OK with it.

I'm certainly happi_er_ with that, but I find that particular patch
odd for other reasons.

In no particular order:

 - what's with the insane non-C syntax? Double parentheses have no
actual meaning in C:

     if ((flags & AT_INTERPRETED)) {
         if ((mode & MAY_EXEC)) {

   so I don't understand why you'd use that strance thing.

 - why is this an AT_INTERPRETED flag? I don't understand the name, I
don't understand the semantics.

   Why would that flag have the same value as AT_SYMLINK_FOLLOW?

   Why isn't this just a new _mode_ bit, which is what I feel is
sensible? We only use three bits (with no bits set meaning
"existence"), so we have *tons* of bits left in that namespace, and it
would make much more sense to me to have

        #define EXECVE_OK 8

    which is the same as the "group exec" bit, so it actually makes
some kind of sense too.

 - related to that "I don't understand the semantics", the
"documentation" for that thing doesn't make sense either:

    +         The
    +    main usage is for script
    +    interpreters to enforce a policy
    +    consistent with the kernel's one
    +    (through sysctl configuration or LSM
    +    policy).  */

Now, what I *think* you mean is

 (1) user-space executable loaders want to be able to test the *same*
policy as the kernel does for execve()

 (2) access(path, EXECVE_OK) will do the same permission checks as
"execve()" would do for that path

 (3) if you already have the fd open, use "faccess(fd, NULL,
F_OK_TO_EXECUTE, AT_EMPTY_PATH)"

 (4) maybe we want to add a flag for the "euid vs real uid", and that
would be in the "flags" field, since that changes the actual *lookup*
semantics

Note that that (4) is something that some normal user space has wanted
in the past too (GNU libcs has a "eaccess()" thing for "effective uid
access").

And yes, we still need to talk details:

 - no backwards compatibility issues, because we've happily always
checked 'mode' for being valid, so old kernels will always return
-EINVAL.

 - POSIX namespace issues for EXECVE_OK means that the name probably
needs some thinking (maybe we just need to call it __ACCESS_OK_EXECVE
internally or something - the kernel actually doesn't even export the
existing [FRWX]_OK values, because we "know" they map tho the usual
"owner RWX" bits, with F being "no bit set")

 - I really want the exact semantics very clearly defined. I think
it's ok to say "exact same security check as for 'execve()'", but even
then we need to have that discussion about

    (a) "what about suid bits that user space cannot react to"
    (b) that whole "effective vs real" discussion

So to recap: I'm very much ok with some access() extension, but I
think even that very much needs clarification, and the existing patch
is just odd in many many ways.

                  Linus
