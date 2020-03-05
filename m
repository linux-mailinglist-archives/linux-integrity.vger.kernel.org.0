Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3F17AFB5
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 21:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCEUa0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 15:30:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43541 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgCEUa0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 15:30:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id v9so2030269wrf.10;
        Thu, 05 Mar 2020 12:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=juYwq62t6R4eHfh+DtghPbycszS3hALzIrDdl9KbM1c=;
        b=JggJGJZ74CId5O5W+ekRHBGRii5hGwwlVujhFs+0LWqATqCFf49ZWMlfjE7Fey199u
         gbHwtr1I22EQ6hiNPyW5wjGztf6TdkwL1eSWjYbf6VfdYFFUU4wtaGKp/mX4X0hSuW/z
         uH6UEnVsYpAtMZDoHL2NJVypq3/KYW2OlTifk5/woCgCWvo41+V6qeC6VV8RcsiXRaGm
         EL4H9y5t2NRseP/T/dFdb3U+bQuD13EQtYu8G+an8LOvWem1Pwtx/3ms0q86TaSQ8w/n
         QVdkdabYX71ROFgWS9afD4L4UxIFQlCbjmM8+FrA1XvVkO81g3AvkMeKC5jah7Ja/e1k
         ogIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=juYwq62t6R4eHfh+DtghPbycszS3hALzIrDdl9KbM1c=;
        b=h5Yay2XQ5bflVGjiqkIBbPbSmefIz/32hUUPnCd3LDD/0BpZzEmKW8bHnAyN051J9E
         fVtnRzTcLv1U0vd1Zz2zlyFR9l2k9u3HWgwWM5FCeRa3c+UMSjvN6Pk4D81EAkNsvJOw
         MsiUqcTut9N9usRbDb1sJCBkOBngjt1gfCsiQb9VrOfmXBWH/60ed7UlQML3Ym7c4xYy
         Pnhh+G0Ojn/49CLPAqoObxpySQY8ykpyu/hbb5smo3RSCHm7yKFR1DMCnYHA42dXNzdm
         7xGiENOxe6I7dtBeqqDJltsYql+RIeXxO2ECNXcAcwmRRis2LI2OlVMdFZJybpjZh+SS
         SbRg==
X-Gm-Message-State: ANhLgQ00mkAiSC1dmJvnr7DnrDWhaTWymvyALF3N1bqYF0VLhzq6ZoJc
        FoO7/VfQhm/CFxZ0BtcwG6c=
X-Google-Smtp-Source: ADFU+vuPdn1HOnk75j4r99XPjPJh1599lKBBZ32CYxv+g/Sq9+FHWjKwmdgjb/JXnVfAnHyEpemCVg==
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr707308wrs.142.1583440224101;
        Thu, 05 Mar 2020 12:30:24 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d7c:7000:ec58:d834:7ed:456a])
        by smtp.gmail.com with ESMTPSA id k66sm8000310wmf.0.2020.03.05.12.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:30:23 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3] MAINTAINERS: adjust to trusted keys subsystem creation
Date:   Thu,  5 Mar 2020 21:30:13 +0100
Message-Id: <20200305203013.6189-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
to trusted-keys/trusted_tpm1.c in security/keys/.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: security/keys/trusted.c
  warning: no file matches F: include/keys/trusted.h

Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
files in security/keys/trusted-keys/ are identified as part of
KEYS-TRUSTED.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Changes to v1:
  - use a global pattern for matching the whole security/keys/trusted-keys/
    directory.
Changes to v2:
  - name the correct directory in the commit message

Sumit, please ack.
Jarkko, please pick this patch v3.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c755e03ddee..7f11ac752b91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9276,8 +9276,8 @@ L:	keyrings@vger.kernel.org
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
-F:	security/keys/trusted.c
-F:	include/keys/trusted.h
+F:	include/keys/trusted_tpm.h
+F:	security/keys/trusted-keys/
 
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
-- 
2.17.1

