Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96055425028
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Oct 2021 11:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbhJGJgi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Oct 2021 05:36:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49216 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbhJGJgg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Oct 2021 05:36:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C14122636;
        Thu,  7 Oct 2021 09:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633599282;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCNTuDA86Yx9mhczyzKj3htwjs7J498UQ14YZsykrCc=;
        b=v8MxO+Z9+wZUj7kyZJZZsj43QSOA9qP8qdBGZl5KhBakBb7WMCMhTbzUmV47v8QXhJ2oWM
        pBqiJhqVd6bMgwVAEiAiWHGuEF2m9gFUztFOePARjtQNtjj61/c6ivM75N0s9OUt48w1+8
        PRgbeSewhDMCZ5Onub5cHBZiqF5ZMaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633599282;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCNTuDA86Yx9mhczyzKj3htwjs7J498UQ14YZsykrCc=;
        b=a9zOJ7KaE5DQmuYtspuTo/lmPqddlua1mL5oSf3SZJW0w69HoBw70k2NYJyOP15DSxgVm5
        W6HJCzjjzGnSWxAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1071E13513;
        Thu,  7 Oct 2021 09:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eu7CATK/XmGfNwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 07 Oct 2021 09:34:42 +0000
Date:   Thu, 7 Oct 2021 11:34:40 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Alex Henrie <alexh@vpitech.com>, linux-integrity@vger.kernel.org,
        alexhenrie24@gmail.com, Curtis Veit <veit@vpieng.com>
Subject: Re: [PATCH v2] ima: add gid support
Message-ID: <YV6/MBZzZ5GS+MCv@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211005003237.501882-1-alexh@vpitech.com>
 <81863154aebf9d3e023bd37acca8ff265a187fd0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81863154aebf9d3e023bd37acca8ff265a187fd0.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex, Mimi,

> Hi Alex,

> On Mon, 2021-10-04 at 18:32 -0600, Alex Henrie wrote:
> > From: Curtis Veit <veit@vpieng.com>

> > IMA currently supports the concept of rules based on uid where the rule
> > is based on the uid of the file owner or the uid of the user accessing
> > the file. It is useful to have similar rules based on gid. This patch
> > provides that ability.

> > Signed-off-by: Curtis Veit <veit@vpieng.com>
> > Co-developed-by: Alex Henrie <alexh@vpitech.com>
> > Signed-off-by: Alex Henrie <alexh@vpitech.com>
> > ---
> > v2: Trivial changes that Mimi requested

> Sorry, scripts/check-patch.pl reported some warnings.  Two more trivial changes.

> > ---
> >  Documentation/ABI/testing/ima_policy |   8 +-
> >  security/integrity/ima/ima_policy.c  | 201 +++++++++++++++++++++++----
> >  2 files changed, 180 insertions(+), 29 deletions(-)

> > diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> > index 5c2798534950..e1a04bd3b9e5 100644
> > --- a/Documentation/ABI/testing/ima_policy

> > @@ -78,9 +81,13 @@ struct ima_rule_entry {
> >  	unsigned long fsmagic;
> >  	uuid_t fsuuid;
> >  	kuid_t uid;
> > +	kgid_t gid;
> >  	kuid_t fowner;
> > +	kgid_t fgroup;
> >  	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
> > +	bool (*gid_op)(kgid_t, kgid_t);
> >  	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
> > +	bool (*fgroup_op)(kgid_t, kgid_t); /* gid_eq(), gid_gt(), gid_lt() */

> scripts/checkpatch.pl complains about missing variables.
+1

> >  	int pcr;
> >  	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
> >  	struct {

> > @@ -582,10 +590,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
> >  		} else if (!rule->uid_op(cred->euid, rule->uid))
> >  			return false;
> >  	}
> > -
> > +	if ((rule->flags & IMA_GID) && !rule->gid_op(rule->gid, cred->gid))

> All of uid_op/gid_op calls in ima_match_rules() pass the "cred->xxxx,
> rule->xxx" except here, where it is rule->gid, cred->rule.   Reversing
> the parameters here will help with addressing the checkpatch.pl
> warning.
+1

Apart from those checkpatch issues patch LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> thanks,

> Mimi

