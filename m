Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD394F1ECA
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 00:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiDDWEf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379693AbiDDV6k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 17:58:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99B41635
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 14:40:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q14so14632093ljc.12
        for <linux-integrity@vger.kernel.org>; Mon, 04 Apr 2022 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvKxsafXL2Gat8gnxoPlSsJysAlo5fGZyeeEP4baNY8=;
        b=A9tjEjTQxL5uzMyZiDMZsByK+whBGLSB6qHE+uZRK7pVJilQTKdEsI9cEjxGRejl5b
         J71jC7xcvbNYqvYxcPtUkqcG/jeaBVt1hzrA68i4S37/iSwMfqtVSRk8JDPuGGLw6XZI
         nrysu96epRGW5riZujfcbHCnjDbtfn5ZsZrfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvKxsafXL2Gat8gnxoPlSsJysAlo5fGZyeeEP4baNY8=;
        b=jutuaa3NjWmIqyIYieJhXGQs/XrWOme1j205saqvjwh214kkhRzdvWueOAZtz+Yl46
         FEjDxKTH/mm+ripCTStO77W7C/nJos/qgpqKl0waVA6+E7eyG9bHDZLdzHz5A+cK2v/d
         ctx2zhl0AzI5nktWCdgEB9ZzVD0w/8eKl9fTgCxiI4iVX7NWP6IKRurgZRXxN7XlEYLC
         zOjOe8ZI7axvZR7sozWw25Bqy92TP3yxxnepvrDwmtnT9XcyoAbvuFU5YRBIzNsQehIz
         a94RGRi2D7PUZJcz1j54F4M91At4f2noEGV0yg+KZvbZe410EiCeFqg7yN+hghlKM9a4
         gbew==
X-Gm-Message-State: AOAM533QVYeiNZAIVfW+qi0d82tcBip3erfD1fwWkgvOpBwxGcZJnVVg
        8ZnFxq7VELDChkoMAUJesU89s6i7jITPpv8DOR4=
X-Google-Smtp-Source: ABdhPJxvPJaGke3BcxWtO+BKRmjXqcBtW4C1v3N2NkPiU6LriZQGTbfAb3RQj5Mhur5vEEYVPaPuYg==
X-Received: by 2002:a2e:994a:0:b0:249:7be6:9e62 with SMTP id r10-20020a2e994a000000b002497be69e62mr65590ljj.215.1649108441943;
        Mon, 04 Apr 2022 14:40:41 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id z11-20020a0565120c0b00b0044a378908d5sm1270346lfu.179.2022.04.04.14.40.38
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 14:40:39 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id b17so12117464lfv.3
        for <linux-integrity@vger.kernel.org>; Mon, 04 Apr 2022 14:40:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr239017lfb.435.1649108438583; Mon, 04
 Apr 2022 14:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net> <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
In-Reply-To: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 14:40:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFQCUto1LGo8Cozhe1n9KjoU_99v94ubU_QWSQob7ntw@mail.gmail.com>
Message-ID: <CAHk-=wjFQCUto1LGo8Cozhe1n9KjoU_99v94ubU_QWSQob7ntw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 4, 2022 at 2:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (4) maybe we want to add a flag for the "euid vs real uid", and that
> would be in the "flags" field, since that changes the actual *lookup*
> semantics

Duh. We already did that long ago, and it's there as AT_EACCESS.

I should have just looked at the code more closely.

But that "you didn't even check what we already do, Linus" thing just
makes it even more obvious that all of this makes perfect sense in the
confines of access() already, and a new "check _these_ protections"
should just be a new mode bit.

                 Linus
