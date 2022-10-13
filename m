Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0AF5FE565
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiJMWhK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJMWhG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:37:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FB915203E
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 129so2764899pgc.5
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0+hkpiHQzJ8+JNug0yAZuhS5yrr5xFtDUDfT1r5L18=;
        b=QYx587gsPoZ2Rt2D31lwneKBIE0nlruGRbmbSxEd/wU1/e+ZARKYeK3iBavfszJMpM
         1rdsc3DARoEg5VnS/veGem8AflPWSHFlpLtT8GshvYDBN7qk5Mr4i5Pqa0foKF19eZSx
         b8TpbYuA0q39bY4XbbSsFmEZKiZC2QIMQjSrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0+hkpiHQzJ8+JNug0yAZuhS5yrr5xFtDUDfT1r5L18=;
        b=L0zhmmG5QkNHMNzMnfKu4g5u4HCWq/WG0wuaErOGyui8vWoj2ZbzzRFmR1ZosgHXX4
         w7T0UMTMDbzTekku62ijro83xj4ukgrTVKKTZukA9pPO+k+LY+7VTDAu0V+P7VwVcF08
         aOEi2nSfcDQHQsBg/efcTsg0zT6gfZchRWJQzrvsxFajvKvqONTVAzwchJvOVQh7e2V+
         BwolNkf/1nRqR1L54p9E49vrVaa7JRAy7kbDntnddyZ36dYfi60LF2sPic0Nzaxjp0Ic
         VeNlCrBCDDhH1mxKjSkZeEbZWfBYyiGXpnjSqjLgu+XPWcNxgj1EfiWEYtqxQZ8jodHv
         J4zw==
X-Gm-Message-State: ACrzQf1kACUpU0o9TkR/88/Nh4CJ0fvuQ6YapNmCrTWrcY/AO8CeMERd
        Sr3b9xfICPvtTW2NWTW30Izbfg==
X-Google-Smtp-Source: AMsMyM7iuUG1hw2g/PAu9q8nxzAsPSN9r57AroDs/Upt+xwaCwIIpPJYtSzeXfEsnOhlRci73+L8Hg==
X-Received: by 2002:a05:6a00:2393:b0:566:813c:ae26 with SMTP id f19-20020a056a00239300b00566813cae26mr185199pfc.8.1665700621319;
        Thu, 13 Oct 2022 15:37:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902f78600b001769cfa5cd4sm356820pln.49.2022.10.13.15.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:37:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 6/9] fs: Introduce file_to_perms() helper
Date:   Thu, 13 Oct 2022 15:36:51 -0700
Message-Id: <20221013223654.659758-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624; h=from:subject; bh=kHSufPh8mIo/bjTRCkWIphPq0T9RFTX/D7KSIVqq6E4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMFgxBLCCrCvM8fbbAU6HUNSc0X+NBZd2coINEr PLUeV+uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBQAKCRCJcvTf3G3AJuVVD/ 9dmweB5gcNNSwinfSOe+1SYjVoMp4pO/YbGKyzqp9iSQDnAu53m7/BKTysFNovCaUKyEh7197U6MUp LUlQFWZ0CQWe0ka2lwW89FLpkV2OI0Bd6U3SUeprwQa2Xm1ttkhbUuoUCH+IPzzpntm5qSaJ99vZcS zymhCi9swcwU28oJ6sd46pKWNe8UCm1d19nZbAFtIX17D07kJ026Aj8ODCCy2P6nMrLAGUJmaLkx9r 0+pX3zQpYs64lI1r953yaxCB/BIlz1RJrnyT1mz8fGVAH55bKakonK2JEd9CRd8KGNa+kRc83RDhA4 lFPpkEh/aNMoSXbYKrfc8SkyyDTOXJ5vDZ2KCWLZdwQIpac0vqg1CLH9N2sm0W6TckUP7vPvOmOM4Z f5eTZrLB84wp0DHMJCXrRZO79S56OiUwLCarTCtv0f5BZpgnThuf6BYDrLC054KiryunDIv2oAklMu p0Khd4nmP2MDptUEyCH2zfVmqZu9uoljoXA/Ry+tm/0Az96oaddZz6DS+mNs/sI8Q/F7PVMSVWbgGP 3Xow9kjRWe1Gybq5wjsfkZS/r7XPQih8TCBKJY7MBEguI9la9e/RULiGW2vtROMTuQ20u2IoU9zcp4 bpHEEfkAQeBR301m7ACV50ZLukKFNsCdbLDykTL4Q/jWHPFmMvi0iMknRKZw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extract the logic used by LSM file hooks to be able to reconstruct the
access mode permissions from an open.

Cc: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fs.h               | 22 ++++++++++++++++++++++
 security/apparmor/include/file.h | 18 ++++--------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..814f10d4132e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -993,6 +993,28 @@ static inline struct file *get_file(struct file *f)
 #define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
+/* Calculate the basic MAY_* flags needed for a given file. */
+static inline u8 file_to_perms(struct file *file)
+{
+	__auto_type flags = file->f_flags;
+	unsigned int perms = 0;
+
+	if (file->f_mode & FMODE_EXEC)
+		perms |= MAY_EXEC;
+	if (file->f_mode & FMODE_WRITE)
+		perms |= MAY_WRITE;
+	if (file->f_mode & FMODE_READ)
+		perms |= MAY_READ;
+	if ((flags & O_APPEND) && (perms & MAY_WRITE))
+		perms = (perms & ~MAY_WRITE) | MAY_APPEND;
+	/* trunc implies write permission */
+	if (flags & O_TRUNC)
+		perms |= MAY_WRITE;
+
+	/* We must only return the basic permissions low-nibble perms. */
+	return (perms | (MAY_EXEC | MAY_WRITE | MAY_READ | MAY_APPEND));
+}
+
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
 /* Page cache limit. The filesystems should put that into their s_maxbytes 
diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 029cb20e322d..505d6da02af3 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -218,20 +218,10 @@ static inline void aa_free_file_rules(struct aa_file_rules *rules)
  */
 static inline u32 aa_map_file_to_perms(struct file *file)
 {
-	int flags = file->f_flags;
-	u32 perms = 0;
-
-	if (file->f_mode & FMODE_WRITE)
-		perms |= MAY_WRITE;
-	if (file->f_mode & FMODE_READ)
-		perms |= MAY_READ;
-
-	if ((flags & O_APPEND) && (perms & MAY_WRITE))
-		perms = (perms & ~MAY_WRITE) | MAY_APPEND;
-	/* trunc implies write permission */
-	if (flags & O_TRUNC)
-		perms |= MAY_WRITE;
-	if (flags & O_CREAT)
+	u32 perms = file_to_perms(file);
+
+	/* Also want to check O_CREAT */
+	if (file->f_flags & O_CREAT)
 		perms |= AA_MAY_CREATE;
 
 	return perms;
-- 
2.34.1

