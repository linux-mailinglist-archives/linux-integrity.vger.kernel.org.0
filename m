Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3056077EF
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJUNM3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 09:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJUNM2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 09:12:28 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18950371A5;
        Fri, 21 Oct 2022 06:12:15 -0700 (PDT)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 3D08A4000F;
        Fri, 21 Oct 2022 13:12:08 +0000 (UTC)
Date:   Fri, 21 Oct 2022 15:12:07 +0200
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, brauner@kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y1Kapxz65g+wlv8r@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
 <CAHC9VhS-RwQwg3o0+8n-UsqvhpR+WESOsFQ3T_ax1YWY51Eksw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS-RwQwg3o0+8n-UsqvhpR+WESOsFQ3T_ax1YWY51Eksw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, thank for your reply,

On Thu, Oct 20, 2022 at 11:02:07AM -0400, Paul Moore wrote:
> On Thu, Oct 20, 2022 at 9:55 AM Nicolas Bouchinet
> <nicolas.bouchinet@clip-os.org> wrote:
> >
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >
> > Fixes a NULL pointer dereference occuring in the
> > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > triggered if a `inode_init_security` hook returns 0 without initializing
> > the given `struct xattr` fields (which is the case of BPF) and if no
> > other LSM overrides thoses fields after. This also leads to memory
> > leaks.
> 
> You'll have to forgive me, my connection is poor at the moment and my
> time is limited, but why not simply add some additional checking at
> the top of evm_inode_init_security()? The LSM hook already memset()'s
> the passed lsm_attrs to zero so xattr::{name,value,value_len} should
> all be zero/NULL.  Can you help me understand why that is not
> possible?
> 
> Based on my current understanding, I believe this is something that
> should be addressed at the IMA/EVM level and not necessairly at the
> LSM layer.

The NULL pointer dereference occurs in the `evm_protected_xattr_common()`
function which was originaly called in `evm_inode_init_security()`. I
directly fixed this part at the `evm_inode_init_security()` level.

This patch also addresses other problems which partially occurs at the
`security_inode_init_security()` hook level.
More precisely, based on my understanding, the hook is supposed to initialize
every hooked LSM security xattr and next, if evm is enabled, protect them using 
a HMAC algorithm. However, in the current behavior the use of the
`call_int_hook()` macro by `security_inode_init_security()` overwrites the 
previously initialized xattr for each iteration of the `hlist_for_each_entry()`
loop. Thus, only the last security attribute is taken into account by
evm and freed. Checking the NULL pointer at evm level does not solve this
memory leak.

Based on other replies, I inlined the `call_int_hook()` macro directly into the
`security_inode_init_security()` hook.
> 
> > Adds a `call_int_hook_xattr` macro that fetches and feed the
> > `new_xattrs` array with every called hook xattr values.
> >
> > Adds a `evm_init_hmacs` function which init the EVM hmac using every
> > entry of the array contrary to `evm_init_hmac`.
> >
> > Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
> >
> > The `MAX_LSM_EVM_XATTR` value has been raised to 5 which gives room for
> > SMACK, SELinux, Apparmor, BPF and IMA/EVM security attributes.
> >
> > Changes the default return value of the `inode_init_security` hook
> > definition to `-EOPNOTSUPP`.
> >
> > Changes the hook documentation to match the behavior of the LSMs using
> > it (only xattr->value is initialised with kmalloc and thus is the only
> > one that should be kfreed by the caller).
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  include/linux/lsm_hook_defs.h       |  2 +-
> >  include/linux/lsm_hooks.h           |  4 ++--
> >  security/integrity/evm/evm.h        |  2 ++
> >  security/integrity/evm/evm_crypto.c | 23 ++++++++++++++++++++++-
> >  security/integrity/evm/evm_main.c   | 11 ++++++-----
> >  security/security.c                 | 29 ++++++++++++++++++++++++++---
> >  6 files changed, 59 insertions(+), 12 deletions(-)
> 
> -- 
> paul-moore.com

Thank for your time,

Best regards,

Nicolas Bouchinet
