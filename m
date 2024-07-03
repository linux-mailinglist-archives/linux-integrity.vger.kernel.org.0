Return-Path: <linux-integrity+bounces-2973-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3D924CD8
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 02:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83931F2244A
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 00:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657E1361;
	Wed,  3 Jul 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2g0L0rv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7639B;
	Wed,  3 Jul 2024 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967684; cv=none; b=GHb9xjilZURM89ie0oe4/oiZghDQdhnpob986MMAPAkmeAgwVrfFXagxHlFpqgKxVKAVtklPMVEuMNbgjf1zVM0mY5I8EBBPpybkjfAs4sai+lHd+EW80o1nESfjD3cWBRvSJNKUIbX3rEJRRm1gbNCEaao63a5IJbrVwQ2Et+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967684; c=relaxed/simple;
	bh=1VcpuV2FfStRLvavkaB9W9ZVWw/27dwvy043xnumcIc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uaanynbjK1W9bZlWnjmye5OfK7Qfyl+1igj5is7xcAas5qzZn/p95sL5urSEdeOcg4V0V13eIOcU6eB90rWJL/a6nbdphyzQrAYN2Ot+ZMfj/QA8ER5M9+Xo/+YcSQuK90jaTVkr6H9r7v2yd7t/ZyO1k0O+2H4xaQdUCILyDJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2g0L0rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7F6C116B1;
	Wed,  3 Jul 2024 00:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719967683;
	bh=1VcpuV2FfStRLvavkaB9W9ZVWw/27dwvy043xnumcIc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=a2g0L0rvVlxqdwklQXrG7T3zapsQCIE77XX7VS/r0l1V/+mAsmadiMH1Uq3lWcmxH
	 hWcdoRIvHB/MMrSrmTRfyUMgixKmG4rTR2GV5eUMqnMDrhmpM5bZdq0LJKmqM0nf0n
	 NGiBpM+b+jVABKkhQzQ4mRM4BfeCV+Yx0jaQ7loTLtebnLI2AdcFvvnRzZsV8YEoEM
	 9wNSjye4IeQSSaATeL6d9OjTvDQW5XXymsNtVfnpAIVSqDHd34bCmqjMAM1zUoPDUX
	 ijyfomfEI68bKFWKz7+1qla1knFgX6YYLz7JAN/4EpjABEd5oAyZNeLFCJfPmr+Mnm
	 f/lm4JJ4qPUOA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jul 2024 03:48:00 +0300
Message-Id: <D2FHNOGO624G.HX2SKHYFXU4L@kernel.org>
Cc: <naveen.n.rao@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
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
 <D2FHD82R8YAC.YBL9FAIVMBWL@iki.fi>
In-Reply-To: <D2FHD82R8YAC.YBL9FAIVMBWL@iki.fi>

On Wed Jul 3, 2024 at 3:34 AM EEST, Jarkko Sakkinen wrote:
> https://lore.kernel.org/linux-integrity/20240703003033.19057-1-jarkko@ker=
nel.org/T/#u
>
> There's also bunch of other drivers than tpm_ibmvtpm so better
> to limit it to known good drivers.
>
> I can take at the actual issue in August and will review any
> possible patches then. This one I'll send after my current PR
> for TPM has been merged.

After this patch has been merged to mainline, you can send your change
as a feature patch for tpm_ibmvtpm and replace Kconfig line with
"depends on ... || TCG_IBMVTPM".

This zeros the risk other drivers than tpm_tis, tpm_crb and tpm_ibmvtpm,
and thus is the only possible solution that I'm willing to accept in
*fast phase*". I.e. the most conservative and guaranteed route, like
anyone with sane mind should really.

BR, Jarkko

