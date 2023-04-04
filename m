Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE06D6C01
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Apr 2023 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjDDS3K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Apr 2023 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjDDS2y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Apr 2023 14:28:54 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BA903B
        for <linux-integrity@vger.kernel.org>; Tue,  4 Apr 2023 11:26:08 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j7so39847297ybg.4
        for <linux-integrity@vger.kernel.org>; Tue, 04 Apr 2023 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680632765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyjoFpVijlAvxTCbOhJJ22iDzQUactcN5oOMXtPKyqU=;
        b=fcxPf/i8xq/kSQfoVdznWlATaPoee6x4Dem/NHTsVKRgZLeTmjolTZLa/+wlaVzoo2
         9wvH9iZDHP0vTlVzDnxPCaPpHN3tDUjPt67SQO61fkm34DihtHBMRLAFcs2rMItJTIhy
         I6ffUk8HIw91u9pqKUvjV5A2g74DjoemZoBP07KThvSgH49wdGzmNq3+3McXhZUTP6Pp
         haNgzYnEbjtZi+tD+GbjOtszKTPwrkXxqpENHShf5NPe98Q7/dEGAs3IkKkA7iFl8wl0
         Nim2er0csMAF8UUSFkm0qwDshTzU0tzM7EOY6pkH15hkYpDAVagWgrcgvIf+Y7NEmhNw
         8ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyjoFpVijlAvxTCbOhJJ22iDzQUactcN5oOMXtPKyqU=;
        b=Wb4PsFig7EnvxcPXmgufm/XNZcrLiM/9xZdpklbvaeRxH6p2Yb9+pitOeIYemd7ytb
         gOm1EYDEAKIewWZ5LofMssJwBatt/Pus8Mfi4KGp1yrR9Abc6275QkHPya2LL9O1T/cL
         PvNP16Rb1wFZbvIlazXjSLAoCEVu47ua/SL4XDpRCZsSHWEEu1RcL2z+cmqXNVoR8/2s
         tijsSyuk4cC0kfnAhDR5VvQ5zaw9RLxiqEdzfux7kSUJy7SXhiB91REgYJ4ZkAvi0/2Z
         9qjWoKTa06Z6X6sy0AUSffckgnEbLyn0dXfxbXrGlTmchjfeW36+H1s0p0aipM2o9U32
         0vTQ==
X-Gm-Message-State: AAQBX9frJyveY3e6RZST/xnhKCjfQJWxJdP3eK4NMQl/G6rzSSsABi7H
        SJxwdZx7Oq9AtVJOWDNyrT32RUPBjMadWed98y8h
X-Google-Smtp-Source: AKy350Z1zr2YlO7SKFTwlplbfhoyc2wR4q7sivsyQWkkLJjxdDoxjxyefjzb/C0u+bqpRWOrC8ylutsAT9jk1XyHS7o=
X-Received: by 2002:a25:7449:0:b0:b75:8ac3:d5d9 with SMTP id
 p70-20020a257449000000b00b758ac3d5d9mr2436296ybc.3.1680632765167; Tue, 04 Apr
 2023 11:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com> <20230331123221.3273328-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230331123221.3273328-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 4 Apr 2023 14:25:54 -0400
Message-ID: <CAHC9VhT17mtnncuKVNzqr0zTU+E5R+8wMaxF4AYXS_bG9L0HZQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] reiserfs: Add security prefix to xattr name in reiserfs_security_write()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 31, 2023 at 8:33=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Reiserfs sets a security xattr at inode creation time in two stages: firs=
t,
> it calls reiserfs_security_init() to obtain the xattr from active LSMs;
> then, it calls reiserfs_security_write() to actually write that xattr.
>
> Unfortunately, it seems there is a wrong expectation that LSMs provide th=
e
> full xattr name in the form 'security.<suffix>'. However, LSMs always
> provided just the suffix, causing reiserfs to not write the xattr at all
> (if the suffix is shorter than the prefix), or to write an xattr with the
> wrong name.
>
> Add a temporary buffer in reiserfs_security_write(), and write to it the
> full xattr name, before passing it to reiserfs_xattr_set_handle().
>
> Also replace the name length check with a check that the full xattr name =
is
> not larger than XATTR_NAME_MAX.
>
> Cc: stable@vger.kernel.org # v2.6.x
> Fixes: 57fe60df6241 ("reiserfs: add atomic addition of selinux attributes=
 during inode creation")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/reiserfs/xattr_security.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This looks good to me, thanks.  While normally I would merge something
like this into the lsm/stable-X.Y branch, I'm going to merge it into
lsm/next to give it a week or two of extra testing.  I think anyone
who is using reiserfs+LSM (doubtful as it looks horribly broken) would
be okay with waiting a few more days at this point :)

--=20
paul-moore.com
