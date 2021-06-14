Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9753E3A704D
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 22:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhFNU0Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 16:26:24 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:59394 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbhFNU0W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 16:26:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id CD8851817A0D5;
        Mon, 14 Jun 2021 22:16:36 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LQOMc3Q2a1Ft; Mon, 14 Jun 2021 22:16:35 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3Byo3RcpDR1u; Mon, 14 Jun 2021 22:16:34 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     keyrings@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Bottomley <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 0/3] DCP as trusted keys backend
Date:   Mon, 14 Jun 2021 22:16:17 +0200
Message-Id: <20210614201620.30451-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DCP is an IP core found on NXP SoCs such as i.mx6ull.
While its bigger brother, CAAM, can directly wrap and unwrap blobs
in hardware[0], DCP offers only the bare minimum and the blob
mechanism needs aid from software.

This series adds support for a new trusted keys backend that makes use
of DCP's feature to use hardware keys which can never be read out.

[0] https://lore.kernel.org/lkml/cover.56fff82362af6228372ea82e6bd7e586e2=
3f0966.1615914058.git-series.a.fatoum@pengutronix.de/

---
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: David Howells <dhowells@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: keyrings@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Shawn Guo <shawnguo@kernel.org>

David Gstir (1):
  doc: trusted-encrypted: add DCP as new trust source

Richard Weinberger (2):
  crypto: mxs-dcp: Add support for hardware provided keys
  KEYS: trusted: Introduce support for NXP DCP-based trusted keys

 .../admin-guide/kernel-parameters.txt         |   1 +
 .../security/keys/trusted-encrypted.rst       |  84 ++++-
 MAINTAINERS                                   |   9 +
 drivers/crypto/mxs-dcp.c                      | 110 +++++-
 include/keys/trusted_dcp.h                    |  13 +
 include/linux/mxs-dcp.h                       |  19 +
 security/keys/trusted-keys/Makefile           |   1 +
 security/keys/trusted-keys/trusted_core.c     |   6 +-
 security/keys/trusted-keys/trusted_dcp.c      | 325 ++++++++++++++++++
 9 files changed, 554 insertions(+), 14 deletions(-)
 create mode 100644 include/keys/trusted_dcp.h
 create mode 100644 include/linux/mxs-dcp.h
 create mode 100644 security/keys/trusted-keys/trusted_dcp.c

--=20
2.26.2

