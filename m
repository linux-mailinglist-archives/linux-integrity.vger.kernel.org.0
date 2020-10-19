Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3255D292CF3
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 19:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgJSRhD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 13:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbgJSRhC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 13:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603129021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lYvd6Kc5MQZgVAzrvYKcsZrecx2ck/hDIb16nUNa8SU=;
        b=bNLT4mlJo3IREWVZAEEpECTkYx6Pg6kHSE/3n1/6LB6cKaSPLgSujJT8zKrE+TdZzKeKuD
        eed6qqpv2aSOlci31ujwWES0Epl1QmuNLPx7BB8nd7hUKB9Zl5IaKkvVe0Mbfb8I/xW4bE
        skzW/ADmpD3fLZAm0ejOafGurJ1sZ9E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-wikFRZlFNZi6M8D7ua7_wA-1; Mon, 19 Oct 2020 13:36:59 -0400
X-MC-Unique: wikFRZlFNZi6M8D7ua7_wA-1
Received: by mail-qv1-f71.google.com with SMTP id m11so376212qvt.11
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 10:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lYvd6Kc5MQZgVAzrvYKcsZrecx2ck/hDIb16nUNa8SU=;
        b=rVg3FUfeAZBMIPwIPtG9UU9Xh0xVTjHyt4ze4XuH322EUOoxKLw+59SoMhi0s0Xg9v
         sFIvncdNugoO8cHxkoJ+2ZIyzFVhEwqxA9uTE5XfBMFngSnolPgPRROZBXeJT7F76gTq
         dZ2Q8fBkqRIWMLF7FVtpXa/qtnLicpEuYwBjLR1D350WbNkrXS5ww3KiD9hHZOvytOWW
         BR4VnGh/T1S2tNvzruU0EQj9sty/l2Xl2TQpvNdzydg0B46pk+KnOkAcdTo3VGmzYLz9
         3Jmrg35lkm8oIg7iCZFOh63X1/StJXCsc/tQBYpYRjw2VgIAqEIj/2ocKZzN2V+ioK/c
         qEgQ==
X-Gm-Message-State: AOAM5329WXbEFw23YNcvque+pBpP4uwlxBrFXxj3621JDo8u3XHcw83L
        0Gayx4b0qIBULcDw/U3CHClSkQveFtbDTDWqA+AV85qK8q1z7skOXIGb3QmFcujma/bQy8sZsGT
        Qkw7qiqarM05tLN9pkSHTS4oaA/ea
X-Received: by 2002:ac8:5389:: with SMTP id x9mr575083qtp.106.1603129019009;
        Mon, 19 Oct 2020 10:36:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3+ziEhGgg3i43z5XMnTEnwSx2vwI9vWybcMni3mq3qdw3hxI6nEAg4xK1Cv/MhfSLFqhHkg==
X-Received: by 2002:ac8:5389:: with SMTP id x9mr575060qtp.106.1603129018778;
        Mon, 19 Oct 2020 10:36:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b8sm271101qkn.133.2020.10.19.10.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:36:58 -0700 (PDT)
From:   trix@redhat.com
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        mortonm@chromium.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] security: remove unneeded break
Date:   Mon, 19 Oct 2020 10:36:53 -0700
Message-Id: <20201019173653.527-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/integrity/ima/ima_appraise.c     | 1 -
 security/keys/trusted-keys/trusted_tpm1.c | 1 -
 security/safesetid/lsm.c                  | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3dd8c2e4314e..f400a6122b3c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -181,7 +181,6 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 		if (sig->version != 2 || xattr_len <= sizeof(*sig))
 			return ima_hash_algo;
 		return sig->hash_algo;
-		break;
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
 		ret = xattr_value->data[0];
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index b9fe02e5f84f..eddc9477d42a 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -901,7 +901,6 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p,
 		break;
 	case Opt_err:
 		return -EINVAL;
-		break;
 	}
 	return ret;
 }
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 8a176b6adbe5..1079c6d54784 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -125,7 +125,6 @@ static int safesetid_security_capable(const struct cred *cred,
 		pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
 			__kuid_val(cred->uid));
 		return -EPERM;
-		break;
 	case CAP_SETGID:
 		/*
 		* If no policy applies to this task, allow the use of CAP_SETGID for
@@ -140,11 +139,9 @@ static int safesetid_security_capable(const struct cred *cred,
 		pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
 			__kuid_val(cred->uid));
 		return -EPERM;
-		break;
 	default:
 		/* Error, the only capabilities were checking for is CAP_SETUID/GID */
 		return 0;
-		break;
 	}
 	return 0;
 }
-- 
2.18.1

