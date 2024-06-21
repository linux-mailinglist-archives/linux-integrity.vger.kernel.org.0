Return-Path: <linux-integrity+bounces-2907-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1991244D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 13:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1AA1C23B0C
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AE179658;
	Fri, 21 Jun 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="wmrHK9qK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F36178CE8
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970256; cv=none; b=Mj/uFj9HZFTQJFdY41pO03l9QpSSonhozrdnYL0E8bZw3kIFTPb1aj+U3bdEptVnY8HvpkYzyHQhdBmeHfaKbSDbro8nlwb2zSQO2hTW5gMv3wX12BbUptfPHbn+4IPfIZ4Uq4l+JKgo+Rbyq9h2efMbipMQEG12LwWhHDZRP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970256; c=relaxed/simple;
	bh=UOA4LNHVU4pCH20AEtQnR2364d4Ibt0P+ak21rlRMQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwYDJ7RMZTRS9HinrIQmCLUk6/4z9Qljesx3VwqX0aN2BUJ9J+qNMlDVjf+aymg4s9ryhiR6ZieeOYHifkVr6F5Lzr3AEhApFXnyKcdyUHI16Vs8Usu+SDbRBJ+MSR6VkLmC0SRpqGqlXL70IPex/CgSxn168dAbL5vt0GT67Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=wmrHK9qK; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LkxhuiYuBNJellNWJj//MDqSE0GNeAFLqTXtCdEPXQo=; b=wmrHK9qK2Vq5gHsARInQfmZIFz
	N+RSy3oF16F6FK9XVfd/1zQ9SR0mc1RWIquqdb6Mli38sUEcAUxMGhIc9hV4ToEF/ZzDnLi2Rk/Y+
	1rBr5u3uC5fB8grRdPVE27eGVzfbvh4a0SMXjuWzhAmyZHUZJLTly/wkxjr2J3S+8gWFfexV1M5+J
	wn/G/AJv99Gtyozpfp0r6OwIdkZ6nXRcs5Ai1FJ3NSOsK5/dr5+tZHwSOnmTRyXauzQvbl0MNb9VO
	qShYF3K2Q8jYPAJ23wgAxik8lUCYDvfr4OZtg0vIo0JFu8SLAkV1lmZs5HWCtd1chWUCRhm+vk/lz
	F3MoRjXw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sKcgd-0075dk-3B;
	Fri, 21 Jun 2024 12:44:12 +0100
Date: Fri, 21 Jun 2024 12:44:11 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-integrity@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [ima-evm-utils][PATCH 2/3] CI/CD: Disable pkcs11 providers for
 Debian and AltLinux
Message-ID: <ZnVni8XlHevSIfEB@earth.li>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
 <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>
 <ZnVP1nLxm1vhc1l0@earth.li>
 <5fc85cd29bc8456bfd1cd47b6dbe38bfbaeb4907.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc85cd29bc8456bfd1cd47b6dbe38bfbaeb4907.camel@linux.ibm.com>

On Fri, Jun 21, 2024 at 06:24:38AM -0400, Mimi Zohar wrote:
> On Fri, 2024-06-21 at 11:03 +0100, Jonathan McDowell wrote:
> > On Thu, Jun 20, 2024 at 08:59:11PM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Disable testing provider support on Debian:latest and AltLinux:sisyphus
> > > since both now get stuck while running OpenSSL provider-related tests.
> > > This is most likely due to an update in a dependency (OpenSSL, libp11,
> > > softhsm,  or others).
> > 
> > This seems to disable it for both Debian stable + testing.  Is it
> > actually broken for both?
> 
> There is no pkcs11-provider package on stable, so the test is skipped.

Ah, right. I can't actually figure out what tree Stefan's patch is
against to try myself. https://git.code.sf.net/p/linux-ima/ima-evm-utils
does not have the commented out softhsm2 / pkcs11-provider apt line.
Where should I be looking?

J.

-- 
Web [   Synonym: word used when you can't spell the one you want   ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

