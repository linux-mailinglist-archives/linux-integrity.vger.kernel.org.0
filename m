Return-Path: <linux-integrity+bounces-3148-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489E9339E6
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 11:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C031C20372
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D5B36134;
	Wed, 17 Jul 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI/FSaLG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4408224FA;
	Wed, 17 Jul 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208715; cv=none; b=RJ0MS4f2az7ferCRXFTCeO5sRqKU7lfVKcSzgQ61hVVGmpidH1HbDbkF9ILH7s7ScsJ5UDAk3CZZ9wwA3ubfNbH20zWXpIjxpjM/00wUsJ6aMBIPrybIdH7EfpKh8+Sd73gbOV9ZTJIhT80sy8wyujFF2Il3YTEAsUE9RvV5mh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208715; c=relaxed/simple;
	bh=ETsBeuQ8VYOeEzZh29vlEPmitcCpXugfV/BZrYiqiBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIGkauKJr/VqHRfQA2TH5PEYbMDLgVOlZFN1/ZbGST0kjxq9NKjM+uua7aXhmAiSAch8+vZDvdvlAzqBp0VL5bftfN2QwoJFX8YLpaFrLMxjeVipfn6UH+BUIV08aAy8qDRzxqvx6KkICGkW1N6Br17KKNOwsnJk4UOiqWbDbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI/FSaLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10151C32782;
	Wed, 17 Jul 2024 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721208714;
	bh=ETsBeuQ8VYOeEzZh29vlEPmitcCpXugfV/BZrYiqiBE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WI/FSaLGA709YP/WtFZvNd3GWbb2QRNaq/UBApnIGqD/Waefe8EGBpUUxi1yfm6MS
	 kw3iXYCJ7VecvSAIGg4tVKitMSGN7J/G83B4TN5Gd2JKX9rJnvHyscKDWXGHlpn8tC
	 wXH2Ny4njRRrXRkbiDDGtzi6DDUSGQdt1nrsZbqfIsTMJ2KUFSGHAKRWq7l6kEGwGZ
	 fY8qJ/AqSxt522wk81ljWeft4tcP6mBnrF4c6O7lCcsTGlWPP6uFjtWiWMESwso3XG
	 5hAxaTUuoH25krg8vAM+wIdL7I7UPU/DfHpufRPMAE4QfHHtJOQk03LqafgY02u3gf
	 /NsTris5Jdzbw==
Message-ID: <b601bec70e1e5ad403a469fd7f9757a2d8e93ea6.camel@kernel.org>
Subject: Re: [PATCH v3] tpm: Relocate buf->handles to appropriate place
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Howells
	 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
	 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 17 Jul 2024 12:31:50 +0300
In-Reply-To: <527dce2173da6f65753109d674882979736c152e.camel@kernel.org>
References: <20240716185225.873090-1-jarkko@kernel.org>
	 <36ceafb1513fac502fdfce8fb330fc6e18db47ce.camel@HansenPartnership.com>
	 <527dce2173da6f65753109d674882979736c152e.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-17 at 12:27 +0300, Jarkko Sakkinen wrote:
> On Tue, 2024-07-16 at 15:32 -0400, James Bottomley wrote:
> > On Tue, 2024-07-16 at 21:52 +0300, Jarkko Sakkinen wrote:
> > [...]
> > > Further, 'handles' was incorrectly place to struct tpm_buf, as tpm-
> > > buf.c does manage its state. It is easy to grep that only piece of
> > > code that actually uses the field is tpm2-sessions.c.
> > >=20
> > > Address the issues by moving the variable to struct tpm_chip.
> >=20
> > That's really not a good idea, you should keep counts local to the
> > structures they're counting, not elsewhere.
> >=20
> > tpm_buf->handles counts the number of handles present in the command
> > encoded in a particular tpm_buf.=C2=A0 Right at the moment we only ever
> > construct one tpm_buf per tpm (i.e. per tpm_chip) at any one time, so
> > you can get away with moving handles into tpm_chip.=C2=A0 If we ever
> > constructed more than one tpm_buf per chip, the handles count would
> > become corrupted.
>=20
> It is not an idea. That count is in the wrong place. Buffer code
> has no use for it.

Also you are misleading here again. Depending on context tpm_buf
stores different data, including handles.

BR, Jarkko

