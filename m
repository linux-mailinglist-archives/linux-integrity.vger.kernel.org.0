Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2B2047C5
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 05:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgFWDE3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 23:04:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39466 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbgFWDE2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 23:04:28 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id E02BB20B7192;
        Mon, 22 Jun 2020 20:04:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E02BB20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592881467;
        bh=381Z41lC2pIuRAjDOd1plbxk7DixDyCGV2sdQrwp2K8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF7DmQg0pl1+RSkVQ+UHXPhVzA05min9ZtgSAp4sjf9eiEZbWpW37yBlfH4Gs28JW
         0qObN7Q++fObJG1IT7S2kSL/nQAK+qLRq40yPxUbGqe7qmmxL7F9H+ILgRR4jYoKUY
         ERX66DrDmXerBOnmTGdDXf4AQUuQjrQQAd71dIPc=
Date:   Mon, 22 Jun 2020 22:04:10 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: Re: [PATCH 01/12] ima: Have the LSM free its audit rule
Message-ID: <20200623030410.GA6048@sequoia>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
 <20200623003236.830149-2-tyhicks@linux.microsoft.com>
 <277dd210-c443-c067-e731-44ac53418fa5@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277dd210-c443-c067-e731-44ac53418fa5@schaufler-ca.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-06-22 17:55:59, Casey Schaufler wrote:
> On 6/22/2020 5:32 PM, Tyler Hicks wrote:
> > Ask the LSM to free its audit rule rather than directly calling kfree().
> > Both AppArmor and SELinux do additional work in their audit_rule_free()
> > hooks. Fix memory leaks by allowing the LSMs to perform necessary work.
> >
> > Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > Cc: Janne Karhunen <janne.karhunen@gmail.com>
> > ---
> >  security/integrity/ima/ima.h        | 6 ++++++
> >  security/integrity/ima/ima_policy.c | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index df93ac258e01..de05d7f1d3ec 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -404,6 +404,7 @@ static inline void ima_free_modsig(struct modsig *modsig)
> >  #ifdef CONFIG_IMA_LSM_RULES
> >  
> >  #define security_filter_rule_init security_audit_rule_init
> > +#define security_filter_rule_free security_audit_rule_free
> >  #define security_filter_rule_match security_audit_rule_match
> 
> In context this seems perfectly reasonable. If, however, you're
> working with the LSM infrastructure this set of #defines is maddening.
> The existing ones have been driving my nuts for the past few years,
> so I'd like to discourage adding another. Since the security_filter_rule
> functions are IMA specific they shouldn't be prefixed security_. I know
> that it seems to be code churn/bikesheading, but we please change these:
> 
> static inline int ima_filter_rule_init(.....)
> {
> 	return security_audit_rule_init(.....);
> }
> 
> and so forth. I understand if you don't want to make the change.
> I have plenty of other things driving me crazy just now, so this
> doesn't seem likely to push me over the edge.

I'd be happy to take a stab at that as a follow-up or a 13/12 patch. I'd
like to leave this one as-is for stable kernel reasons since it is
straightforward and simple.

Tyler

> 
> >  
> >  #else
> > @@ -414,6 +415,11 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
> >  	return -EINVAL;
> >  }
> >  
> > +static inline void security_filter_rule_free(void *lsmrule)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> >  static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
> >  					     void *lsmrule)
> >  {
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index e493063a3c34..236a731492d1 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -258,7 +258,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
> >  	int i;
> >  
> >  	for (i = 0; i < MAX_LSM_RULES; i++) {
> > -		kfree(entry->lsm[i].rule);
> > +		security_filter_rule_free(entry->lsm[i].rule);
> >  		kfree(entry->lsm[i].args_p);
> >  	}
> >  	kfree(entry);
