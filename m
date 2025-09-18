Return-Path: <linux-integrity+bounces-7171-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBEB8629D
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 19:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC70E1CC11BA
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B2B311599;
	Thu, 18 Sep 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfRaOQ3M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73F2641C3
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215408; cv=none; b=Y40+xWVP8fYMztMJoLCCy/omzIp5Hlj4M73pTomTx3jQhzLVDN3/EeYsJWcxXoG3bqNb00NiLTJhwZYVGn3or2oQl1m11/rZiK1eec3xD+dZY4VdJrJqw9DIvQTGUcNbbwAzS8vummR9mKD/JwkuIOBZ6eahU5E2q1eacIl8WNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215408; c=relaxed/simple;
	bh=bCivMrrzSDZCfODVNctUXmOEf7dvgBD5/MRpYFBDjos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqoHZjN2P0J5zFXfsLLr+IAIsTSmwB0vGhyJOBklmo+r9EMFp5q0Y35a6YFMA3p7MN+Gq+NrGFHliy1TBMOlA7DC6wY1cSkZEbpUV2RUrTWKVJPJ+z+eK+I7SXFxn13oZnyFJmmxfEFpD/zEVohSKgk34neehxFs4d7nb2a/32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfRaOQ3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3B6C4CEE7;
	Thu, 18 Sep 2025 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758215407;
	bh=bCivMrrzSDZCfODVNctUXmOEf7dvgBD5/MRpYFBDjos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfRaOQ3MqEbnbgABTbKyk1p6eA0vjOHMp6mHqQVoq9pI9e0IHiidfSuleu+9dndfH
	 U5EMS3QcMGSnJEFSWkcu6wowaUglA6jv8wAgMZTudEYtv/nzK/Qs3Y4F4zfOsDF3tA
	 QGdK5odxhtd+7Jw+ZiKOuHjHR7HPMn1+GJGzCjbP5tPEj5XjaBxuwdH4h5zoO2bPMY
	 48skOj0u04hHvOAVwh3+OZlITdEWD2VJs40tAy3NvUgKyYvaOrv3fDeuM4SJdoYr0n
	 jxawBP10ynjuPOgw7l8gqoyHy1w+wA04AfhdjGU4eIHUSTUrneGKzbkln63QvfHgn4
	 UAJ0pFhwxCvlA==
Date: Thu, 18 Sep 2025 20:10:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= JOUEN <fjouen@sealsq.com>
Cc: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Issue with TPM kernel code
Message-ID: <aMw87PsUY8h_K8yM@kernel.org>
References: <GVAP278MB0280F83F8CE1884D26A0BA35B116A@GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM>
 <aMwzDvvpGH4dfj2O@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMwzDvvpGH4dfj2O@kernel.org>

On Thu, Sep 18, 2025 at 07:27:58PM +0300, Jarkko Sakkinen wrote:
> Polite remark, and this also how vger works: use plain text email.
> The list drops HTML mail and thus your original message won't
> appear at lore.kernel.org (but since I responded this response
> luckily will).


So apparently I was wrong, so all good:

https://lore.kernel.org/linux-integrity/GVAP278MB0280F83F8CE1884D26A0BA35B116A@GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM/

Perhaps the list settings have been changed. Still plain text
would be the most reasonable choice.

BR, Jarkko

