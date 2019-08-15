Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183408F6CE
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2019 00:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfHOWMH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Aug 2019 18:12:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34998 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHOWMH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Aug 2019 18:12:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so3567130wrq.2;
        Thu, 15 Aug 2019 15:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VSiIUxKNFkiB9+c2R7u/EHBxMEOJ5mWiAVsv2Kr2Ss=;
        b=rTGOAv3m5luaq1ehyRbEBi86OwaDKnQJHxNxdriJPiKL8f+I/Xpy3GV8kwLthHOs7d
         BZgsnEkETL4p4sJMg2JziTz9+d8Z9Yku2PzB5233Gs63D192b7JFEVH/lIrUIk98HTRg
         fmDywUwWIDm035RYzUAESEyyeO+SnDiUWR2XPeP990bYnUvlqGzY7qtN0oTzeLDWXstP
         Gn8bdvX/bCxFlP5NNT0gtLQimum0Se7r2xp2paWVcWw8YzjtrSsaijE1ZWpRO+gFii/a
         TppOIF3UGEZphCq1HU9y7UFImyf7LNbUhNgmYvJz6igD78B6zhY3UI6rU/vm24GGhbYa
         nf6A==
X-Gm-Message-State: APjAAAUT+Bv7yGfJe03E35bFLtJTRu4WYH51PN1z+7KTJ3RddioCvsNJ
        dT/xzRgaxGN6E/ya8nd/BlTONcTW
X-Google-Smtp-Source: APXvYqzGC77fYDK9g8cZlzwrtM9BXuO3SFsvZ/94xoIb+aLGXYv3+AJ8L4V7boO03nAosNmMzRnbrw==
X-Received: by 2002:adf:fe08:: with SMTP id n8mr7111830wrr.60.1565907125380;
        Thu, 15 Aug 2019 15:12:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id h97sm10652662wrh.74.2019.08.15.15.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 15:12:04 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        linux-kernel@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [RESEND PATCH] MAINTAINERS: keys: Update path to trusted.h
Date:   Fri, 16 Aug 2019 01:12:00 +0300
Message-Id: <20190815221200.3465-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815215712.tho3fdfk43rs45ej@linux.intel.com>
References: <20190815215712.tho3fdfk43rs45ej@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update MAINTAINERS record to reflect that trusted.h
was moved to a different directory in commit 22447981fc05
("KEYS: Move trusted.h to include/keys [ver #2]").

Cc: Denis Kenzior <denkenz@gmail.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfb344ba2914..168e5121578e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8916,7 +8916,7 @@ S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
-F:	security/keys/trusted.h
+F:	include/keys/trusted.h
 
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
-- 
2.21.0

