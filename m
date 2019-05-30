Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F842FB6C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2019 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfE3MHw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 May 2019 08:07:52 -0400
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:5864 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfE3MHw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 May 2019 08:07:52 -0400
X-EEMSG-check-017: 218180233|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 May 2019 12:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559218046; x=1590754046;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vw8k6X9AZfC7QqqSg/maX61CSRpZFfNVIw9J5/4v6/o=;
  b=IrV4n2gKIQ2NBF0DELVjnKaCyCUs/nRUj3m+2eYz6IvZgtATCWt8/20e
   Tj/L6GXHPcY4k5wYlqxER+htK7MsW6AFnM2bfO7ZT7l6bJJg45uFs8FfH
   M3XU7EYpkg52V2PM/Y/Au+CfaOBKJzpZVildRqwfb+YwnkpsZIyYKRyCO
   SRnswGEOSoGAkx/r8HVPyTe6j7qbZBzzPlTT3dgwbrOjnJI+q0BwMFLPo
   tgNPh9G+sHQVlMc3HgX2pAliFKivaiQ81efYscCPvRDNZYU6hhT10Q46B
   uTqNpiVonh8ZHssSTejbHqGRlO26ThIKu7IbyGHg4pncylMtPhvQjEOib
   g==;
X-IronPort-AV: E=Sophos;i="5.60,531,1549929600"; 
   d="scan'208";a="28332329"
IronPort-PHdr: =?us-ascii?q?9a23=3AdqT+RRW/pAztjgO5R3f8MHsJwsLV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRWDtadThVPEFb/W9+hDw7KP9fy5ACpZu8fK7C9KWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sBjdutMLjYd8Lqs9xR?=
 =?us-ascii?q?TEr3lVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWhBOfixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTrUTCETP2mEXxlqOWcFkr+vO05Oj9Z7Xmp5ucO5d1igH4LKsuhtSyDfk3Pw?=
 =?us-ascii?q?UBRWSW+fmw2Kf98UD2XrlGlOA6nrHcsJ/AJMQboqC5AxVS0oYm8xu/FCqp0M?=
 =?us-ascii?q?8DkHkbLFNKZBKHj4/zN1HIO/D3F+2zg1urkDd13/zGJKHuAo3RLnjfl7fsZb?=
 =?us-ascii?q?R95FRayAo1099T/ZFUBasbIPLzR0/xssLXDhkiPgy7xuboEtR91ocEVW2TBa?=
 =?us-ascii?q?+ZNbvYsUWU6eI3P+mMeIgVtS78Kvgi5/7hl2U5lEQZfamo25sXdX+5Eu5nI0?=
 =?us-ascii?q?qCZHrgmMsOEWAPvgAmVuzllEWCUSJPZ3a1R688/is0CJ+iDYrYXoCimqGB3C?=
 =?us-ascii?q?OiEp1TYWBGDUqMHmnye4qYXPcMbTqYItV9nTwcSbihV4gh2AmqtA/7zbpnM+?=
 =?us-ascii?q?XV9jQZtZLlyNh6+eLTlQsz9TxoD8WQyH+NT25qkWMSXTM2375woVZ7ylid1a?=
 =?us-ascii?q?h0mftYFcZc5/lRSAc1KYbcz/BmC9D1Qg/BetaJSFC7QtSpGD0xVcw+zMMTY0?=
 =?us-ascii?q?ZnGtWikhDC0zOvA78SirOLGZg0/bzH0njvKMZy1WzG2LMij1Y4WMtPM3Ophq?=
 =?us-ascii?q?pl+wjUHY7JnF2Tl7y2eqQEwC7N6GCDwHKTs05CVg5wULvKXXQdZkbNqNT2+E?=
 =?us-ascii?q?fCT7u0BrQhNQtAxtSOJbdNat3s3h16Q6LBMdLYbiqSkn2wGBCFwPvYboPsfW?=
 =?us-ascii?q?hb3yzHCFUCngY78nOPNAx4DSCk9THwFjtrQGnzblvs/O82k3aySks53knedE?=
 =?us-ascii?q?F6/6ak8R4Sw/qHQrUc2axS63RpkCl9AFvoh4GeMNGHvQc0OfwBMN4=3D?=
X-IPAS-Result: =?us-ascii?q?A2BgCgCnxu9c/wHyM5BlHgEGBwaBZYEqAjsqgToBMiiEF?=
 =?us-ascii?q?JMCUgaBECWJUIlwhxYJAQEBAQEBAQEBNAECAQGEQAKCfSM4EwEDAQEBBAEBA?=
 =?us-ascii?q?QEDAQFsKII6KQGCZwEFIwQRQRALGAICJgICVwYNBgIBAYJTDD+BdxSqEXwzh?=
 =?us-ascii?q?UeDKoFGgQwmAgKLUhd4gQeBOAyCXz6EKoMkglgEi0WIJpRSLwmCD4IUgj6OS?=
 =?us-ascii?q?QYbgiGUNy2Nc5ZuIYFYKwgCGAghD4MnghsXjjwjAzCBBgEBjUoBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 May 2019 12:07:25 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4UC7OpY029772;
        Thu, 30 May 2019 08:07:24 -0400
Subject: Re: sleep in selinux_audit_rule_init
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Jurgens <danielj@mellanox.com>
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
 <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
 <1558530022.4347.11.camel@linux.ibm.com>
 <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
 <1558533420.4347.30.camel@linux.ibm.com>
 <1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov>
 <CAE=NcranYrvV5Xnu8656kyDVUUzCs=Tdy+fkeo5jwVhtF8=81Q@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a39cedd1-a932-3140-bf11-ef4e3a88e254@tycho.nsa.gov>
Date:   Thu, 30 May 2019 08:07:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAE=NcranYrvV5Xnu8656kyDVUUzCs=Tdy+fkeo5jwVhtF8=81Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/30/19 6:39 AM, Janne Karhunen wrote:
> On Wed, May 22, 2019 at 6:27 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>>> Ok.  The question is then how should IMA handle missing domains/types.
>>>    Just dropping IMA policy rules doesn't sound safe, nor does skipping
>>> rules in case the domains/types are restored.
>>
>> You can just do what audit_dupe_lsm_field() does.  It effectively
>> disables the rule upon the invalidation (which makes sense, since it can
>> no longer match anything since nothing can have that domain/type) but
>> retains the string value so it can later re-activate the rule if the
>> domain/type becomes valid again later.
> 
> Finally got a moment to look into this. It looks to me there is
> already a notifier? Could something like this work?
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d213e835c498..2203451862d4 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -154,6 +154,8 @@ unsigned long ima_get_binary_runtime_size(void);
>   int ima_init_template(void);
>   void ima_init_template_list(void);
>   int __init ima_init_digests(void);
> +int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
> +                         void *lsm_data);
> 
>   /*
>    * used to protect h_table and sha_table
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index 5749ec92516f..449502f5c3dc 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -52,6 +52,10 @@ int ima_hash_algo = HASH_ALGO_SHA1;
>   static int hash_setup_done;
>   static struct workqueue_struct *ima_update_wq;
> 
> +static struct notifier_block ima_lsm_policy_notifier = {
> +       .notifier_call = ima_lsm_policy_change,
> +};
> +
>   static int __init hash_setup(char *str)
>   {
>          struct ima_template_desc *template_desc = ima_template_desc_current();
> @@ -691,6 +695,10 @@ static int __init init_ima(void)
>                  error = ima_init();
>          }
> 
> +       error = register_lsm_notifier(&ima_lsm_policy_notifier);
> +       if (error)
> +               pr_warn("Couldn't register LSM notifier, error %d\n", error);
> +
>          if (!error)
>                  ima_update_policy_flag();
>          else
> diff --git a/security/integrity/ima/ima_policy.c
> b/security/integrity/ima/ima_policy.c
> index e0cc323f948f..c3983d24279a 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -252,8 +252,8 @@ __setup("ima_appraise_tcb", default_appraise_policy_setup);
>   /*
>    * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
>    * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
> - * the reloaded LSM policy.  We assume the rules still exist; and BUG_ON() if
> - * they don't.
> + * the reloaded LSM policy.  Keep currently invalid fields around in case
> + * they become valid after a policy reload.
>    */
>   static void ima_lsm_update_rules(void)
>   {
> @@ -269,11 +269,23 @@ static void ima_lsm_update_rules(void)
>                                                             Audit_equal,
>                                                             entry->lsm[i].args_p,
>                                                             &entry->lsm[i].rule);
> -                       BUG_ON(!entry->lsm[i].rule);
> +                       if (result == -EINVAL)
> +                               pr_warn("ima: rule for LSM \'%d\' is invalid\n",
> +                                       entry->lsm[i].type);

I could be wrong, but I think there is still a problem here in that you 
are modifying entry->lsm[i].rule in-place, but it is protected under RCU 
and therefore needs to be duplicated and then modified?  Also you are 
leaking the old rule?  Both of those issues also exist prior to your 
patch but you aren't fixing them here. And lastly, it looks like lsm 
notifiers are atomic notifiers (not clear to me why) so you can't block 
in the callback, thereby requiring scheduling the work as is done in 
infiniband.  I'm not sure though why we can't make the lsm notifiers 
blocking notifiers.  The only callers of call_lsm_notifier() are 
sel_write_enforce() and selinux_lsm_notifier_avc_callback(), called from 
avc_ss_reset(), called from sel_write_enforce(), security_load_policy() 
and security_set_bools(), all outside of locks and in process context 
AFAICS.

>                  }
>          }
>   }
> 
> +int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
> +                         void *lsm_data)
> +{
> +       if (event != LSM_POLICY_CHANGE)
> +               return NOTIFY_DONE;
> +
> +       ima_lsm_update_rules();
> +       return NOTIFY_DONE;
> +}
> +
>   /**
>    * ima_match_rules - determine whether an inode matches the measure rule.
>    * @rule: a pointer to a rule
> @@ -327,11 +339,10 @@ static bool ima_match_rules(struct
> ima_rule_entry *rule, struct inode *inode,
>          for (i = 0; i < MAX_LSM_RULES; i++) {
>                  int rc = 0;
>                  u32 osid;
> -               int retried = 0;
> 
>                  if (!rule->lsm[i].rule)
>                          continue;
> -retry:
> +
>                  switch (i) {
>                  case LSM_OBJ_USER:
>                  case LSM_OBJ_ROLE:
> @@ -352,11 +363,6 @@ static bool ima_match_rules(struct ima_rule_entry
> *rule, struct inode *inode,
>                  default:
>                          break;
>                  }
> -               if ((rc < 0) && (!retried)) {
> -                       retried = 1;
> -                       ima_lsm_update_rules();
> -                       goto retry;
> -               }
>                  if (!rc)
>                          return false;
>          }
> 
> 
> 
> --
> Janne
> 

