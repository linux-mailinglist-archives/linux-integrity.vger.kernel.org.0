Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF2223352E
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgG3PRo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 11:17:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57242 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3PRn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 11:17:43 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 08FA720B4908;
        Thu, 30 Jul 2020 08:17:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08FA720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596122262;
        bh=chuxueXiJYAb49gdQ/DyVhAD0F/IUtsU0rnfXmoh93o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0OeS5bIW/JKqBnHQCWdUQRYabRb58cp5QC+Jow3Q3MPc9EFP2DYcsEImKbrG6bAA
         NaZIdb+rKWXVwfis6TD1lR5+ksG+CVJRC0TP/uv1uyzfO88bb75mrpn/j51M0Grrhj
         29RhDEg1oPrkKjFv8ztm0U9R9pewO0iCrvTcBUg4=
Date:   Thu, 30 Jul 2020 10:17:40 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] IMA: Add func to measure LSM state and policy
Message-ID: <20200730151740.GX4181@sequoia>
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-2-nramas@linux.microsoft.com>
 <20200730150228.GV4181@sequoia>
 <c2f0c4cc-67a9-d467-1b2c-7edaea47c9d6@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f0c4cc-67a9-d467-1b2c-7edaea47c9d6@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-30 08:15:34, Lakshmi Ramasubramanian wrote:
> On 7/30/20 8:02 AM, Tyler Hicks wrote:
> 
> > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > index 07f033634b27..a0f5c39d9084 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> > > @@ -442,13 +442,20 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> > >   {
> > >   	int i;
> > > -	if (func == KEY_CHECK) {
> > > -		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
> > > -		       ima_match_keyring(rule, keyring, cred);
> > > -	}
> > >   	if ((rule->flags & IMA_FUNC) &&
> > >   	    (rule->func != func && func != POST_SETATTR))
> > >   		return false;
> > > +
> > > +	switch (func) {
> > > +	case KEY_CHECK:
> > > +		return ima_match_keyring(rule, keyring, cred);
> > > +	case LSM_STATE:
> > > +	case LSM_POLICY:
> > > +		return true;
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > >   	if ((rule->flags & IMA_MASK) &&
> > >   	    (rule->mask != mask && func != POST_SETATTR))
> > >   		return false;
> > > @@ -1044,6 +1051,18 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> > >   		if (ima_rule_contains_lsm_cond(entry))
> > >   			return false;
> > > +		break;
> > > +	case LSM_STATE:
> > > +	case LSM_POLICY:
> > > +		if (entry->action & ~(MEASURE | DONT_MEASURE))
> > > +			return false;
> > > +
> > > +		if (entry->flags & ~(IMA_FUNC | IMA_PCR))
> > > +			return false;
> > > +
> > > +		if (ima_rule_contains_lsm_cond(entry))
> > > +			return false;
> > > +
> > >   		break;
> > >   	default:
> > >   		return false;
> > > @@ -1176,6 +1195,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> > >   				entry->func = KEXEC_CMDLINE;
> > >   			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
> > >   				entry->func = KEY_CHECK;
> > > +			else if (strcmp(args[0].from, "LSM_STATE") == 0)
> > > +				entry->func = LSM_STATE;
> > > +			else if (strcmp(args[0].from, "LSM_POLICY") == 0)
> > > +				entry->func = LSM_POLICY;
> > 
> > This patch generally looks really good to me with the exception of one
> > thing...
> > 
> > We should only accept rules with these specified hook functions when an
> > LSM that has measurement support is enabled. This messes up the ordering
> > of your patch series but it could be as simple as doing this:
> > 
> > 			else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
> > 				 strcmp(args[0].from, "LSM_STATE") == 0)
> > 				 entry->func = LSM_STATE;
> > 
> > Or you could do something a little more complex, like what's done with
> > CONFIG_IMA_LSM_RULES. You could create a CONFIG_IMA_MEASURE_LSM option
> > that's default enabled but depends on CONFIG_SECURITY_SELINUX and then
> > check for IS_ENABLED(CONFIG_IMA_MEASURE_LSM) in ima_parse_rule().
> > 
> > I'd personally opt for just placing the
> > IS_ENABLED(CONFIG_SECURITY_SELINUX) check directly into
> > ima_parse_rule().
> > 
> 
> The LSM hook can be used by any security module (not just SELinux) to
> measure their data.
> 
> I have implemented measurement in SELinux to illustrate the usage. Maybe, I
> can add the check you have suggested for now and when more security modules
> start using this IMA policy additional checks can be added as appropriate.

Yes, that's what I envision.

The main idea is that there's negative feedback to userspace when IMA
can't possibly do anything with an LSM_STATE/LSM_POLICY rule.

Tyler

> 
> thanks,
>  -lakshmi
