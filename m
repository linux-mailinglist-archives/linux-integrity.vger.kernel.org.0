Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29CE20A63A
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406754AbgFYT4v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 15:56:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34258 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406569AbgFYT4v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 15:56:51 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C112520B7186;
        Thu, 25 Jun 2020 12:56:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C112520B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593115010;
        bh=sekTES5IzADnZwEMcNqxwil4AanF3Q2g56gRNKJ3GLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJZuTascxtrKzgUyovajscFvQQPGu4BdWCtyQ5AqM/SVwqn2GvbPaVAj+fq/7NakZ
         leRtf0ear/nVwUzL4sRJCdQBFDQpnLt6M+beXTBnw5h3PYagDZOnLq9ipfRfIJWn74
         2eHaEK8jIuvQfhO/TXrDLRaWusqHl3LES4tFHDLQ=
Date:   Thu, 25 Jun 2020 14:56:47 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/12] ima: Create a function to free a rule entry
Message-ID: <20200625195647.GB4694@sequoia>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
 <20200623003236.830149-3-tyhicks@linux.microsoft.com>
 <1593113613.27152.345.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1593113613.27152.345.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-06-25 15:33:33, Mimi Zohar wrote:
> On Mon, 2020-06-22 at 19:32 -0500, Tyler Hicks wrote:
> > There are several possible pieces of allocated memory in a rule entry.
> > Create a function that can free all allocated memory for a given rule
> > entry.
> > 
> > This patch introduces no functional changes but sets the groundwork for
> > some memory leak fixes.
> > 
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Having a function to release all memory associated with a policy rule
> in general is a good idea.  However, in the case of the shallow copy,
> we're not removing any IMA rules, just updating the LSM info.
> 
> There is an opportunity to transition from the builtin policy rules to
> a custom IMA policy.  Afterwards IMA policy rules may only be
> appended.
> 
> An IMA custom policy based on LSM info may be loaded prior to the LSM
> policy.  These LSM based rules are inactive until the corresponding
> LSM rule is loaded.  In some environments, LSM policies are loaded and
> removed frequently.  The IMA rules themselves are not removed, just
> the LSM info is updated to reflect the current LSM info.
> 
> > ---
> >  security/integrity/ima/ima_policy.c | 33 +++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 236a731492d1..1320333201c6 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -261,6 +261,27 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
> >  		security_filter_rule_free(entry->lsm[i].rule);
> >  		kfree(entry->lsm[i].args_p);
> >  	}
> > +}
> > +
> > +static void ima_free_rule(struct ima_rule_entry *entry)
> > +{
> > +	if (!entry)
> > +		return;
> > +
> > +	/*
> > +	 * entry->template->fields may be allocated in ima_parse_rule() but that
> > +	 * reference is owned by the corresponding ima_template_desc element in
> > +	 * the defined_templates list and cannot be freed here
> > +	 */
> > +
> > +	/*
> > +	 * When freeing newly added ima_rule_entry members, consider if you
> > +	 * need to disown any references after the shallow copy in
> > +	 * ima_lsm_copy_rule()
> > +	 */
> > +	kfree(entry->fsname);
> > +	kfree(entry->keyrings);
> > +	ima_lsm_free_rule(entry);
> >  	kfree(entry);
> >  }
> >  
> > @@ -298,10 +319,18 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> >  			pr_warn("rule for LSM \'%s\' is undefined\n",
> >  				(char *)entry->lsm[i].args_p);
> >  	}
> > +
> > +	/* Disown all references that were shallow copied */
> > +	entry->fsname = NULL;
> > +	entry->keyrings = NULL;
> > +	entry->template = NULL;
> >  	return nentry;
> >  
> >  out_err:
> > -	ima_lsm_free_rule(nentry);
> > +	nentry->fsname = NULL;
> > +	nentry->keyrings = NULL;
> > +	nentry->template = NULL;
> > +	ima_free_rule(nentry);
> 
> >  	return NULL;
> >  }
> >  
> > @@ -315,7 +344,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
> >  
> >  	list_replace_rcu(&entry->list, &nentry->list);
> >  	synchronize_rcu();
> > -	ima_lsm_free_rule(entry);
> > +	ima_free_rule(entry);
> 
> This should only update the LSM info, nothing else.

That's effectively what's happening since the fsname, keyrings, and
template pointers are being set to NULL, before exiting
ima_lsm_copy_rule(), in the ima_rule_entry that's going to be freed.

This patch is only introducing the function which can free all memory
associated with a rule and is starting to use it in place that a rule
entry is freed.

Would you rather me introduce ima_free_rule() for the upcoming memory
leak fixes in the series but not make use of it in
ima_lsm_update_rule()?

Tyler

> 
> >  
> >  	return 0;
> >  }
