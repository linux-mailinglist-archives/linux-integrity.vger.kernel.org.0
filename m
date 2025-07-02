Return-Path: <linux-integrity+bounces-6591-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB50AF656B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 00:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3432F1C45B62
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC33B244668;
	Wed,  2 Jul 2025 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQeEclC0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E607E0E4;
	Wed,  2 Jul 2025 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495978; cv=none; b=u3UmmE4VgVEeQIgxXeJBV1NAExoG3SDzlHZTi20sdZS989MnGg6HHFXVlqfR6n1sPZdRxq3JHWdzZ5WLbqo8SWaKEXhecdogSwK4Pfao8BUu8vxx3j4caJGU/opy8LTlNK7Be1c2aFbZtaKrqwSnGSkC++RTAWhyqRuy0lFZWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495978; c=relaxed/simple;
	bh=Me3HBaRpSo2Drqnxh7919SJ2zIqa4A1CgSaccDaH15Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUBiJelPf2OIdV2ZjiEST5InjReksyUyITohwdOEO1rzqujdxU/M8TN/eLW/qV0GtTePWHSjrOUgDj+9xkIMUpeyo5QuOgWzUQcCt+DMhiF06EI1wN6jZFnu10MO5XhbSVnEbQSvd2OIClUOh6TRyIP7RewRlI03N4DSFCgOhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQeEclC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD892C4CEE7;
	Wed,  2 Jul 2025 22:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495978;
	bh=Me3HBaRpSo2Drqnxh7919SJ2zIqa4A1CgSaccDaH15Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQeEclC0+BcODyFGyYpqVU+nwhdmD8UTLTTs0dPluum0Z7Okf6d7kxjkSdhq0FqvN
	 YOkxXKJhFskAZa3vy9HJQ4NM2XHW9Uo5HL7w6Na265sLmffsEo3fB/yp2ilFQJB+oK
	 zx6uC+pd93K2Yr0MyQEV5UR4Jc8CCyrC5k05+kW0umt8pxoy4bC6LNRKaK+uczdApZ
	 LwrCuE9xvrZhBMCqEOJrkzkqBE1EQdCVzo4Do8EZvmV5hH2x397SOma26kHgpM3UAi
	 nIW2Gzmf/uqF8Szb4E1RJ8y0X3I1gRfK9cfErJ3jp5jikuN9R6voN+SiywQVA1wrJG
	 p5XwVppM/N4bA==
Date: Thu, 3 Jul 2025 01:39:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4] tpm: Managed allocations for tpm_buf instances
Message-ID: <aGW1JvClZ4lRaaqB@kernel.org>
References: <20250701145136.82726-1-jarkko@kernel.org>
 <7316e17a4d8dba36a4a773f87dc4f516697dd402.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7316e17a4d8dba36a4a773f87dc4f516697dd402.camel@HansenPartnership.com>

On Tue, Jul 01, 2025 at 10:51:55PM -0400, James Bottomley wrote:
> On Tue, 2025-07-01 at 17:51 +0300, Jarkko Sakkinen wrote:
> > Repeal and replace tpm_buf_init() and tpm_buf_init_sized() with
> > tpm_buf_alloc(), which returns a buffer of  memory with the struct
> > tpm_buf header at the beginning of the returned buffer. This leaves
> > 4090 bytes of free space for the payload.
> 
> Shouldn't this be accounted for in tpm_buf_append()? right now it will
> let us run off the end of the allocation by six bytes before it signals
> overflow because it's checking final length against PAGE_SIZE not
> PAGE_SIZE - sizeof(struct tpm_buf).  I realise this should be an
> impossible condition in production, but it's useful for debugging so we
> should be accurate about it to avoid hard to detect bugs.

Fully agree. Thanks for pointing this out!

> 
> Regards,
> 
> James
> 

BR, Jarkko

