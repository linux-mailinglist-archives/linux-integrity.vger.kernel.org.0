Return-Path: <linux-integrity+bounces-3143-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B79330BE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 20:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BAE1F23E69
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB241CAB9;
	Tue, 16 Jul 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeQii+qS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77711643A;
	Tue, 16 Jul 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156055; cv=none; b=hX7RJDzLkRIsO4qFy2FXDJrmebRY6WU2XzlbIYF6MD8aOLAmZ9Oj5fXv7RuSYtwU7X9dCh6A3lD3ZevrtV/m5lVD1CKhZlM+92w3l1cMBZ/atWLxrm+FPdVUPh0Rza7ePr9uBryfhxtf3YKq/QcYYeIY060nuKxuumdJkliUvUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156055; c=relaxed/simple;
	bh=NFsksktPuh/P2tYh8OZpIZjzklEW8ftJUtY7P9VYPLM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=SgzLdVdkxX4hnqgMjESluSlDAwT8FgeFFzc6YLTmR2JayAm0gzl87Auf4ZXVCsXKAQ2H7jLIbDKEAUssV/rnAdqv8JFf3tkz3pNORcoMuW7fA8xq5rtucgL3P41HzqkuvRkk4CZYZu7EYOs/MYw9xAdVbZgdtj3Lr/x7Jw+cWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeQii+qS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5182C4AF0B;
	Tue, 16 Jul 2024 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721156055;
	bh=NFsksktPuh/P2tYh8OZpIZjzklEW8ftJUtY7P9VYPLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jeQii+qSq4akopnm+kp2eTiO4adbCPzpx3W+a+cnLDAnYYVl2DO7JxT/qVlZwMVNE
	 6nG+a8eMJ/dRIIaR11O2WGCX05QsjHQYrM5fLLUIWlSlOa0ZLH9qyId898w9i42OJE
	 h8uAmhfU2hozfQBL6VJrVlMT3Ltlir6OJ22DwKdze+HvsM94FJ8KeBUWCQCUucEgRg
	 6q6PMARotBF67o0qXOd+ufzHRQlsaxVqp+8QI1l5REqSHFA/RnHSY3UdU+FyemU4Gg
	 zBkGJKKSv+omI1FGmDWVD61PLvpknaHuAGeYQS4FwXbi2SJkumrUzJelTE0toGqSa5
	 zx+Sf4DfzSoqQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 21:54:11 +0300
Message-Id: <D2R6WEDWRFMK.247OVMZQ9ME6Z@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
Cc: <stable@vger.kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Relocate buf->handles to appropriate place
X-Mailer: aerc 0.17.0
References: <20240716185225.873090-1-jarkko@kernel.org>
In-Reply-To: <20240716185225.873090-1-jarkko@kernel.org>

On Tue Jul 16, 2024 at 9:52 PM EEST, Jarkko Sakkinen wrote:
> tpm_buf_append_name() has the following snippet in the beginning:
>
> 	if (!tpm2_chip_auth(chip)) {
> 		tpm_buf_append_u32(buf, handle);
> 		/* count the number of handles in the upper bits of flags */
> 		buf->handles++;
> 		return;
> 	}
>
> The claim in the comment is wrong, and the comment is in the wrong place
> as alignment in this case should not anyway be a concern of the call
> site. In essence the comment is  lying about the code, and thus needs to
> be adressed.
>
> Further, 'handles' was incorrectly place to struct tpm_buf, as tpm-buf.c
> does manage its state. It is easy to grep that only piece of code that
> actually uses the field is tpm2-sessions.c.
>
> Address the issues by moving the variable to struct tpm_chip.
>
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>

Dashes missing but I can fix that when I apply this. Just like to keep
change log in git and I add the dashes before sending...

> v3:
> * Reset chip->handles in the beginning of tpm2_start_auth_session()
>   so that it shows correct value, when TCG_TPM2_HMAC is enabled but
>   tpm2_sessions_init() has never been called.
> v2:
> * Was a bit more broken than I first thought, as 'handles' is only
>   useful for tpm2-sessions.c and has zero relation to tpm-buf.c.
> ---

BR, Jarkko

