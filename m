Return-Path: <linux-integrity+bounces-2571-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6C48CD361
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AF61F21406
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9E14A60E;
	Thu, 23 May 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNxg/yTX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1114A4DD;
	Thu, 23 May 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470088; cv=none; b=Dguk6CrRu68GEVsMZRkhwSlmkRLbcitzOTgUs+vNP04j8BdxfYflkK5tmHKGbvN85DxHnDDZZ/ioZ2kIFpuOhUv70StZW9hs/FePqws6oUUd8DAY5fpafmNYbq2c/OY7ibdN6dFrgfsQ6tWSMbBVOJ34gwi02SN95zlmYYaMZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470088; c=relaxed/simple;
	bh=X0IAiBqRUY0FLq2kdKZIILu6oiVxWr2GiV0LmniCoGc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LLN6eZhi/4x46z1p38hn9FiZHpx0YgajfWuYJHA9Tav/jKfX/vozlIhno30CcOYGqMI1cuZjoRoAZxbJDYYCnxkN9x0aDzszlp8Fy1JWU/gjDP0XNNiJpSbbUHByZjSmdX7CZx1lOp/Y99kje8gplFQbh84CwEi37sMvuPbctyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNxg/yTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B70C4AF0D;
	Thu, 23 May 2024 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716470088;
	bh=X0IAiBqRUY0FLq2kdKZIILu6oiVxWr2GiV0LmniCoGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNxg/yTXnENN84R1B2lT5zl4TJlhQ6yOwB9Npy0CueD1wtrpmzDDZK37QO8ypw2b/
	 4CPn58JDHOJx4atTlQIB2L9vjw1tRZgjWeadTKPV9z/H9ytHXn2R1XHEfU7pk99/TQ
	 qlmxDXIQN3E9bTUCMBQtjcr0qfOBOl/+x1GyEgbRgAJPN6DIk6L7FSRZGppJNBjgOw
	 wUWCXNx/nsvFSlz5UmtQg8kms5cHYYDOskoiqGWq+Sfe+UFQkB/150aMPx2n3WZj4K
	 jF3jmvUiDWVrmEXWaspw9Blvndmpv9RPgwSkKK8P7bmzQ4psxsFguvsZDFH5wxozTo
	 2eA+QRMpaCZrg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 16:14:42 +0300
Message-Id: <D1H1V26J3VWO.2KLLJQU3Z54ZJ@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Use ASN.1 encoded OID
X-Mailer: aerc 0.17.0
References: <20240523130839.31265-1-jarkko@kernel.org>
In-Reply-To: <20240523130839.31265-1-jarkko@kernel.org>

On Thu May 23, 2024 at 4:08 PM EEST, Jarkko Sakkinen wrote:
> There's no reason to encode OID_TPMSealedData at run-time, as it never
> changes.
>
> Replace it with the encoded version, which has exactly the same size:
>
> 	67 81 05 0A 01 05
>
> Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so that
> the OID can be simply copied to the blob.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Oops went out by mistake was going to have "--dry-run". I'll resend
this one, sorry.

BR, Jarkko

