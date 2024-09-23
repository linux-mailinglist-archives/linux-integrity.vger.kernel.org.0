Return-Path: <linux-integrity+bounces-3661-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC6497E5D7
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 08:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8061C20AEB
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 06:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9C910A3E;
	Mon, 23 Sep 2024 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="HXplJl6+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2F14F70;
	Mon, 23 Sep 2024 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071572; cv=none; b=GrFGNBpnlE/41Q2K6bCaXaN/05Htl7UpHfWH5JOJqKpx+OzTZ9U7XJPkAJ/N/MUYo2QU3tQV+PV6sYOoT6CUKBZXdWbjqdN8JEMqS/933vi/d/kqy08QugZ2K6i9rH+HQ6shFLGjNeQGxiaKz9n5mRMk+j3yn863FgYOcIew1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071572; c=relaxed/simple;
	bh=inrQqnlNxJW+p7zH4NHhbCI/ETYNWgP7AABkrwY98ww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W+y7rzqgQehaaZLjnj2as+QKV87rhoOZUged11Hj56ZuaZ5U02A+mW9kaofM434YxtJiH4/4u0GsBcB62bxG26erxlviBUbhApxu5sWkgIJkUZrQmHYkIaur1s8b6zoy5LIxlkjOhxiQsG9/yirmYxPaXwJPrIpx2eJasnWeLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=HXplJl6+; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iT8QtlNh0gcmgvNGok6WlN8zEXT8ZhZjbNFl2QH6p0w=; b=HXplJl6+LVYwPYQmGplnO2Bb1+
	RwOCT+IlcmeKuXDRPoR0GW/GQvfL4Gv8NJCB94LLlGV+Nx4xQn0CM0FBIJ61cf+87k1/9YAU3QlB9
	kuuoSvVcYldh5ZY0jQuJEENanEhcaiu2vebZQCzoQYgeU0OTgcged5yCdpiD7SeXw5SlUPSmNSn83
	DouGb6Jpfdy7KA+B/kf0JzcDVIhho+Kd5MYqUzCKK8HmA7NSBw8WP7KvbOIegyRo5kialocvBCEeU
	/n/jNmTN5LjuHsodSIPUsVCAjicc96IjGKEoUqxa1BKLM1ymhlVasLdN/UrFY5MbrInEJ4JLBPplJ
	umGxgwTQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ssc2t-0042DC-0F;
	Mon, 23 Sep 2024 14:05:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 23 Sep 2024 14:05:52 +0800
Date: Mon, 23 Sep 2024 14:05:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Guangwu Zhang <guazhang@redhat.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
Message-ID: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear TPM maintainers:

Please have a look at the tpm hwrng driver because it appears to
be returning a length longer than the buffer length that we gave
it.  In particular, tpm2 appears to be the culprit (though I didn't
really check tpm1 at all so it could also be buggy).

The following patch hopefully should confirm that this is indeed
caused by TPM and not some other HWRNG driver.

---8<---
If a buggy driver returns a length that is longer than the size
of the buffer provided to it, then this may lead to a buffer overread
in the caller.

Stop this by adding a check for it in the hwrng core.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 57c51efa5613..018316f54621 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -181,8 +181,15 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 	int present;
 
 	BUG_ON(!mutex_is_locked(&reading_mutex));
-	if (rng->read)
-		return rng->read(rng, (void *)buffer, size, wait);
+	if (rng->read) {
+		int err;
+
+		err = rng->read(rng, buffer, size, wait);
+		if (WARN_ON_ONCE(err > 0 && err > size))
+			err = size;
+
+		return err;
+	}
 
 	if (rng->data_present)
 		present = rng->data_present(rng, wait);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

