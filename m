Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18550EB1ED
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 15:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfJaOAY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 10:00:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33107 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfJaOAY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 10:00:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id u23so4135369pgo.0
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihVno30NiTJ4nXlPwk0p1JArXGGwnpn9XYnN+QyiMz4=;
        b=pjyU78O3YD26ZTvmDq7xDFKMfe99rm566ijOjFmjEwdUYnQCPRdeZh7dv5cb6Oos8F
         QSMyWgVfo7mHozTV03x0jbZZRFQ4MxkzyoxnQSASeZLcT+BBWjFafJWIhxAR71eLjsbI
         skUqbhe3vLZYr0aQyxC4mSDwJLduVYXX6TAuOGWX4zjay4Dl7oI5v5QoC3NjmlUnQOwh
         zDwnvUGNk71ke/htRBQMgau7Skx9H0uP2dPYY9vy5Z5pD430uSHA/dcr9RabkYUHiZvB
         8cHTdQFXB8svq3viRjwodMFg1PV4zVPLrOzJjHsmldInuV4PcY2HEPSGNgy8RvfBO/tW
         bKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ihVno30NiTJ4nXlPwk0p1JArXGGwnpn9XYnN+QyiMz4=;
        b=Jnr41GAFeFmLs9nRZyfKQT5Arw/ajdzMRovwPkOKEuslG3q05CrlqaEN6IvCAZzi5A
         oF64wyq0FtNavk1IceHlLJfPVukiWoM0ANspzoFFAOcHJr4X5OhRaLesrJY4r14S7uOW
         0NuIadkebG4nHtUHkZlRJWJMzgknUUIIJAmMZ/O4SCaG9ENHVCJiVeIBxR8NJRODixum
         Fbdb4iLODPzeEyKvEEk/ah8Hujd9M7EcwbAVktdWiGgD+S/vMLyIXQIoc8wpxFQYobqR
         OFa5dcHh7MweWG9V5gZBEqDIOUZnihUeo+x8dMLZpw90LBF2T5qmwm9fLv854Er186tH
         srBg==
X-Gm-Message-State: APjAAAUeN/6e//lwdLq/UOO2nBDPQTFppC/v2jO959SkWaH0iBcpE7pM
        /N8+CjitKOZvfzaTxfMaN13PFQ==
X-Google-Smtp-Source: APXvYqz8MkbuV1hRddfSZ/QAk8v+XST0VkzaBOaZtV3PDcEQqkrpHQNhHr7g24puFk5SVUbTJ1tdbA==
X-Received: by 2002:a17:90a:fa02:: with SMTP id cm2mr7821867pjb.129.1572530422954;
        Thu, 31 Oct 2019 07:00:22 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.143])
        by smtp.gmail.com with ESMTPSA id i16sm3522441pfa.184.2019.10.31.07.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 07:00:22 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com
Cc:     corbet@lwn.net, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        stuart.yoder@arm.com, janne.karhunen@gmail.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted Keys
Date:   Thu, 31 Oct 2019 19:28:42 +0530
Message-Id: <1572530323-14802-7-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Provide documentation for usage of TEE based Trusted Keys via existing
user-space "keyctl" utility. Also, document various use-cases.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/security/keys/index.rst       |  1 +
 Documentation/security/keys/tee-trusted.rst | 93 +++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/security/keys/tee-trusted.rst

diff --git a/Documentation/security/keys/index.rst b/Documentation/security/keys/index.rst
index 647d58f..f9ef557 100644
--- a/Documentation/security/keys/index.rst
+++ b/Documentation/security/keys/index.rst
@@ -9,3 +9,4 @@ Kernel Keys
    ecryptfs
    request-key
    trusted-encrypted
+   tee-trusted
diff --git a/Documentation/security/keys/tee-trusted.rst b/Documentation/security/keys/tee-trusted.rst
new file mode 100644
index 0000000..ef03745
--- /dev/null
+++ b/Documentation/security/keys/tee-trusted.rst
@@ -0,0 +1,93 @@
+======================
+TEE based Trusted Keys
+======================
+
+TEE based Trusted Keys provides an alternative approach for providing Trusted
+Keys in case TPM chip isn't present.
+
+Trusted Keys use a TEE service/device both to generate and to seal the keys.
+Keys are sealed under a hardware unique key in the TEE, and only unsealed by
+the TEE.
+
+For more information about TEE, refer to ``Documentation/tee.txt``.
+
+Usage::
+
+    keyctl add trusted name "new keylen" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+"keyctl print" returns an ascii hex copy of the sealed key, which is in format
+specific to TEE device implementation.  The key length for new keys are always
+in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
+Examples of trusted key and its usage as 'master' key for encrypted key usage:
+
+More details about encrypted keys can be found here:
+``Documentation/security/keys/trusted-encrypted.rst``
+
+Create and save a trusted key named "kmk" of length 32 bytes::
+
+    $ keyctl add trusted kmk "new 32" @u
+    754414669
+
+    $ keyctl show
+    Session Keyring
+     827385718 --alswrv      0 65534  keyring: _uid_ses.0
+     274124851 --alswrv      0 65534   \_ keyring: _uid.0
+     754414669 --als-rv      0     0       \_ trusted: kmk
+
+    $ keyctl print 754414669
+    15676790697861b422175596ae001c2f505cea2c6f3ebbc5fb08eeb1f343a07e
+
+    $ keyctl pipe 754414669 > kmk.blob
+
+Load a trusted key from the saved blob::
+
+    $ keyctl add trusted kmk "load `cat kmk.blob`" @u
+    491638700
+
+    $ keyctl print 491638700
+    15676790697861b422175596ae001c2f505cea2c6f3ebbc5fb08eeb1f343a07e
+
+The initial consumer of trusted keys is EVM, which at boot time needs a high
+quality symmetric key for HMAC protection of file metadata.  The use of a
+TEE based trusted key provides security that the EVM key has not been
+compromised by a user level problem and tied to particular hardware.
+
+Create and save an encrypted key "evm" using the above trusted key "kmk":
+
+option 1: omitting 'format'::
+
+    $ keyctl add encrypted evm "new trusted:kmk 32" @u
+    608915065
+
+option 2: explicitly defining 'format' as 'default'::
+
+    $ keyctl add encrypted evm "new default trusted:kmk 32" @u
+    608915065
+
+    $ keyctl print 608915065
+    default trusted:kmk 32 f380ac588a925f488d5be007cf23e4c900b8b652ab62241c8
+    ed54906189b6659d139d619d4b51752a2645537b11fd44673f13154a65b3f595d5fb2131
+    2fe45529ea0407c644ea4026f2a1a75661f2c9b66
+
+    $ keyctl pipe 608915065 > evm.blob
+
+Load an encrypted key "evm" from saved blob::
+
+    $ keyctl add encrypted evm "load `cat evm.blob`" @u
+    831684262
+
+    $ keyctl print 831684262
+    default trusted:kmk 32 f380ac588a925f488d5be007cf23e4c900b8b652ab62241c8
+    ed54906189b6659d139d619d4b51752a2645537b11fd44673f13154a65b3f595d5fb2131
+    2fe45529ea0407c644ea4026f2a1a75661f2c9b66
+
+Other uses for trusted and encrypted keys, such as for disk and file encryption
+are anticipated.  In particular the 'ecryptfs' encrypted keys format can be used
+to mount an eCryptfs filesystem.  More details about the usage can be found in
+the file ``Documentation/security/keys/ecryptfs.rst``.
+
+Another format 'enc32' can be used to support encrypted keys with payload size
+of 32 bytes.
-- 
2.7.4

