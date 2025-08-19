Return-Path: <linux-integrity+bounces-6879-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46487B2CF72
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Aug 2025 00:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC3516F3A7
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Aug 2025 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852F2222B4;
	Tue, 19 Aug 2025 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obP3ZuSD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B9221F0A
	for <linux-integrity@vger.kernel.org>; Tue, 19 Aug 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643130; cv=none; b=gs1PMfSO/SNA8K7MYvGQIqBVKP+/qiMHnMCXGC7LqfZP1lGhDb8/oymI1C1sL41qiw6xj8dVONE0O1Cy3cqmEC459fYEL0h9Kdhewr47AJ5Rv6FPZ3PqsxETgfmelveAQJVw7fBn4ODGndKIkg3DwRpKCZj6avlIn2bDvBToOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643130; c=relaxed/simple;
	bh=GzBivtbgMu7i0vc+VdHkreLxd7ZzWAV1e+MSZhfgl28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx9iHgOEiMPjUbS9KTRxX9FGPFUJNLiuo1fe8Jb9WxKuis3nDuaV3G+jJuLsX1LrKObH5+FJqFHjWIVZWrDI2FcjW8fvXaW9Xtqj5kKltu02stQKefsLITC4quJN9O0KGS49UlVodScP24G68NBVK+vTjbf4thrGae4etNw8Uzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obP3ZuSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50572C113CF;
	Tue, 19 Aug 2025 22:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755643129;
	bh=GzBivtbgMu7i0vc+VdHkreLxd7ZzWAV1e+MSZhfgl28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obP3ZuSDqoAkQetnEAspfPuhaoApnumiNxTWzwXeYygm2wlD8xs5kM1qhGyzQvenW
	 gih/5SGw3kCtrudWzMJx5zb2GevGfhNeuhPGtvki/+wbpDjrkYS/WFFCtIkAuLM8qr
	 1ItvvTnX3ExnTOADcCaY3j0bYHgci7a7N3cPH0Ueo4Jiguq8TOciXZhXjMBS1pZ8IZ
	 QbOd4I80MUY4bqq0jEK0qRVltwdnZi9ZBLDYSHHaxugS5jnyCTn4zEBMqbc1SYRZk5
	 t0T0LOjn2v5qyGOB/p3gXwwoWu0Cfj8KU63qDhmWNVLxTwu1p3X/RxJG3y1zBNFOvu
	 qtZSFwRbgQqvQ==
Date: Wed, 20 Aug 2025 01:38:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aKT89ojg5bvG4Sr0@kernel.org>
References: <20250702202851.33344-1-daleksan@redhat.com>
 <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
 <aKNlck45-FF_p40t@kernel.org>
 <CAG+gbFe07nngs2-2iifeK7usAEo3C07NuSsQU7jVpps0m-3RzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG+gbFe07nngs2-2iifeK7usAEo3C07NuSsQU7jVpps0m-3RzA@mail.gmail.com>

On Mon, Aug 18, 2025 at 03:12:02PM -0400, Denis Aleksandrov wrote:
> Hi Jarkko,
> 
> Thanks for the detailed review. I will update the fix, test it,
> and send over a v2.
> 
> Hoping to get that over to you this week or early next.
> 
> Best,
> Denis
> 
> P.S.
> Would you like the v2 in a new thread, or keep it here?

Please try to quote responses properly.

Yeah, maybe it is better to open a new thread anyhow.

BR, Jarkko

