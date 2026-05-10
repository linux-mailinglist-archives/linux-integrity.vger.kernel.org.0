Return-Path: <linux-integrity+bounces-9513-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yZ6iKw3i/2mQ/wAAu9opvQ
	(envelope-from <linux-integrity+bounces-9513-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 03:40:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D601D502246
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7051302713E
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 01:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692321E097;
	Sun, 10 May 2026 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC+0uxYR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9B1DF248;
	Sun, 10 May 2026 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778377225; cv=none; b=XJKrrCJjyssGFtVTS5j1+JoSU9OeHSZBkhx2Sc8iuxe6asZU9o7VrCrl6GAgkIkhqdequXHG3QhRqX1DBILhTm0qPHk5pVLOWZtCF9HhKWtl+nUl41ckYV0RUcK8mGFu7bfghg4ZrpL7Ijyj7d6bxkT2CwXi83U3lepiFWyWqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778377225; c=relaxed/simple;
	bh=mrozHPPskf0IcuzmNrktTLea1r7KvMHO2Gs96cHR86I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBHyRWEymUg0EMRL350Qf3W7aAIzZt6nKC0W2I3TSrsSucI67M/Zk1mXOaV5p26l4k9z1fwD6mDj+J3Gt7TZZMEFLr/sPw3yXHVi7SZmAxrVSlu1v452XaI5dY1lJCeudVtOCqIK596PPHWBYuYnI0Gj9jzxeuteUHGc/FUcaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC+0uxYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98510C2BCB2;
	Sun, 10 May 2026 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778377225;
	bh=mrozHPPskf0IcuzmNrktTLea1r7KvMHO2Gs96cHR86I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SC+0uxYRmYZ50l+F3uAn6DpaQOdqdtyRakceSpPFOdcldGsg/2gPzCEJSdjNP65Nx
	 BEcH83bgwyaHutWWBPmlpKimL8zAg4dUFf1uvF6rE+EahrQG1YiIGXkT8V8oJF0nV2
	 lvJD+j85Q7GEzgHJFbDBAq8loEKEJ98i3/ybpWn/wnVuqrrdTTgAw/3f28KDU2WW1+
	 ZxestruQ2/VZFK0at4I3LsNcCQ75oDFVtw6lPw+yPx/2cRlvDDtFSYd4wmRdgLULzc
	 /Srxs9PKChaj13Ttl+0Pc6MIOwVQ31705khknnNhI5rkpty+wxBlLEIZT+xZ2sw/jY
	 b6M1qCfgeIhAw==
Date: Sun, 10 May 2026 04:40:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: jbouron@amazon.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, noodles@meta.com, peterhuewe@gmx.de
Subject: Re: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
Message-ID: <af_iBSYsCCxK4h2l@kernel.org>
References: <af8aRHUDDho2orTW@kernel.org>
 <20260509225450.29027-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509225450.29027-1-gunnarku@amazon.com>
X-Rspamd-Queue-Id: D601D502246
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,ziepe.ca,vger.kernel.org,meta.com,gmx.de];
	TAGGED_FROM(0.00)[bounces-9513-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

On Sat, May 09, 2026 at 10:54:49PM +0000, Gunnar Kudrjavets wrote:
> On Fri, May 09, 2026 at 11:28 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > Just for sake of understanding:
> >
> > What is "kiro" and is assisted-by the tag supposed to be used here?
> 
> Kiro is an AI-powered IDE built on top of Claude [1]. In this case,
> it helped with reasoning about the correctness of the fix, generating
> test cases to validate the change, and formalizing the commit message.
> 
> I'm trying to follow the established guidelines for AI attribution
> in kernel contributions to maintain scientific integrity [2] ;-)

OK, cool. I do know what Claude is :-) Just was unfamiliar term.

> 
> On a more utopian note, it is likely that in a year or so there'll be
> research conducted into how AI-assisted development is influencing the
> changes to the kernel. My goal is to get into the habit of indicating
> that AI was used to increase the number of valid data points.

Sure.

> 
> [1] https://kiro.dev/
> [2] https://docs.kernel.org/process/coding-assistants.html
> 
> Gunnar

BR, Jarkko

