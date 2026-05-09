Return-Path: <linux-integrity+bounces-9508-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNuHC1uF/2l47QAAu9opvQ
	(envelope-from <linux-integrity+bounces-9508-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 21:04:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38B501240
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 21:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FC83010144
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F11135B644;
	Sat,  9 May 2026 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F929bkZj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53C78F2B;
	Sat,  9 May 2026 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353374; cv=none; b=iZM78Lq6hVUXGeFEIKDS/qntvi/xodFM2eIQAflnUO5hCxUhsN11hJb1zGjb+MprIQv2rWJ9/HT9K3O6GH6BVc33KSF7gqsN/Dm72dkddIkNwV2Nqqy47g9CNNIhgIyEGzZwcWtKuT252Z/dogNmXSMmiKlV9tOGw5EJLC8mVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353374; c=relaxed/simple;
	bh=3L5MGmAY4K7yVhPbWt+iykzQHgmJT3cO9wISvo86ih0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw353/89wgBzWbF5HntfqW2P61EUBSLQuQN31OKUBz+y9U7dsjDZ4o8PwVYCv+3RrmqwxiBuHj3nVsr0Fsf2AkHP53K8rJYaz+uB+7LLkj+IZmpA7/sgsqgcMiRdcBBysyACZ1dJO0WHPMj2j+WfWx1UpGO+COgJ7kf7/ZsmM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F929bkZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72693C2BCB2;
	Sat,  9 May 2026 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778353373;
	bh=3L5MGmAY4K7yVhPbWt+iykzQHgmJT3cO9wISvo86ih0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F929bkZj/KQNErTx2YN8zFhEeb92XpjTpU9o0yk/8bxuz5oz859uh0hMoHNaE/Mqs
	 Hs6seTCZRIe8xbqEhKM7pcI/fsB43G3vuFdTb8kdcqM47887xJckIuc88qPfaf/+KJ
	 RbDAxsrjnsIycMCHNUvx1DJLjz+/r6zC+C2oSBXGa0j5fFm5F3W4So5EDpy9j8dWrN
	 uw4lQCd0qS2Rg2JLhZZ1kdmEgNjTSf+UrpME2bU6Nx5uGpu+Ai7fdIO7v4olPkJJvq
	 6tOKU+jL+EAUaswsMiGAnASh4QOBE9Qj7y3VzAIQJ5rwmSGO8obvhjf1f0n0oIfRPv
	 QFKvw3XZGrHyQ==
Date: Sat, 9 May 2026 22:02:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Windsor <dwindsor@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: svsm: constify tpm_chip_ops
Message-ID: <af-E2d_jlowRk0ta@kernel.org>
References: <20260505202738.145800-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505202738.145800-1-dwindsor@gmail.com>
X-Rspamd-Queue-Id: 8D38B501240
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9508-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 04:27:38PM -0400, David Windsor wrote:
> Constify the SVSM vTPM ops. It is statically initialized and never
> written to, so let's store it in .rodata.
> 
> Every other tpm_class_ops instance in drivers/char/tpm/ is already
> const.
> 
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  drivers/char/tpm/tpm_svsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> index f5ba0f64850b..b74d60f687d5 100644
> --- a/drivers/char/tpm/tpm_svsm.c
> +++ b/drivers/char/tpm/tpm_svsm.c
> @@ -49,7 +49,7 @@ static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, bufsiz);
>  }
>  
> -static struct tpm_class_ops tpm_chip_ops = {
> +static const struct tpm_class_ops tpm_chip_ops = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
>  	.send = tpm_svsm_send,
>  };
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> -- 
> 2.53.0
> 

Thanks, applied.

BR, Jarkko

