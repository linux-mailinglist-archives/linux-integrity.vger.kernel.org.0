Return-Path: <linux-integrity+bounces-8305-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEEQNgdLdmk6PAEAu9opvQ
	(envelope-from <linux-integrity+bounces-8305-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 17:55:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511781815
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 17:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF40030056CB
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A19121E087;
	Sun, 25 Jan 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEZOa2Vs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212825771;
	Sun, 25 Jan 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769360130; cv=none; b=Z5nEJO0qsThLy7GL4umPmaZM/rlUBd6RrJDHSbUUTyXsa1j4beRAwFyrUizWOR2sAghNbh5I6erkAJ2k+byEJVgBeLQSslsXb6IbIAy7F0s4oJYluOX+UrKX3zTC731ue2U+iia0D+Zt0HQoFLCItJSIWp7UjhsiVhDnkVOp75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769360130; c=relaxed/simple;
	bh=e601XR9Ll0fGNQhfmDvffrnFWUouTHvrVak62rZBKlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xfkf3uZwixeV/6A3bwl61wQlgUU2oBxdhWOYEPxQa5QluXw1/9cTFZACukdCQn3HfnKx1fimM9dT7jb8GqtxCHP97ZXc50OYk2+Iy24HgvVgYUuAqhfWs7zBgPgnsDWwQQ25kmSX3v4po4qsyScAU+Qkam611CdikraT6M4gzAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEZOa2Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494EAC4CEF1;
	Sun, 25 Jan 2026 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769360129;
	bh=e601XR9Ll0fGNQhfmDvffrnFWUouTHvrVak62rZBKlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEZOa2Vs4uilLdPA6iMJI6//97wEsCTcLBqoH0VwIzyH0OTUwt7pHxO35O2Mm9fGJ
	 u55F1AFt6NWDHM74bZUHkinvFdCWZDHdQz3fIQGSw/ppp40qvHE+YJtK6glzlKn8NK
	 Ue0fp8CbEHnOmN6+wEGSgvfTrEvPvlkwejHPVsWIW457nFF3X6hcl4PmJsnvpvE0Pd
	 RVrFc1qteJrfP5hjRkwhOORnB/bdgVtPvsRfGtk/hvz6ROatMwMj2kwU2keRZeAgNs
	 NmvE2uwPb7WgE6lhi4CJBxKcBWhTZCkw7zwSDUtnfilwBDiI3LgOHfZxCbaxq3vKkG
	 5ydaUTXb1j1PQ==
Date: Sun, 25 Jan 2026 18:55:25 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	nayna@linux.ibm.com, stefanb@linux.ibm.com, rnsastry@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] keys/trusted_keys: fix handle passed to
 tpm_buf_append_name during unseal
Message-ID: <aXZK_aamKlxqNJ3H@kernel.org>
References: <20260123165504.461607-1-ssrish@linux.ibm.com>
 <20260123165504.461607-2-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123165504.461607-2-ssrish@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8305-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,hansenpartnership.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8511781815
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:25:03PM +0530, Srish Srinivasan wrote:
> TPM2_Unseal[1] expects the handle of a loaded data object, and not the
> handle of the parent key. But the tpm2_unseal_cmd provides the parent
> keyhandle instead of blob_handle for the session HMAC calculation. This
> causes unseal to fail.
> 
> Fix this by passing blob_handle to tpm_buf_append_name().
> 
> Fixes: 6e9722e9a7bf ("tpm2-sessions: Fix out of range indexing in name_size")
> 
> References:
> [1] trustedcomputinggroup.org/wp-content/uploads/
>     Trusted-Platform-Module-2.0-Library-Part-3-Version-184_pub.pdf
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index a7ea4a1c3bed..6340823f8b53 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -465,7 +465,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  }
>  
>  /**
> - * tpm2_unseal_cmd() - execute a TPM2_Unload command
> + * tpm2_unseal_cmd() - execute a TPM2_Unseal command
>   *
>   * @chip: TPM chip to use
>   * @payload: the key data in clear and encrypted form
> @@ -498,7 +498,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  		return rc;
>  	}
>  
> -	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
> +	rc = tpm_buf_append_name(chip, &buf, blob_handle, NULL);
>  	if (rc)
>  		goto out;
>  
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

And applied. I also need to check what is wrong with my QA because
it should have catched this.

BR, Jarkko

