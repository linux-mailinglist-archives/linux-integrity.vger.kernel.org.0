Return-Path: <linux-integrity+bounces-1299-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532985B9B2
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 11:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312702854D3
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607D664C9;
	Tue, 20 Feb 2024 10:55:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13365BC6;
	Tue, 20 Feb 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426547; cv=none; b=X+wFUNQGEWK0BGFjXVoVV7FqmYZmxlBH7pr9SPvN7ugzZppevsRXLRrLhjsoYuhGJHzklaBGMDNPtPLfvj7s4vrfx2m8pamLK7G0s1ADqTs7JxxMpOapk78tIoSTwMtuYLF6VaL7tmHUC0IlsyaJeYPmyzsKjA6jewUxvFO9iTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426547; c=relaxed/simple;
	bh=51PlZ9crQdCLSq/Dbk0zLEgBJaNa1UNFqgkIbcc7QSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZXMOsvTilpTYekI2EayXiHRWOb1Gixo11p4Pwg9MV47pK1qJqvhh1AmyHPyUJaM392x4KKrsjnFQb+T0vseb5N9P47CHhxs3dh6171WVp6QFJrCFS0h6T1auO7r9PpKPmoHYjmZkJL8VU/KiokbLqvmWBNxDRhxC1Ukho/NsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 69D4930003C66;
	Tue, 20 Feb 2024 11:55:36 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5BFFD4DD9EB; Tue, 20 Feb 2024 11:55:36 +0100 (CET)
Date: Tue, 20 Feb 2024 11:55:36 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 0/4] Add missing TPM compatible strings
Message-ID: <20240220105536.GA4555@wunner.de>
References: <cover.1705140898.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1705140898.git.lukas@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Dear Jarkko,

since v6.8-rc6 is approaching and the end of this cycle is thus in sight,
please do not forget to merge this series:

https://lore.kernel.org/all/cover.1705140898.git.lukas@wunner.de/

All 4 patches have a Reviewed-by from you and patch 1 has an Acked-by
from Rob.

Thanks,

Lukas

