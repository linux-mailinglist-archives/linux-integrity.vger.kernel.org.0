Return-Path: <linux-integrity+bounces-3521-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE2975235
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A171F24394
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAE19CC14;
	Wed, 11 Sep 2024 12:29:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B19199926;
	Wed, 11 Sep 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057791; cv=none; b=Cte6kTJ1JWPYdXefi0J389Qe4M3i0b8gI4wIuRl0h4RAeT4yJyEDrfWmlw9EyFqwJggLCFVX2DEced1Y5sAA39MLn3P1ckV6N8QZsFgviGxuakTqOPLuQ8k5Z1IafxsH6HT0t2EYHkHiUHEr2SJ1D08Y/+38FvxZfNko3axdahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057791; c=relaxed/simple;
	bh=e91/lnm3O35CPOn9e9/8oby0GwpZOiLYJczWkLs47LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KsHkYbdWN6ZiXewY/pl9wfVubXTSRCIL6xNpvWl9HOOyx5YCdNJ/ZuY+31ajS4bsT3U2VcUNpA622LX0Y9SQfoGjzuyMneVPnh3VW+RzZN4oydNWfa1PPwFCYEHFpPAqhyUOQY3+GI9zR5dDFGC5L2CZSy/fdlhcLkJdoVkqupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X3fPm6JyHz9v7Nx;
	Wed, 11 Sep 2024 20:04:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 6790514086A;
	Wed, 11 Sep 2024 20:29:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3pscjjeFmDBG3AA--.60453S2;
	Wed, 11 Sep 2024 13:29:33 +0100 (CET)
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
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
Date: Wed, 11 Sep 2024 14:28:57 +0200
Message-Id: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwD3pscjjeFmDBG3AA--.60453S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWxAw47XF4rZr4kGryrXrb_yoW3Xw18pa
	1FkryYyFy5Jr1IkFWfJw17u3y5Arsayw43Gwn3Jw15AasIqF10ya92kF15ur9xGr10q34F
	qrWYqw1jkw1Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQHzQAAsC

From: Roberto Sassu <roberto.sassu@huawei.com>

Support for PGP keys and signatures was proposed by David long time ago,
before the decision of using PKCS#7 for kernel modules signatures
verification was made. After that, there has been not enough interest to
support PGP too.

Lately, there is renewed interest in supporting PGP keys and signatures for
the following use cases:

- EFI variables in modern Lenovo laptops are in PGP form:
  https://lore.kernel.org/keyrings/2493611.1723748374@warthog.procyon.org.uk/

- Appraisal of RPM package headers for integrity check
  https://lore.kernel.org/linux-integrity/20240905152512.3781098-1-roberto.sassu@huaweicloud.com/


To make these use cases possible, introduce support for PGP keys and
signatures in the kernel, and load provided PGP keys (e.g. Linux
distribution own PGP keys) in the built-in keyring and .ima keyrings.

This feature does not interfere with existing signature verification
mechanisms, such as the one for kernel modules. One has to explicitly call
verify_pgp_signature() to take advantage of it.

For the envisioned use cases, PGP operations cannot be done in user space,
since the consumers are in the kernel itself (Integrity Digest Cache and
IMA). Also they cannot be done in a trusted initial ram disk, since PGP
operations can occur also while the system is running (e.g. after software
package installation).

In addition to the original version of the patch set, also introduce
support for signature verification of PGP keys, so that those keys can be
added to keyrings with a signature-based restriction (e.g. .ima). PGP keys
are searched with partial IDs, provided with signature subtype 16 (Issuer).
However, due to the possibility of ID collisions, the key_or_keyring
restriction is not supported.

The patch set includes two preliminary patches: patch 1 introduces
mpi_key_length(), to get the number of bits and bytes of an MPI; patch 2
introduces rsa_parse_priv_key_raw() and rsa_parse_pub_key_raw(), to parse
an RSA key in RAW format if the ASN.1 parser returns an error.

Patches 3-5 introduce the library necessary to parse PGP keys and
signatures, whose support is added with patches 6-10. Patch 11 introduces
verify_pgp_signature() to be used by kernel subsystems (e.g. IMA). Patch 12
is for testing of PGP signatures. Finally, patches 13-14 allow loading a
set of PGP keys from a supplied blob at boot time.

Changelog

v2 [3]:
- Fix description of verify_pgp_signature()
- Change references from RFC 4880 to RFC 9580 (suggested by Jonathan
  McDowell)
- Remove support for v2 and v3 PGP keys (suggested by Jonathan McDowell)
- Explain better CONFIG_PGP_TEST_KEY
- Add MODULE_DESCRIPTION() for all kernel modules (suggested by Jeff
  Johnson)
- Don't fill capabilities and MPIs for unsupported key algorithms
- Check if there is enough data when parsing PGP key MPIs and RSA RAW keys
- Fix style issues
- Fix debug messages in pgp_request_asymmetric_key()
- Search verification key in the secondary keyring for the pgp_test key
  type

v1 [2]:
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

v0 [1]:
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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-modsign.git/log/?h=pgp-parser
[2] https://lore.kernel.org/linux-integrity/20220111180318.591029-1-roberto.sassu@huawei.com/
[3] https://lore.kernel.org/linux-integrity/20240818165756.629203-1-roberto.sassu@huaweicloud.com/

David Howells (8):
  PGPLIB: PGP definitions (RFC 9580)
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
 certs/system_keyring.c                  |  94 ++++
 crypto/asymmetric_keys/Kconfig          |  39 ++
 crypto/asymmetric_keys/Makefile         |  13 +
 crypto/asymmetric_keys/pgp.h            | 216 +++++++++
 crypto/asymmetric_keys/pgp_library.c    | 610 ++++++++++++++++++++++++
 crypto/asymmetric_keys/pgp_parser.h     |  18 +
 crypto/asymmetric_keys/pgp_preload.c    | 111 +++++
 crypto/asymmetric_keys/pgp_public_key.c | 482 +++++++++++++++++++
 crypto/asymmetric_keys/pgp_signature.c  | 510 ++++++++++++++++++++
 crypto/asymmetric_keys/pgp_test_key.c   | 131 +++++
 crypto/asymmetric_keys/pgplib.h         |  74 +++
 crypto/asymmetric_keys/restrict.c       |  10 +-
 crypto/rsa.c                            |  14 +-
 crypto/rsa_helper.c                     |  83 +++-
 include/crypto/internal/rsa.h           |   6 +
 include/crypto/pgp.h                    |  36 ++
 include/linux/mpi.h                     |   2 +
 include/linux/verification.h            |  23 +
 lib/crypto/mpi/mpicoder.c               |  33 +-
 23 files changed, 2527 insertions(+), 15 deletions(-)
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


