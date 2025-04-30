Return-Path: <linux-integrity+bounces-6082-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0692AA4617
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 10:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B67466628
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD97521B9F6;
	Wed, 30 Apr 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrw6hQcR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2E21B182;
	Wed, 30 Apr 2025 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003496; cv=none; b=f5yNNIBAXuSyyWFFqDoUZk/QRoLlFQ0JuyfLPGxwYsSKHxUGNlN7aeyFCTlZxKyLIFHMIlKAafqcKuZYrOjdtRagdLXGy1+gGCvUpyavowzV/h8PrwmYUAFNdP9GgHotVcY9Pd+niaQXwgkdCYLzWPds0Q8O+UL7xWXBhLM0CCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003496; c=relaxed/simple;
	bh=Ll3KSEqa1UYp5DsI2uGdvjwuMS4ugb23LjatdJSgsJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndnyM4TOGyACTzx5eVVzOoxI0sLRG2ZhGazMrlUEOuatu55VipBd2v1ueBcYkQWWqMqe+Hg6Oj33pEnm4mIL+f0xtd8BjzSbDRes3wff5y3NSpbtAtX4HeOZ9jJ8WIr46XgzTbOVKCd0M4V7QNiQWhKqWC8AptL0uMIlA6cs9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrw6hQcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D954C4CEED;
	Wed, 30 Apr 2025 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746003495;
	bh=Ll3KSEqa1UYp5DsI2uGdvjwuMS4ugb23LjatdJSgsJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrw6hQcRBj+PQvfvFioygyq8v/eSiOAUv39rnKVE/w9X1EF61Mx0CwWzN1+19GarC
	 RuFUYGve7a/eQj/crVN/u3Szpf0rO5XpENbRXnvDrCuYpgiwwr2NjfBW5e4UReg4X7
	 V2yrCniCmQuOvqHaNYvYVPVJVWpGs5QpM57g6xht52RDOzhptXbwlaD7vlNpZX74M+
	 zBfQrGx4lH2fGSw4HjTS1H1gl3ZrtRWnGQmJnpMaRSdyzCNmemrAvNg73yIHb79QSJ
	 0YKk2yh2GRCJgL9HzAjCLI6Wve00w1+6qeUvjKk3lSMGwAiJknm0GtBT/AuMW77kDI
	 DWk5fXYaHwKhw==
Date: Wed, 30 Apr 2025 09:58:09 +0100
From: Lee Jones <lee@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de
Subject: Re: [PATCH v8 0/5] Add Loongson Security Engine chip driver
Message-ID: <20250430085809.GD1567507@google.com>
References: <20250418093506.1349-1-zhaoqunqin@loongson.cn>
 <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
 <75bb29fa-6d77-6f95-eec4-ee183190da17@loongson.cn>
 <aBHc2tT2-Duj3_-A@gondor.apana.org.au>
 <6b7385ce-d8ad-1be9-4503-55460f40fe72@loongson.cn>
 <CAAhV-H6ku=imPGqaFrey6hCMwXSL4Qsoif9Rv=Gko2R1CBtGmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6ku=imPGqaFrey6hCMwXSL4Qsoif9Rv=Gko2R1CBtGmw@mail.gmail.com>

On Wed, 30 Apr 2025, Huacai Chen wrote:

> On Wed, Apr 30, 2025 at 4:47 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
> >
> >
> > 在 2025/4/30 下午4:18, Herbert Xu 写道:
> > > On Wed, Apr 30, 2025 at 04:14:40PM +0800, Qunqin Zhao wrote:
> > >> Sorry to bother you, may i ask is it fine to move  the Security Engine base
> > >> driver[Patch v8 1/5] to drivers/crypto ?
> > >>
> > >> The base driver uses MFD  interface  to register child device(tpm, rng) , as
> > >> done in
> > >>
> > >> "drivers/iio/common/ssp_sensors/ssp_dev.c" and
> > >> "drivers/firmware/xilinx/zynqmp.c".
> > >>
> > >> Thank you, and I look forward to hearing from you.
> > > I don't mind at this point in time.  But if this driver were to
> > > develop features way outside of the Crypto API in future then I
> > > may change my mind.
> >
> > Hi, Herbert, thanks for your reply.
> >
> > In future it just add child platform devices  name(sm2, sm3, sm4) to
> > "struct  mfd_cell engines".
> >
> >
> > Hi, Huaci
> >
> > Let's go via Herbert's crypto tree for the base driver patch under
> > drivers/crypto/loongson/,
> >
> > What do you think of it?
> In my opinion drivers/mfd is better, because another user is in
> drivers/char rather than drivers/crypto.
> 
> But if moving to drivers/crypto is what Lee Jones wants, then everything is OK.

You can move the driver, but then you must not reference or use the MFD API.

-- 
Lee Jones [李琼斯]

