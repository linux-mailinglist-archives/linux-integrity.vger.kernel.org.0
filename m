Return-Path: <linux-integrity+bounces-6936-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76100B382C3
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2203668E7
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ADE1DFE22;
	Wed, 27 Aug 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgAV8JBW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028311A0711
	for <linux-integrity@vger.kernel.org>; Wed, 27 Aug 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298757; cv=none; b=TFzIzjdQtIg+nhMI4c8qz/48fkIBbc2yp00qEdym4av/p6zVEoAowRxd8W7nhoV5m5GcDN3UtVnPGySkF9i5BYSPxG78oi4oct67RN+7HqohA0+qzUXZ/7AF89b7jYxDR60aG8yiTP4j0CeE5GpZXysqJxhGGMgjPDtiflvVAiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298757; c=relaxed/simple;
	bh=gTUgb0/hlOqaOyrjWYDQPSLJvxZPFKUMPHCBOiwiGDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuK+e6/6pN78d4qnIigvUgHOeo8D1hrBNayQ9Tv0BgXkuEczeNiYVomlOMIBzxAGdzPIlHAIRPJ7xuRprc13MH83USUCb34sAYiKQixOHottnY2poKVUmh6yj39EqqMXx5ryzCWg1gYwgjAt2vx7DekN8ojiM8kxnsmDNYjmuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgAV8JBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FF1C4CEEB;
	Wed, 27 Aug 2025 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756298756;
	bh=gTUgb0/hlOqaOyrjWYDQPSLJvxZPFKUMPHCBOiwiGDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgAV8JBWI+E8y6/rJ25+ffwziLEZ0qN+sEJfkj2HMMAEwy8Izghl5wUb8ewZG4EgM
	 MW0pLchK+a5Scu4cvoJU6icuUSPqs3kzao+pSocCaHtOadki9mlPK3hmeii23eSibd
	 BGBgu76qpmRFrSmIhF6PQ3mOeMGSglCK2MySpt0aIyueJ6crfQDoPvnoFJx4rOCag1
	 oqWyIxpv0hTMXcT5g9iWjc8Y7DuBo1UDoRXedCMVwaL207VQg65/j0f74aa84DIPeV
	 8dbu1PQ3ZcEkcI5Nma3yWRogkgnDwsnfiIpZ4WLeI5CLKj88gt2s/yhn+EIyFkPhZY
	 ctl0wbwo+vr/Q==
Date: Wed, 27 Aug 2025 15:45:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v2] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aK79_nYY01rFvUAt@kernel.org>
References: <20250827022102.17731-1-daleksan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827022102.17731-1-daleksan@redhat.com>

On Tue, Aug 26, 2025 at 10:21:02PM -0400, Denis Aleksandrov wrote:
> Reads on tpm/tpm0/ppi/*operations can become very long on
> misconfigured systems. Reading the TPM is a blocking operation,
> thus a user could effectively trigger a DOS.
> 
> Resolve this by caching the results and avoiding the blocking
> operations after the first read.
> 
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>

I can already say that this definitely to the right direction.  Thanks
for taking time revisiting this, and taking time to restructure it.

I'll give more detailed review later on. One nitpick:

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>

You put this whenever the proposal for "final solution" comes from
an outside source. It's a good practice, and it's not only for the
credit, but also to get to the blame if my proposal turns out to
be an epic failure ;-)

But yeah, hold on for detailed review.

BR, Jarkko

