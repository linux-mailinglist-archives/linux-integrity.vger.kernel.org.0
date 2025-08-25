Return-Path: <linux-integrity+bounces-6902-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE300B33FC8
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891573BBAE4
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70A155322;
	Mon, 25 Aug 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="PkZC0qH4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F510E9;
	Mon, 25 Aug 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125745; cv=none; b=BTr9WXDc2xgyn74PQfy5Wix6UZ/orykpnYzq7AqrBp9VlK0qUUUIlY0R/J4SZO1prdACxHoVssQpBwyME+SA3Sc5ucDpMrpisNkpYYwNyxPkXlS2W5v2S7HiaCFZaRhH+4w+P6x2epuu2GMb/RFohD5PrL6c18MJnxxkPWYOAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125745; c=relaxed/simple;
	bh=HOhpbajuKvguEPDvQEWxA6zlRHv42ZpA5+blMxf+57o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLNpk3RUw2WA0iSEM7BRIC2fKcR71TamF7PnU5u6zTpnZzz/MJZq4YFSz/7rfqd6ph7nhDhpCIQS1tFWoogakRvckOzByqHJj+olDYqqPKsr1P6NOLHKOM4j+OlzIL6l/0bLsALS2E5gmCC95omhRF+r7zo9cF2DOLtIHdsFDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=PkZC0qH4; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mmQMqsoRaSMciWcQ3pQ53yTe9q/g/gqBue99YjtGUAc=; b=PkZC0qH4+KmGmZeIErWu+uYrqx
	YDH1RCtqSDFR2nsbDaLNqGZj9G/mz6BbzkeqZGxLjSnt/78VCTjBlHKb+WCqsuXRUx4p6x1xJjqdB
	rEUkFK6cOMgjo6btHexIr9Pio4RaZ3G9fYB/ZP0QVDZw8i8yAvlGE4kKM9jQiJVl56xkUzmp7A++2
	zGtxyxJY2gQF7xLLdyiDK9YHEr6VxEwxYYB9ubR/lvmfERid02tZyXkhJK8OpPk0OJUYVUmrRzum2
	LKX4ozqwwBABMCFc9EHcHv1CMVgoenTo1jLqfeWTLIZQQTy5OozAINzF1Gokdbqnr0hsul/+UEyiY
	0qmJ6FcA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uqVwE-00E3hr-0x;
	Mon, 25 Aug 2025 13:04:38 +0100
Date: Mon, 25 Aug 2025 13:04:38 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKxRVlyNXUGBwJ2L@earth.li>
References: <aKmwPFb4cCk_E-ob@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aKmwPFb4cCk_E-ob@kernel.org>

On Sat, Aug 23, 2025 at 03:12:44PM +0300, Jarkko Sakkinen wrote:

>My goal with tpm2_protocol is to have ACPICA alike model of imports as
>the crate is driven by TCG spec updates and it is very likely to be
>also used by TPM-RS (also via import style process).

I'm not entirely clear on what your plan is for this / the existing TPM 
drivers in the kernel? I assume it's to eventually remove some of the C 
code in favour of the Rust implementation, but I'm missing exactly how 
that's expected to work.

(Given I've spent a bunch of time this year tracking down various edge 
case issues in the TPM code that have been causing failures in our 
fleet I'm understandably wary of a replacement of the core code. *It* 
might be a perfect spec implementation, but hardware rarely is.)

J.

-- 
/-\                             |    It's deja-vu all over again.
|@/  Debian GNU/Linux Developer |
\-                              |

