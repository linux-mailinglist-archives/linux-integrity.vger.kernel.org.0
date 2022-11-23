Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35FF635EB3
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 13:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiKWM6E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 07:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiKWM5X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 07:57:23 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344AB238;
        Wed, 23 Nov 2022 04:45:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NHLK31bmvz9xFQl;
        Wed, 23 Nov 2022 20:38:47 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAnDvrOFX5ju+aJAA--.57342S2;
        Wed, 23 Nov 2022 13:45:14 +0100 (CET)
Message-ID: <22f47b9d2cade322f9037133b0940640423f9590.camel@huaweicloud.com>
Subject: Re: [PATCH v5 0/6] evm: Prepare for moving to the LSM infrastructure
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 23 Nov 2022 13:44:57 +0100
In-Reply-To: <ccf1937cfdcc5bb28dcc7a58785dd0c65d974597.camel@linux.ibm.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
         <ccf1937cfdcc5bb28dcc7a58785dd0c65d974597.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAnDvrOFX5ju+aJAA--.57342S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWkAFyrZr18Zw1rAr4xJFb_yoW8tr48pF
        WfKa4YqFs5tF1xJ3s7Ar4xZ3yUC3yfGw4UKa4DCrykZ3Z0grySgryS9FWFva4kWrsYga1q
        qF4jv34kJws8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4HJfQABsG
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-11-23 at 07:28 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Wed, 2022-11-23 at 10:51 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > One of the challenges that must be tackled to move IMA and EVM to the LSM
> > infrastructure is to ensure that EVM is capable to correctly handle
> > multiple stacked LSMs providing an xattr at file creation. At the moment,
> > there are few issues that would prevent a correct integration. This patch
> > set aims at solving them.
> 
> Let's take a step back and understand the purpose of this patch set. 
> Regardless of whether IMA and EVM are moved to the "LSM
> infrastructure", EVM needs to support per LSM xattrs.  A side affect is
> the removal of the security_old_inode_init_security hook.  This patch
> set cover letter and patch descriptions should be limited to EVM
> support for per LSM (multiple) xattrs.  The motivation, concerns, and
> problems of making IMA and EVM LSMs will be documented in the patch set
> that actual makes them LSMs.  Please remove all references to "move IMA
> and EVM to the LSM infrastructure".

Hi Mimi

ok, will do.

> When EVM was upstreamed, there were filesystem limitations on the
> number and size of the extended attributes.  In addition there were
> performance concerns, which resulted in staging the LSM, IMA and EVM
> xattrs, before calling initxattrs to write them at the same time.  With
> this patch set, not only are per LSM xattrs supported, but multiple per
> LSM xattrs are supported as well.  Have the size limitation concerns
> been addressed by the different filesystems?   If not, then at minimum
> this patch set needs to at least mention it and the possible
> ramifications.

With your patch, 9d8f13ba3f483 ("security: new
security_inode_init_security API adds function callback") you made it
possible to set multiple xattrs at inode creation time.

This patch set pushes further to the limits, as there could be more
xattrs to be added to the inode. I will mention that.

If there are too many xattrs, I guess the only solution would be to use
less LSMs, or a different filesystem. The per filesystem limit could be
increased separately case by case.

Thanks

Roberto

