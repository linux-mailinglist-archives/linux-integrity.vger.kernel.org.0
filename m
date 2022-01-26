Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180FC49CC91
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbiAZOni (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:43:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57958 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiAZOnh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:43:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15107B81CB5;
        Wed, 26 Jan 2022 14:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5E9C340E3;
        Wed, 26 Jan 2022 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643208214;
        bh=VXrWw1jNaVBP4IYTZprodtpkr5wTpM4k/RGODxJVN20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+7yWnOVJei2pnfnAg5UtMGEUDrQN4An+ntz6vZggJBtpF1uL7kQC24+ytJ1C9dys
         coi/WLJ4UelWPiJBldYcaZ0JTrbjYT/QygLt0yiOVxAaJzFvCSAG+kW5/w2vIUKx8I
         eLQLMLU3rCUv7RZp3fhiciHR9WC9vDkkAADIdRvEjW57dMGOASJ7GtIpxhoZ7Ag9Jb
         dbsQwIt3uPEDByAVuMUR7flrtBKdCu/KRQXfaPt/BVzyCXb+oF4NbPhgEcjv3ryFtU
         jh+B/s0f7bI5KP9wiYA+xqhxHRzuPim/ozRGjHP4ykOIDnqErOZB/z9xERWJAeq6dG
         ZOiIGcHYhaDyQ==
Date:   Wed, 26 Jan 2022 15:43:26 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 22/23] ima: Show owning user namespace's uid and gid
 when displaying policy
Message-ID: <20220126144326.ci646xkm7mjsqwci@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-23-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-23-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:44PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Show the uid and gid values relative to the user namespace that is
> currently active. The effect of this changes is that when one displays
> the policy from the user namespace that originally set the policy,
> the same uid and gid values are shown in the policy as those that were
> used when the policy was set.

"Make sure that the uid and gid values associated with the relevant
ima policy are resolved in the user namespace of the opener of the
policy file."

is more correct. Also note, that by virtue of enforcing that securityfs
files can only ever be opened if the opener's userns is the same or an
ancestor of the userns the securityfs instance is mounted in we are
guaranteed that the uid and gid can be resolved. That's another way of
saying technically *_munged() isn't necessary but it is more correct
since we're crossing the user-kernel boundary.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> v9:
>   - use seq_user_ns and from_k{g,u}id_munged()
> ---
>  security/integrity/ima/ima_policy.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 47f2d1b5d156..151f418036ee 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -2002,6 +2002,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
>  
>  int ima_policy_show(struct seq_file *m, void *v)
>  {
> +	struct user_namespace *user_ns = seq_user_ns(m);
>  	struct ima_rule_entry *entry = v;
>  	int i;
>  	char tbuf[64] = {0,};
> @@ -2087,7 +2088,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_UID) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kuid_munged(user_ns, entry->uid));
>  		if (entry->uid_op == &uid_gt)
>  			seq_printf(m, pt(Opt_uid_gt), tbuf);
>  		else if (entry->uid_op == &uid_lt)
> @@ -2098,7 +2100,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_EUID) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kuid_munged(user_ns, entry->uid));
>  		if (entry->uid_op == &uid_gt)
>  			seq_printf(m, pt(Opt_euid_gt), tbuf);
>  		else if (entry->uid_op == &uid_lt)
> @@ -2109,7 +2112,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_GID) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kgid_munged(user_ns, entry->gid));
>  		if (entry->gid_op == &gid_gt)
>  			seq_printf(m, pt(Opt_gid_gt), tbuf);
>  		else if (entry->gid_op == &gid_lt)
> @@ -2120,7 +2124,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_EGID) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kgid_munged(user_ns, entry->gid));
>  		if (entry->gid_op == &gid_gt)
>  			seq_printf(m, pt(Opt_egid_gt), tbuf);
>  		else if (entry->gid_op == &gid_lt)
> @@ -2131,7 +2136,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_FOWNER) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kuid_munged(user_ns, entry->fowner));
>  		if (entry->fowner_op == &uid_gt)
>  			seq_printf(m, pt(Opt_fowner_gt), tbuf);
>  		else if (entry->fowner_op == &uid_lt)
> @@ -2142,7 +2148,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_FGROUP) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kgid_munged(user_ns, entry->fgroup));
>  		if (entry->fgroup_op == &gid_gt)
>  			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
>  		else if (entry->fgroup_op == &gid_lt)
> -- 
> 2.31.1
> 
> 
