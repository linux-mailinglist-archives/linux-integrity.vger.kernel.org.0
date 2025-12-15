Return-Path: <linux-integrity+bounces-7979-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC704CBCAB2
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 07:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B546A3002D42
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B130C631;
	Mon, 15 Dec 2025 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKQyd7JP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047993C38;
	Mon, 15 Dec 2025 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781028; cv=none; b=Z1u+OUY2lmH0msKMBuszAY/b7ABKp0hrbF7OuaeG/gQbPrU9yWMM82gLf2xkBsDzMiwSNQAEv/VNXxKU28wTX3D25vx7Q/gdSV8T0AJcDOkvSzTjaOeCUZBzEv1svS9AvAMNMdStx2dSSvfMnV2ip88bGGC1XoAzTQglLbO/qfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781028; c=relaxed/simple;
	bh=hdwEyidFu0YJ8FH/D80enu4MOUEqpvEwNzdYg+EeE7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD5gLQBQw42hrnP74N1s+mAuWCKpJwVozVxO2xa1BhGGhxiwsaLcYncBiSXlBowaVrUZNP/aPEbiWrfsK0K3yb5idDKmQIZygi3ooMSZVfYaz1Suwysq2Lfd/HTOhvBNLpAp5iNtTX6iBQHvJ0iaIfj9C2W96C1a0S5vEuZvDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKQyd7JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4A4C4CEF5;
	Mon, 15 Dec 2025 06:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765781026;
	bh=hdwEyidFu0YJ8FH/D80enu4MOUEqpvEwNzdYg+EeE7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKQyd7JPKH5mFRCtYOjcdUfs0xF1qy55XJo1UMVoGK0AjXd9EZVP55cus/+ec1yEH
	 hI2OBnxxT7l/j+72KLmfnG7NSbnlbmZlloVdYKezp/ZlP2Tx4h77flpATFze+nOjgH
	 2iRtM+x4KDdVmx1jtmv8SgeZyKfi/BVRfpQq+YS93dmgIiP9DtvBtLvVnx0JFp2zgI
	 8av+6sMmKdvcZF3aK9jDuyiM+E0F8Wih2oA8Nv9c/8NhTtbA4Io0GB2wdxVtKCHYRg
	 EZuHj26F+7pqlZO157El2Uj83/dCWObEyf5bb6LgTOHqKoquWRxeurSyEc545LE/l9
	 y9UXojLsJASHg==
Date: Mon, 15 Dec 2025 08:43:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <aT-uHgyYw3XhFasi@kernel.org>
References: <20251214213236.339586-1-jarkko@kernel.org>
 <64e3e4e0a92848fd3b02a213c754f096d2026463.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64e3e4e0a92848fd3b02a213c754f096d2026463.camel@HansenPartnership.com>

On Mon, Dec 15, 2025 at 07:18:41AM +0900, James Bottomley wrote:
> On Sun, 2025-12-14 at 23:32 +0200, Jarkko Sakkinen wrote:
> > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus
> > its
> >    use should be pooled rather than directly used. This both reduces
> >    latency and improves its predictability.
> > 
> > 2. Linux is better off overall if every subsystem uses the same
> > source for
> >    the random bistream as the de-facto choice, unless *force majeure*
> >    reasons point to some other direction.
> > 
> > In the case, of TPM there is no reason for trusted keys to invoke TPM
> > directly.
> 
> That assertion isn't correct: you seem to have forgotten we had this
> argument six or seven years ago, but even that was a reprise of an even
> earlier one.  Lore doesn't go back far enough for the intermediate one
> on the tpm list, but the original was cc'd to lkml:
> 
> https://lore.kernel.org/all/1378920168.26698.64.camel@localhost/
> 
> The decision then was to use the same random source as the key
> protection.  Unfortunately most of the active participants have moved
> on from IBM and I don't have their current email addresses, but the
> bottom line is there were good reasons to do trusted keys this way that
> your assertions above don't overcome.  I'm not saying we shouldn't
> reconsider the situation, but we need a reasoned debate rather than
> simply doing it by fiat.

The way I see this is that given that kernel is not running inside TPM,
FIPS certification of the RNG does not have any measurable value.

Random data generation should happen as part of object creation process
i.e. should be fully self-contained process within the TPM in order for 
FIPS to matter.

In the case of sealed data objects, this not the case.

> 
> Regards,
> 
> James
>  

BR, Jarkko

