Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D93F3721
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Aug 2021 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbhHTXAv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 19:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhHTXAu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 19:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629500412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7VnOv6WDzl5ClKEihDvzObOfZ09EwbpA/+Cea++vWS4=;
        b=J3WwoAjkzaU52pQh99PbJJCUVAUfSc+UvxvCV2cP0y2MYplgqmnNCIHZ5hv9gPq9/xZXn6
        EUmxOPl9HkRUvp+EMGwDX1pVVUGHAZx05EQVPb1pSWIFJULvWOhK6bl4U4Ih6mXlNsFgNr
        FaRB4+ob8KeY/FfpTLfCDnJK2LFix4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-VQx9jNUNPPaU0SD8lAkXkw-1; Fri, 20 Aug 2021 19:00:09 -0400
X-MC-Unique: VQx9jNUNPPaU0SD8lAkXkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A78A81853027;
        Fri, 20 Aug 2021 23:00:08 +0000 (UTC)
Received: from localhost (unknown [10.22.33.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D19105D9FC;
        Fri, 20 Aug 2021 23:00:03 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v4 ima-evm-utils 0/2] make default hash algorithm dynamic
Date:   Fri, 20 Aug 2021 19:59:59 -0300
Message-Id: <20210820230001.102249-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In order to allow the distros and users to set their own security policies,
this patch enable a option in configuration time to set the default hash
algorithm to be used. Today, only SHA1 and SHA256 is supported by
ima-evm-utils, but it'll change some day, enabling this dynamic mechanism
facilitates distro maintainers' lives.

At the same time, move from SHA1 to SHA256 default hash algorithm, following
the general movement of dropping SHA1 support in the major distros due to
its weaknesses.

Changelog:
v3: remove wrong comment from m4 script
v2: add a config time option for setting DEFAULT_HASH_ALGO.

Bruno Meneguele (2):
  set default hash algorithm in configuration time
  make SHA-256 the default hash algorithm

 README                  |  2 +-
 configure.ac            |  1 +
 m4/default-hash-algo.m4 | 46 +++++++++++++++++++++++++++++++++++++++++
 src/evmctl.c            |  4 ++--
 src/imaevm.h            |  4 ++++
 src/libimaevm.c         |  2 +-
 6 files changed, 55 insertions(+), 4 deletions(-)
 create mode 100644 m4/default-hash-algo.m4

-- 
2.31.1

