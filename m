Return-Path: <linux-integrity+bounces-8152-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D8FCEEFDF
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 17:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E44553007CA1
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A92C08DC;
	Fri,  2 Jan 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcnrYkIM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73C291C33;
	Fri,  2 Jan 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767372059; cv=none; b=KFlPdx22KW9T5znYaxxAcd3BhBMzKULw9XJDthBAtzDqrFMLkPS91j+sgowZYPT8cCVHn4ubNIie+LEROu244HsijoUkBSKTGEwwdKN7tUu5tAe4BeUGzMHK1KushWeaOtWeBtSGW1IueKU4TbkgVqRh/T4DGgJZaTf+2yInTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767372059; c=relaxed/simple;
	bh=44Avnz9QT72k0Lk4cae71/Wkua3fs/80MartBdrlLc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvJR5+vteXd4kEL+F6t7oKnjIjgG3XXqIQAfvOP/dd1Oa8SJAKLzHfiodgDcq2KhVsRWMBg6IJCkFSURtOpYJlyArfzArkpyFaSMLg+dXz3VO2Uwb193P6OHlCbMblE8G6VcnPtG3zSa8VLVU81dXqUvPoShlSO8giyTYLO5Ly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcnrYkIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0779BC116B1;
	Fri,  2 Jan 2026 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767372058;
	bh=44Avnz9QT72k0Lk4cae71/Wkua3fs/80MartBdrlLc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcnrYkIMigHSzqeXKY0ClBVHO94SkrN8sjrjqNAtOoRnvxhLcyofZqHe89oJyP11S
	 N0rba9aG9r/s1jy71f4Wo3vXrxIdyVhN+JcgUCwni+qKsvplBGB4gYgsa68vshlwyg
	 gzPXuN9JSAIEfuX2cofTMsdn4QRrFsKz2gkFAl+8eryk+1BxdId/xdnAWUj0jV+b37
	 mOi/H6/XhGhqhpyzzEz5YjBwo+spA+ANChMLq0CzeQ2l5TyPuaFSQ3PdJCHbDlLQEt
	 AmHGmmBsr3/yEwbzvzdCftA6g3YYDk2/UJVNtHvzAJ9+EcaP3jDtGKpvFGgKyLRNea
	 UUCY63NfEkbMw==
Date: Fri, 2 Jan 2026 18:40:54 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v8 03/12] tpm: Orchestrate TPM commands in
 tpm_get_random()
Message-ID: <aVf1FgG0S4A8OlfR@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-4-jarkko@kernel.org>
 <aUUeP5qhEISjythp@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUUeP5qhEISjythp@earth.li>

On Fri, Dec 19, 2025 at 09:43:27AM +0000, Jonathan McDowell wrote:
> On Tue, Dec 16, 2025 at 11:21:37AM +0200, Jarkko Sakkinen wrote:
> > tpm1_get_random() and tpm2_get_random() contain duplicate orchestration
> > code. Consolidate orchestration to tpm_get_random().
> 
> Does keeping the respective tpm1/tpm2 bits in their -cmd.c files not make
> more sense, still allowing for the consolidation of orchestration in
> tpm_get_random?

Yeah, especially after not paying attention to this for couple of weeks
this really feels like unnecessary. It would also reduce the overall
delta caused by these patches. I will take here step back and retain
the helpers in tpm1/tpm2-cmd.c files.

BR, Jarkko

