Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8137356D8C
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhDGNme (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 09:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhDGNme (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 09:42:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82331C061756;
        Wed,  7 Apr 2021 06:42:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 7so920972plb.7;
        Wed, 07 Apr 2021 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ipa0RvwM3C5BGFOPZXkjqPnkWW9+i8mIw5Yq7jPoRmY=;
        b=SHVbR0omFUA7VteJUR/croqtfrJPpjfjV+jPLW8dBtTz6ZP8pszQRtkC0BuF+4EHYO
         mHcwgpNajJCrnz/dRH3Hi2yYulX4meN3UrRVP3ZHMvQmOMYydkoBDfSCYLXtjcdrQSgK
         1LtEslSKwThAjvyF1LduVhrI8PV9mzqq+CmpY2mLSOW6pwGnpMD+RX67oKJtZPqN++xy
         IptmWUMvAdx+LvK3RK14WvBRNIHmyi/2is/V9h3uv8MlidDAKv7ZJ38DUMx0yaQKe9+b
         98L6JGrIqw4iaRqPu5m2+Pfh5MoWofknglRGZFGJR/2vOyCoS3kR/FyPMyDuPnTULhM8
         RzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ipa0RvwM3C5BGFOPZXkjqPnkWW9+i8mIw5Yq7jPoRmY=;
        b=SI/fpEZGZLkeB8RCavf2DGThPf5ePc8Yp+1Ia9V2QIN7aqdihObegW22MUmG3BspF5
         GveDvz9MaD5hJ7N2eRDKBrZ367PULL22mvUX4NdcaTzmIlx4dC8JCaN5Dv63jTP3T7Zy
         cYGRJYE4Lym1aY3POKgDsEzuxwyvJJ02a0s4Nhx+zL6Qvxul3zpE5vU9jgP5MiDtJPO8
         E4Yp+v9yLx2i4GI8xhNpfLJt564T1CxMmtn7TkZPE4C4TwQtBcFwgMwPIPQvbxlGtpFf
         Hgoi6DlXUDQii3GS6xGR2q3PZThD9hsWzcQ9p+buhpxCMOfVaE9kdG3aXrp2T/f5GjjJ
         +m9Q==
X-Gm-Message-State: AOAM532H5ObPe5KKYjOaXbJGDBnW1rEx38IqHZJCbx6XLxCpzGrfXR/E
        +blEVS+59KGKzNs4ooFsHgyMKuJDCmmdwA==
X-Google-Smtp-Source: ABdhPJyP0tvek1hSX09alV2MKcNDiEE3x/a54L8saNUEeSU3XKSiQqi18SQEFlTstYoX8EKEBIXM9g==
X-Received: by 2002:a17:902:c40e:b029:e9:3fb8:872f with SMTP id k14-20020a170902c40eb02900e93fb8872fmr3120155plk.74.1617802942924;
        Wed, 07 Apr 2021 06:42:22 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id t65sm1547350pfd.5.2021.04.07.06.42.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 06:42:22 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        herbert.tencent@gmail.com
Subject: [PATCH v4 0/4] crypto: add rsa pss support for x509
Date:   Wed,  7 Apr 2021 21:41:42 +0800
Message-Id: <1617802906-30513-1-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This series of patches add support for x509 cert signed by RSA
with PSS encoding method which is described in RFC8017 [1].

According to RFC8017, there're two encoding methods for signing and
verification. One is PKCS1-v1_5 which is already supported by linux,
the other one is PSS which is not supported by linux yet.

Patch1 make x509 support rsa pss encoding. Because the hash algo used
        by x509_get_sig_params() is in the asn1 "RSASSA-PSS-params"[2],
        we need to parse it at x509 layer, and could ignore other params.

Patch2 adds rsa pss template. It will parse pss related params [2], such as
        mgfhash and saltlen. Then do the rsa-pss verification according
        to RFC8017 section [3] and [4]. The mgf function is according to
        section [5].

Patch3 adds test vector for rsa pss.

Patch4 is the rsa-pss's ima patch. Also a rsa-pss patch for ima-evm-utils
        has been sent. So we could use rsa-pss for ima.

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

[1] https://tools.ietf.org/html/rfc8017#section-9.1
[2] https://tools.ietf.org/html/rfc8017#appendix-A.2.3
[3] https://tools.ietf.org/html/rfc8017#section-8.1.2
[4] https://tools.ietf.org/html/rfc8017#section-9.1.2
[5] https://tools.ietf.org/html/rfc8017#appendix-B.2.1

v3->v4:
  -add RFC link, and more description of the patches

v2->v3:
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
 crypto/rsapss_params.asn1                      |  21 ++
 crypto/testmgr.c                               |   7 +
 crypto/testmgr.h                               |  90 ++++++
 include/crypto/internal/rsa.h                  |  25 +-
 include/linux/oid_registry.h                   |   2 +
 security/integrity/digsig_asymmetric.c         |  18 +-
 14 files changed, 791 insertions(+), 20 deletions(-)
 create mode 100644 crypto/asymmetric_keys/x509_rsapss_params.asn1
 create mode 100644 crypto/rsa-psspad.c
 create mode 100644 crypto/rsapss_params.asn1

-- 
1.8.3.1

