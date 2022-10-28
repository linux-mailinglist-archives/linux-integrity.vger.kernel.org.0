Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6247361138A
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Oct 2022 15:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ1NuB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Oct 2022 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJ1Ntl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Oct 2022 09:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5F1DC82A
        for <linux-integrity@vger.kernel.org>; Fri, 28 Oct 2022 06:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C753162884
        for <linux-integrity@vger.kernel.org>; Fri, 28 Oct 2022 13:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65285C433C1;
        Fri, 28 Oct 2022 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964884;
        bh=Q+kv2/bcn76gBJ6PIsT6BWrbZokAk6HrFoUW6700ZIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GE6j5Vo0d/OF8Sz8VI5xsgiuCWZ6Y2i3EsXJ+zsCwx28kD7/nDMKujg7QQm6J5Kbn
         kT6qaiqCqRaNWFhoishTYxIiLdwyIGnw7Ahp1rYaIwXQ6OAmwvEf7Lm9FbpxnFgJ03
         CO9muwlu7uL7QHCx+KgO+G+QHQX8y1Rb2O6q9/qKZhcOk0gi3HsJHKJLT/4eV8Fb1I
         OQ9wjMbFSwz1VK9efING/arJmhrK+d/f0xkQxJR5kwHcLMM0ws4QiWoLuc5L/5e+8P
         Nwe0MsKd7I+KyljOPHhc/DQRR5EVPIIUA0nXmnmSfnBBvyhSAu1UkjsudlopI3EJGV
         bnmj/ykkeGeJg==
Date:   Fri, 28 Oct 2022 15:47:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [bug report] integrity: implement get and set acl hook
Message-ID: <20221028134759.4eart2oqyclzfkuv@wittgenstein>
References: <Y1u3UBCL4ZHiq0oo@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1u3UBCL4ZHiq0oo@kili>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 28, 2022 at 02:04:48PM +0300, Dan Carpenter wrote:
> Hello Christian Brauner,
> 
> The patch e61b135f7bfe: "integrity: implement get and set acl hook"
> from Sep 22, 2022, leads to the following Smatch static checker
> warning:
> 
> 	security/integrity/evm/evm_main.c:687 evm_inode_set_acl()
> 	warn: duplicate check 'evm_status' (previous on line 661)
> 
> security/integrity/evm/evm_main.c
>     649 int evm_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
>     650                       const char *acl_name, struct posix_acl *kacl)
>     651 {
>     652         enum integrity_status evm_status;
>     653 
>     654         /* Policy permits modification of the protected xattrs even though
>     655          * there's no HMAC key loaded
>     656          */
>     657         if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
>     658                 return 0;
>     659 
>     660         evm_status = evm_verify_current_integrity(dentry);
>     661         if ((evm_status == INTEGRITY_PASS) ||
>     662             (evm_status == INTEGRITY_NOXATTRS))
>     663                 return 0;
> 
> If evm_status == INTEGRITY_PASS then this function returns here.
> 
>     664 
>     665         /* Exception if the HMAC is not going to be calculated. */
>     666         if (evm_hmac_disabled() && (evm_status == INTEGRITY_NOLABEL ||
>     667             evm_status == INTEGRITY_UNKNOWN))
>     668                 return 0;
>     669 
>     670         /*
>     671          * Writing other xattrs is safe for portable signatures, as portable
>     672          * signatures are immutable and can never be updated.
>     673          */
>     674         if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
>     675                 return 0;
>     676 
>     677         if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
>     678             !evm_inode_set_acl_change(mnt_userns, dentry, acl_name, kacl))
>     679                 return 0;
>     680 
>     681         if (evm_status != INTEGRITY_PASS &&
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Always true.
> 
>     682             evm_status != INTEGRITY_PASS_IMMUTABLE)
> 
> It feels like if evm_inode_set_acl_change() fails then it should trigger
> this audit message.  In other words just delete the if statement and
> always call integrity_audit_msg().
> 
>     683                 integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>     684                                     dentry->d_name.name, "appraise_metadata",
>     685                                     integrity_status_msg[evm_status],
>     686                                     -EPERM, 0);
> --> 687         return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is harmless dead code.  Just "return -EPERM;"
> 
>     688 }

Thanks for spotting this, Dan! I've added the following fix below to my
tree. If it shows no regression I'll likely fold it into the patch that
is fixed as we are pre -rc4 (Which is my somewhat arbitrarily chosen
cut-off point for rebases.):

From 16257cf6658d5bde2a055caf48f143c255abade7 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Oct 2022 15:41:31 +0200
Subject: [PATCH] evm: remove dead code in evm_inode_set_acl()

When evm_status is INTEGRITY_PASS then this function returns early and so
later codepaths that check for evm_status != INTEGRITY_PASS can be removed
as they are dead code.

Fixes: e61b135f7bfe ("integrity: implement get and set acl hook")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 security/integrity/evm/evm_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index e074c2b4d499..e01cfd4ad896 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -678,13 +678,12 @@ int evm_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	    !evm_inode_set_acl_change(mnt_userns, dentry, acl_name, kacl))
 		return 0;
 
-	if (evm_status != INTEGRITY_PASS &&
-	    evm_status != INTEGRITY_PASS_IMMUTABLE)
+	if (evm_status != INTEGRITY_PASS_IMMUTABLE)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
 				    -EPERM, 0);
-	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
+	return -EPERM;
 }
 
 static void evm_reset_status(struct inode *inode)
-- 
2.34.1

