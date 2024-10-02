Return-Path: <linux-integrity+bounces-3726-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D7E98E177
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 19:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA071F24B4B
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365011D12E5;
	Wed,  2 Oct 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="jqa0KgSK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACC16419;
	Wed,  2 Oct 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888685; cv=none; b=K5Bmj9TyZ+8c/MQ+SmApdVCoIp0DQCgyWGw3prNeHofZtqJFF5u34cMe7pJ13NWVFnwP5j/l7F5XUKKDqzzvDCK+GvdboLBPsQIyuZBbQnjdeSw8IH+CvNcxatPiBxFhtBSDWuJ4Rp791kg8FXiT6+tET7fEEtVo/7KD0zkZwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888685; c=relaxed/simple;
	bh=Zke3y3eke8w+ewmBfu9SuObgfHveGhN3Gtqgt/1zb4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bSt1AnGeNvPzwEoZUyhTbEu5jVIw8vUzrD7X/0ANPPwhJEuDd0rLoVgbrcscfv0+YDJ4QFySglNU7Nf79GFa7E3E86o/GFRdYqVNUPKic/GCydAyKPNwrk7OA6kMTYpj6eXVlmNNQa8uDZhkwuS9A3ol/dbnd0PHnrzJNoIWTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=jqa0KgSK; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=j2oskKuZlf6gOsjHJS2Mo8WU7zbM9/s5ApMgHQXyIuw=; b=j
	qa0KgSKKIvZ8MxZgXh1GrHB8PGb8eIPBq2wqRauYRtreNRNAAyrSvTLxkzgm2vuS+RXlXwLr6YY57
	QS/aXjwgYdyUOVsA9bX9cBBvAn9H2/iBdRt9AY1YEBQE/fSPpU01dDMqoSzcUZ9NskSmmScKOlGmF
	PdAxf6lA1JKrYupfVvcnNnuyw4yOI8Vu+Hrw62Ct9SnjRxEU7CfXMqvi6cjjA1HnPQulH4MsBIbxc
	odXfvW+QoT/pPTn0XLFUFGjAa91v9DOLWXBr5QKxnszO8POs6vey8i1dIv7jNVy9HolxNCvzcZmGl
	Z/GksrbMqFxbWQExBH8ASEAXUj0NKhxJg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sw2ky-00DFgb-00;
	Wed, 02 Oct 2024 18:03:20 +0100
Date: Wed, 2 Oct 2024 18:03:19 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Problems with TPM timeouts
Message-ID: <Zv1810ZfEBEhybmg@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We have been seeing a large number of TPM transmit problems across our
fleet, with frequent

tpm tpm0: tpm_try_transmit: send(): error -62

errors being logged. I don't have an on-demand reproducer, which makes
diagnosis difficult. In almost all cases it's a transient issue, and a
subsequent attempt to execute a command succeeds, but especially when
the kernel resource broker is involved that can still cause problems, as
the kernel is not doing retries here.  Uptime does not seem to be a
factor.

This is not yet using the new HMAC session bits; kernels affected range
from at least 6.9 back to 5.12. Historically we've not paid attention to
TPMs long after initial boot, these days we're now looking at them
throughout the uptime of the machine so perhaps discovering something
that's been latent for a while.

I have a few things to try, which I'll describe below, but running
through them will take several months due to the difficulties in trying
to track the issue down over a production fleet. I'm posting here in
case anyone has any insight or ideas I might have missed.

First, I've seen James' post extending the TPM timeouts back in 2018
(https://lore.kernel.org/linux-integrity/1531329074.3260.9.camel@HansenPartnership.com/),
which doesn't seem to have been picked up. Was an alternative resolution
found, or are you still using this, James?

That was for a Nuvoton device; ours our Infineon devices. The behaviour
is not firmware specific; we see the problem with the latest 7.85
firmware as well as the older 7.62.

Things we are going to try:

 * Direct usage of /dev/tpm0 rather than /dev/tpmrm0. This is not a long
   term solution as we want multiple processes to be able to access the
   TPM, but is easier to deploy. The expectation is this will lower the
   number of issues due to fewer TPM commands being executed, but that
   this is not the root cause.

 * Retrying command submission on status timeout. We've had details of
   an errata where the status register can become stuck, with the work
   around being command resubmission. I've got a patch for this ready to
   test - I'll follow up to this mail with it, but need to actually roll
   it out and test before I'll submit it for inclusion.

 * Instrumenting other timeout points to see if we're hitting a
   different timeout.

J.

-- 
101 things you can't have too much of : 8 - Hard drive space.

