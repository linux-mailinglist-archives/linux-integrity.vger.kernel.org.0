Return-Path: <linux-integrity+bounces-4039-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC909BFA3F
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 00:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74EE1F22228
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333CE2022C1;
	Wed,  6 Nov 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njxY4Y7X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA9383;
	Wed,  6 Nov 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936436; cv=none; b=fEVQINmD+6aFg5ogPJ1E+Knt40U0PRdpxHzYsPlh2VpGmrPFitFx9m7eT6ZihLSKb7uhgod5hHAibAVTyAJqxB4VRBxSEnNutGaRUirpnzQ9Ff/z9WGBkekEpir9w/AqLPSpJldsKaAOVx6K9yqknUsdOdaH8d+qdx3ppJiW+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936436; c=relaxed/simple;
	bh=3QtCqY2ZAUWBCu848of9UUBkU/Uq+o/yLi4fFYFPYRE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=m4AOglAEvK99aLCioHLOYhsjztKudEpdZ+ZyHT4D0qDryho1RqsYB8yd//du1X2F0tTI25J0dAIDUH7sVXX+07JFPHdDylOJV8qnpKCkVd9PM8TgiPFlhuYMoF7af+r5X9qLEq8JUmW4fUjdbLimEOws+foyX8yyTZCrpeTUR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njxY4Y7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224B7C4CEC6;
	Wed,  6 Nov 2024 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730936435;
	bh=3QtCqY2ZAUWBCu848of9UUBkU/Uq+o/yLi4fFYFPYRE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=njxY4Y7XrwLPxoRFD3I+WMLmAY9ydcRiOD35mnYWpeMTNPL8xeNRTKvcLDIJ0Erph
	 vsXIdfrlgFatYTXagniaxq5fVf0Y1LlZalrKgEck0+Z3lYHe2QkXvNrI0iSFwjXRmq
	 rx44mpxL+0qjU+xuQ4lcsUOcC3MwT0O/j/SvsEe1nchogv1FIq5vrXcOhrIJTJDXIG
	 t4ZzY4jTzP5AWdElK77BOGsCP6FH6h0XdRHHgz5IDKB8VLNnUf4N2d7rVD4UqC8Ni5
	 JXxmiZJzFL49oroHicWAVSRcasYbUk8knNinN5dvHqOdL7XYm9gf9eZ5l+LHxB2OI3
	 GQ+aXso88Y26A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 01:40:31 +0200
Message-Id: <D5FHR6UVEH4G.1OE6D5PDU26X5@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Paul Moore"
 <paul@paul-moore.com>, <linux-kernel@vger.kernel.org>,
 <christian@heusel.eu>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241015193916.59964-1-zohar@linux.ibm.com>
 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
 <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
 <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
In-Reply-To: <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>

On Thu Nov 7, 2024 at 1:22 AM EET, Jarkko Sakkinen wrote:
> > I'm a bit confused here.  It's TPM2_PCR_Extend we have the trouble with
> > (as Mimi says in her email that you quoted) not TPM2_GetRandom.
> >
> > The random number generator reseed occurs in a kernel thread that fires
> > about once a minute, so it doesn't show up in really any of the boot
> > timings.  Plus even with sessions added, what there now isn't a
> > significant overhead even to the running kernel given it's asynchronous
> > and called infrequently.
>
> Ah, right then we need the boot flag, and my earlier comments to the
> parameter apply. I've never used IMA so I don't actually even know in
> detail how it is using TPM.
>
> Now that I did some seek I mixed this up with the report:
>
> https://chaos.social/@gromit/113345582873908273
>
> Anyway concerning this issue and patch, my earlier comments still apply.

Makes me wonder tho why do we then export tpm_get_random() in the first
place? HWRNG does not needed that export, and the code does not have any
of the mentioned features.

BR, Jarkko

