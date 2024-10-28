Return-Path: <linux-integrity+bounces-3925-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ACF9B30A5
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B497B23195
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB001DE3C2;
	Mon, 28 Oct 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9MqfW95"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722F1DC046;
	Mon, 28 Oct 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119335; cv=none; b=FMuBtB28/ZZPpFnOviRx9FAIbXYC7SVyGUVRo6tICT+xUc0shssxGn+KYs5njQYMJsPPXTiCkWMC+sR8lMpYvcAhDWf07oV4hJloJR7k+vmFznuAq6iIGt5+XH21oRoz/OIR8o0wivevRBNr3WNSd25GX1IPiK2tmleEVSw31EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119335; c=relaxed/simple;
	bh=yzOI+0XcZK+dILGOdMbfvaqHyZ/6pBLQQ1bn1noFbaE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BQQdzbKDg6VzkA8nKDL7IN06RX8NRQZGkVuOB2BXuWwCvHo3I78ucrfX/CuEoR50l/GzXSqxovGqQBrDEQyB/jWn4ZSkFXO89Pb2uWpAbg/u50o05D10R2Tkfgzoyz4v/OGaqI+w7W/tyBSi6ftTF79xOgnNpsRK5RZFkGq46cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9MqfW95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E5AC4CEE4;
	Mon, 28 Oct 2024 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730119334;
	bh=yzOI+0XcZK+dILGOdMbfvaqHyZ/6pBLQQ1bn1noFbaE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=A9MqfW95W2xN+1gPg/R6kjFvo6Fdjumbpp4WzxYP75kaP5YvSj/BUb649TJMNNVOV
	 /gYzMSkCrEtO6cX8wG898kzOZURDue3YZI+Zkq+ZvgBIg/pS0i0DqyajVhGxydpyYq
	 pASb6j1RJJJEfI7Pwz8f1EANSO5yJbdmszgYUveb7LWiVNnjdqBmr+KMS6l4AHx8nv
	 C7pirwl9dscoDF1wMWWiBhBP2QNPkVb8PGULbpdfFVjqBBpsajzC2F92avg2OVwKWM
	 CrBXv3uDfQ0aJR869aZn3c0KJX9B8KLPG/blP/XNyoSbH/Tf6aKzHJeMHwv8hkKzzT
	 KAwKJZINEgIvA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 14:42:10 +0200
Message-Id: <D57G47THRYCG.217GTO2ZF5333@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "David Howells" <dhowells@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Stefan Berger" <stefanb@linux.ibm.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] tpm: Rollback tpm2_load_null()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
X-Mailer: aerc 0.18.2
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-3-jarkko@kernel.org>
 <88bfa0f8-4900-4c56-bd23-14d3b3c7de85@molgen.mpg.de>
 <D57FFOHZQDUV.QA3SZQSP63Q2@kernel.org>
 <abc37c7f-b069-4272-956d-77e099cadf11@molgen.mpg.de>
In-Reply-To: <abc37c7f-b069-4272-956d-77e099cadf11@molgen.mpg.de>

On Mon Oct 28, 2024 at 2:38 PM EET, Paul Menzel wrote:
> Dear Jarkko,
>
>
> Am 28.10.24 um 13:10 schrieb Jarkko Sakkinen:
> > On Mon Oct 28, 2024 at 8:13 AM EET, Paul Menzel wrote:
>
> >> Am 28.10.24 um 06:50 schrieb Jarkko Sakkinen:
> >>> Do not continue on tpm2_create_primary() failure in tpm2_load_null().
> >>
> >> Could you please elaborate, why this is done, that means the motivatio=
n
> >> for your change?
> >=20
> > Which part of "not properly handling a return value" I should explain?
>
> Sorry, where is your quote from?
>
> Anyway, maybe explaining why a successful call to tpm2_create_primary()=
=20
> is needed to continue would at least help me.

It's not a void function.

BR, Jarkko

