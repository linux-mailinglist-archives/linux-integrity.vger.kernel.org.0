Return-Path: <linux-integrity+bounces-1790-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3A8805B8
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 20:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777DC1F22B3C
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9D535A9;
	Tue, 19 Mar 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2k0qm1L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634352F79
	for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878261; cv=none; b=SlGic9SU+WI1NH4zMdLtqCMglNtrnvJV8xT4lycrqa9g5IvpiA7mTRmsYLEKLraNwJFjVhRmeOP/U5F0LtRK56f4/y0LdloYOJFzPU/zEzhdwNzbuNfXMzQInlumthuNJSDT2DYIUKtlUUhOwg1w3GJuzG79zqvWv8bEWbPlreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878261; c=relaxed/simple;
	bh=uMOCg+ZAP/LU5NrbSRFjAsa6VME85PBDTSuxQnzbPls=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TIvNedosDlZsenZojBmzradP0z7d/opHHCuZLDiSS/Fcv8EJbliVzWa1mJHzcpnY2iWrDdWZSZ/9LVj6TFJVciShVsRv9tbhdHeJw+fD48rwRfG1xLLlSkMU5Uv3N4S+rdrQFZ6flnDYDMNtygSUFjIY+CjGsBd5ktKyu5u2B1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2k0qm1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583E8C433C7;
	Tue, 19 Mar 2024 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710878261;
	bh=uMOCg+ZAP/LU5NrbSRFjAsa6VME85PBDTSuxQnzbPls=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=u2k0qm1LS3U9RG+L6V2tsbSg4yeTnTT8PMufvtzCPIr4VTTap2njB58slWK0ekd3G
	 2Z+5HZhDSVLcFHRoOWWQYaJI5FVlr5o+wwcgYRIF7O+0VuxhJ9Wre6ap3oIypIRA4v
	 uAqOPqWAo/p8HDoSGS9oj6nnhUrDM3PSv+Z0Db7i9BX7GUya1E9epZU7w0wsWoXPK7
	 ou5UQ8SullKrUTob4fTl2W7DV8vtlugiYxtV1+C7PYjE/hrRSM1XQY8qtWjbsE30GM
	 exjVBNJ+IPXx4YWWSbN75BVkVWiohOorcGkUOLWlaF5BmaaW/lwilf1TtxjiYKaNpP
	 14uW6CeH3Mrdg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 21:57:37 +0200
Message-Id: <CZXZQ544YVAZ.UHT0KAH0B7J2@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Fix suspend/shutdown on some boards by
 preserving chip Locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Adam Alves" <adamoa@gmail.com>
X-Mailer: aerc 0.15.2
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
 <20240307224957.29432-1-adamoa@gmail.com>
 <CZR6VBRUEPKW.26B7HTOJZ0ANX@kernel.org>
 <CAHwaaX8bWOFW2bi6tKpxgf2Cp_vKg5Eqhq618VEur98s+OmD=A@mail.gmail.com>
In-Reply-To: <CAHwaaX8bWOFW2bi6tKpxgf2Cp_vKg5Eqhq618VEur98s+OmD=A@mail.gmail.com>

On Wed Mar 13, 2024 at 7:02 PM EET, Adam Alves wrote:
> Hi Jarkko,
>
> Thank you very much for kindly reviewing this proposal.
>
> After one week without any issues with my PC hanging, it happened
> again. It seems that the fix I am proposing is not final (it only
> reduced the frequency since it always happened when I shutdown after
> couple hours of power up time and now it only happened after two weeks
> with a similar usage rate).
>
> I will share with you the data you requested below.

Thanks I'll definitely check these in detail.

Any possible bug fix (if we decide to fix anything) is tpm_crb.c
including possible kernel command-line parameters or whatever. The
current proposal affects all the possible pieces of TPM hardware so
in all cases it is unacceptable.

Do you have dmesg/journactl transcript? Did you try to update the
firmware?

BR, Jarkko

