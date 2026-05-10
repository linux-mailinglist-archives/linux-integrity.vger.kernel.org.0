Return-Path: <linux-integrity+bounces-9516-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EoIhDfLNAGqdMwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9516-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 20:26:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FAE5059DB
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 20:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF24300AB05
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98630648C;
	Sun, 10 May 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG4nD/4d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FC3043CE;
	Sun, 10 May 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437613; cv=none; b=bfXM6b/gYabcU5JvRumtAldkCJMkKIvWuCbdINhAkXdw5xag1OPMTdvuJg5TSsZQqXaEaRbd++ytjHOWm+Yybn52hr3LM0fkvrCT/oUDSc1T7w51V9k+/lQAHugOQmqXSrDA0YJpkRn7m7EOPJz0+H5VGoJxu47arXJR4WOHraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437613; c=relaxed/simple;
	bh=fJXpb9VxOpGJKGl3l+TydjT48tPKce6RiGttdzrEimw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZzu2f5U2+jLefJi5HJCINPlqPwRWIfxOPTC3rpuM87QQmHz4g/wsuwmvBH1cWvkNluTe+jdLOumX2q+kKH+rx9BFXg6zQ9SPbiz9BojNcujaC9c8GKLPjWchssMU/krSSJBJhXDS3pXYnhe6sAWdV82y02KDw7PgCLFDoFKKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG4nD/4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FB9C2BCB8;
	Sun, 10 May 2026 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778437612;
	bh=fJXpb9VxOpGJKGl3l+TydjT48tPKce6RiGttdzrEimw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tG4nD/4dQDBT/SghgYZ04DMSupFh5YnVS1vd+BmdEvxhA92MfFjY6jrKl06FbPGOv
	 xdN0BccFww/PwONgml+G10rGLl7/SG+44uykp+I+JVU99aqmdUldgfZ6LfPC1h9yLA
	 PQr+Nq7uT4OyIWophwlxlp2H3OkrTvVaK8lzByTNconHjjUBFkC3Mwdc6skVivt8kx
	 vw0ThUTaShmjNWgYV3IpUWH7B0faV5JmRzl7fJ67X/9KUGIM/tAwDwh8qThx6I6HwX
	 xp8fNQzWHGX4D5rLeMxiR2DN7TrxA+lDIoYn6a/hfqUO0BZUL1f2PRr+Yd1Zp6Vi66
	 ruhk1QwP8J7Gg==
Date: Sun, 10 May 2026 21:26:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: jbouron@amazon.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhijaz@amazon.com, noodles@meta.com,
	peterhuewe@gmx.de
Subject: Re: [PATCH v2] tpm: Initialize name_size_alg for non-NULL name in
 tpm_buf_append_name()
Message-ID: <agDN6EbJWXoSB63e@kernel.org>
References: <af_imAiZEQ7WEe5W@kernel.org>
 <20260510171152.4607-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510171152.4607-1-gunnarku@amazon.com>
X-Rspamd-Queue-Id: 65FAE5059DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,ziepe.ca,vger.kernel.org,meta.com,gmx.de];
	TAGGED_FROM(0.00)[bounces-9516-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 05:11:27PM +0000, Gunnar Kudrjavets wrote:
> tpm_buf_append_name() supports callers passing a pre-computed name
> for handles. When name is non-NULL, the code skips the
> tpm2_read_public() path but leaves name_size_alg uninitialized
> before it is used as the memcpy size argument.
> 
> No current in-tree caller passes a non-NULL name, but future use
> cases such as name caching would exercise this path. Initialize
> name_size_alg by calling name_size() on the caller-provided name,
> sharing the error check and assignment with the existing
> tpm2_read_public() path. This prevents unmasking a latent bug when
> the non-NULL name path is eventually used.
> 
> Assisted-by: Kiro:claude-opus-4.6
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> Reviewed-by: Muhammad Hammad Ijaz <mhijaz@amazon.com>
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> ---
>  drivers/char/tpm/tpm2-sessions.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index c4da6fde748f..795cd99dc6fe 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -285,11 +285,14 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  	    mso == TPM2_MSO_NVRAM) {
>  		if (!name) {
>  			ret = tpm2_read_public(chip, handle, auth->name[slot]);
> -			if (ret < 0)
> -				goto err;
> -
> -			name_size_alg = ret;
> +		} else {
> +			ret = name_size(name);
>  		}
> +
> +		if (ret < 0)
> +			goto err;
> +
> +		name_size_alg = ret;
>  	} else {
>  		if (name) {
>  			dev_err(&chip->dev, "handle 0x%08x does not use a name\n",
> 
> base-commit: 44bd97559c26bb4d7abac09d29e58a4152d88567
> --
> 2.47.3
> 

Thank you. Applied.

BR, Jarkko

