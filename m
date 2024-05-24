Return-Path: <linux-integrity+bounces-2602-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB08CE58D
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804C41F219D4
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4FA86263;
	Fri, 24 May 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FvlKLL6d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C9381BB;
	Fri, 24 May 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555609; cv=none; b=n3Bm1lGczXuDGWWbr3O6vvfNYXUWoLRmK46ZXTEzUkQWTyykcr3U261AI0n86cHayPhh+dd8AajDrCF4mVPqFFllAdMh1DZuQzdvax9Pq+3ZMKstcioTcIk26jdC16o5xfCv+90yySFvptlyQfUd96+msrGNrv0sALpnBjZI+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555609; c=relaxed/simple;
	bh=qfcq6WNWHKpJ/mvr6UQL6uWruD8+l21cB3FPyrmhzxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=INcNRZLiRktO+nIRPa3gzjHLc1FmKljGiKXFdZC2oOvZ6TRtG3qPyGsUF6RVMzjj71gCobZd9ecYBT9npXmM+jMNbWTKuilNSDwOgOyD99+XEDkqsjIJ4o1qZ7f7sEF/A7PSWF7JS4TZzLl5Whg5EF7YT9q321pfOyzr2iSrOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FvlKLL6d; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716555607;
	bh=qfcq6WNWHKpJ/mvr6UQL6uWruD8+l21cB3FPyrmhzxY=;
	h=From:To:Subject:Date:Message-Id:From;
	b=FvlKLL6deI24TBZOsU/4naKquA2ClwhcMHhD9ZTZ2aMPwDen2aOjphi5+MABanEdJ
	 bI8Pb8vfHlyqzXb4lCpL5lX62ZYpE01csp4JDJ25/ZeAk1eAApc7ElqZ4q1lps0/9x
	 yv5qGOnThoLaut630G6ONmZ0GOG1217zfkUebLKY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 135611287771;
	Fri, 24 May 2024 09:00:07 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 3DXKpcJ69SnW; Fri, 24 May 2024 09:00:06 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 64BD41287632;
	Fri, 24 May 2024 09:00:06 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 0/3] replace asn1_encode_oid with encode_OID
Date: Fri, 24 May 2024 08:59:52 -0400
Message-Id: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The relacement removes the requirement for consumers to maintain free
form OIDs in their code and instead requires all OIDs encoded to be in
the linux OID registry.

Note patch 2/3 needs fixing up for the tpm2_key_encode memory leak fix.

James

---

James Bottomley (3):
  lib/oid_registry: add ability to ASN.1 encode OIDs
  KEYS: trusted: use encode_OID for OID encoding
  lib: asn1_encode: remove obsolete asn1_encode_oid

 include/linux/asn1_encoder.h              |  3 -
 include/linux/oid_registry.h              |  1 +
 lib/asn1_encoder.c                        | 91 -----------------------
 lib/oid_registry.c                        | 29 ++++++++
 security/keys/trusted-keys/trusted_tpm2.c |  9 ++-
 5 files changed, 35 insertions(+), 98 deletions(-)

-- 
2.35.3


