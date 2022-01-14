Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0AF48E917
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 12:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiANLVY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jan 2022 06:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiANLVX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jan 2022 06:21:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5796C061574;
        Fri, 14 Jan 2022 03:21:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52ABE61EB0;
        Fri, 14 Jan 2022 11:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D524CC36AE5;
        Fri, 14 Jan 2022 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642159282;
        bh=NbrTOKw2NXpLjzztrax4ER9WDyfOxaxGE7tM1uu5Itg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faMRwpg+FACzc2wAngUDsBwF57K/ahxeDdhKvPnZk60jDpOjPTCAjtaC7swrApGhV
         9aya7jA8F6uF8CV12qjbZDPQkYjTfrsUrxamOR4XpP9s6kFa4DW42+jjtr2t5GqmlC
         ga5Ckie1/NQa8I7NZheexto2eFqGWFlV4YTt1dEEDf3/j8Nay5dl3AkcuXp+/CK0LF
         eaKlyvdSqsNlNWxYDVJVst0rGAAdnGLJt8mejElocbf+LvRYxkfaQyj+AMaCcNvT9P
         0NDXiX4BCQJ3who3+JJ8xfl7r1XUNbnnHOR2xRwx0JGJFkaoMsh/3809sl6MwKl/nf
         f80Wf1x65X3RA==
Date:   Fri, 14 Jan 2022 12:21:14 +0100
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
Subject: Re: [PATCH v8 10/19] ima: Implement hierarchical processing of file
 accesses
Message-ID: <20220114112114.tu4f56bm7tewzfmj@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-11-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220104170416.1923685-11-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 04, 2022 at 12:04:07PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement hierarchical processing of file accesses in IMA namespaces by
> walking the list of user namespaces towards the root. This way file
> accesses can be audited in an IMA namespace and also be evaluated against
> the IMA policies of parent IMA namespaces.
> 
> __process_measurement() returns either 0 or -EACCES. For hierarchical
> processing remember the -EACCES returned by this function but continue
> to the parent user namespace. At the end either return 0 or -EACCES
> if an error occurred in one of the IMA namespaces.
> 
> Currently the ima_ns pointer of the user_namespace is always NULL except
> at the init_user_ns, so test ima_ns for NULL pointer and skip the call to
> __process_measurement() if it is NULL. Once IMA namespacing is fully
> enabled, the pointer may also be NULL due to late initialization of the
> IMA namespace.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/ima.h               |  6 +++++
>  security/integrity/ima/ima_main.c | 37 +++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index b6ab66a546ae..fcee2a51bb87 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -65,6 +65,12 @@ static inline const char * const *arch_get_ima_policy(void)
>  }
>  #endif
>  
> +static inline struct user_namespace
> +*ima_ns_to_user_ns(struct ima_namespace *ns)
> +{
> +	return current_user_ns();
> +}
> +
>  #else
>  static inline enum hash_algo ima_get_current_hash_algo(void)
>  {
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 621685d4eb95..51b0ef1cebbe 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -200,10 +200,10 @@ void ima_file_free(struct file *file)
>  	ima_check_last_writer(iint, inode, file);
>  }
>  
> -static int process_measurement(struct ima_namespace *ns,
> -			       struct file *file, const struct cred *cred,
> -			       u32 secid, char *buf, loff_t size, int mask,
> -			       enum ima_hooks func)
> +static int __process_measurement(struct ima_namespace *ns,
> +				 struct file *file, const struct cred *cred,
> +				 u32 secid, char *buf, loff_t size, int mask,
> +				 enum ima_hooks func)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> @@ -395,6 +395,35 @@ static int process_measurement(struct ima_namespace *ns,
>  	return 0;
>  }
>  
> +static int process_measurement(struct ima_namespace *ns,
> +			       struct file *file, const struct cred *cred,
> +			       u32 secid, char *buf, loff_t size, int mask,
> +			       enum ima_hooks func)
> +{
> +	struct user_namespace *user_ns = ima_ns_to_user_ns(ns);
> +	int ret = 0;
> +
> +	while (user_ns) {
> +		ns = ima_ns_from_user_ns(user_ns);
> +		if (ns) {
> +			int rc;
> +
> +			rc = __process_measurement(ns, file, cred, secid, buf,
> +						   size, mask, func);
> +			switch (rc) {
> +			case -EACCES:
> +				/* return this error at the end but continue */
> +				ret = -EACCES;
> +				break;

This seems risky. Every error not -EACCES will be counted as a success.
It doesn't look like __process_measurement() will return anything else
but I would still place a WARN_ON() or WARN_ON_ONCE() in there to make
that assumption explicit.

Right now it looks like your only error condition is -EACCES and non-ima
cracks like me need to read through __process_measurement() to figure
out that that's ok. With a WARN_ON* in there I'd not have needed to bother.

switch (rc) {
case -EACCES:
	/* return this error at the end but continue */
	ret = -EACCES;
	break
default:
	WARN_ON_ONCE(true);
}

or sm similar.
