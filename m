Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77C07CD6E
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2019 22:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfGaUAF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Jul 2019 16:00:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41492 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfGaUAE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jul 2019 16:00:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so43474357lfa.8
        for <linux-integrity@vger.kernel.org>; Wed, 31 Jul 2019 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4ggN8b85WhY772Tz8icRVEi9H8Z27pRL3Cjopocbk0=;
        b=jEr+R5HUy1qRZmHKRPgWo9BIg6ueMFh8uI4rq29CjuGMGHn30YjYC5d/5TBlUdPMN7
         fIgY/6KFCcFChtjspSWDA6PN4QUvxYncN93h40sUw4fZfzrWsVusSEBIoO03hsUc6nNO
         VOQwf2egxcsuaGN6VNxlI8NIceJn1ZCVVcGnLaCaC8W2kiZlGCh0I5NVipKn+b/QHvXF
         myfpn9APsPCyCvNib1Skf/9uCowwuMdqgu/N6PPRyB9PIbecUdgfCdiYri5xi6Pk9fVz
         DSK7t+tWBezedZhHXGjLyQWnnT0w1SKg1Dr4dJQnNa2x+eeLRDC24E0udFBtxdZ+INDy
         FAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4ggN8b85WhY772Tz8icRVEi9H8Z27pRL3Cjopocbk0=;
        b=X0PivIgnbCs5koVl1jSoHz2nJCF8Sl6XbnASauBau4dc9VfCyIxddc1UxR6SM76l1T
         bmY2qH6caxr+gXkbtQEsFEpJP0NnCE6PSHWq1gN4ZV8rLBq/GKqOCQNDvuJv03VBTPrL
         1/SmsmQPIdzmuaTZeT8s4fkH/whYApXNHv2b8dr51/gXsGIivMZLUZMeskgCbuXdNKuT
         ErJyO3+N/ZlQAs9s/odfYKJ4qfB53ON4LJ+PsaNDrDOzt1wT6cpgVkXRoixBtGsVCHZJ
         mp8BE3KVdCIQwswlmwuonlDL5Q/fohdRfDBEPXIWa+tTkqqQSRAspG1TzKooVbdcksXa
         AA9g==
X-Gm-Message-State: APjAAAW6H5KoCY3yPFpKuum/lYMzp1h/2WoWCaB2JT5PWNLaDMzK1T/c
        tbuOaF3KxqCw/ySg1bg6uBry5H5cLEc=
X-Google-Smtp-Source: APXvYqys8bWZmB8pXZPs5re5p/jm1FeDHlMsh8MgbOroiVA1QSDy2ZyN8hemLGz/n2j917RlSvFxPg==
X-Received: by 2002:a19:5218:: with SMTP id m24mr42633910lfb.164.1564603202065;
        Wed, 31 Jul 2019 13:00:02 -0700 (PDT)
Received: from localhost.localdomain ([94.25.228.150])
        by smtp.gmail.com with ESMTPSA id i23sm14164724ljb.7.2019.07.31.13.00.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 13:00:01 -0700 (PDT)
From:   dbaryshkov@gmail.com
To:     linux-integrity@vger.kernel.org
Cc:     Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: ima-evm-utils: README: fix misspellings
Date:   Wed, 31 Jul 2019 22:59:59 +0300
Message-Id: <20190731195959.8170-1-dbaryshkov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Fix several misspellings noted by lintian.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 README | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/README b/README
index 3603ae8..1a3ef02 100644
--- a/README
+++ b/README
@@ -75,7 +75,7 @@ The evmctl utility is used for producing and verifying digital signatures, which
 are used by the Linux kernel integrity subsystem. It is also used for importing keys
 into the kernel keyring.
 
-Linux integrity subsystem allows to use IMA and EVM signatures. EVM signature
+Linux integrity subsystem allows one to use IMA and EVM signatures. EVM signature
 protects file metadata, such as file attributes and extended attributes. IMA
 signature protects file content.
 
@@ -96,8 +96,8 @@ extended attributes.
 
 Kernel configuration option CONFIG_EVM_ATTR_FSUUID controls whether to include
 filesystem UUID into HMAC and enabled by default. Therefore evmctl also includes
-fsuuid by default. Providing '--uuid' option without parameter allows to disable
-usage of fs uuid. Providing '--uuid=UUID' option with parameter allows to use
+fsuuid by default. Providing '--uuid' option without parameter allows one to disable
+usage of fs uuid. Providing '--uuid=UUID' option with parameter allows one to use
 custom UUID. Providing the '--portable' option will disable usage of the fs uuid
 and also the inode number and generation.
 
@@ -127,7 +127,7 @@ Integrity keyrings
 Integrity subsystem uses dedicated IMA/EVM keyrings to search for signature verification
 keys - '_ima' and '_evm' respectively.
 
-Since 3.13 IMA allows to declare IMA keyring as trusted. It allows only to load keys,
+Since 3.13 IMA allows one to declare IMA keyring as trusted. It allows only to load keys,
 signed by a key from the system keyring (.system). It means self-signed keys are not
 allowed. This is a default behavior unless CONFIG_IMA_TRUSTED_KEYRING is undefined.
 IMA trusted keyring is has different name '.ima'. Trusted keyring requires X509
@@ -189,7 +189,7 @@ asymmetric keys support:
 
 Configuration file x509_evm.genkey:
 
-	# Begining of the file
+	# Beginning of the file
 	[ req ]
 	default_bits = 1024
 	distinguished_name = req_distinguished_name
@@ -240,7 +240,7 @@ following steps:
 
 Configuration file ima-local-ca.genkey:
 
-	# Begining of the file
+	# Beginning of the file
 	[ req ]
 	default_bits = 2048
 	distinguished_name = req_distinguished_name
@@ -271,7 +271,7 @@ Produce X509 in DER format for using while building the kernel:
 
 Configuration file ima.genkey:
 
-	# Begining of the file
+	# Beginning of the file
 	[ req ]
 	default_bits = 1024
 	distinguished_name = req_distinguished_name
@@ -405,7 +405,7 @@ When using plain RSA public keys in PEM format, use 'evmctl import --rsa' for im
 
     evmctl import --rsa /etc/keys/pubkey_evm.pem $evm_id
 
-Latest version of keyctl allows to import X509 public key certificates:
+Latest version of keyctl allows one to import X509 public key certificates:
 
     cat /etc/keys/x509_ima.der | keyctl padd asymmetric '' $ima_id
 
@@ -437,5 +437,5 @@ COPYING
 -------
 
 Copyright \(C) 2012 - 2014 Linux Integrity Project. Free use of this software is granted under
-the terms of the GNU Public License (GPL).
+the terms of the GNU General Public License (GPL).
 
