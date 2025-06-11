Return-Path: <linux-integrity+bounces-6416-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F66AD5C85
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 18:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA8C3A221F
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3761F3FD0;
	Wed, 11 Jun 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNLnn3p/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CA1A9B32;
	Wed, 11 Jun 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660225; cv=none; b=kemjkwrAjhCx9zBAFDezRcUEdtGjbS9FruIkKDq9a/1UiFYb3zh3t2xUS9ocGYrwyR5d+cReS+Qlnfda3NUu+ZF93wJavk/xBKP7htaXg0XDnMzsz20669IPhm1bmjPFqg7IK/TYW64quer/xzwM3ItwMg1txZFV7+aZMHrN8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660225; c=relaxed/simple;
	bh=YIqNKSCUkmoxXnYE9WaHtbK4fU+AIhNOIPn0Tq6SnDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiftrWVPPVu5uuklGqtQO714MeBHmTDryjDHE86+QexxsLsLFD2REh6sigbEKP15yg1UIm95dJ8XD+Bk7RobceI3ydU3zS/qErzayMrxhnb6W/yQhXP7bbFICoo+etyQPIZTpSv6CJ7gksKsh8v9J3ug1fvsq4ZXpjGpGtWD4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNLnn3p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E9CC4CEE3;
	Wed, 11 Jun 2025 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660224;
	bh=YIqNKSCUkmoxXnYE9WaHtbK4fU+AIhNOIPn0Tq6SnDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNLnn3p/gh+qIjGTRMAZ8mRpa3RAWENKUAz0+e3GaXq7zw5gC9ssQR8PXIvSJRa2Y
	 QgyD7pGzsZVW2kzkLFPAvo3pYoPhHCvClV+E3yJTUYbu8fBKk1TTMn/FRYzB8VjAhQ
	 osO6Xr3K/hHfm2RuC83sLllqdJbYtL0XgFlMtDmIosUJKacy5FWz8zFUoALxEcOdln
	 gQLKC+UYIoiQ9JCNhrInVb6OVNyu/vB1okJliSId+gQqXk3EhhqFpxMV7hskcnX50/
	 DW7NCylr2Yeha91BwqcWotZN3jLAUuBB6SOipeUvtsBV/5HwT78LfWdNnoR+InNLBW
	 NJ+k2FWmLMK3w==
Date: Wed, 11 Jun 2025 19:43:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] tpm_ffa_crb: handle tpm busy return code
Message-ID: <aEmyPWVoZtG4sNhP@kernel.org>
References: <aEdLc_OpTNvsk5pl@kernel.org>
 <20250610211226.3837372-1-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610211226.3837372-1-prachotan.bathi@arm.com>

On Tue, Jun 10, 2025 at 04:12:25PM -0500, Prachotan Bathi wrote:
> Hi Jarkko
> Replying again, since the last email was rejected due to html content.
> This is building on top of commit a85b55ee64a5da58c6e2c69e2648023189210eae.
> A tpm service can be accessed by the driver using direct message request v2
>  interface according to chapter 3.3, TPM Service Command Response Buffer
>  Interface Over FF-A specificationi v1.0 EAC.
> Best
> Prachotan

Can you mention that spec please in the next version? It's useful
information to document.

BR, Jarkko

