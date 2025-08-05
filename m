Return-Path: <linux-integrity+bounces-6782-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E1B1B7FA
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 18:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D41F625861
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629D291C1B;
	Tue,  5 Aug 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKLcd2Fz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FE21C9F9;
	Tue,  5 Aug 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410119; cv=none; b=ZkwnadjzJExcakqD/QCU00E2EwTKY0v8Xo4KFx7wGlXD427c+YTs744m4I3y3nbkdD5ugv/TuHbfpijOlylSkK9jCt1i2jvWQ+YzisMd+RtphEj9HOD8Dr3EqADDELe7RdmedkW3YEmQL8+PLdHY/1MaXQDqvvVVKz08ttP+ybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410119; c=relaxed/simple;
	bh=0yi4/feUEbr2kJo/l0wIaYw3exx08Do2z81U+NjJSB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ojoxu44TXqq7itte7ylzeMOO7R6ruFlAhjbrNQLHsAcOlXncmsgF4Kr5e8XlCHMuvdr6S+rIHWa7t1e6QHBFfo4Q92QcG21yLiViAxlU5YKdFsj0M2KtbBBEolygIUKG5xa+J/upvMEE7foiT577mGStyuOqCNRNG7EnFEuO4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKLcd2Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B29C4CEF6;
	Tue,  5 Aug 2025 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754410119;
	bh=0yi4/feUEbr2kJo/l0wIaYw3exx08Do2z81U+NjJSB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKLcd2FzISQ+hXTPZWbCDSXbg1oi7sj0cNHZvXWHjJDmtaRNFm21x7E7+1VNMPVoL
	 oxu0csR6lY3v46kgb0J0UtNfpOlfTsGGkirFJOTXrhNpCCaFoWIFvIcUy1/MP7AdfX
	 NvQ0jCnbrCX3O6uz9b2/NCgXttdZbTI/N8IlkLwNZYMqmrmehIgOfIAI3bBsu2T/bu
	 9+U8MCbPtxWSrgalR5HAyI5lwDByrSL9/Z9StpiEQ9WnuGXsTt2yfvZSi3yk/xtgsP
	 bv3fRg2fGNMMVefUWYM+i4Bs7zHpco4T6RpEvbQAdpXrORFljYudQCP3NjKS1B3iOL
	 sMJW/6TuL84AQ==
Date: Tue, 5 Aug 2025 09:07:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: Compare HMAC values in constant time
Message-ID: <20250805160740.GA1286@sol>
References: <20250801212422.9590-1-ebiggers@kernel.org>
 <20250801212422.9590-2-ebiggers@kernel.org>
 <aJIMGWFDZejNwAVP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJIMGWFDZejNwAVP@kernel.org>

On Tue, Aug 05, 2025 at 04:50:17PM +0300, Jarkko Sakkinen wrote:
> 
> I think we might want to also backport this to stables.
> 

That's what I did originally, but on v1 James complained about it being
characterized as a fix.

- Eric

