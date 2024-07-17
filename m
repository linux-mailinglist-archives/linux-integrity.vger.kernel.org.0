Return-Path: <linux-integrity+bounces-3149-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E69339F5
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F76281C46
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B03B791;
	Wed, 17 Jul 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GifQ4lNb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0D1BF37;
	Wed, 17 Jul 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208870; cv=none; b=EnR2w1f5lRwPR/zj/qEVqHgfTSuageRfCLAsoGWuYuHKYCfpM4COcaJsJ3mN9z/mHS1Cc1Pvp6Nn0zBMIlDayqueGKCtVAPa216mEf6sdLXmfhf/OBQb07Iwn+DrWFzjSF9kJSHCnNkWslQd5WLIbtuud8Okhzi8degZxNQb2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208870; c=relaxed/simple;
	bh=NZKuHsBukGGdYd0w5Ke97TNmqKDBxrBIkmwjfb/saEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmAFuDAnFC7FqcOcDCU6fDxT9VtjplJQYZK2RwlDHbBA2meVj/JVEBBkhT+QCxi7hh+T4oAV4WLQGAG+nO8Uq5QxobwLLfXkAkU6sP0ltozp0L5B6673QiBJJyThWLeFGRuIKamMznJBUj7m4EbDeAnCqFlVmv2xUy6ByY8E74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GifQ4lNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C66AC32782;
	Wed, 17 Jul 2024 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721208869;
	bh=NZKuHsBukGGdYd0w5Ke97TNmqKDBxrBIkmwjfb/saEw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GifQ4lNbNfBDnxlKn1CnW9N2h1NhEQyA23Mf4t1JeWZ3MPRlH9f97Z9PQXAKKlxLM
	 e7VqSaTCVFa2xxNgj4y9e+Qaav7M24SjuL0gE8hLofnH3+QyIPMeKpltLigwXLayMy
	 qdjSOxOEBah+MnBoTlvlfmcoExKlrxr2nYS0wVH6+Z5WaKXpTe2nE2vgecNDuC8ihm
	 AaFgdVT8WZg+DMLiOn25sJJPPCcwCWj9jMld+8zttI5jaLAzZc5YpN19dYuAjSqtQ0
	 dMT+Qqh8G0jR5TUqAIv1nEFJ8Ihuw0kNEKEdVgqVDrjzGcA7AaNsUSMEn52xj0jQtn
	 K9TYjFijt0Ajg==
Message-ID: <e6675b5f26606997c6ac9ce2fb411e474a09fdce.camel@kernel.org>
Subject: Re: [PATCH v3] tpm: Relocate buf->handles to appropriate place
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Howells
	 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
	 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 17 Jul 2024 12:34:26 +0300
In-Reply-To: <b601bec70e1e5ad403a469fd7f9757a2d8e93ea6.camel@kernel.org>
References: <20240716185225.873090-1-jarkko@kernel.org>
	 <36ceafb1513fac502fdfce8fb330fc6e18db47ce.camel@HansenPartnership.com>
	 <527dce2173da6f65753109d674882979736c152e.camel@kernel.org>
	 <b601bec70e1e5ad403a469fd7f9757a2d8e93ea6.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-17 at 12:31 +0300, Jarkko Sakkinen wrote:
> On Wed, 2024-07-17 at 12:27 +0300, Jarkko Sakkinen wrote:
> > On Tue, 2024-07-16 at 15:32 -0400, James Bottomley wrote:
> > > On Tue, 2024-07-16 at 21:52 +0300, Jarkko Sakkinen wrote:
> > > [...]
> > > > Further, 'handles' was incorrectly place to struct tpm_buf, as tpm-
> > > > buf.c does manage its state. It is easy to grep that only piece of
> > > > code that actually uses the field is tpm2-sessions.c.
> > > >=20
> > > > Address the issues by moving the variable to struct tpm_chip.
> > >=20
> > > That's really not a good idea, you should keep counts local to the
> > > structures they're counting, not elsewhere.
> > >=20
> > > tpm_buf->handles counts the number of handles present in the command
> > > encoded in a particular tpm_buf.=C2=A0 Right at the moment we only ev=
er
> > > construct one tpm_buf per tpm (i.e. per tpm_chip) at any one time, so
> > > you can get away with moving handles into tpm_chip.=C2=A0 If we ever
> > > constructed more than one tpm_buf per chip, the handles count would
> > > become corrupted.
> >=20
> > It is not an idea. That count is in the wrong place. Buffer code
> > has no use for it.
>=20
> Also you are misleading here again. Depending on context tpm_buf
> stores different data, including handles.

These false claims can be also proved wrong by trivial git grep,
which clearly shows its scope.

BR, Jarkko

