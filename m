Return-Path: <linux-integrity+bounces-9498-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMf+Lbwc/2m92QAAu9opvQ
	(envelope-from <linux-integrity+bounces-9498-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 13:38:36 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114754FF7BB
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 13:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 969363013A8A
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B908351C3C;
	Sat,  9 May 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ5D2Wtq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAD34FF40;
	Sat,  9 May 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778326712; cv=none; b=IXrhpwJCZyF5voU7c+c+q/s5uaUF9NB8IxrFSZyqb50yuQnQslUOLU6gARSeubXZ/Wpdq00p/JV6VoH1k1HpnC/crkLDy8YEE7v3H4Zr1RF2dRCiU63XxujaD3EnW46+m7d7Mz0YlAUhwtKbyRj87mdZNFAIKvxS6YXUgfoPvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778326712; c=relaxed/simple;
	bh=K3XVyJMfn6rhx4RdalhYv34IacOy2XY8EzJNsKUe4D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOaJjz2RlULAbF/3w/6RkgU7bgPqgi2h1ApsfB0uezYXISaOatsdM2RSZj/QQLxxlILhkal3h7TpdifiRdAb1Uy9nzrZMolkXxJrBDvpfoZzQd2q8p5kbG6ewBQAGUsCAr9pIknh9ETdRGhoqdhUaQucLPBvv/UQy9KFP7yQGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ5D2Wtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8768DC2BCB2;
	Sat,  9 May 2026 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778326711;
	bh=K3XVyJMfn6rhx4RdalhYv34IacOy2XY8EzJNsKUe4D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZ5D2WtqKAby9AvOcgSY7KwG31iPLCnPZ2HXn0oy91uWfxDCis0GMjeGjbESkKXC/
	 ndNqitf9OePSSVfbV9EnefxRv3eZRw3QJwhJb6HR4WWv1EwtQSZHgS4Jw0We0KMvqC
	 PR7I2Cto07Q106w7En3p6lJ1z7/5jskRH4Ay/FbSzcVfTeKT0IXQHzfs8WqNlT0d/t
	 Ct9xLmb8WR4Gn8r0klRaYzOSTlZZiQITXFkW7VhyppjM8RgFTrKS0478Vbd9oEeypG
	 xLUNnU4VRC1ri7ZFnnx+r0iGSTLalkD+t7Bwe/pI4f2xQG3oM83NKUC9VAouVmfsrH
	 T2CaRuUZcQubg==
Date: Sat, 9 May 2026 14:38:28 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, noodles@meta.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
Message-ID: <af8ctMk1epISg32L@kernel.org>
References: <20260427163238.20230-1-gunnarku@amazon.com>
 <af8aRHUDDho2orTW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8aRHUDDho2orTW@kernel.org>
X-Rspamd-Queue-Id: 114754FF7BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,meta.com,vger.kernel.org,amazon.com];
	TAGGED_FROM(0.00)[bounces-9498-lists,linux-integrity=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 02:28:08PM +0300, Jarkko Sakkinen wrote:
> On Mon, Apr 27, 2026 at 04:32:26PM +0000, Gunnar Kudrjavets wrote:
> > The 'space' pointer in tpm2_flush_space() is assigned from
> > &chip->work_space, which is the address of an embedded struct member
> > within struct tpm_chip. This address can never be NULL, making the
> > NULL check dead code. The new code follows the existing pattern
> > established by the other callers in tpm2-space.c which also assign
> > from &chip->work_space without a NULL check. Remove the dead code
> > to avoid confusion.
> > 
> > Fixes: e3aaebcbb7c6 ("tpm: Clean up TPM space after command failure")
> > Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> > Assisted-by: Kiro:claude-opus-4.6
> 
> Just for sake of understanding:
> 
> What is "kiro" and is assisted-by the tag supposed to be used here?
> 
> > Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> > ---
> >  drivers/char/tpm/tpm2-space.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> > index 60354cd53b5c..1eec72eb8208 100644
> > --- a/drivers/char/tpm/tpm2-space.c
> > +++ b/drivers/char/tpm/tpm2-space.c
> > @@ -169,9 +169,6 @@ void tpm2_flush_space(struct tpm_chip *chip)
> >  	struct tpm_space *space = &chip->work_space;
> >  	int i;
> >  
> > -	if (!space)
> > -		return;
> > -
> >  	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
> >  		if (space->context_tbl[i] && ~space->context_tbl[i])
> >  			tpm2_flush_context(chip, space->context_tbl[i]);
> > 
> > base-commit: 949692da7211572fac419b2986b6abc0cd1aeb76
> > -- 
> > 2.47.3
> > 
> 
> It's all good otherwise, just need clarification as we are learning
> how to deal with these patches :-)

Hold on, I would not remove it: it's an invariant. It's not dead code.

BR, Jarkko

