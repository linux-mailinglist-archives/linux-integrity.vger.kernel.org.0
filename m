Return-Path: <linux-integrity+bounces-3166-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96763933DA9
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403D61F211CF
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016851802A9;
	Wed, 17 Jul 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYz14SvK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF8566A;
	Wed, 17 Jul 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223224; cv=none; b=sQ39GJnJnPWo5jEq0LSK3Px6DEcTNZoFQ+cJOyzmbravZuV63KbIv1BzA4cC7akrRzecSTZL/K/4CTmXuH8iRdJyeZPb3xoC0AtFyy6dEzTBiAvPm2zmRdizCqGJSzVw3SOwjOWYOp/zoZXeDF0FTfBh4/E6dBl7RvTGXaSC+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223224; c=relaxed/simple;
	bh=g3cwZ/x9CY+hSC/sCIT3dsiPeI4OGPupHHfnIETxlL8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=d3LP6zQWDRtJvbnOvgX1HgI8DuLdnrzffMwzGAWq2bQFL+W6GFFftLtLC/xQieeZFdv86MlqXnNUwknHmv/ZfnEVkRczaiTMQwHSGgzO+B/00wCMp8xVoMkRMzFB9UiWz5qa3SzRWDDI7wU1MMp3zXDLru0xvrX9oxiSSZmlWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYz14SvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197BC32782;
	Wed, 17 Jul 2024 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721223224;
	bh=g3cwZ/x9CY+hSC/sCIT3dsiPeI4OGPupHHfnIETxlL8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eYz14SvKF7e9RuRHc+ddupm5RGSWpk/BNZPG5vX6+JUlsTq3jlg85qdEw/wHq9uNh
	 lZDo7CqGTDh8NhkGL0bsi+XJvcgRfmcifR4Nkh2pthuVCXTKxYAbzSOKfmc7JV/YCE
	 oWcwDLJJvdWH+X4BZpMpS5lC5xvl4O/FzOFnq9P5+0157PyIL+AKjDo2hbB5HzpXWF
	 9EMMQayO1OWPu8RlXk32tlwGfIv5wBuVM8gYy31khVk74wHwOlz9kBzhWUO/FpfLvp
	 ELjDVey2vtkqR2bdVrCE2bepJKF349xBpZMeKOcphlyGv6p3/GdYo4OyhLt77fQ1aP
	 5p8nVI8qzuJQQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 16:33:39 +0300
Message-Id: <D2RUPJ5P1LXX.1T2OL2PBT2K78@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v2 1/2] KEYS: trusted: fix DCP blob payload length
 assignment
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Richard Weinberger" <richard@nod.at>, "David
 Oberhollenzer" <david.oberhollenzer@sigma-star.at>
X-Mailer: aerc 0.17.0
References: <20240717112845.92088-1-david@sigma-star.at>
In-Reply-To: <20240717112845.92088-1-david@sigma-star.at>

On Wed Jul 17, 2024 at 2:28 PM EEST, David Gstir wrote:
> The DCP trusted key type uses the wrong helper function to store
> the blob's payload length which can lead to the wrong byte order
> being used in case this would ever run on big endian architectures.
>
> Fix by using correct helper function.
>
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted key=
s")
> Suggested-by: Richard Weinberger <richard@nod.at>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@i=
ntel.com/
> Signed-off-by: David Gstir <david@sigma-star.at>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I applied the patches, will send the PR later on (probably either
-rc2 or -rc3), so thus they are mirrored already to also linux-next.

BR, Jarkko

