Return-Path: <linux-integrity+bounces-6778-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11DDB1B530
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 15:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBC33AEAE8
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86398277003;
	Tue,  5 Aug 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZx+zMvi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEE274B33;
	Tue,  5 Aug 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401507; cv=none; b=ODLTGJjtAgNyJh+frtqS5TrpW+7uMBlN0VPbl+zZxdtxVqTWEZkc/Vn9iHblRwnTvIGzlccfhsMGv+m5MLOSB6GNT+TCycsDnRTYnbSTD46pCrq3606DJ5Q+6ecS9lOcbc7u7z7PGRGiBM/dIPUXQUnnHlzNNfZXeXlwqHz3WTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401507; c=relaxed/simple;
	bh=DPPKym/d7/t8DT6cRYgC5qKSiHrUid4Smz2gSFS4+kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D88pkS9bDRPD7I+riEPq82VJvhh/Lk2CnLPy2txNuWSel4WhvA2asx5HB1HqD8i7MpqVWzqx0ZQbIAQMEkvr54m6MrP4fQrhuvHvzi4YKZ5hjgKNvK+d+VBoFkzBPFbDfR5YcWy2Gh3q2tZ0O7Vd7hgm8+T2+AZ17CQWaobOlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZx+zMvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E24C4CEF0;
	Tue,  5 Aug 2025 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754401506;
	bh=DPPKym/d7/t8DT6cRYgC5qKSiHrUid4Smz2gSFS4+kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZx+zMviIUhVGCfMYhabOIsQFc5gN0z1Gt4b1ay/Cpl9khyXkiPRpJCIbFS6WFKNY
	 pbHpQZJBI6BWabGHiOWm4jhP570v1xGER4eUw4T7129M9XD9Sd/y2j3RbwpfdjE1zN
	 t/RUY/z1cz4ghQZEEu3PoAb+faOL/qd3pXD7n7sv9yf7vxsc9VjzVwjdz47icLB9V6
	 yz6fQPh6bi3usqQqy0iqSI0+p0pHIag+pcdmSdN82GT/XDVKxCnrkpBZZjmAtOhakm
	 ne6Pw+LIGH2UWvQtfQoy5q9jrzlXPBhYqBbdGoD18BIfs92C4ch3LqV16lVp77XCBp
	 LIt5KouKKFs9Q==
Date: Tue, 5 Aug 2025 16:45:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] KEYS: trusted_tpm1: Use SHA-1 library instead of
 crypto_shash
Message-ID: <aJIK33R5lgNYb2fR@kernel.org>
References: <20250731212354.105044-1-ebiggers@kernel.org>
 <20250731212354.105044-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731212354.105044-3-ebiggers@kernel.org>

On Thu, Jul 31, 2025 at 02:23:53PM -0700, Eric Biggers wrote:
> Use the SHA-1 and HMAC-SHA1 library functions instead of crypto_shash.
> This is simpler and faster.
> 
> Replace the selection of CRYPTO, CRYPTO_HMAC, and CRYPTO_SHA1 with
> CRYPTO_LIB_SHA1 and CRYPTO_LIB_UTILS.  The latter is needed for
> crypto_memneq() which was previously being pulled in via CRYPTO.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
 
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

