Return-Path: <linux-integrity+bounces-3940-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D71E9B70B2
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 00:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4242C282AC0
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20292144A7;
	Wed, 30 Oct 2024 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBEIm0oh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76C71E3DFE;
	Wed, 30 Oct 2024 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332109; cv=none; b=Oc/NO2Tz2bxiWo1FBe5714C5w7ArESl/3p9FfQRBXNJo7gKu2G5/vY9+bJNz5lA8ZOgxRhfb/rKVwNYjIo3Io9MhgJY1jRUtvOGQqOB1Gb+Pnj6WIdT82TMh8QOGxzJzMZW5RezWKuvbaTLIv4xkFZEoohPUYEPZ7DecR6fzbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332109; c=relaxed/simple;
	bh=sdP3cmceKoTBTmv68ump4mtr8l8T89PTZNm/eFbYY/k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FK/qT40GdXKP8a7PM5YGyTsHIzuQhX2cA36YqMazvLz1Hmb8b5fr/XgenMfCNPPZg3H7PIUg9dwUO7i9lRJw+zyBLuTupaXyMIdiI12K4hpdYHTp+Mu21I8U9u7GNQ0AHancxtE6r/FUuptXB8nXP35GZAdgH2iutPB2xITWE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBEIm0oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5CBC4AF11;
	Wed, 30 Oct 2024 23:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730332109;
	bh=sdP3cmceKoTBTmv68ump4mtr8l8T89PTZNm/eFbYY/k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MBEIm0ohPfj6/5VXvwaEAMJyS/6D+v6qQPwEixuIRWOXGo7NYb/2dsrezD3EZrjE+
	 TiYbZQ35lQlxvaEJUU8Glv3i1hLBORwBfSioCKfH6LkIFPOjwfJ02f/EzZJCeI5sHf
	 XAsFmWEnGitMjXuVQRI1Tvfc0P4nHTeSgV1Na3RQ4XknL3sJ+a6pS8K5OixDDmzh8I
	 9xb08Zqfpmtdd1dI9DrKlrNmSjPpXv2prFVtLpWhJzT6V5fQjnB2jOVvR6Ku/S4cov
	 EF6m+9IvYkaQPF4P0o0MQb0WPpuI/bXXbU5Sc3CObjT+aAv3sx3Mj77RfHkaXdF40D
	 bfQ7B0n9If0/A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 01:48:25 +0200
Message-Id: <D59JJFBKKJ14.2KQSUSXP649DE@kernel.org>
Cc: "Jett Rink" <jettrink@chromium.org>, "LKML"
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe" <peterhuewe@gmx.de>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v6] tpm: Add new device/vendor ID 0x50666666
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240910191117.1001581-1-jettrink@chromium.org>
 <D43HINLZGMXS.FYJOK0SVQFQW@kernel.org> <ZxckGbxzpWDuXG_q@google.com>
In-Reply-To: <ZxckGbxzpWDuXG_q@google.com>

On Tue Oct 22, 2024 at 7:03 AM EEST, Tzung-Bi Shih wrote:
> Hi Jarkko,
>
> On Wed, Sep 11, 2024 at 04:21:24PM +0300, Jarkko Sakkinen wrote:
> > I applied this (will push later to my remote tree).
>
> I failed to find the patch in [1].  Is it somehow overlooked?
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.g=
it/log/?h=3Dnext

It is applied to my master branch now:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

Can you sanity check that it looks good? Thanks and sorry for the
delay!

BR, Jarkko

