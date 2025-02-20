Return-Path: <linux-integrity+bounces-4952-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5F0A3E6BD
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 22:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5941719C373F
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C982641D0;
	Thu, 20 Feb 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2jlj9NL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA42147E9;
	Thu, 20 Feb 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087387; cv=none; b=eDCYxhdjKzoNeIbywgyPkerHcvsaEWmsC2yDU0CxUW72SUzGI0ZN54TMKYW81A/SFo+KcYycWBZNiU+6SHKx6pIWW0cL678QtTWZCPjrFTSs5tg0A73UKeonb/JENSTkZeuClQQwTz11nKR2bhO6fPGKJb3o5rf1R8iE8jN2oEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087387; c=relaxed/simple;
	bh=O3DT5MvTbli6j6HGumy9m5773CwCIv3sxPWm36Idlbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Db9G/nd+QPKAaG2HDqi9mF4b1AmIYi04BkbCmVYnA/O96vH+K+MJ5K/6pt/tULjhqlk770PL1RGm6r7kifpUpG/o9CYQCQGZAsvwwniqQmPvFw2YCr7/erOqnRYE9LM4Tb7Q6ekXh1jQzintaNUYIyqapCf9qdhqVDJTSh7l4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2jlj9NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44A6C4CED1;
	Thu, 20 Feb 2025 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740087387;
	bh=O3DT5MvTbli6j6HGumy9m5773CwCIv3sxPWm36Idlbk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i2jlj9NLu+SoUVXm6k0vP0l+J/wnUwHx6dT7Pn0vD9PbO8LTfnir3bNgyPdthPRZq
	 ZkIdUcXLvrNzJ5oRV4ywa/79yFDGqDTQegdC4PxWIGFK5XvDPKrDev5NtxC7rYmwaB
	 Tc9clPqJQWX9ciqregM/zKlCbpft36t8wV5LTymD0A1FsL2nB4pYvK05JyThQGpOHB
	 iSH8j0Ak3dh9YD5uImmK/8hsQJWYtsSnyPF32wq9ceHlvM/qbQxhfw1qInLwNxr095
	 MpAcZIzvB8aUSO2khUXCOtclftinYOxiDpUW8K+bQJJcXewJqFn29tBKae761E99iw
	 /kwPS4DLE28pw==
Message-ID: <0d8682ca28d2ed43d1d0f1b2a28f7d62e4ee2957.camel@kernel.org>
Subject: Re: [PATCH v5 2/5] tpm_crb: clean-up and refactor check for idle
 support
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 23:36:22 +0200
In-Reply-To: <285e81d8-dd07-4075-9c09-0e2b4e59aeae@molgen.mpg.de>
References: <20250219201014.174344-1-stuart.yoder@arm.com>
	 <20250219201014.174344-3-stuart.yoder@arm.com>
	 <Z7b2BlllE6HVIZNN@kernel.org>
	 <7c913fc0-0f2c-4327-99ee-510bdff8a537@arm.com>
	 <285e81d8-dd07-4075-9c09-0e2b4e59aeae@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 20:09 +0100, Paul Menzel wrote:
> Dear Stuart,
>=20
>=20
> Thank you for the patch. Should you respin, you could spell *clean
> up*=20
> in the summary/title with a space.
>=20
> The diff looks good.
>=20
>=20
> Kind regards,
>=20
> Paul

So for the sake of overall good it is better maybe to keep
this immutable as this will make it more plausible for
potential testers.

BR, Jarkko

