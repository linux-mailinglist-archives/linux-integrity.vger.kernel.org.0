Return-Path: <linux-integrity+bounces-6171-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7749AB0F7B
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 11:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C593B8F06
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCC28DB73;
	Fri,  9 May 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="bsMOAxeU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36428D840;
	Fri,  9 May 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783934; cv=none; b=OWPxe+j0dhja0FdmruGIA5o6543Z2gFJf3m1k0g6o2ur3dvCuDKjNf8nN4qFfBTe/LailLOijwt8hOKSnjAkP9CqZTsU/4oQQKcoMho2om0RUstNDhNkc9O5xrarsVHbBOAI6yBSviO35vMOQXwtZWEP9fMqyux7LIkR3iL4Efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783934; c=relaxed/simple;
	bh=rCAKiZwC07a6hYm1JXeN/eU4Io7sxQr9R2Z0uILb7+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auPX5lzaTDejiGDwy33UJdQ1GkRY1JzCEefgM1l5K0MVUP6D5jaExW8NXBa+xYJefZUKc7ayY/4Kd7hoFzPgSlJmVH6D9IZhIiwbx9C/NVAlblZ3wOw/Pjw8O9zOE6QExuIwIqjNW2YF1ruC+9N9zQw52Erc6Rk+ang08Qf15UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=bsMOAxeU; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OgKUwxjDLVEnkNCJ6apJ/HjXQWHF4sHczo99k4VuzQ0=; b=bsMOAxeUeKSmOj0fW9khPDifvx
	VkxBt0BZF6rOZ95DJ9mT28mVjw5BmwkTkW0uRU1aESBW3EVgBHDKiGehu6BFrK6Cgx2lLlloSjlls
	GZu7ZwU3QsrtYF3/WiV1ilNeKBy4rviTv8t0ujG8adRNI1fSHGXUnyRi/ElCOv/37eGymenZnq78N
	vZcrtuIDjWwRzBn97Emxc8hE51NZakOvVRVh+kQatQ+ciT0ZSmmNj96+AN7lPdigoEcSXn1dBxRLQ
	/dquK9ssHjsBeQf8b++9QOolNj61Y8i8/3z1T3LIZBz003LpQdp1+hjQEqGANPtdHpvrQAHJLCAOR
	lRTKp6nA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uDKIC-004olb-2U;
	Fri, 09 May 2025 17:45:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 May 2025 17:45:20 +0800
Date: Fri, 9 May 2025 17:45:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [v3 PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <aB3OsMWScE2I9DhG@gondor.apana.org.au>
References: <aBccz2nJs5Asg6cN@gondor.apana.org.au>
 <202505091721.245cbe78-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505091721.245cbe78-lkp@intel.com>

On Fri, May 09, 2025 at 05:34:09PM +0800, kernel test robot wrote:
> 
> our bot applied this patch directly upon v6.15-rc5. could you let us know if
> this is a correct appliment?

Yes it is correct.

The patch was buggy, the test_bit_acquire should've been inverted too:

---8<---
Invert the FINAL_PUT bit so that test_bit_acquire and clear_bit_unlock
can be used instead of smp_mb.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/key.h b/include/linux/key.h
index ba05de8579ec..81b8f05c6898 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -236,7 +236,7 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
-#define KEY_FLAG_FINAL_PUT	10	/* set if final put has happened on key */
+#define KEY_FLAG_USER_ALIVE	10	/* set if final put has not happened on key yet */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
diff --git a/security/keys/gc.c b/security/keys/gc.c
index f27223ea4578..748e83818a76 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -218,8 +218,8 @@ static void key_garbage_collector(struct work_struct *work)
 		key = rb_entry(cursor, struct key, serial_node);
 		cursor = rb_next(cursor);
 
-		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
-			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
+		if (!test_bit_acquire(KEY_FLAG_USER_ALIVE, &key->flags)) {
+			/* Clobber key->user after final put seen. */
 			goto found_unreferenced_key;
 		}
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 7198cd2ac3a3..3bbdde778631 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -298,6 +298,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->restrict_link = restrict_link;
 	key->last_used_at = ktime_get_real_seconds();
 
+	key->flags |= 1 << KEY_FLAG_USER_ALIVE;
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
 	if (flags & KEY_ALLOC_BUILT_IN)
@@ -658,8 +659,8 @@ void key_put(struct key *key)
 				key->user->qnbytes -= key->quotalen;
 				spin_unlock_irqrestore(&key->user->lock, flags);
 			}
-			smp_mb(); /* key->user before FINAL_PUT set. */
-			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
+			/* Mark key as safe for GC after key->user done. */
+			clear_bit_unlock(KEY_FLAG_USER_ALIVE, &key->flags);
 			schedule_work(&key_gc_work);
 		}
 	}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

