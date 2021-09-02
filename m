Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A453FF418
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Sep 2021 21:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbhIBTZh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Sep 2021 15:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347326AbhIBTZg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Sep 2021 15:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630610676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OVdnnpMTxP6vgzXkHfrhBGrwWeSq9CcQGkVFvBnnzwY=;
        b=Ir7TI+QOo4vwF4a/MeDx3ceXNj9e0SkyVry9ObNAyvDbDxVKVOzX6EDDQd4IYXPGJxAR1Z
        ubQBy48FUzOz6jRhOU3Hnu3y6ZTYEf/leE64JHUYILr2K+mC/nHsvgxVXZ00bY7g4N2DSf
        w/jtugGltZ+uZWVCqgTjygJNr6Ck+6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-Cn4HBb1QMQubz0mjbE7Dtw-1; Thu, 02 Sep 2021 15:24:35 -0400
X-MC-Unique: Cn4HBb1QMQubz0mjbE7Dtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20FB9801AE3;
        Thu,  2 Sep 2021 19:24:34 +0000 (UTC)
Received: from localhost (unknown [10.22.8.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A31D727C47;
        Thu,  2 Sep 2021 19:24:29 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v5 ima-evm-utils 0/2] make default hash algorithm dynamic
Date:   Thu,  2 Sep 2021 16:24:25 -0300
Message-Id: <20210902192427.314337-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
v4: check against hash_info.h kernel header instead of /proc/crypto
v3: remove wrong comment from m4 script
v2: add a config time option for setting DEFAULT_HASH_ALGO.

Bruno Meneguele (2):
  set default hash algorithm in configuration time
  make SHA-256 the default hash algorithm

 README                  |  2 +-
 configure.ac            |  2 ++
 m4/default-hash-algo.m4 | 34 ++++++++++++++++++++++++++++++++++
 src/evmctl.c            |  4 ++--
 src/imaevm.h            |  4 ++++
 src/libimaevm.c         |  2 +-
 6 files changed, 44 insertions(+), 4 deletions(-)
 create mode 100644 m4/default-hash-algo.m4

-- 
2.31.1

