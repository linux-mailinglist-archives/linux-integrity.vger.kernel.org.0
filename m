Return-Path: <linux-integrity+bounces-3147-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BAB9339CD
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 11:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F400B2111B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1CF374F6;
	Wed, 17 Jul 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ/8MOO7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6D2D61B;
	Wed, 17 Jul 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208474; cv=none; b=nrA+QtICtdxpiuXQn9L1RylewcMw6JFEQTKnKEf0YzmZnOw/Py46/3BQBiaKTbR0yYvHlDBn9bSL5mdUERbeSJudvsjKSoYN2OEtbcZOTOqBsYBVWqxwO1XeiQaegvT4PGGe5yy1ljC1Cp1YeA9kIUVm+aPAP3P3QJviOfkIvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208474; c=relaxed/simple;
	bh=payKeKJtIxwqy/FKba2RH8l09eevqXdxf3JGW8EmUZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmFTZrhjaIJ1eqiCkA6CuezVezLcwyaxAtdrdVOcSyjEUYZnDxsYID9LYHcsZF24Ae25DWDTUPZjHyIEp1G7jXv1rv9NbGeVZICcA0FHbUl2czOsdQWRgXZP/8lzIsMOmUM4uHKMPOI7r8/e/4J65NBn4yczLdpqzDHl9Gs6eDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ/8MOO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80AAC32782;
	Wed, 17 Jul 2024 09:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721208474;
	bh=payKeKJtIxwqy/FKba2RH8l09eevqXdxf3JGW8EmUZ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qQ/8MOO7QSm9Z7AjZyv/efH4CkPul9PmWjxM47pYc017NVHbWxQmGivqehfDLyvRI
	 UGnAuQaCRSW9cEDmigbDzFPzhsizOOJ9tUCg0kXCCHhebpzrormAAuOFNpKHyW5ow2
	 kmcPdHkxp86TGi05161rvI0gdhBq5m0yx8v3tOA/QpmZBht0Q1OyTVw/ghVJyXuIyQ
	 Y/Zx32gakFSKjUfjPzOvxjho7sG68ZwU85skXfq5pF256ZKU6aAkpEZyiGG78nRxDJ
	 RoLZ2qKgPkTEB+RfnM6ilkMPTL4edk6MKrvm/O+QTMo6a198UdBo+0Vq8f7lqz2xhB
	 oUXkAl13CVLGA==
Message-ID: <527dce2173da6f65753109d674882979736c152e.camel@kernel.org>
Subject: Re: [PATCH v3] tpm: Relocate buf->handles to appropriate place
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Howells
	 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
	 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 17 Jul 2024 12:27:50 +0300
In-Reply-To: <36ceafb1513fac502fdfce8fb330fc6e18db47ce.camel@HansenPartnership.com>
References: <20240716185225.873090-1-jarkko@kernel.org>
	 <36ceafb1513fac502fdfce8fb330fc6e18db47ce.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-16 at 15:32 -0400, James Bottomley wrote:
> On Tue, 2024-07-16 at 21:52 +0300, Jarkko Sakkinen wrote:
> [...]
> > Further, 'handles' was incorrectly place to struct tpm_buf, as tpm-
> > buf.c does manage its state. It is easy to grep that only piece of
> > code that actually uses the field is tpm2-sessions.c.
> >=20
> > Address the issues by moving the variable to struct tpm_chip.
>=20
> That's really not a good idea, you should keep counts local to the
> structures they're counting, not elsewhere.
>=20
> tpm_buf->handles counts the number of handles present in the command
> encoded in a particular tpm_buf.=C2=A0 Right at the moment we only ever
> construct one tpm_buf per tpm (i.e. per tpm_chip) at any one time, so
> you can get away with moving handles into tpm_chip.=C2=A0 If we ever
> constructed more than one tpm_buf per chip, the handles count would
> become corrupted.

It is not an idea. That count is in the wrong place. Buffer code
has no use for it.

BR, Jarkko

