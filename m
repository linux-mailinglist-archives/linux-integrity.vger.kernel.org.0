Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20509617FA0
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKCOc5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKCOc4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 10:32:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C904178B7
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 07:32:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EA8021C7A;
        Thu,  3 Nov 2022 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667485971;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fEKvxK4h0LbkgHCW7eTG4Re1NecvnHtIX+afxLL3tWM=;
        b=cG+bJk/sROMpfOaypVyvprPBQZ6SAWkR5USJSXjNxvFRhh7XLdQC+4B+84a9joItu4uShV
        XDMd7bvZ1PqPmAcSHvnzANjW7/fMzFdR77tTy6axMEi+k6yH7/D5lA8XEUtRBbcn9klnKT
        yObNqMgrNSYTJSYbUUtBJUEikwzPX2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667485971;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fEKvxK4h0LbkgHCW7eTG4Re1NecvnHtIX+afxLL3tWM=;
        b=vP+voFWSZI3wv7/rvNie5RpZQIBIUdrUMqNcSxZNkWZgNpWsX+3KzRD4SQC+ltAJrmwO4e
        HWsU5bLCY5MrbqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE23413AAF;
        Thu,  3 Nov 2022 14:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3cZvNBLRY2OWAQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 03 Nov 2022 14:32:50 +0000
Date:   Thu, 3 Nov 2022 15:32:48 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH ima-evm-utils v4 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
Message-ID: <Y2PREKTdNQhwhPEK@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
 <20221101201803.372652-2-zohar@linux.ibm.com>
 <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
 <145f4c70ec894c4980d9455485cdac4673e01d04.camel@linux.ibm.com>
 <52e19952-a1c3-722e-2267-a625e16c37a2@linux.ibm.com>
 <4db89eab7d21124aa7945ccf4fd150c3ee4d259c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db89eab7d21124aa7945ccf4fd150c3ee4d259c.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Tue, 2022-11-01 at 20:25 -0400, Stefan Berger wrote:

> > On 11/1/22 19:04, Mimi Zohar wrote:
> > > Hi Stefan,

> > > On Tue, 2022-11-01 at 17:46 -0400, Stefan Berger wrote:

> > >> On 11/1/22 16:17, Mimi Zohar wrote:
> > >>> This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.

> > >> $ git show acb19d1
> > >> fatal: ambiguous argument 'acb19d1': unknown revision or path not in the working tree.

> > >> Are you reverting this from a public tree? or could you just drop this patch from your series?

> > >> Also after removing this patch from the mbox file I cannot apply these patches to my sourceforge checkout -- presumably next-testing branch:

> > >> $ git am ./v4_20221101_zohar_address_deprecated_warnings.mbx
> > >> Applying: log and reset 'errno' after failure to open non-critical files
> > >> Applying: Log and reset 'errno' on lsetxattr failure
> > >> Applying: travis: update dist=focal
> > >> Applying: Update configure.ac to address a couple of obsolete warnings
> > >> Applying: Deprecate IMA signature version 1
> > >> error: patch failed: src/libimaevm.c:684
> > >> error: src/libimaevm.c: patch does not apply
> > >> Patch failed at 0005 Deprecate IMA signature version 1
> > >> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > >> When you have resolved this problem, run "git am --continue".
> > >> If you prefer to skip this patch, run "git am --skip" instead.
> > >> To restore the original branch and stop patching, run "git am --abort".

> > > Sorry, I should have used "--base=auto" when generating the patch set.
> > > Yes, the patch set is based on the github next-testing branch.


> > Is the github repo now the main repo and sourceforge repo is dead?

> The "next" branch in both repo's are the same.  Before posting patches,
> I verify that github Actions works.   As a result, the next-testing
> branch on github is rebased frequently.  Once a patch set is ready, the
> "next" branch in both repo's is updated.

> To answer your question the github repo is primary.
Maybe deleting everything in sourceforge and ad put single file with link to
github.com would save you work (having master, next and next-testing branches
with this file).

Kind regards,
Petr

> Mimi

