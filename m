Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6143BD61
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Oct 2021 00:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbhJZWq2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Oct 2021 18:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhJZWqY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Oct 2021 18:46:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806F4C061570;
        Tue, 26 Oct 2021 15:44:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv3so581107pjb.3;
        Tue, 26 Oct 2021 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pbwaXXHnvCbbtImOhR1XxTruqxYAB5oj9GgtPi3o/qo=;
        b=pcOQ/l4LI49Ji38qwBDwa7GjQpZZqj2OgmqZFuUC/KFLdqqVPGcCXFoNnomAPoTvWt
         BSfzgXyRnnR5SM0jXalC4QWYoJOOnQhrb1DzQuEC+x8xXGPIHef8aTGBCRLKzPeml0Ok
         LjvOjU5Vg/oxQHkGeH3MUTphLHgVdEQnOS7am8QYacoQIseIrTAMzTU6KgboAxBllIfC
         TfzRVqN+v6li6J4gvhCDvQr4T4p/FSK2USw1syAgw+0XwdhZ8+euUUQYgnWqL5wmScJ3
         DTHk6tKDTsD0fki40O3UkIhi8Fq7OrahdCyub7R/l0TqU0ji8DK+9nY6PhZKJtmU/smu
         docw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pbwaXXHnvCbbtImOhR1XxTruqxYAB5oj9GgtPi3o/qo=;
        b=Kvz/wuw/iu03uggVqyaDkA1RP0ncXcyZttFY9fpeNMOB/3Ycuk2CWvctdK48/bPMhM
         JOSYw/VNj+PGHEhbYSz3CbLeTl+aFV2rxk0Y1WXA+Ys5mODAXwl31UC9ZQVizszA5klk
         CFxN739dpcCa801/L7DwdYUlLKxY25kMxMaFSXtpm7DFl6jhEe4zYUh6fSgg+dXg9hYz
         Zf1C+1DTTKZQ0h+Xdq7/CRgFI4mRPQk8/J6GNBTLgsmUAVwZAQ6dW787Kk/yAnrnC3NH
         YNdaR8yahzJNF378Jkhi5Yo/pCUo8zMi81q+irkfM92US7ry1pg5BfPv2M0mP/DH8Gb+
         tBgQ==
X-Gm-Message-State: AOAM531NODbMWydw4xr6OqGZk934C9r815EHiz7nzGc3oneb3KKdp73y
        6OFwhX36ghxKcZ8lREveyAY=
X-Google-Smtp-Source: ABdhPJzjvqg9bEk1OYk+nLzA4QYhy9hiPbv9hwBvX4gMCUsjynoDl4L9hvLJQ+cYPgZbFRES7ms54Q==
X-Received: by 2002:a17:90a:7e93:: with SMTP id j19mr1824542pjl.172.1635288240053;
        Tue, 26 Oct 2021 15:44:00 -0700 (PDT)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id d17sm11674985pfj.98.2021.10.26.15.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:43:59 -0700 (PDT)
Date:   Tue, 26 Oct 2021 23:43:54 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com
Subject: [PATCH] ima/evm: mark evm_fixmode as __ro_after_init
Message-ID: <20211026224354.GA13009@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

evm_fixmode global variable is never modified
outside initcalls, so declaring it with __ro_after_init is better.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 security/integrity/evm/evm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 1c8435dfabee..08f907382c61 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -78,7 +78,7 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
-static int evm_fixmode;
+static int evm_fixmode __ro_after_init;
 static int __init evm_set_fixmode(char *str)
 {
 	if (strncmp(str, "fix", 3) == 0)
-- 
2.20.1

