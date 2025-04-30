Return-Path: <linux-integrity+bounces-6093-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C4EAA5030
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A737981382
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA325A2A1;
	Wed, 30 Apr 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM4NQQ9a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1117C21B;
	Wed, 30 Apr 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026765; cv=none; b=KHSROh7obxkWLX6Rfd72r+4DIBmR8W03HAq6LHDVVNXIExXob1HhoUXla10X3LWqokzPXKTGqxCMXQGBsgjwwpm/hlnV+3blev1DKoBAhr8xF/lwEXf/JXP6C09hwR1SidkaNx6WhYGg7N26rl/ftvlHLXfZfFgnuVZi1rBHxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026765; c=relaxed/simple;
	bh=9BnNSNbGk/SH1Jqts3LNDoiGPJQv2lBeVhQ2pLakZsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zq7t3SHQCkqiUq5Ka3oZqe7teB2/l88QA5eUu7QkrJzQbOlNEXsHtGNGOzzXB5YsalDNjD09yTz6mPIP67jNeIJkt0o7ts/fYBCpJ607iYAWoL909e/r6aLbzl7sLCMpICsaCaXPejJ7ctIZENUbUUnkP7maHjjOID0zgjFHd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM4NQQ9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49966C4CEE7;
	Wed, 30 Apr 2025 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746026764;
	bh=9BnNSNbGk/SH1Jqts3LNDoiGPJQv2lBeVhQ2pLakZsw=;
	h=From:To:Cc:Subject:Date:From;
	b=iM4NQQ9aK4CcuaIjYAyxqodWnUl+aox9OAEYJdvXBTMwtwGmpzFk19Y6IzVhayOF5
	 RP0a7qLN+VGxIQKn1td/abgVsoTSc+6eJ/sQpcdXyJ+KCj9PgPzj3c7DtakarSxnvV
	 6uNZU4P666ukUB553+c4yN7mBIEsuCYB9HaF+Zp5/BmoHe4pXtBlHzfaXSolkQVpOz
	 XG4KUcCIl5szp+HHlw5nc1um/+KJI8qHsw8bqKy2jQE4pO/dN1X8hOBU1pZNS0oU6Z
	 V4N2f1MzKqHSM9Peo7UiqF298c2ZmKdx/69w61O50Pp6QrRdGvNO/XgFieetKB8vGF
	 NszNzEM/uon1w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] KEYS: Reduce smp_mb() calls in key_put()
Date: Wed, 30 Apr 2025 18:25:53 +0300
Message-ID: <20250430152554.23646-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rely only on the memory ordering of spin_unlock() when setting
KEY_FLAG_FINAL_PUT under key->user->lock in key_put().

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 7198cd2ac3a3..aecbd624612d 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -656,10 +656,12 @@ void key_put(struct key *key)
 				spin_lock_irqsave(&key->user->lock, flags);
 				key->user->qnkeys--;
 				key->user->qnbytes -= key->quotalen;
+				set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
 				spin_unlock_irqrestore(&key->user->lock, flags);
+			} else {
+				set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
+				smp_mb(); /* key->user before FINAL_PUT set. */
 			}
-			smp_mb(); /* key->user before FINAL_PUT set. */
-			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
 			schedule_work(&key_gc_work);
 		}
 	}
-- 
2.47.2


