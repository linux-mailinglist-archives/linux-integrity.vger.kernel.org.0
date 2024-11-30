Return-Path: <linux-integrity+bounces-4258-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED99DEEBF
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2024 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CD7281963
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2024 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ECF27447;
	Sat, 30 Nov 2024 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xuzo/gIf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6043224
	for <linux-integrity@vger.kernel.org>; Sat, 30 Nov 2024 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732934270; cv=none; b=EfqSqZy5uO9kUbRPhi3RuPFp30c8zEOHbJNco2+KBMKwhY/jdedqdvVAQq2g8tq+ltedTh5Cd2vh3ofObRJYU2ABL0tuV5HZCRtyRrsespQYMxEoaO3V8d/RHcrLxVEJ3iQRSlaUb4eMxgxRLr1Mj08YDhhaqd8YxA7uahVoPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732934270; c=relaxed/simple;
	bh=z6tSjf1seaaVZUcMvdPsmyg1YWRa8Qzwg3+JyhqCZZg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=ZALE1yVwfhuzTZb+MSH7yUNg9VT5Tsgwlck0AHi2Ba08fGlujdkA1USLPrdLBIKsrrNPj0lHCqbLL40ogaMI9cDGjdJhq7J4yeVlZuwoDmHuuvdNlJTR5swOOHHr4VmAc1by+InIcIDfkGpq+hj2FdBSZXBN0L/t2FpD/2UWICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xuzo/gIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50122C4CECF;
	Sat, 30 Nov 2024 02:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732934269;
	bh=z6tSjf1seaaVZUcMvdPsmyg1YWRa8Qzwg3+JyhqCZZg=;
	h=Date:To:Subject:From:References:In-Reply-To:From;
	b=Xuzo/gIf3CVFQQtvuqAMjck8OtgPCcw441WWMYfk+eyioKPZRnmKZU5HST6P6zv4Q
	 VYBkrwrVfPQZVIjYApu6Rx/JSGyskoLSNt/5Nt86T/dngueQbumufzr2TlXRm5i2OW
	 vaeG2pqehOwNG+gnwP1W+YPKPqUQdqm9XbYWjQqIfYYyW1FEI5NEm/QyfX2tgYc2WG
	 4ckmrm0mwTLbCdgd7qZTGy7GaHazisib+mxooN5yXqJRzpvtARmhV6ggPCXlHOP0V1
	 ilwWM/vMQFXJttRut0K/ItyezvHF9qWKLWM2iv1X1Zcv7vdW2EnwnWUazYkBsTbAbo
	 o+6+QYF6MIjhA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Nov 2024 04:37:45 +0200
Message-Id: <D5Z5XF9LZBMH.3Q0O1V4U05KV0@kernel.org>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
 <c1b56e93bd7e92d5313fde89dc0ee09fdd4c8577.camel@scientia.org>
 <05f511502a5918fe81d69201ec3df01b25803bcd.camel@HansenPartnership.com>
 <6b66684616408e2f9576bd5eca5ab58254a69438.camel@scientia.org>
 <D5LMVWUBX2FK.205ZHBLQKY7SB@kernel.org>
 <05f8e45aad9f3d975653d8e52bb8cc7c7389442e.camel@scientia.org>
In-Reply-To: <05f8e45aad9f3d975653d8e52bb8cc7c7389442e.camel@scientia.org>

On Mon Nov 25, 2024 at 3:49 PM EET, Christoph Anton Mitterer wrote:
> Hey.
>
> Just for confirmation:
>
> The patch indeed fixed the repeated log messages after a resume from
> hibernate :-)
>
>
> Thanks again,
> Chris.

Awesome, thanks for informing!

BR, Jarkko

