Return-Path: <linux-integrity+bounces-2975-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA3E924CED
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 03:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BACB22D0E
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 01:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2D21373;
	Wed,  3 Jul 2024 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbWxUkCl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F911645;
	Wed,  3 Jul 2024 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968411; cv=none; b=e6BHIK3mrglmccmoNV/r6nLER1yNJVh3uFtb49dmzYeukdRIf746B4skd7BblbfKnK4bTQD356Hlrvn0SrEa9XRDywQW9xPLGodYi1HkYSeChE1V9xUndXPC8TTvlU1EunPIjSK+z85+PKFqa2m0gtxL8EbfG8l4A+byeQjZGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968411; c=relaxed/simple;
	bh=lFjYUrOF7VxhaDL6M2zQYg/d02i9zQFo7I3m20cFD2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YRFQeBM1GU1umRXye8sy2U4koXrhFIHcC3YRptu15y8WPDo2gBYq5jfpjrgBqU3fRT9HnNiuevKsb7Q/Wz3C2jgdS0HnmbvtCNpVBizdmY6KlT0o4jlYnYBEjPTANgGGYgV3PSwUM42iurhhGqsXyd9wpv+5mcGjb7qH+0JUhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbWxUkCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41ECFC116B1;
	Wed,  3 Jul 2024 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719968410;
	bh=lFjYUrOF7VxhaDL6M2zQYg/d02i9zQFo7I3m20cFD2g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sbWxUkCl1dM3JNyZi5jytbVt6B9yMS0pJ63BT+ZfxKLVM0TZEqxdVEkQuONE+UJqB
	 +uRxZpd/QyF2zzT1cENI36TkIi4EzZl/bLY1+9aHkuL/AH2wChOJF8GFj5kcVx2ypv
	 2BFdkSJsMtxVBrVeWq8rDiLEzVlsUk9R58R/ih9N9wUFJUHD4bpPlmskwMSdNrsPbi
	 +xBIj8tgmC6CdYB7ACpD73k4Ccm4k0DsdV/tT839nsKKxauxOTok+vnnlc8OHJPhDi
	 NsMhjiQ1bckpSpKOcuacVAzaMdvroNnQsBiAoMcW8aIbhm5HI4rsEjwjzodp4UJyma
	 slYJ9ruaQuP5A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jul 2024 04:00:07 +0300
Message-Id: <D2FHWYEXITS4.1GNXEB8V6KJM7@kernel.org>
Cc: <naveen.n.rao@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Jarkko Sakkinen"
 <jarkko.sakkinen@iki.fi>, "Stefan Berger" <stefanb@linux.ibm.com>, "Linux
 regressions mailing list" <regressions@lists.linux.dev>
X-Mailer: aerc 0.17.0
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
 <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
 <9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org>
 <53d96a8b-26ef-46a3-9b68-3d791613e47c@linux.ibm.com>
 <D2EFNJTR80JS.1RW91OVY1UH1N@iki.fi>
 <e7db74a0-cd5c-4394-b87e-c31ea0861ea1@linux.ibm.com>
 <b7559dbb323d16fb334f8f8f35b8fda3fb6e481c.camel@iki.fi>
 <85f882ff079554c41a73d8ad4275072c5229f716.camel@iki.fi>
 <D2FHD82R8YAC.YBL9FAIVMBWL@iki.fi> <D2FHNOGO624G.HX2SKHYFXU4L@kernel.org>
In-Reply-To: <D2FHNOGO624G.HX2SKHYFXU4L@kernel.org>

On Wed Jul 3, 2024 at 3:48 AM EEST, Jarkko Sakkinen wrote:
> On Wed Jul 3, 2024 at 3:34 AM EEST, Jarkko Sakkinen wrote:
> > https://lore.kernel.org/linux-integrity/20240703003033.19057-1-jarkko@k=
ernel.org/T/#u
> >
> > There's also bunch of other drivers than tpm_ibmvtpm so better
> > to limit it to known good drivers.
> >
> > I can take at the actual issue in August and will review any
> > possible patches then. This one I'll send after my current PR
> > for TPM has been merged.
>
> After this patch has been merged to mainline, you can send your change
> as a feature patch for tpm_ibmvtpm and replace Kconfig line with
> "depends on ... || TCG_IBMVTPM".
>
> This zeros the risk other drivers than tpm_tis, tpm_crb and tpm_ibmvtpm,
> and thus is the only possible solution that I'm willing to accept in
> *fast phase*". I.e. the most conservative and guaranteed route, like
> anyone with sane mind should really.

Ouch, that won't obviously work so please ignore this! :-) Sorry.
It really needs to be !TCG_IBMVTPM because otherwise TCG_TIS_CORE
or TCG_CRB would leak the code over there.

BR, Jarkko

