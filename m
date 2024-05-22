Return-Path: <linux-integrity+bounces-2556-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF0E8CC361
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2CD1C20312
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF39518C22;
	Wed, 22 May 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBMSTYpD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7717550;
	Wed, 22 May 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388781; cv=none; b=lxOu4G0o0Olh7XUOo/eh6or7ZMnjATLwcNF2TAjyG8vl10z1CS2d2fQjDkJlNNv1KD6T+gLJ5f5OptS4GcYfBjXgq9irPvMxLTv6l3E9jGqTQhFcx4ocDOAH1nmpt8TA+vw/Usmh527KGWLI4qY6XnDtbySRH5+ScAjcl+8jS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388781; c=relaxed/simple;
	bh=hmqWc34qySE/ifAYgUKNgLhNP/qYm75CqrN0pa8Ttrs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=A0YGFfdMwAbm3oztBVwSe+ieCLq+B/tBfF9cHB4nJiA8y+0B73sMAW/AxHiEqKEOWtfUHlESvCMdX09EiimIJBSfvRhCSZJAFL2hDrZashy9M31dxDGHIaRZUHPq01E+I/1gkFE03gkmsiYN8gg9ozjedKp5nhLLtKTtUB63vCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBMSTYpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF499C4AF09;
	Wed, 22 May 2024 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388781;
	bh=hmqWc34qySE/ifAYgUKNgLhNP/qYm75CqrN0pa8Ttrs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZBMSTYpD7JiEJeqp2nKxkkEnq1evNKDPKrvJMV/LAknznCysVJzafPCJfSQwT9uys
	 UkTf7A6tZWTHtM64n1r3C5auETya1bVUY8HJDqqXRxfxsbfxgOp8LOEvwoBwuJ/jGB
	 eCeQj4dFz5QbBHuIWYWnS0y5TSV1dRdgRSGm12S1jmf7avqUH9ZudjaHlFYW9EGLqy
	 DEssBHRhGf3zl5B/Ij7gFOptPD1GllTfZZefjq+pdHUXliNIjJA3Pl79pnI1Ey6eCG
	 K6ss4pNI6c3UAblNwQS59VGjzpGUj5ep3T5EoqrlyinBEi9UwPUKFMD/w8nAXDz6b+
	 xGVO6/QsLmuLg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 17:39:36 +0300
Message-Id: <D1G91ISGEB3K.35SA67CPX59JE@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Vitor
 Soares" <ivitro@gmail.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
 <D1G5O2Z86E4W.2DHG4QZE2W2JG@kernel.org>
 <56e52200bd9ede6bcdcc907d24bd4a3e0dddd24f.camel@gmail.com>
 <D1G8FRJFBBAO.X8CAFK3K34VJ@kernel.org>
 <0d925d801d8988bb55afa476fb0564b052d54e62.camel@HansenPartnership.com>
In-Reply-To: <0d925d801d8988bb55afa476fb0564b052d54e62.camel@HansenPartnership.com>

On Wed May 22, 2024 at 5:20 PM EEST, James Bottomley wrote:
> On Wed, 2024-05-22 at 17:11 +0300, Jarkko Sakkinen wrote:
> > For tpm_crb we should actually disable HMAC at some point. It is
> > essentially a performance regression for it.
>
> You'd think that, because of the shared buffer and no bus, but you
> never quite know.  For instance several confidential computing early
> implementations used the crb interface set up by qemu (i.e. over shared
> buffers which are readable by the host).  For them the only way to get
> security is with sessions.  Even with the default Intel CRB, the TPM
> transaction isn't handled directly by the main CPU, it's offloaded to
> the ME (which we all know google loves because of its tight security
> boundary).  It is entirely possible to imagine a software interposer
> running in the ME snooping the CRB buffer.  A very different type of
> attack from the LPB interposer, but plausible non the less.
>
> James

Should have put "consider". I've tested with crb and spi and have
not noticed anything get stuck. One more reason to run tests with
that Celeron CPU from 2018...

BR, Jarkko

