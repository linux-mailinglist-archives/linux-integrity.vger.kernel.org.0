Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3760CD92
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 15:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiJYNd6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Oct 2022 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiJYNd6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Oct 2022 09:33:58 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC5C18B095;
        Tue, 25 Oct 2022 06:33:55 -0700 (PDT)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id CB59C1BF219;
        Tue, 25 Oct 2022 13:33:49 +0000 (UTC)
Date:   Tue, 25 Oct 2022 15:33:48 +0200
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, brauner@kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y1flvA2hJn2pNSiJ@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
 <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
 <Y1Ki8838IAicXzlb@archlinux>
 <8607d166bbd2f32f1e71e5d7ce40b937eaeb410b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8607d166bbd2f32f1e71e5d7ce40b937eaeb410b.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi !

On Mon, Oct 24, 2022 at 12:35:52PM -0400, Mimi Zohar wrote:
> Hi Nicolas,
> 
> On Fri, 2022-10-21 at 15:47 +0200, Nicolas Bouchinet wrote:
> > Hi Mimi,
> > 
> > Thanks for the IMA/EVM project which I enjoy very much.
> > 
> > On Thu, Oct 20, 2022 at 03:51:38PM -0400, Mimi Zohar wrote:
> > > On Thu, 2022-10-20 at 15:55 +0200, Nicolas Bouchinet wrote:
> > > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > > 
> > > > Fixes a NULL pointer dereference occuring in the
> > > > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > > > triggered if a `inode_init_security` hook returns 0 without initializing
> > > > the given `struct xattr` fields (which is the case of BPF) and if no
> > > > other LSM overrides thoses fields after. This also leads to memory
> > > > leaks.
> > > > 
> > > > Adds a `call_int_hook_xattr` macro that fetches and feed the
> > > > `new_xattrs` array with every called hook xattr values.
> > > > 
> > > > Adds a `evm_init_hmacs` function which init the EVM hmac using every
> > > > entry of the array contrary to `evm_init_hmac`.
> > >   
> > > Only EVM portable digital signatures include all of the protected
> > > xattrs.   Refer to commit 8c7a703ec978 ("evm: Verify portable
> > > signatures against all protected xattrs").
> > > 
> > Sorry, maybe I was not clear enough, the proposed patch does not change the
> > set of the protected security xattrs initialized by the LSMs and processed by EVM.
> > 
> > As I explained to Paul, based on my understanding, the `security_inode_init_security()`
> > hook is supposed to initialize every hooked LSM security xattr and next,
> > if evm is enabled, protect them using a HMAC algorithm.
> > However, in the current implementation, the use of the `call_int_hook()` macro by
> > `security_inode_init_security()` overwrites the previously initialized xattr for
> > each iteration of the `hlist_for_each_entry()` loop.
> > 
> > I have noticed that more than one LSM may initialize a security xattr at a time,
> > eg. SELinux + BPF.
> 
> Does BPF have a security xattr and, if so, does it need to be
> protected?   It would need to be defined and included in the list of
> evm_config_xattrnames[].  If it doesn't define a security bpf xattr,
> then bpf should not be on the security_inode_init_security() hook.  (I
> assume Roberto's patch is going in this direction.)
> 
> Before the EVM hmac is updated, the existing EVM hmac is verified.  I
> would be concerned if bpf defined a protected security xattr.   Could
> the same guarantees, that security.evm isn't updated without first
> being verified, be enforced with bpf?
> 

I am not that comfortable with BPF programs but based on what Alexei Starovoitov pointed out here
https://lore.kernel.org/bpf/20221021164626.3729012-1-roberto.sassu@huaweicloud.com
BPF should not be able to write into the xattrs pointers. And thus shouldn't be included
in `evm_config_xattrnames[]`.
> > 
> > IMHO my supplementary `evm_init_hmacs()` function name is a bit confusing, I would
> > enjoy if you have a better proposition. Note that `evm_init_hmacs()` have the same
> > behavior as `evm_init_hmac()` if only one security xattr is given as a parameter.
> 
> I'm missing something here.  As evm_inode_init_security() is the only
> caller of evm_init_hmac(), why is a new function defined instead of
> updating the existing one?   If there is a valid reason, then one
> function should be a wrapper for the other.
> 

There is no valid reasons, I was just unsure about replacing existing functions, will update it.
> > > > 
> > > > Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
> > > 
> > > Won't this break existing EVM hmac usage?
> > I might be wrong, but as far as I understand it, the only working condition for
> > EVM now is when only one security xattr is involved, otherwise there will have
> > a mismatch between the initialization and the verification.
> > Indeed, the verification takes into account every security xattr written in its
> > refering dentry.
> 
> Agreed, independently as to whether BPF defines a security xattr, if
> two LSMs initialize security xattrs, then this change is needed.  Are
> there any other examples?

I think that in its current state the kernel cannot load two LSM capable of xattr
initialization as they are all defined with the `LSM_FLAG_EXCLUSIVE` flag set.
But I may be unaware of other LSM in development stage.
> 
> (nit: I understand the line size has generally been relaxed, but for
> IMA/EVM I would prefer it to be remain as 80 chars.)
> 

No problem, will change it !
> Mimi
> 

I'll take time to run few tests with BPF and send a patch v3 with new changes.

Regards,

Nicolas Bouchinet
