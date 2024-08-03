Return-Path: <linux-integrity+bounces-3281-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113F946AB4
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E98B20FC7
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C956A10A2A;
	Sat,  3 Aug 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8Ebt/p1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE461CA93;
	Sat,  3 Aug 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722705830; cv=none; b=Viqn7ci4oin1FxfQfeoc9NWz7O6gtyMO6k6lvCEeisFupc7aJ/9SHwcJKrQfIL2SJjRglagh0X1oZYgmbsOwUNXzqOJpxgSGqh3zJ9xdnPwCo/e6p0/clCdPng3SK0Fkay1q9qd5lljA3m01gkP95g89n/KwJs9DMBRso/P4/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722705830; c=relaxed/simple;
	bh=EkkwAMACJmTQZm7JWb3yBW1E9hWHxAftJL3TlAlWnM0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V3LsnHcrs5ujmHr1RyN7VfRq4vX/MaPiSJRxIrj/vFr3BkPv/cOkRitpOpu4hg3EO9ZUdFKcD+jvtxwZkvwwAg5DU59ALISdRb4BwaESIxIm194xyPCq8gjjRUS4hROYqvlxfHCUj8A5oQlmTC4qhRGtRVN5gR59O7flzyV3iW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8Ebt/p1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8F5C116B1;
	Sat,  3 Aug 2024 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722705830;
	bh=EkkwAMACJmTQZm7JWb3yBW1E9hWHxAftJL3TlAlWnM0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=G8Ebt/p1ZY/XFfch6MRNJm6JveQ8WQb0LvNsMlVmDVzT1Jz9rnDAgwzOrRSxDWStR
	 LSoLcHhfBWw0iHwfF18KoirMlCfNoZLUrtDzurLiuU89oXhXb2nndyQh8rmEW0/kt1
	 rZr0+EA+d+2hIq8PpiNZUrWJyMCtTzUXi15UZxRppVJi7vuTaLMN/BzFM2Rxb3REn/
	 54yWZzlhLdCSGzjy9BGw1JRLUw+pvLvkAWbZjfg8acVre0dZczeNBGfa4NoueA0LLI
	 L9YH+Uq0fPOxvxkAYtzoeoblxu8pvHdlJzemGywQOEL0fK2uj9wee4aq3C65Yhx7il
	 g6emZ306Kb0Kw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Aug 2024 20:23:46 +0300
Message-Id: <D36G8ZE7HVOG.2ABMNVCL4M7H8@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Peter Huewe" <peterhuewe@gmx.de>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4] tpm: Add new device/vendor ID 0x50666666
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jett Rink" <jettrink@chromium.org>, "LKML"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <20240802210957.629455-1-jettrink@chromium.org>
In-Reply-To: <20240802210957.629455-1-jettrink@chromium.org>

On Sat Aug 3, 2024 at 12:09 AM EEST, Jett Rink wrote:
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Suggested-by: jarkko@kernel.org

So put is as "Jarkko Sakkinen <jarkko@kernel.org>"

And no newline in-betwen.

>
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> ---
>
> Changes in v4:
> Add Suggested-by tag. Sorry that I forget.

No worries but please refine the form ;-) [I could do it but that way
I think it will stikc the best in the future.]

BR, Jarkko

