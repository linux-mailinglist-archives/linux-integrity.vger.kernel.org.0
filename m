Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3E3149449
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Jan 2020 11:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgAYKBt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Jan 2020 05:01:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36928 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYKBs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Jan 2020 05:01:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so2887415lfc.4
        for <linux-integrity@vger.kernel.org>; Sat, 25 Jan 2020 02:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puiterwijk.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=F0HK6FDi1Dd89nZsuH4rZERNHwmmUP6DhW6002m9wQM=;
        b=RMazaV1dsxNMLQunDuGOHncNxiaku4Ry5VAlv+4AjGM8jYVCMISfQwEF+vE8KMQk5Y
         HS6lNXOg6Ydi8nz0VW2exJqFggdxG48smRJxQ114nc1dSyW/+CpeM01qkAUnAN7928cr
         6ZxX4fDZQOdh6xWJdvgHXUmfacf+wrN/j1vqBWvW46Mrjhmu36FenPhGxIKh0AUXvwNx
         v2ESa/DIsIdVbXAYCuylSfRpx1Fhbud57LONkxpsZ/9AZBlXSErJeVYmoAoPCF1z8fvF
         zlrZVpFXzkDZDX12u7C5/e2CaOrqqvztxRNJzljCyEDYTAtdzYYvJT5mmybruEZiR9wi
         j0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=F0HK6FDi1Dd89nZsuH4rZERNHwmmUP6DhW6002m9wQM=;
        b=POJbDUOwCNRnPEyr3391x0nsXOejFbGw9AX3GvSj/qX9CTAZtyrlNclkiECefPWWeZ
         IToqWH9YwkwsQlqI/7/KtSeOAKbUQJ2+LaC5sWJ4y2zGTdHTZi1MVR55RHuwZAcwLVvr
         F0GbL7xwW7/j/Cuz0i7JNQ/cww1WTQjhoQEiiswCLRVdv0fHUy8ocnSuNa6+KD3llUIl
         ezSBw6cwmxi4vFSwRAZmtItyDRbbspuneX3GpJpmzgtLt9GguyQbX54BM6GDLxw2CyUm
         skrNKYF+ImdnvctIYusz8OvjvH6yogBRwb8Ezpy14IENgsS4t8584LB+a1xSgIwOqYy+
         iu0Q==
X-Gm-Message-State: APjAAAVJ0Yadym1rR0UJ/vRAFeCAts9D/19VYPUDFEtsefNaZSPaBTJ9
        VAqWT4NHCiONW+YU3ugHpawdRnqch1xyvbfUKqwvm20q7mk=
X-Google-Smtp-Source: APXvYqzhK8Q31v3dZwCFm167XKvDL83CMo8NtJz2MExlXum46xGPrNvnGcRFICHIf1hQusxiGG0HWOfaJ7WyQb3y/hs=
X-Received: by 2002:ac2:5e72:: with SMTP id a18mr3485973lfr.9.1579946507195;
 Sat, 25 Jan 2020 02:01:47 -0800 (PST)
Received: from 1055973899907 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jan 2020 02:01:46 -0800
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Date:   Sat, 25 Jan 2020 02:01:46 -0800
Message-ID: <CAJweMdZ62LkuRzA1BCupFJvDMEGsKJD4BSMmGJ0E85vWuPsPng@mail.gmail.com>
Subject: [PATCH] Fix file2bin fread return value checking
To:     linux-integrity@vger.kernel.org
Cc:     Patrick Uiterwijk <patrick@puiterwijk.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The fread(3) function only returns the number of bytes read if size=1.
Instead, this function is used with the file length as size, and nmemb=1,
in which case it returns the number of elements read, not their length.
So it will return "1" if at least size bytes were read, so we should be
expecting that.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index b02be8b..5a5afc5 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -205,7 +205,7 @@ static unsigned char *file2bin(const char *file,
const char *ext, int *size)
 		fclose(fp);
 		return NULL;
 	}
-	if (fread(data, len, 1, fp) != len) {
+	if (fread(data, len, 1, fp) != 1) {
 		log_err("Failed to fread %zu bytes: %s\n", len, name);
 		fclose(fp);
 		free(data);
-- 
2.24.1
