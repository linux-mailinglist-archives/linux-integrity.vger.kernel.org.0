Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97639302C
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 15:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhE0N4B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 09:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhE0N4B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 09:56:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641EC061574;
        Thu, 27 May 2021 06:54:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g18so645194pfr.2;
        Thu, 27 May 2021 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LR6D5K3uAI+YCRmgnJRZEuK6Dn6CALSy8IeIHX8nBa4=;
        b=poOiwLvNz1oNH1mN/IOC18I0gbkaEmZaSw/u6eJjwlJapDkW6gCbF/hyXclcjnDRmS
         qNK1UbXZDXY+Mh8ep9U7fc4WbL9qDwIJdv0R+tnGydlnq5717DARIcGkjgv2nU8+QJXy
         i8DCw0TszjvCWro0La1Ngw+vlBT5UjUIekzXDeUeOEfcgc09DKJEjGBcOof16YyBE00T
         c7y5KuJPsrcP3Rcn3qXM5cSgjuzt1MUSEvalsukUjVx4snQnwR/2VcSOvXJgR790yS8Y
         4UNYRLoacbKFsrwLJOeXuLfE8vmNBAGyY2oPbbPdzPmOf4sdXp3WjmHYY7+jQG8HVDBw
         KbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LR6D5K3uAI+YCRmgnJRZEuK6Dn6CALSy8IeIHX8nBa4=;
        b=E6qnEOUzaFHMZwAZ0shPAf/fqNcfFxNuZfH/ISJcjRgH5huQeUWHGXNBka1gjqEtc2
         fV1m2cvG2hP8UHKLtgc9ZBVah8/UT58IhIsCfk3vqkx9AAL1ks0dqarMWgkinBOgE06G
         8PeJjqtrLz8SM7cSEGk6L1/LoH3cvCAYt1PPeZ9Nyt1H1cH3ydF/cLh/JSeCyTBNjhkO
         qf3z5ZToUXmpPgDTN0YhUL0O09wg/VpWBFwv1VLkLUttrBS6QC49vBkKmsBtLiKou1Fa
         +dIJ6GESDBZdUrVkTWJsBCHQoxrQl7kOuagr/iCf2nXTAL/PiUFjPoG9T81EtgRGoLDr
         kNjg==
X-Gm-Message-State: AOAM531oFebpAVA9R9To6ZP5u7oGTyH+6QYP4+15maSF/5pugS6IOA9X
        mzh+7f5FluWSt2N5EGVXtum5umv8PvE=
X-Google-Smtp-Source: ABdhPJxRRHW6DmbG3lK+mQLgTmkdC5dMuTV8JWB+J6eaJpTzYoRkr4gJTz29JnqgpbIk1BMYlzjzpQ==
X-Received: by 2002:a05:6a00:1992:b029:2df:b93b:49a with SMTP id d18-20020a056a001992b02902dfb93b049amr3439399pfl.11.1622123667633;
        Thu, 27 May 2021 06:54:27 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 10sm2163387pgl.39.2021.05.27.06.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 06:54:27 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        dhowells@redhat.com, jarkko@kernel.org,
        tianjia.zhang@linux.alibaba.com, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 0/7] crypto: add eddsa support for x509
Date:   Thu, 27 May 2021 21:53:28 +0800
Message-Id: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This series of patches add support for x509 cert signed by eddsa,
which is described in RFC8032 [1], currently ed25519 only.

Curve25519 is an elliptic curve used for key agreement(ECDH).
It is a Montgomery curve.

Edwards25519 is a twisted Edwards curve and birationally equivalent
to Curve25519, the birational maps are described in rfc7748 section 4.1.[2]
Ed25519 is a Digital Signature Algorithm over Edwards25519.

The kernel's curve25519 code is used for ECDH, such as set_secret(),
generate_public_key() and compute_shared_secret(), these are useless
for eddsa, and can not be reused, eddsa do the verification on the
given public key and signature.

According to RFC8032 section 4 [3], there're two variants: PureEdDSA and
HashEdDSA. These patches support PureEdDSA which named Ed25519.

Patch1 fix a memory leak bug in sm2.

Patch2 fix a mpi_resize bug, this bug will cause eddsa verification failed.

Patch3 exports some mpi common functions.

Patch4 makes x509 layer support eddsa.

Patch5 moves some common code in sm2 to separate files. These code is also
       used by eddsa.

Patch6 is the implementation of eddsa verification according to RFC8032
       section 5.1.7 [4].

Patch7 adds test vector for eddsa.

Test by the following script:

keyctl newring test @u

while :; do
    certfile="cert.der"

    openssl req \
            -x509 \
            -newkey ED25519 \
            -keyout key.pem \
            -days 365 \
            -subj '/CN=test' \
            -nodes \
            -outform der \
            -out ${certfile} 2>/dev/null

    exp=0
    id=$(keyctl padd asymmetric testkey %keyring:test < "${certfile}")
    rc=$?
    if [ $rc -ne $exp ]; then
        case "$exp" in
            0) echo "Error: Could not load ed25519 certificate $certfile!";
        esac
        exit 1
    else
        case "$rc" in
            0) printf "load ed25519 cert keyid: %-10s\n" $id;
        esac
    fi
done

Best Regards
Hongbo

[1] https://datatracker.ietf.org/doc/html/rfc8032
[2] https://datatracker.ietf.org/doc/html/rfc7748#section-4.1
[3] https://datatracker.ietf.org/doc/html/rfc8032#section-4
[4] https://datatracker.ietf.org/doc/html/rfc8032#section-5.1.7

v1->v2:
  -fix the warning "warning: no previous prototype"
   reported-by: kernel test robot <lkp@intel.com>
  -add more comments about these patches

Hongbo Li (7):
  crypto: fix a memory leak in sm2
  lib/mpi: use kcalloc in mpi_resize
  lib/mpi: export some common function
  x509: add support for eddsa
  crypto: move common code in sm2 to ec_mpi.c and ec_mpi.h
  crypto: ed25519 cert verification
  crypto: add eddsa test vector

 crypto/Kconfig                            |  15 +
 crypto/Makefile                           |   4 +
 crypto/asymmetric_keys/public_key.c       |  73 ++++-
 crypto/asymmetric_keys/x509_cert_parser.c |  14 +-
 crypto/asymmetric_keys/x509_public_key.c  |   4 +-
 crypto/ec_mpi.c                           |  82 ++++++
 crypto/ec_mpi.h                           |  37 +++
 crypto/eddsa.c                            | 326 ++++++++++++++++++++++
 crypto/sm2.c                              | 104 +------
 crypto/testmgr.c                          |   6 +
 crypto/testmgr.h                          |  32 +++
 include/linux/oid_registry.h              |   1 +
 lib/mpi/mpi-add.c                         |   4 +-
 lib/mpi/mpiutil.c                         |   2 +-
 14 files changed, 591 insertions(+), 113 deletions(-)
 create mode 100644 crypto/ec_mpi.c
 create mode 100644 crypto/ec_mpi.h
 create mode 100644 crypto/eddsa.c

-- 
2.27.0

