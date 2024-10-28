Return-Path: <linux-integrity+bounces-3922-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA99B2FD5
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4621C23F73
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925011DC74A;
	Mon, 28 Oct 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDlL1ozw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8F1DA2FD;
	Mon, 28 Oct 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117412; cv=none; b=O9MBP0ZS4vi16aZIUEi96+SyQeklOk+czvOcLG9cmmR+Y++vshMn/FZcb16WHgtvASbANgQn/jFUdgv/7On5nOdaRHp9EW/fvQE6AGYU3Wel19S2k9+oEmtLcNg6czFPRdtPO3Q2QxdrXFNEGHyVrghz4/49RFMqvwNk+KoUQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117412; c=relaxed/simple;
	bh=l5qalQPiwCYhTC3zWpqOzDEvbB3Z5puNHOvHklAezwA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Gry9jjep4+PKEJUXfUh5uWwKRGwsAsRxNX4DNdaQA3ZDXGq44ePiqrHeQdSttw7KH3FUL9nAt/OV0V/VpD8Vu4ShInmjXLl3KkOWCxS5gk57gQKcmOye6rrPvbKGeZSQ8K1xM00YRUGoVFLjtwpo4Hte9u6Ry2DiKo+vH+NSWXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDlL1ozw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A34DC4CEE4;
	Mon, 28 Oct 2024 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730117411;
	bh=l5qalQPiwCYhTC3zWpqOzDEvbB3Z5puNHOvHklAezwA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EDlL1ozw1Wu3K3uSzBJ5adQi8VkhBdNP+GTmcAI/b+yah183t8I4np5OzbcAJy5HM
	 PR1241pJnh4SP1Rx8700JfmXBeGRiRvLQjKX4fWkmGPbzYaBSL1apxUfDTQPhMbGHJ
	 FSxFkDUUM8zHl7ZztgEAptrbCryJbM2r769Wd1xo1i6ykZeiblrYfQMbZB325/Nsdc
	 tZuhY+xSlwRZeU1Jnh0LskNp3cIYO2zJSbclbnuKbJ+4zHegJfrPVZZgIGJ6O+snwO
	 pAbXn1ZDfvq+LayFD6CyXYiB9TmG7aNHSZxQzk5lQZnsf7eRj52RyMPDytNPZ6Wcr8
	 sa6cgOWVPuYKQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 14:10:07 +0200
Message-Id: <D57FFOHZQDUV.QA3SZQSP63Q2@kernel.org>
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
In-Reply-To: <88bfa0f8-4900-4c56-bd23-14d3b3c7de85@molgen.mpg.de>

On Mon Oct 28, 2024 at 8:13 AM EET, Paul Menzel wrote:
> Dear Jarkko,
>
>
> Thank you for your patch.
>
> Am 28.10.24 um 06:50 schrieb Jarkko Sakkinen:
> > Do not continue on tpm2_create_primary() failure in tpm2_load_null().
>
> Could you please elaborate, why this is done, that means the motivation=
=20
> for your change?

Which part of "not properly handling a return value" I should explain?

BR, Jarkko

