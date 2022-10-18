Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A97602FDE
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJRPiv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJRPiu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 11:38:50 -0400
X-Greylist: delayed 108362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 08:38:49 PDT
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A8ABCB93
        for <linux-integrity@vger.kernel.org>; Tue, 18 Oct 2022 08:38:48 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MsHsZ163mzMqN0w;
        Tue, 18 Oct 2022 17:32:02 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MsHsX4RHJzMppDd;
        Tue, 18 Oct 2022 17:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1666107122;
        bh=nHmKfmaafXkFdZ1cKaSMwMPaalSNB93vBG08IP5ymEI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d//1P7UDlfmXbLfumG+7GpwG1gBkOSiMcd7vK+r3gwZgQAcSVhG6f6IwKYD1ZZ14d
         jqolszIvuEQVXfMRDyH0EwIRyfEYgrtiqXAxlJDrhSuFRhyTkFDamwfwwcejzkTA09
         0osNI20uMpVmFVF26H9VTbG+/aGTP8ScmL90w/3A=
Message-ID: <0a8f21a6-02de-36f0-7613-06ed3daf934b@digikod.net>
Date:   Tue, 18 Oct 2022 17:31:59 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 0/9] integrity: Move hooks into LSM
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Paul Moore <paul@paul-moore.com>, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20221013222702.never.990-kees@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is a complementary patch series that didn't received review: 
https://lore.kernel.org/all/20210427113732.471066-1-roberto.sassu@huawei.com/

On 14/10/2022 00:36, Kees Cook wrote:
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
> 
> -Kees
> 
> Kees Cook (9):
>    integrity: Prepare for having "ima" and "evm" available in "integrity"
>      LSM
>    security: Move trivial IMA hooks into LSM
>    ima: Move xattr hooks into LSM
>    ima: Move ima_file_free() into LSM
>    LSM: Introduce inode_post_setattr hook
>    fs: Introduce file_to_perms() helper
>    ima: Move ima_file_check() into LSM
>    integrity: Move trivial hooks into LSM
>    integrity: Move integrity_inode_get() out of global header
> 
>   fs/attr.c                             |  3 +-
>   fs/file_table.c                       |  1 -
>   fs/namei.c                            |  2 -
>   fs/nfsd/vfs.c                         |  6 --
>   include/linux/evm.h                   |  6 --
>   include/linux/fs.h                    | 22 +++++++
>   include/linux/ima.h                   | 87 ---------------------------
>   include/linux/integrity.h             | 30 +--------
>   include/linux/lsm_hook_defs.h         |  3 +
>   security/Kconfig                      | 10 +--
>   security/apparmor/include/file.h      | 18 ++----
>   security/integrity/evm/evm_main.c     | 14 ++++-
>   security/integrity/iint.c             | 28 +++++++--
>   security/integrity/ima/ima.h          | 12 ++++
>   security/integrity/ima/ima_appraise.c | 21 +++++--
>   security/integrity/ima/ima_main.c     | 66 ++++++++++++++------
>   security/integrity/integrity.h        |  8 +++
>   security/security.c                   | 78 ++++++------------------
>   18 files changed, 175 insertions(+), 240 deletions(-)
> 
