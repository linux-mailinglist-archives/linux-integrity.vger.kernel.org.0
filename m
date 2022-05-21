Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505C352F7DB
	for <lists+linux-integrity@lfdr.de>; Sat, 21 May 2022 05:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiEUDH3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 23:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiEUDH1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 23:07:27 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419851ADA5;
        Fri, 20 May 2022 20:07:25 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id C2F2A3F4; Fri, 20 May 2022 22:07:23 -0500 (CDT)
Date:   Fri, 20 May 2022 22:07:23 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 04/26] ima: Move arch_policy_entry into ima_namespace
Message-ID: <20220521030723.GF9107@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-5-stefanb@linux.ibm.com>
 <20220521024633.GB9107@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521024633.GB9107@mail.hallyn.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 20, 2022 at 09:46:33PM -0500, Serge E. Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:11AM -0400, Stefan Berger wrote:
> > The architecture-specific policy rules, currently defined for EFI and
> > powerpc, require the kexec kernel image and kernel modules to be
> > validly signed and measured, based on the system's secure boot and/or
> > trusted boot mode and the IMA_ARCH_POLICY Kconfig option being enabled.
> > 
> > To avoid special-casing init_ima_ns as much as possible, move the
> > arch_policy_entry into the ima_namespace.
> > 
> > When freeing the arch_policy_entry set the pointer to NULL.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima.h             |  3 +++
> >  security/integrity/ima/ima_init_ima_ns.c |  1 +
> >  security/integrity/ima/ima_policy.c      | 23 +++++++++++------------
> >  3 files changed, 15 insertions(+), 12 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index 9bcde1a24e74..2305bf223a98 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -125,6 +125,9 @@ struct ima_namespace {
> >  
> >  	struct list_head __rcu *ima_rules;  /* Pointer to the current policy */
> >  	int ima_policy_flag;
> > +
> > +	/* An array of architecture specific rules */
> > +	struct ima_rule_entry *arch_policy_entry;
> >  } __randomize_layout;
> >  extern struct ima_namespace init_ima_ns;
> >  
> > diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> > index c919a456b525..ae33621c3955 100644
> > --- a/security/integrity/ima/ima_init_ima_ns.c
> > +++ b/security/integrity/ima/ima_init_ima_ns.c
> > @@ -15,6 +15,7 @@ static int ima_init_namespace(struct ima_namespace *ns)
> >  	INIT_LIST_HEAD(&ns->ima_temp_rules);
> >  	ns->ima_rules = (struct list_head __rcu *)(&ns->ima_default_rules);
> >  	ns->ima_policy_flag = 0;
> > +	ns->arch_policy_entry = NULL;
> >  
> >  	return 0;
> >  }
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 69b19f4d5fee..0a7c61ca3265 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -228,9 +228,6 @@ static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
> >  	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
> >  };
> >  
> > -/* An array of architecture specific rules */
> > -static struct ima_rule_entry *arch_policy_entry __ro_after_init;
> > -
> >  static int ima_policy __initdata;
> >  
> >  static int __init default_measure_policy_setup(char *str)
> > @@ -859,9 +856,10 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
> >  	for (rules = arch_rules; *rules != NULL; rules++)
> >  		arch_entries++;
> >  
> > -	arch_policy_entry = kcalloc(arch_entries + 1,
> > -				    sizeof(*arch_policy_entry), GFP_KERNEL);
> > -	if (!arch_policy_entry)
> > +	ns->arch_policy_entry = kcalloc(arch_entries + 1,
> > +					sizeof(*ns->arch_policy_entry),
> > +					GFP_KERNEL);
> > +	if (!ns->arch_policy_entry)
> >  		return 0;
> >  
> >  	/* Convert each policy string rules to struct ima_rule_entry format */
> > @@ -871,13 +869,13 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
> >  
> >  		result = strscpy(rule, *rules, sizeof(rule));
> >  
> > -		INIT_LIST_HEAD(&arch_policy_entry[i].list);
> > -		result = ima_parse_rule(ns, rule, &arch_policy_entry[i]);
> > +		INIT_LIST_HEAD(&ns->arch_policy_entry[i].list);
> > +		result = ima_parse_rule(ns, rule, &ns->arch_policy_entry[i]);
> >  		if (result) {
> >  			pr_warn("Skipping unknown architecture policy rule: %s\n",
> >  				rule);
> > -			memset(&arch_policy_entry[i], 0,
> > -			       sizeof(*arch_policy_entry));
> > +			memset(&ns->arch_policy_entry[i], 0,
> > +			       sizeof(ns->arch_policy_entry[i]));
> >  			continue;
> >  		}
> >  		i++;
> > @@ -925,7 +923,7 @@ void __init ima_init_policy(struct ima_namespace *ns)
> >  	if (!arch_entries)
> >  		pr_info("No architecture policies found\n");
> >  	else
> > -		add_rules(ns, arch_policy_entry, arch_entries,
> > +		add_rules(ns, ns->arch_policy_entry, arch_entries,
> >  			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
> >  
> >  	/*
> > @@ -1005,7 +1003,8 @@ void ima_update_policy(struct ima_namespace *ns)
> >  		 * on boot.  After loading a custom policy, free the
> >  		 * architecture specific rules stored as an array.
> >  		 */
> > -		kfree(arch_policy_entry);
> > +		kfree(ns->arch_policy_entry);
> > +		ns->arch_policy_entry = NULL;
> 
> So the thing that prevents multiple racing occurances of the above two lines is
> that ima_open_policy() sets IMA_FS_BUSY (or returns EBUSY) and then removes
> this file before clearing the flag, right?

(To correct the above: ima_update_policy completes before the flag is
cleared.  The file is not removed in all cases but that's ok.)

> Seems good.
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> 
> >  	}
> >  	ima_update_policy_flags(ns);
> >  
> > -- 
> > 2.34.1
