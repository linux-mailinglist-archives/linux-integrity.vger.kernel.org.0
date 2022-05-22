Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04653050A
	for <lists+linux-integrity@lfdr.de>; Sun, 22 May 2022 19:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiEVRy5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 May 2022 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiEVRy4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 May 2022 13:54:56 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB5E286C1;
        Sun, 22 May 2022 10:54:54 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id AC17566D; Sun, 22 May 2022 12:54:52 -0500 (CDT)
Date:   Sun, 22 May 2022 12:54:52 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com
Subject: Re: [PATCH v12 23/26] ima: Show owning user namespace's uid and gid
 when displaying policy
Message-ID: <20220522175452.GB24519@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-24-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-24-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:30AM -0400, Stefan Berger wrote:
> Show the uid and gid values relative to the user namespace that is
> currently active. The effect of this changes is that when one displays

When you say "is currently active", in my mind it's not clear whether you
mean in the process which opened the seq_file, or is active in the ima_ns,
or the reader (which might I guess be differenet still).  The code of
course does make it clear.  Can you change it to say "the user namespace
which opened the policy_show file" or something like that?

Also, s/The effect of this changes/The effect of this change/.

> the policy from the user namespace that originally set the policy,
> the same uid and gid values are shown in the policy as those that were
> used when the policy was set.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
> v9:
>   - use seq_user_ns and from_k{g,u}id_munged()
> ---
>  security/integrity/ima/ima_policy.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index eb10d895923d..4f8c50ddb777 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -2018,6 +2018,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
>  
>  int ima_policy_show(struct seq_file *m, void *v)
>  {
> +	struct user_namespace *user_ns = seq_user_ns(m);
>  	struct ima_rule_entry *entry = v;
>  	int i;
>  	char tbuf[64] = {0,};
> @@ -2103,7 +2104,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_UID) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kuid_munged(user_ns, entry->uid));
>  		if (entry->uid_op == &uid_gt)
>  			seq_printf(m, pt(Opt_uid_gt), tbuf);
>  		else if (entry->uid_op == &uid_lt)
> @@ -2114,7 +2116,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_EUID) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kuid_munged(user_ns, entry->uid));
>  		if (entry->uid_op == &uid_gt)
>  			seq_printf(m, pt(Opt_euid_gt), tbuf);
>  		else if (entry->uid_op == &uid_lt)
> @@ -2125,7 +2128,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_GID) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kgid_munged(user_ns, entry->gid));
>  		if (entry->gid_op == &gid_gt)
>  			seq_printf(m, pt(Opt_gid_gt), tbuf);
>  		else if (entry->gid_op == &gid_lt)
> @@ -2136,7 +2140,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_EGID) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kgid_munged(user_ns, entry->gid));
>  		if (entry->gid_op == &gid_gt)
>  			seq_printf(m, pt(Opt_egid_gt), tbuf);
>  		else if (entry->gid_op == &gid_lt)
> @@ -2147,7 +2152,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	if (entry->flags & IMA_FOWNER) {
> -		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
> +		snprintf(tbuf, sizeof(tbuf),
> +			 "%d", from_kuid_munged(user_ns, entry->fowner));
>  		if (entry->fowner_op == &uid_gt)
>  			seq_printf(m, pt(Opt_fowner_gt), tbuf);
>  		else if (entry->fowner_op == &uid_lt)
> @@ -2158,7 +2164,8 @@ int ima_policy_show(struct seq_file *m, void *v)
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
> 2.34.1
