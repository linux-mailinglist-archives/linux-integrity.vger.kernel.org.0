Return-Path: <linux-integrity+bounces-3308-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262294DD8F
	for <lists+linux-integrity@lfdr.de>; Sat, 10 Aug 2024 17:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003E91F20CD1
	for <lists+linux-integrity@lfdr.de>; Sat, 10 Aug 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB7168493;
	Sat, 10 Aug 2024 15:58:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A033FBA7;
	Sat, 10 Aug 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723305487; cv=none; b=rAJclqgCAPoE2uiODU8J3Ji3mGE9FWW6QrAInyNpiff9V6wGllWKgSOO0FbSSaTCiRsEUcg5D2exmTqYlBNhWgapljWdGM4bi6rKrUSKvr5tnphBfN+cKa8LbSP1uap9NkD3Puplfv1vmGRUfzQ9KHzzjw4NGObOi5lw/u0YJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723305487; c=relaxed/simple;
	bh=ZNScjajJuLcwG7dBxdnslRyE7cM7YMOX7T0eRP8Gb7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu/Y7v0sUjl7EFsA6D55pPOFjTKUtFfDzMfP5Tak4AzWeiHhtNRreH1zxAirvkFp4reH3sslF9etzgI9prDKyw7+wYQBLCP8zCH5cvS4oM8iKrz/LZUmTOY2EvbFVUIsYZRX3845d4QY9HxDn7fm+UEcGoYI2eqTkHYZHUpFHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 25B87234; Sat, 10 Aug 2024 10:50:00 -0500 (CDT)
Date: Sat, 10 Aug 2024 10:50:00 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	mpatocka@redhat.com, eparis@redhat.com, paul@paul-moore.com,
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v20 02/20] ipe: add policy parser
Message-ID: <20240810155000.GA35219@mail.hallyn.com>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-3-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722665314-21156-3-git-send-email-wufan@linux.microsoft.com>

On Fri, Aug 02, 2024 at 11:08:16PM -0700, Fan Wu wrote:
> From: Deven Bowers <deven.desai@linux.microsoft.com>
> 
> IPE's interpretation of the what the user trusts is accomplished through

nit: "of what the user trusts" (drop the extra 'the')

> its policy. IPE's design is to not provide support for a single trust
> provider, but to support multiple providers to enable the end-user to
> choose the best one to seek their needs.
> 
> This requires the policy to be rather flexible and modular so that
> integrity providers, like fs-verity, dm-verity, or some other system,
> can plug into the policy with minimal code changes.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

This all looks fine.  Just one comment below.


> +/**
> + * parse_rule() - parse a policy rule line.
> + * @line: Supplies rule line to be parsed.
> + * @p: Supplies the partial parsed policy.
> + *
> + * Return:
> + * * 0		- Success
> + * * %-ENOMEM	- Out of memory (OOM)
> + * * %-EBADMSG	- Policy syntax error
> + */
> +static int parse_rule(char *line, struct ipe_parsed_policy *p)
> +{
> +	enum ipe_action_type action = IPE_ACTION_INVALID;
> +	enum ipe_op_type op = IPE_OP_INVALID;
> +	bool is_default_rule = false;
> +	struct ipe_rule *r = NULL;
> +	bool first_token = true;
> +	bool op_parsed = false;
> +	int rc = 0;
> +	char *t;
> +
> +	r = kzalloc(sizeof(*r), GFP_KERNEL);
> +	if (!r)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&r->next);
> +	INIT_LIST_HEAD(&r->props);
> +
> +	while (t = strsep(&line, IPE_POLICY_DELIM), line) {

If line is passed in as NULL, t will be NULL on the first test.  Then
you'll break out and call parse_action(NULL), which calls
match_token(NULL, ...), which I do not think is safe.

I realize the current caller won't pass in NULL, but it seems worth
checking for here in case some future caller is added by someone
who's unaware.

Or, maybe add 'line must not be null' to the function description.

> +		if (*t == '\0')
> +			continue;
> +		if (first_token && token_default(t)) {
> +			is_default_rule = true;
> +		} else {
> +			if (!op_parsed) {
> +				op = parse_operation(t);
> +				if (op == IPE_OP_INVALID)
> +					rc = -EBADMSG;
> +				else
> +					op_parsed = true;
> +			} else {
> +				rc = parse_property(t, r);
> +			}
> +		}
> +
> +		if (rc)
> +			goto err;
> +		first_token = false;
> +	}
> +
> +	action = parse_action(t);
> +	if (action == IPE_ACTION_INVALID) {
> +		rc = -EBADMSG;
> +		goto err;
> +	}
> +
> +	if (is_default_rule) {
> +		if (!list_empty(&r->props)) {
> +			rc = -EBADMSG;
> +		} else if (op == IPE_OP_INVALID) {
> +			if (p->global_default_action != IPE_ACTION_INVALID)
> +				rc = -EBADMSG;
> +			else
> +				p->global_default_action = action;
> +		} else {
> +			if (p->rules[op].default_action != IPE_ACTION_INVALID)
> +				rc = -EBADMSG;
> +			else
> +				p->rules[op].default_action = action;
> +		}
> +	} else if (op != IPE_OP_INVALID && action != IPE_ACTION_INVALID) {
> +		r->op = op;
> +		r->action = action;
> +	} else {
> +		rc = -EBADMSG;
> +	}
> +
> +	if (rc)
> +		goto err;
> +	if (!is_default_rule)
> +		list_add_tail(&r->next, &p->rules[op].rules);
> +	else
> +		free_rule(r);
> +
> +	return rc;
> +err:
> +	free_rule(r);
> +	return rc;
> +}
> +
> +/**
> + * ipe_free_parsed_policy() - free a parsed policy structure.
> + * @p: Supplies the parsed policy.
> + */
> +void ipe_free_parsed_policy(struct ipe_parsed_policy *p)
> +{
> +	struct ipe_rule *pp, *t;
> +	size_t i = 0;
> +
> +	if (IS_ERR_OR_NULL(p))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(p->rules); ++i)
> +		list_for_each_entry_safe(pp, t, &p->rules[i].rules, next) {
> +			list_del(&pp->next);
> +			free_rule(pp);
> +		}
> +
> +	kfree(p->name);
> +	kfree(p);
> +}
> +
> +/**
> + * validate_policy() - validate a parsed policy.
> + * @p: Supplies the fully parsed policy.
> + *
> + * Given a policy structure that was just parsed, validate that all
> + * operations have their default rules or a global default rule is set.
> + *
> + * Return:
> + * * %0		- Success
> + * * %-EBADMSG	- Policy is invalid
> + */
> +static int validate_policy(const struct ipe_parsed_policy *p)
> +{
> +	size_t i = 0;
> +
> +	if (p->global_default_action != IPE_ACTION_INVALID)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(p->rules); ++i) {
> +		if (p->rules[i].default_action == IPE_ACTION_INVALID)
> +			return -EBADMSG;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ipe_parse_policy() - Given a string, parse the string into an IPE policy.
> + * @p: partially filled ipe_policy structure to populate with the result.
> + *     it must have text and textlen set.
> + *
> + * Return:
> + * * %0		- Success
> + * * %-EBADMSG	- Policy is invalid
> + * * %-ENOMEM	- Out of Memory
> + * * %-ERANGE	- Policy version number overflow
> + * * %-EINVAL	- Policy version parsing error
> + */
> +int ipe_parse_policy(struct ipe_policy *p)
> +{
> +	struct ipe_parsed_policy *pp = NULL;
> +	char *policy = NULL, *dup = NULL;
> +	bool header_parsed = false;
> +	char *line = NULL;
> +	size_t len;
> +	int rc = 0;
> +
> +	if (!p->textlen)
> +		return -EBADMSG;
> +
> +	policy = kmemdup_nul(p->text, p->textlen, GFP_KERNEL);
> +	if (!policy)
> +		return -ENOMEM;
> +	dup = policy;
> +
> +	pp = new_parsed_policy();
> +	if (IS_ERR(pp)) {
> +		rc = PTR_ERR(pp);
> +		goto out;
> +	}
> +
> +	while ((line = strsep(&policy, IPE_LINE_DELIM)) != NULL) {
> +		remove_comment(line);
> +		len = remove_trailing_spaces(line);
> +		if (!len)
> +			continue;
> +
> +		if (!header_parsed) {
> +			rc = parse_header(line, pp);
> +			if (rc)
> +				goto err;
> +			header_parsed = true;
> +		} else {
> +			rc = parse_rule(line, pp);
> +			if (rc)
> +				goto err;
> +		}
> +	}
> +
> +	if (!header_parsed || validate_policy(pp)) {
> +		rc = -EBADMSG;
> +		goto err;
> +	}
> +
> +	p->parsed = pp;
> +
> +out:
> +	kfree(dup);
> +	return rc;
> +err:
> +	ipe_free_parsed_policy(pp);
> +	goto out;
> +}
> diff --git a/security/ipe/policy_parser.h b/security/ipe/policy_parser.h
> new file mode 100644
> index 000000000000..62b6209019a2
> --- /dev/null
> +++ b/security/ipe/policy_parser.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2024 Microsoft Corporation. All rights reserved.
> + */
> +#ifndef _IPE_POLICY_PARSER_H
> +#define _IPE_POLICY_PARSER_H
> +
> +int ipe_parse_policy(struct ipe_policy *p);
> +void ipe_free_parsed_policy(struct ipe_parsed_policy *p);
> +
> +#endif /* _IPE_POLICY_PARSER_H */
> -- 
> 2.44.0

