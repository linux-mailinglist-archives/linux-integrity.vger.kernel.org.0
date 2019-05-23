Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37E427CCB
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2019 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfEWM02 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 May 2019 08:26:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56236 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWM01 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 May 2019 08:26:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so5610845wmb.5
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QDBhUQFPIEgcu9iIVwCKjdMeqjq7thIBGGuKG4rqOc=;
        b=RhQ5gN64tDn6YaOuwWEbymhLbuvA+D6mV+qojKNVnhs6+M0QInkdkV2dVyzkJcTFWa
         FArGS4tHonQSQ3nO8PT4AE4X+Y9swkMMbdFvuax9eGTGr9DwHA8IsSE9OK3r0g71qGx6
         R0WKC0B/sSHM7AUS8/wgz59FAqhjNtotwkDfUYDaJxnaU7KMZxg68Yvr25I7Qn64qofV
         n9YpqIflXzA7BDt88rzbDpYBcQzm/IpJ6+QPXMevPlM2W4gLdTNlfuDZnkiBaFzTCNSV
         X7l5qrLKKCiXPiAGusUoR4xpBKf/FyBCQQ7+MAVxz1sS63OCLEh3fKry+gOr7wOw92ul
         Vdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QDBhUQFPIEgcu9iIVwCKjdMeqjq7thIBGGuKG4rqOc=;
        b=lrFRf5TRI3eVz/dcRV7pEt0bzjHnCfmD4VLFYu1FNIu0vn6Zuwj44+MSHfIfhZO+K4
         kI9PqeY5FUC43PK3m22NR3vneBdxIegkmSENsHSrMXFtWqE8g9CuVTOWj+aHRaoTR2ij
         LPkQ7zY/c9cyfGx2C1yypkCtGGfnCARh/ZJqMw4qAFWXkJLLJUDt9npWBEI2VkvMlO9w
         1Ye5HsspX8nnqzSWycG3f5bqJP4spUoBC7+iFRj7GJ7tJRs17AyNbYVyaerJMC0Qi33d
         DVaMZgQbrPZccpHPs2sZzhW3CZV9hHqZWj4LSpf76gTrWp7v9J0xRAHd+0CumMOFEZTj
         H5Vw==
X-Gm-Message-State: APjAAAW5BT/Sw4LLzvGJdjK42LG07Sh0eIMK7tUXp9fuWq+hSA6v/bWW
        +4Jn7U/sZAUYZEj61RgLMvX1LXWL
X-Google-Smtp-Source: APXvYqxhRq6u7ZkbSBhGrNqoZr3xl6CfrAJSBJ+sQjjxLyI65NbIvKwAu/QTVxqBkpLP2fF1ubU6Gw==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr10964467wmc.36.1558614385121;
        Thu, 23 May 2019 05:26:25 -0700 (PDT)
Received: from lothlann.rup.mentorg.com (nat-min.mentorg.com. [139.181.32.34])
        by smtp.gmail.com with ESMTPSA id x187sm11101360wmg.11.2019.05.23.05.26.24
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:26:24 -0700 (PDT)
From:   Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To:     linux-integrity@vger.kernel.org
Subject: [PATCH 1/4] ima-evm-utils: link to libcrypto instead of OpenSSL
Date:   Thu, 23 May 2019 15:26:20 +0300
Message-Id: <20190523122623.25684-1-dbaryshkov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is no need to link to full libssl. evmctl uses functions from
libcrypto, so let's link only against that library.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 configure.ac    | 4 +---
 src/Makefile.am | 9 ++++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 10d1d88ccdc7..9beb4b6c2377 100644
--- a/configure.ac
+++ b/configure.ac
@@ -24,9 +24,7 @@ LT_INIT
 # Checks for header files.
 AC_HEADER_STDC
 
-PKG_CHECK_MODULES(OPENSSL, [ openssl >= 0.9.8 ])
-AC_SUBST(OPENSSL_CFLAGS)
-AC_SUBST(OPENSSL_LIBS)
+PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >= 0.9.8 ])
 AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
diff --git a/src/Makefile.am b/src/Makefile.am
index d74fc6f6e190..b81281a31d9b 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1,11 +1,11 @@
 lib_LTLIBRARIES = libimaevm.la
 
 libimaevm_la_SOURCES = libimaevm.c
-libimaevm_la_CPPFLAGS = $(OPENSSL_CFLAGS)
+libimaevm_la_CPPFLAGS = $(LIBCRYPTO_CFLAGS)
 # current[:revision[:age]]
 # result: [current-age].age.revision
 libimaevm_la_LDFLAGS = -version-info 0:0:0
-libimaevm_la_LIBADD =  $(OPENSSL_LIBS)
+libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)
 
 include_HEADERS = imaevm.h
 
@@ -17,12 +17,11 @@ hash_info.h: Makefile
 bin_PROGRAMS = evmctl
 
 evmctl_SOURCES = evmctl.c
-evmctl_CPPFLAGS = $(OPENSSL_CFLAGS)
+evmctl_CPPFLAGS = $(LIBCRYPTO_CFLAGS)
 evmctl_LDFLAGS = $(LDFLAGS_READLINE)
-evmctl_LDADD =  $(OPENSSL_LIBS) -lkeyutils libimaevm.la
+evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
 
 INCLUDES = -I$(top_srcdir) -include config.h
 
 CLEANFILES = hash_info.h
 DISTCLEANFILES = @DISTCLEANFILES@
-
-- 
2.20.1

