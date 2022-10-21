Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B36078D9
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJUNrn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJUNrk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 09:47:40 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC03277A26;
        Fri, 21 Oct 2022 06:47:38 -0700 (PDT)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B96E1BF20B;
        Fri, 21 Oct 2022 13:47:32 +0000 (UTC)
Date:   Fri, 21 Oct 2022 15:47:31 +0200
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
Message-ID: <Y1Ki8838IAicXzlb@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
 <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

Thanks for the IMA/EVM project which I enjoy very much.

On Thu, Oct 20, 2022 at 03:51:38PM -0400, Mimi Zohar wrote:
> On Thu, 2022-10-20 at 15:55 +0200, Nicolas Bouchinet wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Fixes a NULL pointer dereference occuring in the
> > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > triggered if a `inode_init_security` hook returns 0 without initializing
> > the given `struct xattr` fields (which is the case of BPF) and if no
> > other LSM overrides thoses fields after. This also leads to memory
> > leaks.
> > 
> > Adds a `call_int_hook_xattr` macro that fetches and feed the
> > `new_xattrs` array with every called hook xattr values.
> > 
> > Adds a `evm_init_hmacs` function which init the EVM hmac using every
> > entry of the array contrary to `evm_init_hmac`.
>   
> Only EVM portable digital signatures include all of the protected
> xattrs.   Refer to commit 8c7a703ec978 ("evm: Verify portable
> signatures against all protected xattrs").
> 
Sorry, maybe I was not clear enough, the proposed patch does not change the
set of the protected security xattrs initialized by the LSMs and processed by EVM.

As I explained to Paul, based on my understanding, the `security_inode_init_security()`
hook is supposed to initialize every hooked LSM security xattr and next,
if evm is enabled, protect them using a HMAC algorithm.
However, in the current implementation, the use of the `call_int_hook()` macro by
`security_inode_init_security()` overwrites the previously initialized xattr for
each iteration of the `hlist_for_each_entry()` loop.

I have noticed that more than one LSM may initialize a security xattr at a time,
eg. SELinux + BPF.

IMHO my supplementary `evm_init_hmacs()` function name is a bit confusing, I would
enjoy if you have a better proposition. Note that `evm_init_hmacs()` have the same
behavior as `evm_init_hmac()` if only one security xattr is given as a parameter.

> > 
> > Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
> 
> Won't this break existing EVM hmac usage?
I might be wrong, but as far as I understand it, the only working condition for
EVM now is when only one security xattr is involved, otherwise there will have
a mismatch between the initialization and the verification.
Indeed, the verification takes into account every security xattr written in its
refering dentry.

> 
> -- 
> thanks,
> 
> Mimi
> 

Thanks for your time,
Best regards,

Nicolas Bouchinet
