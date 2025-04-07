Return-Path: <linux-integrity+bounces-5621-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2389A7D150
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 02:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF9516CEFF
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 00:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868662914;
	Mon,  7 Apr 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3htmVgT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10617BA6;
	Mon,  7 Apr 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743986284; cv=none; b=NyE9n+1zVIEM+8lUkrrRE2LRfspBuKJ9Hh3GptMpm/S/uey+egMTFUJGulDqVAB7W7ZNshJtZvocH5c16WgP9cnpQXXJyQwUyzeJJGqZm/18lrimiqavztBvHT4EOTrzdrDrKp2NP7lgYgK20+hflm5ZXVv4M8Hs+vAHEmwXR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743986284; c=relaxed/simple;
	bh=+tGXeQSrGysEIhdSdet8JZyBaFEsGB0pL87dtXIb7C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGDSDUswBpBepyxE1PFFXWdgLGkA9B99GQf7T+UxHD9p2Tx0lBGgVyllEDh86cNg+UKRoSB2oIIcmELWqCDGfMLxFZOev8Gnq+n486hFhexxerjjjncxPMl8yZw19cXH+xtfZYziSZoCeFQeO9mqPbgRo+xQl6m+UR2RdvGCE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3htmVgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951DEC4CEE3;
	Mon,  7 Apr 2025 00:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743986284;
	bh=+tGXeQSrGysEIhdSdet8JZyBaFEsGB0pL87dtXIb7C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3htmVgTTtO5WvTkiJ7wTcC5GGl2CSWO8A4OFSoU48qIrDChQIHKBEYQjrkai7gVY
	 xHzIliy1a8laJ+mV+OhziG8nyxvAJ4gjq79WePg0zh+xosbDoyaHLH3tf+fsYAq2NJ
	 dtjgVmmmjkDZg1DgrBZfGFZvcX4Oax6GpK43YbaWi+Vn2WRDzAKFYP07r72CXNFn2m
	 /GolUpaFTRku9B2o0e8J94eGypjYJpZMp21+5UnNdRgMWjVDjrD1cJSk3CIV861hvy
	 qlDkQA3NIZiN/pjzOi+iWieh0qMO4mUYEVN29VP1ObTXx9+fWhjrcJcnn/lnq0mFU3
	 uVcsPUmO1oibg==
Date: Mon, 7 Apr 2025 03:37:59 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: Add a list for unreferenced keys
Message-ID: <Z_MeZ-dC7ugzdkkn@kernel.org>
References: <20250407001046.19189-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407001046.19189-1-jarkko@kernel.org>

On Mon, Apr 07, 2025 at 03:10:45AM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Add an isolated list of unreferenced keys to be queued for deletion, and
> try to pin the keys in the garbage collector before processing anything.
> Skip unpinnable keys.
> 
> Use this list for blocking the reaping process during the teardown:
> 
> 1. First off, the keys added to `keys_graveyard` are snapshotted, and the
>    list is flushed. This the very last step in `key_put()`.
> 2. `key_put()` reaches zero. This will mark key as busy for the garbage
>    collector.
> 3. `key_garbage_collector()` will try to increase refcount, which won't go
>    above zero. Whenever this happens, the key will be skipped.
> 
> Cc: stable@vger.kernel.org # v6.1+
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Rebase went wrong:

https://lore.kernel.org/keyrings/20250407003622.22139-1-jarkko@kernel.org/T/#u

BR, Jarkko

