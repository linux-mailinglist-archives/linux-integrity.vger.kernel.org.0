Return-Path: <linux-integrity+bounces-9047-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLaWBC5qwmlScwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9047-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:40:46 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5909C306940
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85CED3024964
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A731D375;
	Tue, 24 Mar 2026 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnnNQ3qe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403603E1CEA;
	Tue, 24 Mar 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348510; cv=none; b=AWXSVheslyxmoQ0gqIKSjOdAaCdNlNiag4Je1Sd6M7xwkHaiHElQS3qI0GmZDq+li3q3VdDxyqUxjbOzm5Wbvd6MHUwjzAjlOkchdpUY9kBkZDK7Dgp8VyHPYRFtLKspGzkVZdDDI9P7pU4zl/zUVPVR7Xoym3OzNW7siGoQKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348510; c=relaxed/simple;
	bh=ozLikLvinqIb2bQ42DgDWdNkICnKWw52pWepRkNHFkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ae4CwYOL/MdIXjVaTSfgrNqeSw5WZhyEDuPUC7oKAXbSSChSP9xDLPZozzPvLEc6oSJhanVoL8L+zqqQj7O5h2dh4D8XqULYPxtdK1gJfICnqwo38IuDle/buN22BvBCPP5WSWjTQZc+/+gFky0VBfKelT9jAwfvKZ+XiHeBdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnnNQ3qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F90C19424;
	Tue, 24 Mar 2026 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348509;
	bh=ozLikLvinqIb2bQ42DgDWdNkICnKWw52pWepRkNHFkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnnNQ3qeiL76pbHy8+Fe+UascEhQ2QZuk06i6byF7axDxpxXE65ts1CdK5GnmmIGN
	 QOG296DavABcXeZ4wkg//XaTUQvVy+VxF1Ar8ASZ0PxGvR+i/DjBsD2EVu86DsHHH3
	 20RJDmMDkKEVJByy9ITBCvBAvlDcgxV8uXM3/EtGIWg09PZVYAKqaRzPYuExyjuM8c
	 LybbGJUHyF5NgeW50H7fwLo7iQo/dKzwmLTUgfYtpcMur7OfSH8TRSwjpUmy1Tdqvc
	 642KVy1hwvW4ry5OjiojRzdCuIKrnKo9qqzLvw7Mqp+hJANvac6sn3aFp8zmvTqVd1
	 oY+GFKFLgpK/Q==
Date: Tue, 24 Mar 2026 12:35:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Srish Srinivasan <ssrish@linux.ibm.com>,
	Nayna Jain <nayna@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Protocol debugging as a feature
Message-ID: <acJo2cBe2pfDWWGc@kernel.org>
References: <20260323090047.632499-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323090047.632499-1-jarkko@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9047-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5909C306940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:00:46AM +0200, Jarkko Sakkinen wrote:
> TPM_DEBUG is a non-standard way to specify a feature in Linux kernel.
> Introduce CONFIG_TRUSTED_KEYS_DEBUG, and use it to replace TPM_DEBUG in
> TPM 1.x trusted keys.
> 
> Given that protocol bus could contain sensitive data, harden the feature as
> follows:
> 
> 1. In the  Kconfig description postulate that pr_debug() statements must be
>    used.
> 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
> 
> Traces can be enabled e.g., by providing trusted.dyndbg='+p' for the kernel
> command-line.
> 
> Cc: Srish Srinivasan <ssrish@linux.ibm.com>
> Reported-by: Nayna Jain <nayna@linux.ibm.com>
> Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

I'm posting a v2 update with HAVE_* flag and a bit wider scope.

BR, Jarkko

