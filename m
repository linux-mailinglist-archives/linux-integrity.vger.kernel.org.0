Return-Path: <linux-integrity+bounces-3337-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A7F955D8D
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 18:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67F91C20A59
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32B148823;
	Sun, 18 Aug 2024 16:59:46 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B581AD2;
	Sun, 18 Aug 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000386; cv=none; b=AeCafPTSJvV7klRcOG+pdzfCBsLcu+KSnwJqYwSTRA8A6iYU97E9lOhwfuZQOj0OQAT6/jIPpu/hLTvEesxnsC6pg8MwAacRx1qwm3arvAlLy1iucHVwpHhGonjYu96k1YdGysr8hkMjKqfw23RhdpbDuIuPx8L489fn0KJT5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000386; c=relaxed/simple;
	bh=hsTauafTm2FR41Tdc9ImN807VXws3wFETzem63wTHrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j38h+vNkTK/C5KEULp8pS9HZLwh5gZHy8RiKNLsnouH1bvPis3VPnVhkM+fdbCx83Qxzz59BYn4dE3pUS7QwYw3G2fuT5/XSNTp3pMYrNfG2kuqmG4AGlR/Zj2N5gMnKtgOZHWR5Vst11n6UNdZfGlSZVDyhMLXcsvuTV4Cky4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wn1gQ1BQFz9v7Hm;
	Mon, 19 Aug 2024 00:40:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 578ED1401F1;
	Mon, 19 Aug 2024 00:59:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXm4VpKMJm+zZxAQ--.21009S2;
	Sun, 18 Aug 2024 17:59:33 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
Date: Sun, 18 Aug 2024 18:57:42 +0200
Message-Id: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXm4VpKMJm+zZxAQ--.21009S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW7ArW5Zw4fGFW7uFWDtwb_yoWxuF1xpF
	4Fkr90yFyDJrn2kayfJw17uw4rAFs5Aw43Gwnaqw15A3sIqF10ya92kF13uF9xGr18XrWF
	qrWYqw1UCw1Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB5wABs1

From: Roberto Sassu <roberto.sassu@huawei.com>

Support for PGP keys and signatures was proposed by David long time ago,
before the decision of using PKCS#7 for kernel modules signatures
verification was made. After that, there has been not enough interest to
support PGP too.

Lately, when discussing a proposal of introducing fsverity signatures in
Fedora [1], developers expressed their preference on not having a separate
key for signing, which would complicate the management of the distribution.
They would be more in favor of using the same PGP key, currently used for
signing RPM headers, also for file-based signatures (not only fsverity, but
also IMA ones).

Another envisioned use case would be to add the ability to appraise RPM
headers with their existing PGP signature, so that they can be used as an
authenticated source of reference values for appraising remaining
files [2].

To make these use cases possible, introduce support for PGP keys and
signatures in the kernel, and load provided PGP keys in the built-in
keyring, so that PGP signatures of RPM headers, fsverity digests, and IMA
digests can be verified from this trust anchor.

In addition to the original version of the patch set, also introduce
support for signature verification of PGP keys, so that those keys can be
added to keyrings with a signature-based restriction (e.g. .ima). PGP keys
are searched with partial IDs, provided with signature subtype 16 (Issuer).
Search with full IDs could be supported with
draft-ietf-openpgp-rfc4880bis-10, by retrieving the information from
signature subtype 33 (Issuer Fingerprint). Due to the possibility of ID
collisions, the key_or_keyring restriction is not supported.

The patch set includes two preliminary patches: patch 1 introduces
mpi_key_length(), to get the number of bits and bytes of an MPI; patch 2
introduces rsa_parse_priv_key_raw() and rsa_parse_pub_key_raw(), to parse
an RSA key in RAW format if the ASN.1 parser returns an error.

Patches 3-5 introduce the library necessary to parse PGP keys and
signatures, whose support is added with patches 6-10. Patch 11 introduces
verify_pgp_signature() to be used by kernel subsystems (e.g. fsverity and
IMA). Patch 12 is for testing of PGP signatures. Finally, patches 13-14
allow loading a set of PGP keys from a supplied blob at boot time.

Changelog

v1 [4]:
- Remove quiet_cmd_extract_certs (redundant, likely leftover from
  conflict resolution)
- Load PGP keys embedded in the kernel image within load_module_cert()
  and load_system_certificate_list(), instead of using a separate initcall
- Style bug fixes found by checkpatch.pl
- Add <crypto/pgp.h> include in crypto/asymmetric_keys/pgp_preload.c, to
  remove no previous prototype warning
- Correctly check returned tfm in pgp_generate_fingerprint()
- Fix printing message in pgp_generate_fingerprint()
- Don't create a public key if the key blob does not contain a PGP key
  packet
- Remove unused pgp_pubkey_hash array
- Set KEY_EFLAG_DIGITALSIG key flag if the key has the capability
- Allow PGP_SIG_GENERAL_CERT_OF_UID_PUBKEY signature type (for key sigs)
- Add is_key_sig parameter to pgp_sig_get_sig() to ensure the key
  signature type is PGP_SIG_GENERAL_CERT_OF_UID_PUBKEY or
  PGP_SIG_POSTITIVE_CERT_OF_UID_PUBKEY

v0 [3]:
- style fixes
- move include/linux/pgp.h and pgplib.h to crypto/asymmetric_keys
- introduce verify_pgp_signature()
- replace KEY_ALLOC_TRUSTED flag with KEY_ALLOC_BUILT_IN
- don't fetch PGP subkeys
- drop support for DSA
- store number of MPIs in pgp_key_algo_p_num_mpi array
- replace dynamic memory allocations with static ones in
  pgp_generate_fingerprint()
- store only keys with capability of verifying signatures
- remember selection of PGP signature packet and don't repeat parsing
- move search of the PGP key to verify the signature from the beginning
  to the end of the verification process (to be similar with PKCS#7)
- don't retry key search in the session keyring from the signature
  verification code, let the caller pass the desired keyring
- for the PGP signature test key type, retry the key search in the session
  keyring
- retry key search in restrict_link_by_signature() with a partial ID
  (provided in the PGP signature)

[1] https://fedoraproject.org/wiki/Changes/FsVerityRPM
[2] https://lore.kernel.org/linux-integrity/20240415142436.2545003-1-roberto.sassu@huaweicloud.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-modsign.git/log/?h=pgp-parser
[4] https://lore.kernel.org/linux-integrity/20220111180318.591029-1-roberto.sassu@huawei.com/

David Howells (8):
  PGPLIB: PGP definitions (RFC 4880)
  PGPLIB: Basic packet parser
  PGPLIB: Signature parser
  KEYS: PGP data parser
  KEYS: Provide PGP key description autogeneration
  KEYS: PGP-based public key signature verification
  PGP: Provide a key type for testing PGP signatures
  KEYS: Provide a function to load keys from a PGP keyring blob

Roberto Sassu (6):
  mpi: Introduce mpi_key_length()
  rsa: add parser of raw format
  KEYS: Retry asym key search with partial ID in
    restrict_link_by_signature()
  KEYS: Calculate key digest and get signature of the key
  verification: introduce verify_pgp_signature()
  KEYS: Introduce load_pgp_public_keyring()

 MAINTAINERS                             |   1 +
 certs/Kconfig                           |  11 +
 certs/Makefile                          |   7 +
 certs/system_certificates.S             |  18 +
 certs/system_keyring.c                  |  93 ++++
 crypto/asymmetric_keys/Kconfig          |  38 ++
 crypto/asymmetric_keys/Makefile         |  13 +
 crypto/asymmetric_keys/pgp.h            | 206 ++++++++
 crypto/asymmetric_keys/pgp_library.c    | 620 ++++++++++++++++++++++++
 crypto/asymmetric_keys/pgp_parser.h     |  18 +
 crypto/asymmetric_keys/pgp_preload.c    | 111 +++++
 crypto/asymmetric_keys/pgp_public_key.c | 492 +++++++++++++++++++
 crypto/asymmetric_keys/pgp_signature.c  | 505 +++++++++++++++++++
 crypto/asymmetric_keys/pgp_test_key.c   | 129 +++++
 crypto/asymmetric_keys/pgplib.h         |  74 +++
 crypto/asymmetric_keys/restrict.c       |  10 +-
 crypto/rsa.c                            |  14 +-
 crypto/rsa_helper.c                     |  69 +++
 include/crypto/internal/rsa.h           |   6 +
 include/crypto/pgp.h                    |  36 ++
 include/linux/mpi.h                     |   2 +
 include/linux/verification.h            |  23 +
 lib/crypto/mpi/mpicoder.c               |  33 +-
 23 files changed, 2516 insertions(+), 13 deletions(-)
 create mode 100644 crypto/asymmetric_keys/pgp.h
 create mode 100644 crypto/asymmetric_keys/pgp_library.c
 create mode 100644 crypto/asymmetric_keys/pgp_parser.h
 create mode 100644 crypto/asymmetric_keys/pgp_preload.c
 create mode 100644 crypto/asymmetric_keys/pgp_public_key.c
 create mode 100644 crypto/asymmetric_keys/pgp_signature.c
 create mode 100644 crypto/asymmetric_keys/pgp_test_key.c
 create mode 100644 crypto/asymmetric_keys/pgplib.h
 create mode 100644 include/crypto/pgp.h

-- 
2.34.1


