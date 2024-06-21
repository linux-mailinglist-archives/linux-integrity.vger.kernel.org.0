Return-Path: <linux-integrity+bounces-2904-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD828912292
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 12:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99889288B1D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09D171662;
	Fri, 21 Jun 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="JgZdF9ta"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9D16D33A
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966246; cv=none; b=E7RZaOkBavkbKgMP6pq8Q+fLkl/aBLAZjX9q0I4xjfJtRtxsDrxzajagKr67ktD6SYhzi1SC1iMJ9ItgXcpTS3MdiGWOKLqpdDpuZbTb+bb/FElRL6gtFKaSm1y14ecaSalCXokEqpTLwUrBhPgpenRXsLXsZKHQDK2w/qsXIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966246; c=relaxed/simple;
	bh=dE3nMpqleA6JwurZ/lD5y0+0oHyQDLImNJkTmPgJMto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alyA5HclDkWHKNXkNKvMFLsfUJb4lMCgzz7LScYGp2SuYORZNz8ru9k6WjI2nRVgXixOf39fwRHKlzEl68+pqXKy+aC2tJ7qzgM0sXAwcF0i5BclVXRHXum+cSKIDkF2mXbVH8w4V2EJ/wcM8pShBZIkvxXKVqtWT+nm6gj+nJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=JgZdF9ta; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=brCIO7bCiY2wOtJxhou1EetLJhrhUBlCGYM/3u3g0yA=; b=JgZdF9taNF3OQbzh/94ZiYl5+j
	27Uw5traohq3w9SckCX1ejGkHDe9GMFLQVqxJ88ziSjbrpK/0SgTVDELhnQP7Q2A8xmHY1g6LlsMV
	+lfnJntrL3LQix/I3AD4Y0IuoHJDNajbcySmUk9eK0YwSlBYqd7MpYAyiqeFdg0eqa2chibZ48M+n
	p07AWG9tPugqja/ncToQaw5SjDf8lrOzgszX0yHhU9BZwmnB4Z4H9SVUkGvObMfALkzMLcU9MSiTa
	Yo/wL7JxR96OxaproCHszb5kuTwMmqKYGYYNxC3tu3gTXHspaesAPSQhhbPk7Gdkdj/XELF8CsSBL
	6/mlziYw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sKb6k-0071O0-1f;
	Fri, 21 Jun 2024 11:03:02 +0100
Date: Fri, 21 Jun 2024 11:03:02 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [ima-evm-utils][PATCH 2/3] CI/CD: Disable pkcs11 providers for
 Debian and AltLinux
Message-ID: <ZnVP1nLxm1vhc1l0@earth.li>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
 <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>

On Thu, Jun 20, 2024 at 08:59:11PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Disable testing provider support on Debian:latest and AltLinux:sisyphus
> since both now get stuck while running OpenSSL provider-related tests.
> This is most likely due to an update in a dependency (OpenSSL, libp11,
> softhsm,  or others).

This seems to disable it for both Debian stable + testing.  Is it
actually broken for both?

> On AltLinux the issues is related to a pthread_mutex_lock() down the
> C_Login -> C_OpenSession callpath that blocks forever.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  ci/alt.sh    | 2 +-
>  ci/debian.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ci/alt.sh b/ci/alt.sh
> index f86dcec..f1eefbf 100755
> --- a/ci/alt.sh
> +++ b/ci/alt.sh
> @@ -28,4 +28,4 @@ apt-get install -y \
>  		xxd \
>  	&& control openssl-gost enabled
>  
> -apt-get install -y pkcs11-provider || true
> +# apt-get install -y pkcs11-provider || true
> diff --git a/ci/debian.sh b/ci/debian.sh
> index e1bae43..34125d4 100755
> --- a/ci/debian.sh
> +++ b/ci/debian.sh
> @@ -59,4 +59,4 @@ $apt \
>  $apt xxd || $apt vim-common
>  $apt libengine-gost-openssl || true
>  $apt softhsm2 gnutls-bin libengine-pkcs11-openssl || true
> -$apt softhsm2 gnutls-bin pkcs11-provider || true
> +# $apt softhsm2 gnutls-bin pkcs11-provider || true
> -- 
> 2.43.0

J.

-- 
I have found the monster - the monster is us.

