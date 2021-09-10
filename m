Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D282D407173
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Sep 2021 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhIJSsX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Sep 2021 14:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232588AbhIJSsX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Sep 2021 14:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631299631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xH44Vj3XSpHNLJ/QZFW/QEb60H8/3gHT0EEL3+mmQ7Q=;
        b=AO1Mfm44CRSw9MEFg9k80GD2sMpZdd9wQU69P8RRcsq7OvJJ52ZvYf5vOUa16i1dJRPxJK
        G1VVzdazkm4s45ZgCtl1x3XbFO4VuSonmjcx8jXsbIEUSfaV3Z86UGP0zomOPbIPOMWjP/
        8B9k3o3zccFLUBKKm9WsngAzbgJsaFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-_opLIiV6OlGabvcB9kTyyw-1; Fri, 10 Sep 2021 14:47:10 -0400
X-MC-Unique: _opLIiV6OlGabvcB9kTyyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ED6F1084681;
        Fri, 10 Sep 2021 18:47:09 +0000 (UTC)
Received: from localhost (unknown [10.22.33.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEF5460C0F;
        Fri, 10 Sep 2021 18:47:04 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v7 ima-evm-utils 0/2] make default hash algorithm dynamic
Date:   Fri, 10 Sep 2021 15:46:59 -0300
Message-Id: <20210910184701.386163-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In order to allow users to set their own security policies, this patch
adds an option in configuration time to set the default hash algorithm to be
used. Considering that any hash algorithm supported by the kernel can be
used, the chosen algo is then checked against the hash_info.h header file.

At the same time, move from SHA1 to SHA256 default hash algorithm, following
the general movement of dropping SHA1 support in the major distros due to
its weaknesses.

Changelog:
v6 - make user input lower case regardless and rebase code
v5 - remove case insensitive grep
v4 - check against hash_info.h kernel header instead of /proc/crypto
v3 - remove wrong comment from m4 script
v2 - add a config time option for setting DEFAULT_HASH_ALGO.

Bruno Meneguele (2):
  set default hash algorithm in configuration time
  make SHA-256 the default hash algorithm

 README                  |  2 +-
 configure.ac            |  2 ++
 m4/default-hash-algo.m4 | 36 ++++++++++++++++++++++++++++++++++++
 src/evmctl.c            |  4 ++--
 src/imaevm.h            |  4 ++++
 src/libimaevm.c         |  2 +-
 6 files changed, 46 insertions(+), 4 deletions(-)
 create mode 100644 m4/default-hash-algo.m4

-- 
2.31.1

