Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6495306E6
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 02:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiEWAnY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 May 2022 20:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiEWAnY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 May 2022 20:43:24 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3BF30569;
        Sun, 22 May 2022 17:43:23 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 1BF61EB5; Sun, 22 May 2022 19:43:22 -0500 (CDT)
Date:   Sun, 22 May 2022 19:43:22 -0500
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
Subject: Re: [PATCH v12 15/26] ima: Implement ima_free_policy_rules() for
 freeing of an ima_namespace
Message-ID: <20220523004322.GB28089@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-16-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-16-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:22AM -0400, Stefan Berger wrote:
> Implement ima_free_policy_rules() to free the current custom IMA policy's
> rules. This function will be called when an ima_namespace is freed.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> 
> ---
> v10:
>   - Not calling ima_delete_rules() anymore
>   - Move access check from ima_delete_rules into very last patch
> 
>  v9:
>   - Only reset temp_ima_appraise when using init_ima_ns.
> ---
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_policy.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 2775a6d89e6d..054b8f67be04 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -333,6 +333,7 @@ void ima_update_policy_flags(struct ima_namespace *ns);
>  ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
>  void ima_delete_rules(struct ima_namespace *ns);
>  int ima_check_policy(struct ima_namespace *ns);
> +void ima_free_policy_rules(struct ima_namespace *ns);
>  void *ima_policy_start(struct seq_file *m, loff_t *pos);
>  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 45a997709200..eb10d895923d 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1905,6 +1905,20 @@ void ima_delete_rules(struct ima_namespace *ns)
>  	}
>  }
>  
> +/**
> + * ima_free_policy_rules - free all policy rules
> + * @ns: IMA namespace that has the policy
> + */
> +void ima_free_policy_rules(struct ima_namespace *ns)
> +{
> +	struct ima_rule_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
> +		list_del(&entry->list);
> +		ima_free_rule(entry);
> +	}
> +}
> +
>  #define __ima_hook_stringify(func, str)	(#func),
>  
>  const char *const func_tokens[] = {
> -- 
> 2.34.1
