Return-Path: <linux-integrity+bounces-9324-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO8eMRuW62m7OgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9324-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 18:11:07 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728B4612DF
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 18:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A13C43009CD7
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815F63DCDA8;
	Fri, 24 Apr 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7Dj4YbN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6113DCDA1;
	Fri, 24 Apr 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047063; cv=none; b=oAtH/oWnvsloj6HIxgtgFyKrwZ7/u0L0jYY9YJzvxuEghdrbymUMdZvw/3qGQ4qqrPWt+pJt2IsPUI5S8/kmYalN02qnYlNNNc9xUCGAm86AwK6qygsnqR+/x/YO2EvzThroX52azGMROyEPGXRkwrAmsPUJUkFSqy5SvRfjgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047063; c=relaxed/simple;
	bh=Zsy6Ff45uWrYNi6Q5JvPcxoWdNhp3W2xNL5lDQCZHzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOx3sCfWqFXyKLBApqT7wh0ex8JHx1I8W+y5m3z/7NP3zHrN21u7gI4eMHVv8sJfzpFfIC2gvcf/KnT5YOZ5Ca8OgAq4MyxyQLcaHbxiKj+0c+HWXqetPS3prtbCZzjYbh5mdzBzjlZjaVaAybOk3fgo5fHrHU3z/V1uzqcZT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7Dj4YbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36900C19425;
	Fri, 24 Apr 2026 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777047062;
	bh=Zsy6Ff45uWrYNi6Q5JvPcxoWdNhp3W2xNL5lDQCZHzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7Dj4YbNufgdQqfaeuBWv0WereEUAnEZ89rXk8uKzti/uEqb+9t4Y2f9G/42UCoAV
	 4OqLUN5rOrUHyxsiY3z6xQIZBWd9HFJSwV/lYWpKj2NUs1RCi1zvWpmqLC2mO4+Pv4
	 7tA7HMLIplN+kUuGWZmmKuB0x9lSJQWA3E9UF0spHiqvwwkkutlaCf30sNUfKAnW2Q
	 DhqS7B3Sqj8qorgLKoBuI7AW1m/cM1s4foXowSM/uZmOEnqiTmzqTQSCHGX9sVCq6S
	 bDdTpkyOowjF0at4J9ZjwCsT8w6HP/xmY8NAfWiBCzSnrIDAvdQ+nKeTgUVTW8GEJW
	 YZtfmnuj33uGQ==
Date: Fri, 24 Apr 2026 17:10:54 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	jarkko@kernel.org, jgg@ziepe.ca, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [RFC PATCH v3 3/4] Revert "tpm: tpm_crb_ffa: try to probe
 tpm_crb_ffa when it's built-in"
Message-ID: <20260424-agile-falcon-of-honor-4b23ab@sudeepholla>
References: <cover.1777036497.git.noodles@meta.com>
 <f8d6dcbeb5bf2d4316989d05dcaae20225774d51.1777036497.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d6dcbeb5bf2d4316989d05dcaae20225774d51.1777036497.git.noodles@meta.com>
X-Rspamd-Queue-Id: 2728B4612DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9324-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,ziepe.ca,arm.com,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 02:24:30PM +0100, Jonathan McDowell wrote:
> From: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> This reverts commit 746d9e9f62a6e8ba0eba2b83fc61cfe7fa8797ce.
> 
> Now that IMA will retry in the late_initcall_sync level if the TPM is
> not available at first, this change is no longer required.
> 

Acked-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep

