Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189452067E1
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbgFWXE2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 19:04:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60658 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388020AbgFWXE1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 19:04:27 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2887C20B7192;
        Tue, 23 Jun 2020 16:04:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2887C20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592953466;
        bh=vzZAZrsVkwFhLFQvSrdEJZIr64CbwDvMPQLlWesUQc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8dwrHDxQZ7xqGFZyuOfCYAgdkBdbnsFx24QnlxfM/vEoAAo/au6Yuk8UXxo3Wz+g
         wbqxyBRbqs19GTUhUC0vaSTCBTmjqiyF8fYk0ol56lPKd7mxe65Z8OuD366qkNxIzw
         CjRhspmaOgZXdZytBufsh8khs4bldncTpK6e6k74=
Date:   Tue, 23 Jun 2020 18:04:24 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: Re: [PATCH 01/12] ima: Have the LSM free its audit rule
Message-ID: <20200623230424.GB6048@sequoia>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
 <20200623003236.830149-2-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623003236.830149-2-tyhicks@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-06-22 19:32:25, Tyler Hicks wrote:
> Ask the LSM to free its audit rule rather than directly calling kfree().
> Both AppArmor and SELinux do additional work in their audit_rule_free()
> hooks. Fix memory leaks by allowing the LSMs to perform necessary work.
> 
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: Janne Karhunen <janne.karhunen@gmail.com>
> ---
>  security/integrity/ima/ima.h        | 6 ++++++
>  security/integrity/ima/ima_policy.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df93ac258e01..de05d7f1d3ec 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -404,6 +404,7 @@ static inline void ima_free_modsig(struct modsig *modsig)
>  #ifdef CONFIG_IMA_LSM_RULES
>  
>  #define security_filter_rule_init security_audit_rule_init
> +#define security_filter_rule_free security_audit_rule_free
>  #define security_filter_rule_match security_audit_rule_match
>  
>  #else
> @@ -414,6 +415,11 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
>  	return -EINVAL;
>  }
>  
> +static inline void security_filter_rule_free(void *lsmrule)
> +{
> +	return -EINVAL;

Bah, I introduced a build warning here when CONFIG_IMA_LSM_RULES is
disabled. This function should return nothing. I'll wait for additional
feedback before spinning a v2.

Tyler

> +}
> +
>  static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
>  					     void *lsmrule)
>  {
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e493063a3c34..236a731492d1 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -258,7 +258,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>  	int i;
>  
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		kfree(entry->lsm[i].rule);
> +		security_filter_rule_free(entry->lsm[i].rule);
>  		kfree(entry->lsm[i].args_p);
>  	}
>  	kfree(entry);
> -- 
> 2.25.1
