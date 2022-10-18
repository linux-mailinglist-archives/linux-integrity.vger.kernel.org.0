Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5839C602FE1
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJRPjK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJRPi6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 11:38:58 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 08:38:56 PDT
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840B2BE51E;
        Tue, 18 Oct 2022 08:38:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MsHvN4lzDz9xFn1;
        Tue, 18 Oct 2022 23:33:36 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwC3PQRuyE5jwJgGAA--.16309S2;
        Tue, 18 Oct 2022 16:38:31 +0100 (CET)
Message-ID: <3935350428bf290e873d93d8a1f9c26b0e65979e.camel@huaweicloud.com>
Subject: Re: [PATCH 0/9] integrity: Move hooks into LSM
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Paul Moore <paul@paul-moore.com>, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 18 Oct 2022 17:38:19 +0200
In-Reply-To: <0a8f21a6-02de-36f0-7613-06ed3daf934b@digikod.net>
References: <20221013222702.never.990-kees@kernel.org>
         <0a8f21a6-02de-36f0-7613-06ed3daf934b@digikod.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwC3PQRuyE5jwJgGAA--.16309S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZry7Wr4DuFyrKF4kXr1rtFb_yoW5Gw18pF
        s3Ka43ur18JFya9F92v3W3u3W5K3yrWr1UWr13Ar10y3sIvF18Xr4UAry09Fy3WrWrAr12
        grsFgrn8Cr1DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
        z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UGYL9UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4BjQgAAsf
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-10-18 at 17:31 +0200, Mickaël Salaün wrote:
> There is a complementary patch series that didn't received review: 
> https://lore.kernel.org/all/20210427113732.471066-1-roberto.sassu@huawei.com/

Thanks Mickael, just pushed to Github the patch set you mentioned + IMA
on LSM infrastructure.

That patch set was a prerequisite: allowing multiple stacked LSMs to
provide an xattr at inode creation time.

Roberto

> On 14/10/2022 00:36, Kees Cook wrote:
> > Hi,
> > 
> > It's been over 4 years since LSM stack was introduced. The
> > integrity
> > subsystem is long overdue for moving to this infrastructure. Here's
> > my
> > first pass at converting integrity and ima (and some of evm) into
> > LSM
> > hooks. This should be enough of an example to finish evm, and
> > introduce
> > the missing hooks for both. For example, after this, it looks like
> > ima
> > only has a couple places it's still doing things outside of the
> > LSM. At
> > least these stood out:
> > 
> > fs/namei.c:     ima_post_create_tmpfile(mnt_userns, inode);
> > fs/namei.c:                             ima_post_path_mknod(mnt_use
> > rns, dentry);
> > 
> > Mimi, can you please take this series and finish the conversion for
> > what's missing in ima and evm?
> > 
> > I would also call attention to "175 insertions(+), 240 deletions(-
> > )" --
> > as expected, this is a net reduction in code.
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > Kees Cook (9):
> >    integrity: Prepare for having "ima" and "evm" available in
> > "integrity"
> >      LSM
> >    security: Move trivial IMA hooks into LSM
> >    ima: Move xattr hooks into LSM
> >    ima: Move ima_file_free() into LSM
> >    LSM: Introduce inode_post_setattr hook
> >    fs: Introduce file_to_perms() helper
> >    ima: Move ima_file_check() into LSM
> >    integrity: Move trivial hooks into LSM
> >    integrity: Move integrity_inode_get() out of global header
> > 
> >   fs/attr.c                             |  3 +-
> >   fs/file_table.c                       |  1 -
> >   fs/namei.c                            |  2 -
> >   fs/nfsd/vfs.c                         |  6 --
> >   include/linux/evm.h                   |  6 --
> >   include/linux/fs.h                    | 22 +++++++
> >   include/linux/ima.h                   | 87 ----------------------
> > -----
> >   include/linux/integrity.h             | 30 +--------
> >   include/linux/lsm_hook_defs.h         |  3 +
> >   security/Kconfig                      | 10 +--
> >   security/apparmor/include/file.h      | 18 ++----
> >   security/integrity/evm/evm_main.c     | 14 ++++-
> >   security/integrity/iint.c             | 28 +++++++--
> >   security/integrity/ima/ima.h          | 12 ++++
> >   security/integrity/ima/ima_appraise.c | 21 +++++--
> >   security/integrity/ima/ima_main.c     | 66 ++++++++++++++------
> >   security/integrity/integrity.h        |  8 +++
> >   security/security.c                   | 78 ++++++--------------
> > ----
> >   18 files changed, 175 insertions(+), 240 deletions(-)
> > 

