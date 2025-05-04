Return-Path: <linux-integrity+bounces-6121-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2CAA842C
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 07:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801B7179B02
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 05:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42753B1AB;
	Sun,  4 May 2025 05:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="fJhbTGpy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27960320F;
	Sun,  4 May 2025 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746337025; cv=none; b=brnYzzIws2aVsrAikWDCDL1thQ0bog/eHyCNMLaYGuBknudXOtf4E4jvSdlGxVEk3afBa/vjzh8w3j8eb8XLJk+QqJpXVgwDk+CFKAkskekvEIeP7xIXP427y2xyeZIYT5cdubRdfjgS4dIqauMxicRtQce7Lr1Q9CKDRvEafjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746337025; c=relaxed/simple;
	bh=fpLZWtyahtmy3/LUtlIsk0Ranng5q9S5+N3o/YX9Eak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlsuStsqOo3bX6dSmFtWDDlKIPx//vxNNGO94ZjWWR8EIlzEh1w7iTVdvjEasiLD0WkJBMCkKQPCk/peFlrg3pBFG6GpRqWAw87dRdRlvZnq/U0JYN493kvlVV/7Iby/rcSQEpniS6iGM8puRp88iJApsdm9RVzBI5q0Lx/NJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=fJhbTGpy; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9wyyplTiopVOErcI7FhcsAXnP0UOiDJzt5tyc1ZRP70=; b=fJhbTGpyC55naIqgpIzdT6VD3C
	uyoIp8Bh8JbycdR2IzF52YfgGzQITkqtUJyTwijb8RWrDv/KvVB1opqo1EYfoJgR3DpPBTM5Te+k+
	9KRuwhi7Y0zJcgykuyDnyE90cMJ4qBRcOsbas7oNZthFhlxe13eExCYhZ/J7BP2ZjhsF5S9MuHaU+
	KxS9tzH2eQwqKvOQ+OcKA/eKQvzQOXOzfhejqiWg+ZAbwHLlJBDErsyv3wnomE74TYqLPFuetg4o+
	dpwqTToYf4CqEXGyOO8pLeDrSr7TE7nfMX+eD+0HYDkX2fEN3TzoPIqJwvCZgEiz3l3spkEDHPjBM
	2k5tDTAA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uBS1f-003BVM-0X;
	Sun, 04 May 2025 13:36:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 04 May 2025 13:36:31 +0800
Date: Sun, 4 May 2025 13:36:31 +0800
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
Subject: [PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <aBb833yQFY5EpEFx@gondor.apana.org.au>
References: <aBYqlBoSq4FwiDKD@kernel.org>
 <20250430152554.23646-1-jarkko@kernel.org>
 <1121543.1746310761@warthog.procyon.org.uk>
 <aBa2bZGnJ2kRJJpa@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBa2bZGnJ2kRJJpa@gondor.apana.org.au>

On Sun, May 04, 2025 at 08:35:57AM +0800, Herbert Xu wrote:
> 
> Or even better, reverse the FINAL_PUT bit and call it ALIVE, so
> that you can use test_bit_acquire and clear_bit_unlock.

Something like:

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
+#define KEY_FLAG_DONT_GC_YET	10	/* set if final put has not happened on key yet */
 
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
+		if (test_bit_acquire(KEY_FLAG_DONT_GC_YET, &key->flags)) {
+			/* Clobber key->user after final put seen. */
 			goto found_unreferenced_key;
 		}
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 7198cd2ac3a3..7be12d132c4e 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -298,6 +298,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->restrict_link = restrict_link;
 	key->last_used_at = ktime_get_real_seconds();
 
+	key->flags |= KEY_FLAG_DONT_GC_YET;
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
+			clear_bit_unlock(KEY_FLAG_DONT_GC_YET, &key->flags);
 			schedule_work(&key_gc_work);
 		}
 	}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

