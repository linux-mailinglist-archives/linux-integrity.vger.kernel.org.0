Return-Path: <linux-integrity+bounces-9132-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJEZC3Hl02n/ngcAu9opvQ
	(envelope-from <linux-integrity+bounces-9132-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 18:55:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A318E3A576B
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 18:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D1E43015895
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2026 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2BA388E5E;
	Mon,  6 Apr 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPSu1G8y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D938759D;
	Mon,  6 Apr 2026 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494508; cv=none; b=EHM4UIWclohcYnwBJ9icPmjQl3CCAJzjCKQLEKVkaK97aRmEJClbtbx4rDMh6CcbFGleq2Hy5ia1P2l7rf9blmhTvwA5+khEsYIY95OfLdx00Sma+9U5Fd2hY73FLArqiq8FPOv1p8cdJf89Ku6cLKZnw+5Hu0lvVaiLmK9HgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494508; c=relaxed/simple;
	bh=YPa/uyVI/zqPFLBKVoFkDJwBwijtEHRHs03s3tfOZ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6W92YKfkwNoOr/kNCfh1P1pQDwSYwx8Wxjg+dUUFRHnFlvmAyXtv2wjCp6TmhCYzzShbZPuIpd+QJVQxzmZ1tCdwz+xk4yDQjwTkBjkcRnm8wZtIWrepBUtL4tB4QhE8OXQtNBPfCyn63hg5jA6MDNbSUUsl+qd6euoR30E0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPSu1G8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4343BC4CEF7;
	Mon,  6 Apr 2026 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775494507;
	bh=YPa/uyVI/zqPFLBKVoFkDJwBwijtEHRHs03s3tfOZ/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPSu1G8yBRgJShEMiu/+j9upL2j+a0NY3G8eULqcdFSnVU+teFCtNYnqjbCFLkUj2
	 eMRppvBNylHBFD+njmyliTADdLua7U7arTjjkYbfU5TQW7Mivuv1/2ExjlAh/PcXnS
	 IZpfs1K7j+enuMZ8dsjdg3XlSa5ci/cbq+biGIiHagNSLKjOjq1TUzkfkYc4Uduqkz
	 fzgqWC69jt8FIqUNX6fqQcCcYKUdEu1K8Hrjux3iTMXDW/Y/MsmDvz1vSfaTdBlsp3
	 Bly1FwKmjXyKXPYDXGj4I7vNjBvQCNlzk0Da+qPhwU9ytoBLDupG4J0bwENGxvpBdI
	 /qHBboGghIp3g==
Date: Mon, 6 Apr 2026 09:53:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
	roberto.sassu@huawei.com, David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@linux.win>,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: public_key: Remove check for valid hash_algo
 for ML-DSA keys
Message-ID: <20260406165350.GD2971@sol>
References: <20260405231224.4008298-1-stefanb@linux.ibm.com>
 <20260405231224.4008298-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405231224.4008298-2-stefanb@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9132-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.win:email]
X-Rspamd-Queue-Id: A318E3A576B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 07:12:22PM -0400, Stefan Berger wrote:
> Remove the check for the hash_algo since ML-DSA is only used in pure mode
> and there is no relevance of a hash_algo for the input data.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Ignat Korchagin <ignat@linux.win>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  crypto/asymmetric_keys/public_key.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index 09a0b83d5d77..df6918a77ab8 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -147,11 +147,6 @@ software_key_determine_akcipher(const struct public_key *pkey,
>  		   strcmp(pkey->pkey_algo, "mldsa87") == 0) {
>  		if (strcmp(encoding, "raw") != 0)
>  			return -EINVAL;
> -		if (!hash_algo)
> -			return -EINVAL;
> -		if (strcmp(hash_algo, "none") != 0 &&
> -		    strcmp(hash_algo, "sha512") != 0)
> -			return -EINVAL;

Does this broaden which hash algorithms are accepted for CMS signatures
that use ML-DSA and contain signed attributes?

- Eric

