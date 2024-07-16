Return-Path: <linux-integrity+bounces-3130-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA82B932803
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 16:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204C72835AC
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 14:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2698819AD67;
	Tue, 16 Jul 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPDJFPRb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118313CA99;
	Tue, 16 Jul 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138938; cv=none; b=ee+lgE+KdZvaFVgO8kz01WsbK85q+InhnfgFry66owdaNrVE2CxTKNev1A4nrO6HlinKkt5ekZr+UIoZis7mKVlswN9B5bNCVWWMjWe0EuKl7zECalFnznDLtHANgRzneniIpbcyPxF2JA/QftfSXjx4Rz69gL7GPUV2cHDN4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138938; c=relaxed/simple;
	bh=MlH+M2doNSUE7F6BQ3S+dbdXyCh5BRBLElOuopLAljw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a+5nxrHiecZ8wZPO8LnvCWsWe7xTGfVq30qN6lgNzUDXaIgZTUt3ww1ufGJ59Z9Ek7ysYSYM2/lIHsCnoBoX9U27IgYd0fem1JrhFyAv1Z9F6HndrUQ4cnIeRzy/+RUKth/b7ZzGbhFMURhfd1eDbdzwCkhj50hPC+3DofpbZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPDJFPRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9252C116B1;
	Tue, 16 Jul 2024 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721138937;
	bh=MlH+M2doNSUE7F6BQ3S+dbdXyCh5BRBLElOuopLAljw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=OPDJFPRbCMMAfXF/A8knMUKVI5FglkFM6yHajdQc0ltAXKu0wRlUoaKRAx1QOT/qH
	 Ov3C1ZqFub2Z/v5PmKhAMIcs3zq5HLqOlYOYakfIhSrXcZaBjRKvuewZysCqf6Aqa9
	 yeX4CHzZAf7hzIOPAnpXjt7laRfRl5fXKDlnBvdPYVy1eFh10o4fUaAPIPnRiOF2F2
	 vIt1eEhHleKIb58ZhMetEgZXabndNe8Mu+DXCxGmp4IkxfBCSVJyFEBmGcj4Gbk/Ib
	 3I9LyQC/XJd8oyqWAs/+OAQj8eVA7GA3ggZIakR6fCAueEgiI+y767He2SkvbjNeDg
	 P+MxxNrzK4zZA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 17:08:55 +0300
Message-Id: <D2R0TZB6I6Z8.1R0YSFP46LXPF@kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 2/6] tpm: add policy sessions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-3-James.Bottomley@HansenPartnership.com>
 <D2QXYCVI47RK.GFOY8SNQHWW2@kernel.org>
 <D2R0SSS449F2.1CSVCMJ39S3LB@kernel.org>
In-Reply-To: <D2R0SSS449F2.1CSVCMJ39S3LB@kernel.org>

On Tue Jul 16, 2024 at 5:07 PM EEST, Jarkko Sakkinen wrote:
> On Tue Jul 16, 2024 at 2:53 PM EEST, Jarkko Sakkinen wrote:
> > > -	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
> > > +	u8 name[AUTH_MAX_NAMES][2 + HASH_MAX_DIGESTSIZE];
>
> Ouch, we definitely do not want 2-dimensional arrays. I missed this in
> the hmac review.
>
> Why this is based on count (AUTH_MAX_NAMES) rather than space? Is that
> value from the specs?
>
> You could just as well replace name and name_h with a single tpm_buf
> instance in "sized" mode and return -E2BIG from the functions that use
> it. Right, those don't return anything but void, which should be also
> fixed.

tpm_buf_write_u32()
tpm_buf_write()
tpm_buf_write_u32()
tpm_buf_write()

Two buffers stored. The read functions are non-destructive. Let's not
invent ad-hoc crap when we have already a tested and legit tool for
this.

BR, Jarkko

