Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF935621C
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 05:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348448AbhDGDuE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 23:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348435AbhDGDuE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 23:50:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BD2C06174A;
        Tue,  6 Apr 2021 20:49:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c17so11930011pfn.6;
        Tue, 06 Apr 2021 20:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mb6pSf8jYcC2SPBXAnnfVa04OpwGqbwk0AimKEd04X0=;
        b=YQ4AkC0ft4IxGUiJQ+88IqN63+N0ZKGoG273VBWkjsB//Bh4+jWI7lcqVrC/U7IC86
         dahyZ/UUwTravJ2DAoCTleHPDDy3PfZaCHrVDdf5zgBZlQexZ0/sAi+MhXNnrPCQJAdT
         a0QK6p49FEyFgfkocRjyYZUbZST/jrQIiqnxgj+C4EF/jce+NYvyRKLJeHRztvHRdsNh
         wzBko7PY/JUoTjLkzz7XrPxWQwMt2vMsVaXOLaWw78TKCDztgIeBokKFqte7XqL6QMkx
         F7/+0VlWqgulJSVkYX2y7Wi/LEWAu15lxuuLf67k35NKHnTSg4bDiC3ndfQr5zDOmMOx
         neFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mb6pSf8jYcC2SPBXAnnfVa04OpwGqbwk0AimKEd04X0=;
        b=dJKLmfD4Mh/NjUFzoaIHSTjYNObIUcrYWnLLhMjOJ7qvDcuwheKG6YVQoCFFCY3M+c
         G57fWyrR3yya3OmojNAoGVUZs1f/E/bDfoOoPI4aRs+wfssi1MiXhj4u7TZcHMeUw09O
         ju8PWHqhjqurX4Cq95PGMSaUBSTfHmVquVnGeC3OTUuIFOfs/dxryhNCJtMDCmAak1va
         hqvC8FQLkn/vz9/0SHu6zXuHtuO+Cp0cfinPx09t6wm7eGRP9uxPhMID/zEQLEpkuOj7
         XNjwD1YZ9IG8DdysQbeuyIfPUE4c0O2uISc3pdrns4DPy+3+KUnBKKLMfKiL5VlEUBDL
         5N8w==
X-Gm-Message-State: AOAM531RchiVQ/hI35lWhBnsEe64IvMDq1C9bS1JkWX1W336a/QB+B4s
        lnsjqTqGQTyAPuvfqaITEkjIfMsF6ZnMhw==
X-Google-Smtp-Source: ABdhPJwzp4Mvba46wvWikrcNEZ7xAzTiLoZi0xHi9gUuS8qt8AbSwDORa7I8DrDzGo7/1pfYW7aVqw==
X-Received: by 2002:a63:5f88:: with SMTP id t130mr1373821pgb.403.1617767395076;
        Tue, 06 Apr 2021 20:49:55 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s21sm6000922pgl.36.2021.04.06.20.49.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 20:49:54 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH v3 0/4] crypto: add rsa pss support for x509
Date:   Wed,  7 Apr 2021 11:49:14 +0800
Message-Id: <1617767358-25279-1-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This series of patches adds support for x509 cert signed by RSA
with PSS encoding method. RSA PSS is described in rfc8017.

Patch1 make x509 support rsa pss encoding and parse hash parameter.

Patch2 add rsa pss template.

Patch3 add test vector for rsa pss.

Patch4 is the rsa-pss's ima patch.

Test by the following script, it tests different saltlen, hash, mgfhash.

keyctl newring test @u

while :; do
    for modbits in 1024 2048 4096; do
        if [ $modbits -eq 1024 ]; then
            saltlen=(-1 -2 0 20 32 48 64 94)
        elif [ $modbits -eq 2048 ]; then
            saltlen=(-1 -2 0 20 32 48 64 222)
        else
            saltlen=(-1 -2 0 20 32 48 64 478)
        fi

        for slen in ${saltlen[@]}; do
            for hash in sha1 sha224 sha256 sha384 sha512; do
                for mgfhash in sha1 sha224 sha256 sha384 sha512; do
                    certfile="cert.der"
                    echo slen $slen
                    openssl req \
                            -x509 \
                            -${hash} \
                            -newkey rsa:$modbits \
                            -keyout key.pem \
                            -days 365 \
                            -subj '/CN=test' \
                            -nodes \
                            -sigopt rsa_padding_mode:pss \
                            -sigopt rsa_mgf1_md:$mgfhash \
                            -sigopt rsa_pss_saltlen:${slen} \
                            -outform der \
                            -out ${certfile} 2>/dev/null

                    exp=0
                    id=$(keyctl padd asymmetric testkey %keyring:test < "${certfile}")
                    rc=$?
                    if [ $rc -ne $exp ]; then
                        case "$exp" in
                            0) echo "Error: Could not load rsa-pss certificate!";;
                        esac
                        echo "modbits $modbits sha: $hash mgfhash $mgfhash saltlen: $slen"
                        exit 1
                    else
                        case "$rc" in
                            0) echo "load cert: keyid: $id modbits $modbits hash: $hash mgfhash $mgfhash saltlen $slen"
                        esac
                    fi
                done
            done
        done
    done
done

Best Regards

Hongbo

v2-v3:
  -add the crypto/rsa-psspad.c which is missed in previous patch

v1->v2:
  -rebase patches to cryptodev/master to fix the issues that
   reported-by: kernel test robot <lkp@intel.com>

Hongbo Li (4):
  x509: add support for rsa-pss
  crypto: support rsa-pss encoding
  crypto: add rsa pss test vector
  ima: add support for rsa pss verification

 crypto/Makefile                                |   7 +-
 crypto/asymmetric_keys/Makefile                |   7 +-
 crypto/asymmetric_keys/public_key.c            |   5 +
 crypto/asymmetric_keys/x509_cert_parser.c      |  71 ++++-
 crypto/asymmetric_keys/x509_rsapss_params.asn1 |  19 ++
 crypto/rsa-psspad.c                            | 398 +++++++++++++++++++++++++
 crypto/rsa.c                                   |  14 +-
 crypto/rsa_helper.c                            | 127 ++++++++
 crypto/testmgr.c                               |   7 +
 crypto/testmgr.h                               |  90 ++++++
 include/crypto/internal/rsa.h                  |  25 +-
 include/linux/oid_registry.h                   |   2 +
 security/integrity/digsig_asymmetric.c         |  18 +-
 13 files changed, 770 insertions(+), 20 deletions(-)
 create mode 100644 crypto/asymmetric_keys/x509_rsapss_params.asn1
 create mode 100644 crypto/rsa-psspad.c

-- 
1.8.3.1

