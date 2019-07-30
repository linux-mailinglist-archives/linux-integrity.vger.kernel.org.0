Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D04E7A849
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfG3MZI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 08:25:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33023 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbfG3MZH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 08:25:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id f20so20756775pgj.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jul 2019 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihVno30NiTJ4nXlPwk0p1JArXGGwnpn9XYnN+QyiMz4=;
        b=qbiyr6oe9qmKjEI/E2pv/fDSjK/fIiWbv00GPWqkaY7IeiYE3b93IixfbKgrbfOki4
         TKD9IEJlrA1TANkylWk2FpXKR6F1NYac7MjvuQH0ePRjZXsDj5u1NMDXKTKJ8apiLru+
         H1UmLUZhxay6j2lrbQeVp1PPfhxGTe4BYfbu07PKWrQJyOCerjM4U6lHiVMBOixJhlKz
         mZtYAZwHgvnITkIA3MnfqHcC0lDX2Fb3uW9K3OsNn5mt7dlLXuCpoHG9etCaZ+IWoc92
         RQtiGHprKKQqEFEkbz4b2fCaojhnl4idmkaR7k+HPZ3TMHUTAX0MuFD8tqHBqJ3HvCv+
         e4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ihVno30NiTJ4nXlPwk0p1JArXGGwnpn9XYnN+QyiMz4=;
        b=fcgXiRw9OqnDEa8g6qjThXtwhPSnD2lxRn/niO4DrlDZL7u8kP7wKBehKwrIdmAVpg
         NK2xHNYpSW+yC72vRbLPmmhMYoZ93Nzzy4yTgYMtlZ/LAQDVVd4QWvfW7jM2/nT3iUYG
         4xXR1NIkMOza7ZTbEcpS0uzwFfhcfQcQU/e/lVmpNsBKEgWgH4H1m3MFO5coPiv96Lmz
         Hl/zib95X4QrEo7TE2vI6HO7RiX5uZ/nFWGFsNG8JRvjPZZHIL+FII7TGkxvN5ZhRqB/
         yzMLuUyvlI3M/TDoGf0VsC/9bKgcQROeceNQ49fV5htsUqn2Mweh1L+ZEx1mlHj+sROD
         z/TQ==
X-Gm-Message-State: APjAAAXpnQykwS1/jXoy0eyYl40l0mGS+mBtIKJHxWfhjil75j1re8CN
        Rn9x0MOnFLJhl4giuPrEZ8vNfg==
X-Google-Smtp-Source: APXvYqzBpML/+RG6mX83dkrKgyogoRedECvKNQJNISkarkVtJCD+BTonb8A1Odg1bhwhsgBxg6rmqw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr43312932pfc.110.1564489506754;
        Tue, 30 Jul 2019 05:25:06 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id v8sm54895462pgs.82.2019.07.30.05.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 05:25:06 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC v2 5/6] doc: keys: Document usage of TEE based Trusted Keys
Date:   Tue, 30 Jul 2019 17:53:39 +0530
Message-Id: <1564489420-677-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
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

