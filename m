Return-Path: <linux-integrity+bounces-7407-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15688BCBBB1
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 07:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1D004E1EED
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB8E1F4C99;
	Fri, 10 Oct 2025 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Tb5QJs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3872AE70;
	Fri, 10 Oct 2025 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074731; cv=none; b=X+rJ9wKMopUxQx+o48YzurEcoZcyHtfRaH5UkcFRSs2Zu8H/TGzvndOJW6raSv/6XWwsBPRq4anelV6ih7dShWn4UEiuxi3n1YR/AJD7W4UZDcatcuURcS9WZb3/Q6S8gbP7HMf48hARFaoBm4nfiAUM22Tl1B5h0Op9leMO1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074731; c=relaxed/simple;
	bh=F7O07B2LlSVeGYLipoh5LnBlEanKkhrcvSpVxLznUi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzfOgK+2vWDcF4kS63Fod64JMlwy4aIHV+whFe6hHK4Y/Ffz1FAX/D1MzOjkxFQ+cRTrA9y6EwnN32Nl/MAxp8bMN0M7ZLJbut1lIhFKO6DVfD+zWIJZLw4mfLflSnH+7Txxx1PrtT/RFcrYa4CqSg80XrKVLcMMccEiaLqEgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Tb5QJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC54C4CEF1;
	Fri, 10 Oct 2025 05:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760074730;
	bh=F7O07B2LlSVeGYLipoh5LnBlEanKkhrcvSpVxLznUi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7Tb5QJsKj9BY9Hmmuu/c0VOajg2Qj7o0FDzvbBRRGnzW6Q3BD/D8C2acY3j2vsYJ
	 v4RvcQ7vp1oxIxEhtKlmw2taE4xZbqFAsbdfXfM61xxfgyTkkBc58LpDvJBAu1pptj
	 UavfvZZ9yNkDaxNvulWvTn55RVUGCo9Idqmsow+LO9kDfGBYvCIEjHweXNu52xiOUH
	 EDWh/U5N7182eDb6R/H0va5pjUYOLc3PqNpFwc2FvdUqQvp3Yk9XJalrGgik9RxvCh
	 xDrmQfICRQSI7kdK2/Z0QIZUcGLWj9Jx8VKDLcM0bLMdMRTlLtTQZi4xZVmatZupR/
	 atYUvZESwW9XA==
Date: Fri, 10 Oct 2025 08:38:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-2
Message-ID: <aOib5vbM4qDZr7sL@kernel.org>
References: <aOibAOKu_lEsSlC8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOibAOKu_lEsSlC8@kernel.org>

On Fri, Oct 10, 2025 at 08:35:00AM +0300, Jarkko Sakkinen wrote:
> As per Chris' feedback, commands fail because it is based on Google's a
> non-standard proprietary TPM alike implementation. And the issue is not
> PC Client Profile specific. "typical profiles" are fine when they become
                              "atypical profiles"

> "typical profiles".
 

BR, Jarkko

