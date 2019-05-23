Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270A627CCC
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2019 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfEWM02 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 May 2019 08:26:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33882 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWM01 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 May 2019 08:26:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so6084191wrt.1
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7FMozhU3KB35sxTSvoCaF3hObciT+FdVvy5GXZ8JmCI=;
        b=ccNF1pKpzFNZ/HriA0fx/d1RYlkZiU15YjhjNtWX5PxXufqrK78JTQlG5uLZOnNSML
         BIabg1JCT9sQQ0z0RZTgcwhFDC9cNK7Ln6k6UqhSgekzR9PhU+O8bBFQTym4Pu6eUN5A
         yOdDILC7xUh0tHI7g2J4AsNfrHgaxcG7vLcsRtoi0Wh7MXGadPiXa1HKf8ZVINAQ09f9
         tLXRdGuWBI1A/KQw9avpBebEYvakYMliAMlY1slCexddHdD8ju4orgH2LZCKTr1+oKzw
         R7gcyDTvJ25ZCR/CZh/EC8dLty0qCES8BPfVQI6F3cB5Yk2tHs24hVBNmVK1vWxkV8bs
         J6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FMozhU3KB35sxTSvoCaF3hObciT+FdVvy5GXZ8JmCI=;
        b=aM6A79i6JsHxkSpE1AhaGvcwScXjCXZ7tZeksjJtdhTxOFLkshixtehiJwFd3SZy4G
         dlwXkhaOqaASLCnBl+0GVcSgByEi9Ywc9RkQ+5WtR1WKTRGKE+3sM7ago0yCLw4P09fP
         9UAn+kpvcE+oeSz1+Wmyy5C/O7FHkS9ydtjM2RQMTUcZSjVyqv2wG9W+psuL/xV/J7rg
         U5Labz6vcsGqCFbyN3q8wAOXOgLco5J2VVWvHtBcEqkMUearQgXB3bL4LVi/1PHdU+Rq
         wieyJIgEbx+YuQXu5a83CWHt2DYjB7/rp0vCB5bGc9u7XkcEguxRSwZX7ig0Wx9JQiNN
         9cFQ==
X-Gm-Message-State: APjAAAX1y0FDSufP4Y+iut12KzipMJOblDVUQ3shQYdR4GCezp7HqeOh
        BT+7OS/+iJ1KNZuJCqjIZLcLlqjv
X-Google-Smtp-Source: APXvYqw9wDABUWseTzly1GUf5/8drt1ck5HNHmWt1P7Yspf55L6c27FKuebyhUl7uJ/4Y37Uj7WSBg==
X-Received: by 2002:adf:f788:: with SMTP id q8mr60285130wrp.181.1558614386065;
        Thu, 23 May 2019 05:26:26 -0700 (PDT)
Received: from lothlann.rup.mentorg.com (nat-min.mentorg.com. [139.181.32.34])
        by smtp.gmail.com with ESMTPSA id x187sm11101360wmg.11.2019.05.23.05.26.25
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:26:25 -0700 (PDT)
From:   Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To:     linux-integrity@vger.kernel.org
Subject: [PATCH 2/4] ima-evm-utils: replace INCLUDES with AM_CPPFLAGS
Date:   Thu, 23 May 2019 15:26:21 +0300
Message-Id: <20190523122623.25684-2-dbaryshkov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523122623.25684-1-dbaryshkov@gmail.com>
References: <20190523122623.25684-1-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replace INCLUDES variable with AM_CPPFLAGS to stop Automake from warning
about deprecated variable usage.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 src/Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index b81281a31d9b..164e7e4af020 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1,7 +1,7 @@
 lib_LTLIBRARIES = libimaevm.la
 
 libimaevm_la_SOURCES = libimaevm.c
-libimaevm_la_CPPFLAGS = $(LIBCRYPTO_CFLAGS)
+libimaevm_la_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 # current[:revision[:age]]
 # result: [current-age].age.revision
 libimaevm_la_LDFLAGS = -version-info 0:0:0
@@ -17,11 +17,11 @@ hash_info.h: Makefile
 bin_PROGRAMS = evmctl
 
 evmctl_SOURCES = evmctl.c
-evmctl_CPPFLAGS = $(LIBCRYPTO_CFLAGS)
+evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 evmctl_LDFLAGS = $(LDFLAGS_READLINE)
 evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
 
-INCLUDES = -I$(top_srcdir) -include config.h
+AM_CPPFLAGS = -I$(top_srcdir) -include config.h
 
 CLEANFILES = hash_info.h
 DISTCLEANFILES = @DISTCLEANFILES@
-- 
2.20.1

