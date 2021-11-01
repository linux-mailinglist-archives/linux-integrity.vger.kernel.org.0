Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B897442035
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Nov 2021 19:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhKASn7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Nov 2021 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhKASn5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Nov 2021 14:43:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A5C061767
        for <linux-integrity@vger.kernel.org>; Mon,  1 Nov 2021 11:41:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r12so67686703edt.6
        for <linux-integrity@vger.kernel.org>; Mon, 01 Nov 2021 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK7r+aOUpXiWnfiwAPiSOz1gaCFp1ie4wKIj38RnVS0=;
        b=ruKobEoKgA+9XBxDsgVW1CRTiVWK+aw/bHsUEJ0s52ltCFSRjtIqfAPoS7wGOBxQr2
         IUtSLE+xTgVPnOcNQkt/Afjf+zw9SsXwnk0HQqgnjm+lFqMc2HAzqV4NMVVzFqSZ0CG3
         BXtPJOl0LNHCsG2zYyU5mJqnLTUMjqf55mVBcm/8RzBGawMMHjV84a3LjCF8wbToFYig
         ZixbsMAyzF0XGTu1dzGfWfKJspHNy1e1BgfOs9lXaabZhexAGWali4LkDy45fbhRKFps
         oNvk+j1lQ6ZeZ3UD0vV9og0yfN+WHzuPp2gvKKIw52fhwJ9+3gF9OC4EyOnO6v1+q6cG
         iIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK7r+aOUpXiWnfiwAPiSOz1gaCFp1ie4wKIj38RnVS0=;
        b=amBCVgJ4T0jJNSRxR+FUNWwoe6wjwyXtlhFq0d0YbQHvZZziyCR/jdHHSONriqEEzp
         Usq4yLy5wqlKPZXc75oe7H6zMilEGlcLjV76JaYN203s61ReOq0kOM4mnYHfIfyJQuh7
         IhRIy2jB8I1rLMMIZnGzILcUmVzVrbI13FhXIPNG46U5fP56EvIpex3NEewY88vGS3X6
         7rsVadUiJRByQwrbglofGTsGCliyBwWWX9swHB1vVBEb9YtVKXF4vK/CtjEc3IYH8NpI
         ECWHbXg4azsGqn+ktZJUbmDSVEXyJbWCZ3Ab0MRlEbgGwsrvRDtFlCKWxMS9i1bjEPIs
         zrfA==
X-Gm-Message-State: AOAM533pRBWEH++XVAK4bQQBh5Mht3EM4qzrCxl4/amy9CeqDi1cH/Jg
        BL5Gs5GaRHWPW7ofxSFnT5UApQ==
X-Google-Smtp-Source: ABdhPJw1o58zrRvllzKw3O/CP70fCWa3OK8W/Nc/1ktVmi36JGPjLsBMcoTFRiSdotgSABpmTqs4Uw==
X-Received: by 2002:a05:6402:1242:: with SMTP id l2mr24547785edw.50.1635792081696;
        Mon, 01 Nov 2021 11:41:21 -0700 (PDT)
Received: from localhost ([2a00:e67:5c9:a:2e15:c474:2ef7:bc26])
        by smtp.gmail.com with ESMTPSA id e13sm7175182eje.95.2021.11.01.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:41:20 -0700 (PDT)
From:   andreas@rammhold.de
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andreas Rammhold <andreas@rammhold.de>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] KEYS: trusted: Fix trusted key backends when building as module
Date:   Mon,  1 Nov 2021 19:41:14 +0100
Message-Id: <20211101184115.1468041-1-andreas@rammhold.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Andreas Rammhold <andreas@rammhold.de>

Before this commit the kernel could end up with no trusted key sources
even though both of the currently supported backends (TPM and TEE) were
compiled as modules. This manifested in the trusted key type not being
registered at all.

When checking if a CONFIG_… preprocessor variable is defined we only
test for the builtin (=y) case and not the module (=m) case. By using
the IS_REACHABLE() macro we do test for both cases.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
---

This is a resend becuase of this unfortunate timeline:
  - 2021-05-09: Regression hits mainline with v5.13-rc1
  - 2021-07-16: Issue reported. v1 of this patch sent out
  - 2021-07-21: Ahmad sends out alternative patch to fix issue
  - 2021-07-27: Jarkko (Maintainer) NACKs Ahmad's patch because of scope
  - 2021-07-29: v2 with fixes sent out
  - 2021-07-29: Jarkko gives his Reviewed-by and requests one more v3
  - 2021-07-31: v3 sent out
  - 2021-09-13: Pinged, no feedback
  - 2021-09-27: Pinged, Mimi (Maintainer) comments due to to misunderstanding.
                Question about why this is not merged ignored
  - 2021-10-11: Pinged, no feedback

v3:
* Fixed patch formatting

v2:
* Fixed commit message
* Switched from IS_DEFINED() to IS_REACHABLE()


 security/keys/trusted-keys/trusted_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index d5c891d8d3534..5b35f1b876441 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
 MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
 
 static const struct trusted_key_source trusted_key_sources[] = {
-#if defined(CONFIG_TCG_TPM)
+#if IS_REACHABLE(CONFIG_TCG_TPM)
 	{ "tpm", &trusted_key_tpm_ops },
 #endif
-#if defined(CONFIG_TEE)
+#if IS_REACHABLE(CONFIG_TEE)
 	{ "tee", &trusted_key_tee_ops },
 #endif
 };
-- 
2.33.0

