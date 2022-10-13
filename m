Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98A5FE58E
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJMWsE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJMWsD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:48:03 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B715625C
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:47:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-345528ceb87so30840237b3.11
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1IR8UJAXpBvZzT/7GU3mPJId/fsK+MjCQImPKCJ6/sE=;
        b=494pVkEaye9j6W73gXASpcofuAwYpM8raxnnmd1fAvyJgfOU03JZz9MO0MwIAjuQB8
         HJXSVng3LvLv4mjlYbYklko4RiCHJPFYIDHBmQtsXYaQXmoJNGg5mBe5O18nM4pKZtCz
         BQ+XEnuJHBqpKUq57I0cvQJFj52fM2G34WlwKY+xaeKbZlwol3H5HF/GmCL9KxTga5hz
         MkGuYaWY+5XxbRx6DOwH+rf1BPL6O2iNZcx2SPRpn197vXwdCLY2N6gqe4PUE6mHs9/p
         WmgZzPH7Jh+WhD8QD1HEWn5oyetJOPaxJ82rEpvTKlaMiwnRw6rt5JGPuhJ1HPHccLeQ
         DP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IR8UJAXpBvZzT/7GU3mPJId/fsK+MjCQImPKCJ6/sE=;
        b=oUs7bOmjke7nayFAWP0lwTqmIMYcoCShEhRgpzntByDrQSgHq/Vb2B6mP4Vjz+Qty5
         oq88umhFdb9R+5B3/+3KGuDIRujqhFP55Q/glXFQXcCwgttZOiu1LoFTn3fusYoxi8Lh
         OVtbBCfp8QDgiH+aQditM0vYyPfd+8mMmN1GnDpUzrTHDBf1gL/1Ndnh0O20qCOJjtrN
         TF/LFwBOx4Qxyi8IrtLrqHClvh1EskM/gzY9iCN1yWBOj6Asp3ddk7nxnoxn8wO9Zvjd
         glknY4+hS+YSSBConz2g5K2iSCVFqXt7Ya+WjStHC3L+7tsxOkcETEOmQ8D083aFwHZ1
         FfWQ==
X-Gm-Message-State: ACrzQf0qTyuakHrZ89xZSNVA+/byOjRiLCo5JOSK0B8nJKzT3P+EfcuT
        AikZFylK4J/Zx4xAcdZ8q5BPTf1T3lcwunH2lHJp
X-Google-Smtp-Source: AMsMyM66u4ycBEjkV14kyk8hv+CgFXOhd+BlJtzLmHlVeQsNjrCO+H/M7KrOZYcl+Hk9LD0EpW++ugAIf5g0qHvCUuY=
X-Received: by 2002:a81:f84:0:b0:357:c499:44e6 with SMTP id
 126-20020a810f84000000b00357c49944e6mr2075620ywp.51.1665701273317; Thu, 13
 Oct 2022 15:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222702.never.990-kees@kernel.org>
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Oct 2022 18:47:42 -0400
Message-ID: <CAHC9VhR1kGT0+zM3smAQMEzGQLmVNhHu40f=YK3qavuYvcQYQQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] integrity: Move hooks into LSM
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 13, 2022 at 6:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> It's been over 4 years since LSM stack was introduced. The integrity
> subsystem is long overdue for moving to this infrastructure. Here's my
> first pass at converting integrity and ima (and some of evm) into LSM
> hooks. This should be enough of an example to finish evm, and introduce
> the missing hooks for both. For example, after this, it looks like ima
> only has a couple places it's still doing things outside of the LSM. At
> least these stood out:
>
> fs/namei.c:     ima_post_create_tmpfile(mnt_userns, inode);
> fs/namei.c:                             ima_post_path_mknod(mnt_userns, dentry);
>
> Mimi, can you please take this series and finish the conversion for
> what's missing in ima and evm?
>
> I would also call attention to "175 insertions(+), 240 deletions(-)" --
> as expected, this is a net reduction in code.
>
> Thanks!

Without looking at any of the code, I just want to say this 100% gets
my vote; this is something we need to make happen at some point.

Thanks Kees!

> Kees Cook (9):
>   integrity: Prepare for having "ima" and "evm" available in "integrity"
>     LSM
>   security: Move trivial IMA hooks into LSM
>   ima: Move xattr hooks into LSM
>   ima: Move ima_file_free() into LSM
>   LSM: Introduce inode_post_setattr hook
>   fs: Introduce file_to_perms() helper
>   ima: Move ima_file_check() into LSM
>   integrity: Move trivial hooks into LSM
>   integrity: Move integrity_inode_get() out of global header
>
>  fs/attr.c                             |  3 +-
>  fs/file_table.c                       |  1 -
>  fs/namei.c                            |  2 -
>  fs/nfsd/vfs.c                         |  6 --
>  include/linux/evm.h                   |  6 --
>  include/linux/fs.h                    | 22 +++++++
>  include/linux/ima.h                   | 87 ---------------------------
>  include/linux/integrity.h             | 30 +--------
>  include/linux/lsm_hook_defs.h         |  3 +
>  security/Kconfig                      | 10 +--
>  security/apparmor/include/file.h      | 18 ++----
>  security/integrity/evm/evm_main.c     | 14 ++++-
>  security/integrity/iint.c             | 28 +++++++--
>  security/integrity/ima/ima.h          | 12 ++++
>  security/integrity/ima/ima_appraise.c | 21 +++++--
>  security/integrity/ima/ima_main.c     | 66 ++++++++++++++------
>  security/integrity/integrity.h        |  8 +++
>  security/security.c                   | 78 ++++++------------------
>  18 files changed, 175 insertions(+), 240 deletions(-)

-- 
paul-moore.com
