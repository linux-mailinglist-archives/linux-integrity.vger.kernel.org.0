Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E8832D9
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2019 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfHFNi3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Aug 2019 09:38:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45151 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfHFNi2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Aug 2019 09:38:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so41524943pfq.12
        for <linux-integrity@vger.kernel.org>; Tue, 06 Aug 2019 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=r40JvNtQzAmBXDCDF67wHN0+Oy3VvJDZYkpPqIGDFuQ=;
        b=KBoVwZ04PhncET1tWdYPpy444Jn3q6H7B+LLVxKtCSaYCPfXuKaJl3qTHomWuNvfJf
         4HhcU4vXAHz2cvXQl1j9itwqkUs69tQ5XtwKdJED34MhYZpdCals14n3uLdK5THxOXkW
         ACLhMWK182v4ZjR+wB0hKCQTYDwj8+tcK1hyNY9kj0e15uSy6Iq9BEc4hxBvbpEZTTzb
         Pk+YFPXEwoCl9xMngBXWhcehIdavfU97xnV7tMjgTUQ+La9B8gq3QWO3SBtMJ13Iu0Za
         bBG6ui8OGzWAV2/5i5NyonudDtwjmo0nbBOUFAz9z+jZ61HbkHFpNA98P1Top/Wpfk+D
         /jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r40JvNtQzAmBXDCDF67wHN0+Oy3VvJDZYkpPqIGDFuQ=;
        b=QmF5+lIuEkhJNP1K6K0naqmK+oDHQvvo5DmkReC7v6aM89PicsHJ4GWGveh/oV4y0i
         C5vjbgj1YarP5dNHDpSxgEJx7lI7u/4FFd9kq8z5ZlRfjYqUZxUaEWz3+NaOINE9x1eK
         oOPJDoNc5QGnAcx6qdBY6ZcXVAWGXF0i3E4m2xFQ2gvqJjE6f7aKzbRwXqmQzv+ugUyA
         TcBYr4RlB76A3WQxyh6JB6n2OXKka34ToydWlpx+DcEAhRKlks4TlgJtACKhTT1RA6oD
         b2nhub3gSs8gnC8Bvvi3g8AHf2oyqBZGgPv3M7sLWZweA1xs/eryYVgZD2VlpFWYXK7R
         FSxg==
X-Gm-Message-State: APjAAAW5LN6MqfEaBJzlxtn3QMzA2i4EogiLWSmRetSmWwXYrvsW3ceo
        UEauVDnk8ZRU0HNYTrQ9ZBL0iQ==
X-Google-Smtp-Source: APXvYqyWbL0AXjQcYJK4QZNvs0rlofxvh7XRtlmtVPyED+Q7AjljHrwHoOUlKxemph5CVKqrVstjIg==
X-Received: by 2002:a63:1b66:: with SMTP id b38mr3145892pgm.54.1565098707997;
        Tue, 06 Aug 2019 06:38:27 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id l4sm89183984pff.50.2019.08.06.06.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 06:38:27 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC/RFT v3 0/3] KEYS: trusted: Add generic trusted keys framework
Date:   Tue,  6 Aug 2019 19:07:17 +0530
Message-Id: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch-set is an outcome of discussion here [1].

I have tested this framework with trusted keys support provided via TEE
but I wasn't able to test it with a TPM device as I don't possess one. It
would be really helpful if others could test this patch-set using a TPM
device.

[1] https://www.mail-archive.com/linux-doc@vger.kernel.org/msg30591.html

Changes in v3:

Move TPM2 trusted keys code to trusted keys subsystem.

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (3):
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: move tpm2 trusted keys code
  KEYS: trusted: Add generic trusted keys framework

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 drivers/char/tpm/tpm-interface.c                   |  56 ---
 drivers/char/tpm/tpm.h                             | 224 ------------
 drivers/char/tpm/tpm2-cmd.c                        | 307 -----------------
 include/keys/trusted-type.h                        |  45 +++
 include/keys/{trusted.h => trusted_tpm.h}          |  42 +--
 include/linux/tpm.h                                | 264 +++++++++++++-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../keys/{trusted.c => trusted-keys/trusted-tpm.c} | 363 ++++----------------
 security/keys/trusted-keys/trusted-tpm2.c          | 378 +++++++++++++++++++++
 security/keys/trusted-keys/trusted.c               | 343 +++++++++++++++++++
 12 files changed, 1109 insertions(+), 925 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (72%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (76%)
 create mode 100644 security/keys/trusted-keys/trusted-tpm2.c
 create mode 100644 security/keys/trusted-keys/trusted.c

-- 
2.7.4

