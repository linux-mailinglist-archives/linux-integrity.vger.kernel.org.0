Return-Path: <linux-integrity+bounces-4033-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9117A9BF574
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 19:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5512B288B85
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636CD208214;
	Wed,  6 Nov 2024 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix6tW9Cl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E536D;
	Wed,  6 Nov 2024 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918319; cv=none; b=JDtwUW7wuOrt8xp0oBgnEPP+yp9kBoDsf3nG6pNni9+T333IayqfBfnDvaapFuTK1WRxBLfKtuIUM3KtHPgaA84fB3Y+L/iG0NbzXaWgGfwmxxOIQL//6Kzg74Z6KhOWM10rxMBZUdmJ/gVZfD6yLGmx7jIVMNoszEDTKpAtXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918319; c=relaxed/simple;
	bh=tVEgPo14STreEG8UQOeK4cUOz0zDlmTUOzlk8/PZQ3U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=goPzEExxIMZyV0KO+vRb1aSfQmD7nA6F50FogmOnOcrVTIJN8kfDEOAvuYaXR0lo2xhafx9p10Ynw1vXTz1dC0RHMEBoBcETL1z2lqdKhfy+50IbHYPw9Pf4fmfj1iIarY6gMtOwmyEJXmlD6PA+h5sdBrSJrv5DZ7+wRKFQO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix6tW9Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69977C4CEC6;
	Wed,  6 Nov 2024 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918318;
	bh=tVEgPo14STreEG8UQOeK4cUOz0zDlmTUOzlk8/PZQ3U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ix6tW9CletS/q+2tcwXs8z665+y2pVvYb5d4FymMHWP9e+d+jah1rWsoiIi3q5+Dj
	 T3kpGI11cvQO0gl2pp7FgYZTe0AvWR5aEnGG9xuZeFRRTUVk584plOyeSxHVQvX6BZ
	 Lac6NKee/lpsxze3WPy6x/NPQ+tjavobQXaBHO2wCvokq9P0PfU6MdbX/xeeajq1hc
	 3KrjRhVso1sv2eA1gNJs1aRK+DThJc+MfNSIvz4tKWMISofRUl6BI9t3jo58HEv37v
	 aVTO6re0gCIdNvvaMIHQMoeBjkYLaW8mCvzssl9W+Lq4MP4jkCSIr2SPGo5ylbTVtF
	 fimu0yePEmr8Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Nov 2024 20:38:34 +0200
Message-Id: <D5FBC0756PMF.3SBC48BP5UTET@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [GIT PULL] KEYS: keys-next-6.12-rc7
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <D5FB9PK9DD35.1B1VBVMPOZPRS@kernel.org>
In-Reply-To: <D5FB9PK9DD35.1B1VBVMPOZPRS@kernel.org>

On Wed Nov 6, 2024 at 8:35 PM EET, Jarkko Sakkinen wrote:
> Couple of fixes for keys and trusted keys. For me it id not make
> (common) sense to separate them into separate them into separate keys
> and trusted keys PR's.

oops, sorry for the typos ;-)

BR, Jarkko

