Return-Path: <linux-integrity+bounces-7737-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69415C926E6
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E16FB4E20DC
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29CA32E6B1;
	Fri, 28 Nov 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI3LAqBM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4622652D;
	Fri, 28 Nov 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342891; cv=none; b=k8TTOdKrYcbh0OeDu0yvuc5+uJp/OzPKSRf598XlH10vNvOCav5ECRhXtrLAsi3SBUq1AuiI6KEopiqfNHrbOmVpnbmztEcirPpcU59JCOUb47Fr01t2tL9UjjYwoJ91mgMAprfeGaPL2D0zVErzbcIvIGqXNLj77OngiX3fc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342891; c=relaxed/simple;
	bh=Vfv7i6W4jhlb1AZh7GLsz7jNAOj610qAMQpttCQJWpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVqy8q1KTvVcvx6RLiUQmV6wshj7CDXolqq3gH2qQdW4KXT8MdGHJchBO+a0cPqHGnI/lCVHBCPi2GD4JdTIo81R5jhTbf/JM1tRZwe1/u4pSiBjuT3um08NfXdAmGad0KaJyWahdUSRxctZ400YKL72ccabHJRPvvohn6KoctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI3LAqBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95768C4CEF1;
	Fri, 28 Nov 2025 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764342889;
	bh=Vfv7i6W4jhlb1AZh7GLsz7jNAOj610qAMQpttCQJWpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UI3LAqBM750GQlTsnM2/oBEyx1ciS6AelWLljo0yWMUVe4e8gIV/R7/CJd+b4vK1g
	 at172zI1H/U+vhczESz+mRbHE22rDJ//sLIUpkJMsRQKfXlbf3CCIyMQ1ZPCJmw/zY
	 Zt6GaiMkMkPWBmX8jFKt4hAsuWN05PCVDA7iO5MMNxkUoNSFgpHw1LO2HfGZoKHR8O
	 lnHrXm7JDer5jGRfoD6jtsuWUwTw6sVO3p9EKFNHaj3vTp7LGByRpbCyTWgYBtS5sS
	 sh0FEX39XyEO/Y9dD1MYCnSca55hgBQ9mIxf67c85GizZ9g5SleYWA5nOzy61KAeNa
	 KGsfQoyDNaC4w==
Date: Fri, 28 Nov 2025 17:14:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
	Stefano Garzarella <sgarzare@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 3/8] KEYS: trusted: Replace a redundant instance of
 tpm2_hash_map
Message-ID: <aSm8ZVheHZIIV4uJ@kernel.org>
References: <20251128025402.4147024-1-jarkko@kernel.org>
 <20251128025402.4147024-4-jarkko@kernel.org>
 <aSlvCROaUqwZ244Z@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSlvCROaUqwZ244Z@earth.li>

On Fri, Nov 28, 2025 at 09:44:41AM +0000, Jonathan McDowell wrote:
> On Fri, Nov 28, 2025 at 04:53:55AM +0200, Jarkko Sakkinen wrote:
> > 'trusted_tpm2' duplicates 'tpm2_hash_map' originally part of the TPN
> > driver, which is suboptimal.
> > 
> > Implement and export `tpm2_find_hash_alg()` in the driver, and substitute
> > the redundant code in 'trusted_tpm2' with a call to the new function.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>

Thank you.

BR, Jarkko

