Return-Path: <linux-integrity+bounces-6952-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F56B3CB68
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Aug 2025 16:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5171D7B64B6
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Aug 2025 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CD919D07A;
	Sat, 30 Aug 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3LJter8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF6EEA6
	for <linux-integrity@vger.kernel.org>; Sat, 30 Aug 2025 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563366; cv=none; b=o6k0Pwnc3vImRsJPnDgIye1nbom0rAY7hbI2UZ7I/Ypf6PteqPD+QH8uleSIeBKtGGNmq/xeqHmenCaC7B4FZ8POxwi5aTEuYwW27BFqt4epxsLO9z2CUBCVklLC7r5Hnx8ECHEK5RbOZmXXSaOMCP+nhhD2YgwboasTqj0Q+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563366; c=relaxed/simple;
	bh=Ix1M1sctaaNk+bTpguNt2NulyIkAUtRrdvBjfMU4P3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co9REafqOEOrxwCwNJ/UsYPl/yXt0VFeOJHTict/QwStfM+S1fvo+8IU7I24vX+NtJfNDnbe3+Nj9clTZX4IXQl5mxcesv+f2X14rRgfNqdUXxO6/4HJJPmhhTZ2rKS0WHDFfLCVivJTr7x9D+0Wx4IK6lxbNOpRUWa5bYdD2zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3LJter8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055BCC4CEEB;
	Sat, 30 Aug 2025 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756563365;
	bh=Ix1M1sctaaNk+bTpguNt2NulyIkAUtRrdvBjfMU4P3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3LJter8K6J+6XuDo0YvcpklYWKHtckUpmHUiRvSQFF0PkfjrUC+Us5NQYaLItljr
	 NFbsvCezLSNzm6lFGcEYXb+/qTSDyHuKmybYNSLJeCcu99evOwfQviiB3/p2bHFpa+
	 sRs54WR9xd2TeLjbTyqq4VG5v76YSiWNV+LiandDr6HXtSxmpud1BGO9ZEZarj19gq
	 qjpogzZ1JsA6Ulfz7q7fzR1T5A40AqsCQdFR9rew77iQQUEm244P4d5DGPmWinz/e6
	 fdFohGW42I7sqsy/COWQKK5Qu7V+blZKbUyOpHwMlvw44yPJ8FSF6NaUf7bBClc+FK
	 +8Xi7WwaQkBwA==
Date: Sat, 30 Aug 2025 17:16:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v3] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aLMHoVFj_jvsom_Q@kernel.org>
References: <20250829175152.9704-2-daleksan@redhat.com>
 <aLMGm9tf2mEdI_YX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLMGm9tf2mEdI_YX@kernel.org>

On Sat, Aug 30, 2025 at 05:11:44PM +0300, Jarkko Sakkinen wrote:
> This is really good as now the patch has more value, given than it
> removes useless computation from everyone. Thanks for revisiting
> and reconsidering the approach.

Further, given that it is such a nice and sound code change, I'm
looking forward to review v4 so that it will have zero rough
edges (as it is reachable state for this patch). I.e. one more
iteration for great work, not for bad performance.

BR, Jarkko

