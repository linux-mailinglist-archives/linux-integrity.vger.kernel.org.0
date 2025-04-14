Return-Path: <linux-integrity+bounces-5862-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A78A874F0
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 02:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F9F16EACD
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 00:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B064D;
	Mon, 14 Apr 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdE2lwKp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2F36C;
	Mon, 14 Apr 2025 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744589482; cv=none; b=KNBGG5khV7Z3Bn33NjrsGHn+97Rqv8oCrfY2UWSCFc9lUTYiWXWM+0EnTfVE2rBxeuy2HAANIcST43rqgvIjtUUL3jrjiE57YWr+o2vzzVg7y9Y4ODoq/NY5gQNWUAWj5pNcOnMHi4oTLkryU8XH83eW5URc7WzDJvGgxR8K3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744589482; c=relaxed/simple;
	bh=sQaOwj/u6yguSN1RNd3/P7Jsj2iqheN+9vkHMOOsJCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMASMyJ6nghF0oWSwU8Eg2DCEk3sPOnwO/v6b30hOQdC+wG8YYKFEKU1LHbcyMcDQf/ksy7FSKy9GWF5//X2oLVJecxMQPjVMimhnFJ26A3sgab0AtYr6v0/sVKQoUb/pIkFiflVXp7ZgQ0vCEjPEBaUK9XO352HOGybV6HJzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdE2lwKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6659AC4CEDD;
	Mon, 14 Apr 2025 00:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744589481;
	bh=sQaOwj/u6yguSN1RNd3/P7Jsj2iqheN+9vkHMOOsJCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdE2lwKpvTGfX2OBgyJPUmRZxrWbXFo8dWeOUZMadEyHQuuR2QOHTqjPkKcJvEftu
	 +689JEtWyQCbeEwrDdW/1xZEtoEtZoC86M0Gea9oNQFD7ggFa3FOs8CNc1UhBl5avH
	 ic0j51KbAOLHyLR412l5q57AdjdqYJHgemwt7shQwXewq1ttxL75n49pXjgqv1UB+4
	 MxBjFmP1GmVN34rIiyvzz8rkMcOQNDjvkZrPtETE7WEHrsRq1Ig7vt74ii8aJlNZpv
	 zAY9MfooGIN2u95tvr59/uLZcMj/0+lhGez8X/CgD0eGBgDQGaR+Do9lvIJfm0iFDG
	 XrlbdxKqohn7w==
Date: Sun, 13 Apr 2025 20:11:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jonathan McDowell <noodles@meta.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 9/9] tpm: End any active auth session before
 shutdown
Message-ID: <Z_xSp9-elIJXPu28@lappy>
References: <20250403192050.2682427-1-sashal@kernel.org>
 <20250403192050.2682427-9-sashal@kernel.org>
 <Z--KA3cyFGsqNBKE@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z--KA3cyFGsqNBKE@earth.li>

On Fri, Apr 04, 2025 at 08:28:03AM +0100, Jonathan McDowell wrote:
>NAK. Not sure on the logic that decided this was applicable for 5.4, 
>but it's obviously not even been compile tested:
>
>noodles@sevai:~/checkouts/linux$ git checkout v5.4.291
>Updating files: 100% (13517/13517), done.
>Previous HEAD position was 219d54332a09 Linux 5.4
>HEAD is now at 52bcf31d8e3d Linux 5.4.291
>noodles@sevai:~/checkouts/linux$ git grep tpm2_end_auth_session
>noodles@sevai:~/checkouts/linux$
>
>The auth session bits were introduced in 699e3efd6c645 (tpm: Add HMAC 
>session start and end functions), which landed in 6.10.

I'll drop it, thanks!

-- 
Thanks,
Sasha

