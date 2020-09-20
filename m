Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732582715AD
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Sep 2020 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgITQVO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Sep 2020 12:21:14 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50125 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbgITQVO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Sep 2020 12:21:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0U9VT-1s_1600618863;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U9VT-1s_1600618863)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Sep 2020 00:21:04 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephan Mueller <smueller@chronox.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Colin Ian King <colin.king@canonical.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Gilad Ben-Yossef" <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v7 00/10] crpyto: introduce OSCCA certificate and SM2 asymmetric algorithm
Date:   Mon, 21 Sep 2020 00:20:53 +0800
Message-Id: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello all,

This new module implement the OSCCA certificate and SM2 public key
algorithm. It was published by State Encryption Management Bureau, China.
List of specifications for OSCCA certificate and SM2 elliptic curve
public key cryptography:

* GM/T 0003.1-2012
* GM/T 0003.2-2012
* GM/T 0003.3-2012
* GM/T 0003.4-2012
* GM/T 0003.5-2012
* GM/T 0015-2012
* GM/T 0009-2012 

IETF: https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
oscca: http://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml
scctc: http://www.gmbz.org.cn/main/bzlb.html

These patchs add the OID object identifier defined by OSCCA. The
x509 certificate supports sm2-with-sm3 type certificate parsing
and verification.

The sm2 algorithm is based on libgcrypt's mpi implementation, and has
made some additions to the kernel's original mpi library, and added the
implementation of ec to better support elliptic curve-like algorithms.

sm2 has good support in both openssl and gnupg projects, and sm3 and sm4
of the OSCCA algorithm family have also been implemented in the kernel.

Among them, sm3 and sm4 have been well implemented in the kernel.
This group of patches has newly introduced sm2. In order to implement
sm2 more perfectly, I expanded the mpi library and introduced the
ec implementation of the mpi library as the basic algorithm. Compared
to the kernel's crypto/ecc.c, the implementation of mpi/ec.c is more
complete and elegant, sm2 is implemented based on these algorithms.

---
v7 changes:
  1. add sm2 test vectors to testmgr.
  2. fix potential memory leak in testmgr (PATCH 6/10).
  3. rebase on mainline.

v6 changes:
  1. remove mpi_sub_ui function from mpi library.
  2. rebase on mainline.

v5 changes:
  1. fix compilation failure when SM2 is configured as a module.
  2. simplify the mpi and ec code, remove unused functions reported by test robot.

v4 changes:
  1. Pass data directly when calculating sm2 certificate digest.
  2. rebase on mainline.

v3 changes:
  1. integrity asymmetric digsig support sm2-with-sm3 algorithm.
  2. remove unused sm2_set_priv_key().
  3. rebase on mainline.

v2 changes:
  1. simplify the sm2 algorithm and only retain the verify function.
  2. extract the sm2 certificate code into a separate file.


Tianjia Zhang (10):
  crypto: sm3 - export crypto_sm3_final function
  lib/mpi: Extend the MPI library
  lib/mpi: Introduce ec implementation to MPI library
  crypto: sm2 - introduce OSCCA SM2 asymmetric cipher algorithm
  crypto: testmgr - support test with different ciphertext per
    encryption
  crypto: testmgr - Fix potential memory leak in test_akcipher_one()
  crypto: sm2 - add SM2 test vectors to testmgr
  X.509: support OSCCA certificate parse
  X.509: support OSCCA SM2-with-SM3 certificate verification
  integrity: Asymmetric digsig supports SM2-with-SM3 algorithm

 crypto/Kconfig                            |   17 +
 crypto/Makefile                           |    8 +
 crypto/asymmetric_keys/Makefile           |    1 +
 crypto/asymmetric_keys/public_key.c       |    6 +
 crypto/asymmetric_keys/public_key_sm2.c   |   61 +
 crypto/asymmetric_keys/x509_cert_parser.c |   27 +-
 crypto/asymmetric_keys/x509_public_key.c  |    3 +
 crypto/sm2.c                              |  481 +++++++
 crypto/sm2signature.asn1                  |    4 +
 crypto/sm3_generic.c                      |    7 +-
 crypto/testmgr.c                          |   24 +-
 crypto/testmgr.h                          |   59 +
 include/crypto/public_key.h               |   15 +
 include/crypto/sm2.h                      |   25 +
 include/crypto/sm3.h                      |    2 +
 include/linux/mpi.h                       |  192 +++
 include/linux/oid_registry.h              |    6 +
 lib/mpi/Makefile                          |    6 +
 lib/mpi/ec.c                              | 1509 +++++++++++++++++++++
 lib/mpi/mpi-add.c                         |  155 +++
 lib/mpi/mpi-bit.c                         |  251 ++++
 lib/mpi/mpi-cmp.c                         |   46 +-
 lib/mpi/mpi-div.c                         |  238 ++++
 lib/mpi/mpi-internal.h                    |   53 +
 lib/mpi/mpi-inv.c                         |  143 ++
 lib/mpi/mpi-mod.c                         |  155 +++
 lib/mpi/mpi-mul.c                         |   94 ++
 lib/mpi/mpicoder.c                        |  336 +++++
 lib/mpi/mpih-div.c                        |  294 ++++
 lib/mpi/mpih-mul.c                        |   25 +
 lib/mpi/mpiutil.c                         |  204 +++
 security/integrity/digsig_asymmetric.c    |   14 +-
 32 files changed, 4435 insertions(+), 26 deletions(-)
 create mode 100644 crypto/asymmetric_keys/public_key_sm2.c
 create mode 100644 crypto/sm2.c
 create mode 100644 crypto/sm2signature.asn1
 create mode 100644 include/crypto/sm2.h
 create mode 100644 lib/mpi/ec.c
 create mode 100644 lib/mpi/mpi-add.c
 create mode 100644 lib/mpi/mpi-div.c
 create mode 100644 lib/mpi/mpi-inv.c
 create mode 100644 lib/mpi/mpi-mod.c
 create mode 100644 lib/mpi/mpi-mul.c

-- 
2.19.1.3.ge56e4f7

