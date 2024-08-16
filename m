Return-Path: <linux-integrity+bounces-3327-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E467C9547FE
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 13:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649C8B2241C
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BAE85C5E;
	Fri, 16 Aug 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="WmwWE4WZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5A155727;
	Fri, 16 Aug 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807355; cv=pass; b=nbtU+zExXmy+fjKFbkfLurcR9GxAXkr7HL4vNFhgDcYHEOkaJe2dd7jsGQPgFpyZFKyXoXK9Xxk1MM3+MHRWIw8W4mZEvfSBtm/+1rn01WxvTke8vASBq3ot1rQEtZJYtbhCKOn7UNN++cAjwUcV3MDwE7Tp76sUG3g1r1+ynss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807355; c=relaxed/simple;
	bh=V73G1ph7A4jlD8z73K7hiUCMs96TWLHN98ZuDIkEFKQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject; b=ITNKOUcxi9VEOYloDiP8i6sRLccNslaTohtCbY/IHDUP8FsgaqGbWd5bfnBQ5phxSUkVumlAuHJfhFzrPmMIcV4aUIcTFiapihazI9TzgYMxEm18MMIstLI5uSfMNr4ekYWWOnkbdE+Vi+mIXbn4nTkfwEEab4RJLobv7S/Mu0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=WmwWE4WZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-106.elisa-laajakaista.fi [83.245.197.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WlfXQ4QjKz49Q7J;
	Fri, 16 Aug 2024 14:14:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1723806888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uvF0qX6Miuc3lKVQd7sJzmzq21xmCuqisnie2MIM8tc=;
	b=WmwWE4WZbDHSqhbSHQgd8d+MuTvDoDW19Q3dqHQSksONnmdW+RiHfJpc03QgFy7Q8cNW69
	H8vUTrvjYcoLZiE/qpitR8+7tEmKGvVBe5yfXIhi8y9JU5QQVQyrzCSEIVFjqyiPtSuqRf
	FzRt4RZSAPq7PtkyzqOxbBaD+BCmNwWZaE/Ac/wZNHj3hJFgwQoFch4lRm2BKeVkmI7SVs
	zhqP9+2lBHjWGv2PUQTjQ4eSPz1xZYHQUviVzVM3SJ8iRjEPbKPeBfO/9eQVE1BNkJPVvh
	LUKNpej323nxOSIfPayp0si/NwrhsMmNYIIZ5sRek3dNLOkstbk+oUhba6VofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1723806888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uvF0qX6Miuc3lKVQd7sJzmzq21xmCuqisnie2MIM8tc=;
	b=BnMUvhVnAzELUeeWIynMmlcBYSWVOC5Dn+gLNXTl//m04v2qJo6DqTEg4ghum4j97t7iJa
	nN7jP8S5jJnJAtZ7l/64n4BmeDIASXSVy/mAOR3Za76EgwOlqS8/tx8BqkvdNg1vR5b2Yr
	0Mcbu63zk3vD9dSdxtefLjtFgNxYSFD5bHXn9Q9z/B3GUKawHQmC8Ndzmt7x6ODWYXKYHT
	ZWw2BkbmSUiW+eGCguj3SMwVf+c/i0GmG9eXPFpo1DViRhZMKEanEHQIhAooKI0gT3oITe
	bgPlKHwr9XWqytZqEhzDW/OOho2UXWnibeT4PdzH/F8rhX086XBz8YazftXewg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1723806888; a=rsa-sha256;
	cv=none;
	b=iVeEWOncV0Ot6QGyKm6rV28HuYFcGjpQDrASMSUKS2ZbV0J2/gIfs5kGRaOMIaTNuyR7Oe
	1gZvPraJA5Gc1MhO/j0RKMtlvjEJmJOdasToASlRg6jXAIJc4nlIv9+qg4mQFJLILn3nwU
	6v0rGM7kydc8jNv+I1+uBl1ESTmCftw+KszmSIxYzXPTfIi2yx7f8ApBDJLSRs4DutFmQs
	IhJKaTS2mETftSDo4HQ5G0pTZD1ii2yerTrw67Hrc8QJ9ke4JcOEENovG0TnNg8ZcaKDEi
	bTA/wVImWI5kn/9UrQTj6CaEBYn10Yz0nSxvWLDNriHOUD4P2bDTUoBpHJ7vAQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 14:14:45 +0300
Message-Id: <D3HAJIMUJEVC.154RCMPVU2URD@iki.fi>
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "David
 Gstir" <david@sigma-star.at>
Subject: [GIT PULL] KEYS-TRUSTED: keys-trusted-next-6.11-rc4
X-Mailer: aerc 0.17.0


The following changes since commit a4a35f6cbebbf9466b6c412506ab89299d567f51=
:

  Merge tag 'net-6.11-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git=
/netdev/net (2024-08-15 10:35:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/keys-trusted-next-6.11-rc4

for you to fetch changes up to 0e28bf61a5f9ab30be3f3b4eafb8d097e39446bb:

  KEYS: trusted: dcp: fix leak of blob encryption key (2024-08-15 22:01:14 =
+0300)

----------------------------------------------------------------
Hi,

Contains two bug fixes for a memory corruption bug and a memory leak bug
in the DCP trusted keys type. Just as a remainder DCP was a crypto
coprocessor in i.MX SoC's.

BR, Jarkko

----------------------------------------------------------------
David Gstir (2):
      KEYS: trusted: fix DCP blob payload length assignment
      KEYS: trusted: dcp: fix leak of blob encryption key

 security/keys/trusted-keys/trusted_dcp.c | 35 ++++++++++++++++++++--------=
----
 1 file changed, 22 insertions(+), 13 deletions(-)

