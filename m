Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2D6064E8
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJTPsC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 11:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJTPsB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 11:48:01 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6306C19D89A
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 08:48:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t186so19915yba.12
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1FgKYeu1p//oQqI8aloC3qi8jZpEu+hoUnjxFymh4Kw=;
        b=Yq0S3FR84Q/sf2fswB2ghCBhoy7IIgMhl3hdhxREh3R659IXlLQYVfczsBOBNZzojl
         jfZGgnvXqco7BpUcmvH4uHt6ujAV4TLRg1DyAnsi+j/A5dwXEqVe9ZN4671I1lVpKmlw
         kX7IbDBrCy//NTHBOQLu2p0sTUslE/3itfzsEa39HupsSQVn1zHoO+QkSjLEMKDD2foo
         NzvfCgYxPjXhjKBLl2O7ZNPMwfgLlAuhUFuh6Bc/EAZnwNU4/tjtW9QexrP1BCWhfHEO
         vmBX4Vf6wdbIjL5G3EqXLuQ308pNReaHKqra0/qqGuYHzYM0ycCyQjyBzZhcax8npD9X
         j/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FgKYeu1p//oQqI8aloC3qi8jZpEu+hoUnjxFymh4Kw=;
        b=m2ZPM7fDa8iALDveknaMri13jvU8yGXmCnm1fovmSROiSVLkwhZxWVIF3VSJrrtnrN
         vOrW34rXhSm4gLI70z3yWCuinZF7qkbm4FjFE7VpfYeaYUvozP0RGIOaUA3dwyLk74CK
         sMSFpXFhA1biJv4JRUMJH18xz/ujjOc2gCWZb2xXDTnAMX/MqFulAsB45tB+U7syb3Wd
         ZopMMnaV4k71Ut4g4bgBg2KEcca8vdEteeDvzcb+8H4kgdZ1zecJl5vE3xE+gzR0/A2U
         UimTg9c3b5KWu1X4fUg2K9ZV8QyNnKON/wqwrQD7axj7QYPLe2PeFYi8gND84/7eAAGt
         XQEA==
X-Gm-Message-State: ACrzQf1hhf7XtiV+EflrpxSJo2lmpjCE/IJHBpW3XTSjSGtsfXdLsSlZ
        E1hdQeVQlBLjZk/IV4dLJb5Lcd08bU//FNzBY+aT
X-Google-Smtp-Source: AMsMyM7qAGLonUqMOVaGL4XnjKhbi9gjpeiqUQpAKWVmVrvVhzDqUNkBgxcJP3aA7gaQ6AiFfLWPCO+ZPilqGhDMyaI=
X-Received: by 2002:a05:6902:124f:b0:6c0:770:1890 with SMTP id
 t15-20020a056902124f00b006c007701890mr12155097ybu.186.1666280879508; Thu, 20
 Oct 2022 08:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222702.never.990-kees@kernel.org> <20221013223654.659758-4-keescook@chromium.org>
 <20221018150213.7n4sv7rtsh6lshd5@wittgenstein> <1b41c633bbd31b82b02fdbae718f2f11ac862181.camel@huaweicloud.com>
 <202210181126.E58AB4A0F@keescook> <00bf4f189e4ec3b98130451f40e77ead8f28179e.camel@huaweicloud.com>
In-Reply-To: <00bf4f189e4ec3b98130451f40e77ead8f28179e.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Oct 2022 11:47:46 -0400
Message-ID: <CAHC9VhTfF0oU5ppYcf_WMztDp-nyZ9bQ2oE4Z+b5Ajk4wszw-Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] ima: Move ima_file_free() into LSM
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Petr Vorel <pvorel@suse.cz>,
        Jonathan McDowell <noodles@fb.com>,
        Borislav Petkov <bp@suse.de>, Takashi Iwai <tiwai@suse.de>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 19, 2022 at 2:56 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Tue, 2022-10-18 at 11:29 -0700, Kees Cook wrote:
> > On Tue, Oct 18, 2022 at 05:32:40PM +0200, Roberto Sassu wrote:
> > > I also did this work before. In my implementation, I created a new
> > > security hook called security_file_pre_free().
> > >
> > > https://github.com/robertosassu/linux/commit/692c9d36fff865435b23b3cb765d31f3584f6263
> > >
> > > If useful, the whole patch set is available at:
> > >
> > > https://github.com/robertosassu/linux/commits/ima-evm-lsm-v1-devel-v3
> >
> > Ah, lovely! Can you pick this back up and run with it? I mainly did
> > these a proof-of-concept, but it looks like you got further.
>
> It was some time ago. If I remember correctly, I got to the point of
> running IMA/EVM and passing basic tests.
>
> Will take a look at your patches and comments, and integrate in mines
> if something is missing.
>
> Will also send again the prerequisite patch set.

Thanks Roberto, I appreciate you taking the time to resume your
earlier work.  I think this will be a nice improvement and help us
cleanup a lot of code.

-- 
paul-moore.com
