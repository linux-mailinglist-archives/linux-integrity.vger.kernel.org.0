Return-Path: <linux-integrity+bounces-6123-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531BFAA8499
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 09:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB06189A2C2
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 07:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980AC14B07A;
	Sun,  4 May 2025 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="pGo++wuM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD694B5AE;
	Sun,  4 May 2025 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746345211; cv=none; b=Ca2KWkFZ6YLXmXAtcg5o4OCSHvq8VMJXK94VtLJnO1a2HogBjZlWs1lFE2LgewqlLcfeSHMgYT7dDvpKUK1mulfaoT8RSawR5JJCAUwG1tIYTgcRnCes/ExofSOSsoX3HEaV+zuS6OLhMkUwIJAc7FzFoUO2ijNK0772aXaqS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746345211; c=relaxed/simple;
	bh=3mZkvsMVZ3TmoteIDSZkFVTfbQghz/+q0hCyVGCNds4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6jYgj6uAOV2gB3xThG5SchUPAolWSP7hht4z/QW2/zwEjtl8yU7qpZw3mJ0rg/jy6GMW/4R1pNqAfRV63xNuKGUzAGEdt/hxAKd3LV3OupWUngsOb9bOtzPdcLHIitvJjF+Uleyi3DRsUnGryVs3nlLH+Rp5AhkID229Q35wUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=pGo++wuM; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5Pp7UXCRue9lL41cTrbfnqtJ1uqpTa0PBDfwUmhSThc=; b=pGo++wuMRrRfp8ysN6dc5BAzTj
	bLzpsjxS+BHCWmMwkkugvd/eTC82KZ6hmVdPznwivqBhXPRaUXyWxpH4MIScd8UXgcT9CH/OWeUzN
	rrqvWHuQuky8HQ2CgrHb+QZpyXVzKfV5pKHEc2/dPVDOUxHIeIK0ERM6hJFPsPIobk2vCS71cZTai
	zMPEg8gb2obT6pYTTosf9lQIeVXQEHoSt4YD8H56wp88yDAPrBOSrkpFE0kbxAx/OH0Cj606VmF3C
	1OAnnEsRlSYVqtWL25CvQl54JuIwmzq8i1v2Ahe5xxWG1ncvX26/VW+LjSlqN0BrosmgoQbA+XCXW
	c0DpfMUg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uBU9X-003CUy-28;
	Sun, 04 May 2025 15:52:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 04 May 2025 15:52:47 +0800
Date: Sun, 4 May 2025 15:52:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [v2 PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <aBccz2nJs5Asg6cN@gondor.apana.org.au>
References: <aBb833yQFY5EpEFx@gondor.apana.org.au>
 <aBYqlBoSq4FwiDKD@kernel.org>
 <20250430152554.23646-1-jarkko@kernel.org>
 <1121543.1746310761@warthog.procyon.org.uk>
 <aBa2bZGnJ2kRJJpa@gondor.apana.org.au>
 <1131866.1746344653@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131866.1746344653@warthog.procyon.org.uk>

On Sun, May 04, 2025 at 08:44:13AM +0100, David Howells wrote:
> 
> You need __set_bit() or 1<<N.

Sorry, I'll fix that.

> Also, don't really like the name, but that's just bikeshedding.  I think I'd
> lean more to your initial suggestion of KEY_FLAG_ALIVE.

I was going to do that but there is already a flag called
KEY_FLAG_DEAD and it would be very confusing since they mean
completely diferent things.

How about USER_ALIVE?

---8<---
Invert the FINAL_PUT bit so that test_bit_acquire and clear_bit_unlock
can be used instead of smp_mb.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/key.h b/include/linux/key.h
index ba05de8579ec..aaab26d84d25 100644
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
index f27223ea4578..d00002054ada 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -218,8 +218,8 @@ static void key_garbage_collector(struct work_struct *work)
 		key = rb_entry(cursor, struct key, serial_node);
 		cursor = rb_next(cursor);
 
-		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
-			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
+		if (test_bit_acquire(KEY_FLAG_USER_ALIVE, &key->flags)) {
+			/* Clobber key->user after final put seen. */
 			goto found_unreferenced_key;
 		}
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 7198cd2ac3a3..fb78c3a0be76 100644
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

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

