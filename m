Return-Path: <linux-integrity+bounces-4675-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE3A23C2E
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787337A2BDF
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92424B28;
	Fri, 31 Jan 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJvyz0it"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3B1CA81
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738319126; cv=none; b=k2ubFEkh4Z8MVhcLjBXrips20YAQssGjzpCeRPDbuL3CQJuUaptFNp/UinCVBbo6+K6X7MXKKJ6CIajLVDyGkxIaJ7pf87F4f7ptR8XCfC4j1uf1jobOWztrtprVTjyes6I5A28E540IBXDZ47oVA5D/GCrjAx9umW59kxris7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738319126; c=relaxed/simple;
	bh=GRIcu//5Q5U/aXsV/JPZjbLkSk3juXa/4xH6nFrAH6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ONITm39v/IZqreEVJThRYfrneYT1BM71/P1o1dY44DIC5b9zVh+tHG0H2IJl81L6CjNVq10Mqy8RNuMnohY1rd3NXmyan+cGJsZEbwDASe+5oWzBUo9/xnW6tgOthey8T88q0ooU0NLzgbxhIHXRaJva8lfI/lxN0kxC5Cz0axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJvyz0it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B8EC4CED1;
	Fri, 31 Jan 2025 10:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738319126;
	bh=GRIcu//5Q5U/aXsV/JPZjbLkSk3juXa/4xH6nFrAH6g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TJvyz0itXtpqvcUxexGHs3QJQ3Rxuj2LPwDd+nx8tYTo7OIzue5fUtJyrPjDnS1Cq
	 DDfR8h8FhW2SdliHJCsj/RIKVriipWU2tIiTZYH0HV2X4e9VjekHBmbNgn+hvpgLcl
	 L5ZtQw6tjkwsNFRpIx7dBQImmujuGwM0YBF4u59Yko8HRCvM19Y1PsmYcuzOeircBY
	 6QK5se//lvyoYDbXTSG1sfQjTVhVBCOZOAUvdOXQe14zoWIRrCdT4u5xf9gmPacXdN
	 S9rXVC3hbYHSAQvRLiJJCdciP/ab9bjvNgcxReRJIQ9lkBY5I8VuXSVLESPnfWluJP
	 3HEdIHwWudDKg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jan 2025 12:25:21 +0200
Message-Id: <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
Cc: "Jonathan McDowell" <noodles@earth.li>,
 <linux-integrity@vger.kernel.org>
Subject: Re: TPM operation times out (very rarely)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailer: aerc 0.18.2
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz> <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org> <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
In-Reply-To: <Z5yLYVBn6inIH8cG@kitsune.suse.cz>

On Fri Jan 31, 2025 at 10:35 AM EET, Michal Such=C3=A1nek wrote:
> Hello,
>
> On Fri, Jan 31, 2025 at 01:31:01AM +0200, Jarkko Sakkinen wrote:
> > On Wed Jan 29, 2025 at 6:02 PM EET, Jonathan McDowell wrote:
> > > On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Such=C3=A1nek wrote:
> > > > there is a problem report that booting a specific type of system ab=
out
> > > > 0.1% of the time encrypted volume (using a PCR to release the key) =
fails
> > > > to unlock because of TPM operation timeout.
> > > >=20
> > > > Minimizing the test case failed so far.
> > > >=20
> > > > For example, booting into text mode as opposed to graphical desktop
> > > > makes the problem unreproducible.
> > > >=20
> > > > The test is done with a frankenkernel that has TPM drivers about on=
 par
> > > > with Linux 6.4 but using actual Linux 6.4 the problem is not
> > > > reproducible, either.
> > > >=20
> > > > However, given the problem takes up to a day to reproduce I do not =
have
> > > > much confidence in the negative results.
> > >
> > > So. We see what look like similar timeouts in our fleet, but I haven'=
t
> > > managed to produce a reliable test case that gives me any confidence
> > > about what the cause is.
> > >
> > > https://lore.kernel.org/linux-integrity/Zv1810ZfEBEhybmg@earth.li/
> > >
> > > for my previous post about this.
> >=20
> > Ugh, this was my first week at new job, sorry.
> >=20
> > 2000 ms is like a spec value, which can be a bad idea. Please look at
> > Table 18.
> >=20
> > My guess is that GUI makes more stuff happening in the system, which
> > could make latencies more shaky.
> >=20
> > The most trivial candidate would be:
> >=20
> > 	status =3D tpm_tis_status(chip);
> > 	if ((status & TPM_STS_COMMAND_READY) =3D=3D 0) {
> > 		tpm_tis_ready(chip);
> > 		if (wait_for_tpm_stat
> > 		    (chip, TPM_STS_COMMAND_READY, TPM_TIS_TIMEOUT_MAX /* e.g. 2250 ms=
 */,
>
> 2250 is more than the measured 2226 but I have no idea if that's random
> or in some way deterministic.

Your text vs GUI at least gives evidence of stochasticity while not a
full-fledged proof. You can expect e.g. more IRQs happening when you
run a GUI. I did not engineer that number. You could e.g. double the
original number. The whole framework for timeout_b is ridiculous (if
it is because of me it does not change that fact).

Or perhaps we could consider even  wait_event_interruptible() inside
wait_for_tpm_stat(), since it is interruptible.

BR, Jarkko

