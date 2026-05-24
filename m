Return-Path: <linux-integrity+bounces-9647-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCgAGneJEmp10gYAu9opvQ
	(envelope-from <linux-integrity+bounces-9647-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:15:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 129655C1663
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92560300EFB4
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 05:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82E2EFDAF;
	Sun, 24 May 2026 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk9eNaJU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7C2F7478;
	Sun, 24 May 2026 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779599729; cv=none; b=U0BPH5EO9wVLqRkPJXdZZZpNQCt1DC3JOGSrJUGseKg00P0p2SLD7ylTZ1yWK20uAmPv441daYqZal3g+byYbYEg0ZkJpCuqFgy2yH9a8TLhIB2+LFVGJCsAvU+Ya12EUQ5EIoknuN80vgho7aN+J0ExghE7uUoY6RZ5sT7exd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779599729; c=relaxed/simple;
	bh=fHWc8nAYAz7OPYn3/irAz5Zps16T5mscYvl+m9RoEZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WG/X+9ZQJk8ku/eljNB7aU/2gxftReiL3S7TQAOzqXX3pMulGw0tmKn2Xd59vLoTvXGz5yQWCkHzJtz+CM/pIybWpnOK/d0qWfi9ZpbJXwRqdxbpogjKf/OI4WIWN0Cl9oNa7vYduO8b7EePBb14tTS5Dca0nV4A4GZwPtpeDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk9eNaJU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6CC361F000E9;
	Sun, 24 May 2026 05:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779599728;
	bh=S2EiS1f01ryjm2Z8gBccKQbpE/j6NghwVq278P3vsdk=;
	h=From:To:Cc:Subject:Date;
	b=Wk9eNaJU8xlbXe8SagSUSUQQjTC50r8gbhA0p9LXeIVeq96+POQEj8oo+PAysX3cm
	 tw4hMvZAjWwNjSd67a4/0s8TCzwonShYPDLAzIcEsrD5yfk2gIaAT7znPe0vzUaPv5
	 UV1MME/TD7CxrB79BedOZE8qvDvyUHdYeFAnlyPdZNGmiHfnGd4VHUV/BADpUw7uuS
	 PbSTw83K99U+AZeC27sWol4xIy1D2YQszYQ6AAOrmVR8Ol8uxJ0VJEPrICtx5vVxir
	 qkFf8tIYXyjDCCVoekQqrTNXqP1cVxU3I53AvzDk84/g86XQocsl+f+vIImIQPwDzO
	 TYHgIG5KZUTog==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 0/3]
Date: Sun, 24 May 2026 08:15:11 +0300
Message-ID: <20260524051519.3708075-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9647-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 129655C1663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces key type for operating with asymmetric keys using
a TPM2 chip.

Change Log
==========

v8:
- Reset patch change logs given the overhaul of the code and patches.
- Have only single new subkey type.
- Make key type only use TPM operations.
- Use TPM2_Sign for both ECC and RSA keys.
- Align key descriptions with other key types.

Previous versions
=================

* v7: https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@kernel.org/
* v6: https://lore.kernel.org/linux-integrity/20240528035136.11464-1-jarkko@kernel.org/
* v5: https://lore.kernel.org/linux-integrity/20240523212515.4875-1-jarkko@kernel.org/
* v4: https://lore.kernel.org/linux-integrity/20240522005252.17841-1-jarkko@kernel.org/
* v3: https://lore.kernel.org/linux-integrity/20240521152659.26438-1-jarkko@kernel.org/
* v2: https://lore.kernel.org/linux-integrity/336755.1716327854@warthog.procyon.org.uk/
* v1: https://lore.kernel.org/linux-integrity/20240520184727.22038-1-jarkko@kernel.org/
* Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/


Jarkko Sakkinen (3):
  lib/asn1_encoder: Add asn1_encode_integer_bytes()
  crypto: Migrate TPMKey ASN.1 objects from trusted-keys
  keys: asymmetric: tpm2_asymmetric

 crypto/Kconfig                            |    7 +
 crypto/Makefile                           |    6 +
 crypto/asymmetric_keys/Kconfig            |   17 +
 crypto/asymmetric_keys/Makefile           |    1 +
 crypto/asymmetric_keys/tpm2_asymmetric.c  | 1096 +++++++++++++++++++++
 crypto/tpm2_key.asn1                      |   11 +
 crypto/tpm2_key.c                         |  150 +++
 include/crypto/tpm2_key.h                 |   46 +
 include/linux/asn1_encoder.h              |    3 +
 include/linux/tpm.h                       |   10 +
 lib/asn1_encoder.c                        |   62 ++
 security/keys/trusted-keys/Kconfig        |    2 +-
 security/keys/trusted-keys/Makefile       |    2 -
 security/keys/trusted-keys/tpm2key.asn1   |   11 -
 security/keys/trusted-keys/trusted_tpm2.c |  119 +--
 15 files changed, 1421 insertions(+), 122 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_asymmetric.c
 create mode 100644 crypto/tpm2_key.asn1
 create mode 100644 crypto/tpm2_key.c
 create mode 100644 include/crypto/tpm2_key.h
 delete mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.47.3


