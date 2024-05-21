Return-Path: <linux-integrity+bounces-2505-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBBD8CAE5B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 14:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD95AB236DD
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CFC524C9;
	Tue, 21 May 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rV6VPLZb";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rV6VPLZb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69128E7;
	Tue, 21 May 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294799; cv=none; b=PSVWQiOkAsWZIp/44ANqRo+4dd70Cv/vA6f9Ll9iA3vsmZuqaijzGovom1f+RC4T9uyWAhSS3Zpjy9ze3hPbk0hcHgkN92fSGwEd8ha7p5F6/6Ur4H1S922qMSCjexuWjN4T2aKWOHwX1v4KMJo7+Zg4LV5SIqAmPVply3cT4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294799; c=relaxed/simple;
	bh=4vgdnofIwNb1ajkPrbOT3Lbl60nVqFJx34gAkwyuadw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/bDkrZ+R2MgHDryzUeLq8YfxvXpbGSeCNwOqAif7mYbfn/h7nu3qDwBfAmrmMDgCMMQzGclSnWtTkIuYbIFYwVD1iL+4/jZvRkL+/k2P9nJAhNYMgTECCgOiDH51E5hvO0WSja7Dt7WShb6/tf3tJ17PGwCr1vWOGw0KNcuom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=rV6VPLZb; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=rV6VPLZb; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716294796;
	bh=4vgdnofIwNb1ajkPrbOT3Lbl60nVqFJx34gAkwyuadw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=rV6VPLZbcuitBrYL9HiTHXTUIHK4acf3fvSRb+IP3bLyn9wvZQ6CcnMgX/v+9kWN3
	 Ye16A4Mmp86Rmb+HoQfQeallNhoDqUPfvnOj+i+iobx5zLbbNEjJPNWk0Ijy/JryDB
	 intlJ6gWa7w5GhiyBgj0td1wEZjbGqjUv6iwT8dQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id DFD5412872E9;
	Tue, 21 May 2024 08:33:16 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id m6rnL6AmJ_J8; Tue, 21 May 2024 08:33:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716294796;
	bh=4vgdnofIwNb1ajkPrbOT3Lbl60nVqFJx34gAkwyuadw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=rV6VPLZbcuitBrYL9HiTHXTUIHK4acf3fvSRb+IP3bLyn9wvZQ6CcnMgX/v+9kWN3
	 Ye16A4Mmp86Rmb+HoQfQeallNhoDqUPfvnOj+i+iobx5zLbbNEjJPNWk0Ijy/JryDB
	 intlJ6gWa7w5GhiyBgj0td1wEZjbGqjUv6iwT8dQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8614412872C0;
	Tue, 21 May 2024 08:33:15 -0400 (EDT)
Message-ID: <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Vitor Soares <ivitro@gmail.com>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Tue, 21 May 2024 08:33:14 -0400
In-Reply-To: <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> This benchmark could be done in user space using /dev/tpm0.

Let's actually try that.  If you have the ibmtss installed, the command
to time primary key generation from userspace on your tpm is

time tsscreateprimary -hi n -ecc nistp256


And just for chuckles and grins, try it in the owner hierarchy as well
(sometimes slow TPMs cache this)

time tsscreateprimary -hi o -ecc nistp256

And if you have tpm2 tools, the above commands should be:

time tpm2_createprimary -C n -G ecc256
time tpm2_createprimary -C o -G ecc256

James



