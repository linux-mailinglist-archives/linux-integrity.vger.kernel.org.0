Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342C83561B8
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 05:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbhDGDEo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 23:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhDGDEn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 23:04:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56CC06174A;
        Tue,  6 Apr 2021 20:04:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g35so7167813pgg.9;
        Tue, 06 Apr 2021 20:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L2ZahL3BM9zMTRN6qi10FAZfrxjb2GT5DQ+NiJkPnJE=;
        b=GwqKFBPMn4bFVhdezkkUI0ymRkbCcANy+U391GQLhZ1o+FLDlCjFtqX3B9Gnp6wKwT
         QaGs2eJln78cXpBjhEpRqJR5WBrVkbzP9XD0hdUSt4RiYj5DizpLaZCBHVIBBb39SF/U
         5qhFtpPwqESyyHtuwcbkUjI5ZuseMXDRWi3DdP/6sLYhr7EceHFibD1vngMUkzhCOmwl
         p/hBlaId6GLdBS3fURHP/9eyOlvBgukmLD6C9B6vSUH9Ot5cEbDD4p0a0N57PUpVG/dX
         4a3MMazn/QnE/AuXexyrh/AgQmDhwH6kivk1LQXze8oc2AW3DpGsgrE3lGJYxll68KGu
         Kj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L2ZahL3BM9zMTRN6qi10FAZfrxjb2GT5DQ+NiJkPnJE=;
        b=ly8mK7pSeMO5E0v9t+JSqAa//mUe4MZETT8pJhLk0qBlWp24rRGVjxof/1qvDsGJQ0
         bK/eipH1WVsAqPv3mPJGEEVXwsjs2V1+9IJXnMpJLKhWlu3UM5Ah0aUmyvGjse189SdR
         sm3F291J759/uJii+lpcL5tW0ll8TWexTXS5ZHHrAd0NDf9A5RQiswv6qtri7C5ZeiZf
         UD0VwACw+f8DMA3IfRdI/TKQadY8y3Mt1XeabuoHMa4XcSI3h3CnKGyx9XnxZGyU2Ilq
         nSCIO1j3FqTyn3gvAmokSK9Q+LYuqNVWabyEIs9Z/s8e6Qk0LP7zIMDIqLUgYnBmaxJA
         PMxg==
X-Gm-Message-State: AOAM530p+hVf6vMUFBxDeZNa6Tyw4X15xxh6hSAbZTk6HDtIXFfuwnGN
        8V+5kH2k1M2VGq1stCFYAdmoUfe8Prgebw==
X-Google-Smtp-Source: ABdhPJzcEIhqJm98AluNdVQFJvExLoakzANuWS4gJisMtZd4p9VhyVeQQfQGkdjTp1NEM5E4iw6cjw==
X-Received: by 2002:a63:e552:: with SMTP id z18mr1258823pgj.100.1617764672735;
        Tue, 06 Apr 2021 20:04:32 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id w3sm3395313pjg.7.2021.04.06.20.04.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 20:04:32 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH v2 0/4] crypto: add rsa pss support for x509
Date:   Wed,  7 Apr 2021 11:03:45 +0800
Message-Id: <1617764625-15421-1-git-send-email-herbert.tencent@gmail.com>
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

v1->v2:
  -rebase patches to cryptodev/master to fix the issues that
   reported-by: kernel test robot <lkp@intel.com>

Hongbo Li (5):
  x509: add support for rsa-pss
  crypto: support rsa-pss encoding
  crypto: add rsa pss test vector
  crypto: ecdsa ima support
  ima: add support for rsa pss verification

 crypto/Makefile                           |   7 +-
 crypto/asymmetric_keys/Makefile           |   7 +-
 crypto/asymmetric_keys/public_key.c       |   5 ++
 crypto/asymmetric_keys/x509_cert_parser.c |  71 ++++++++++++++++-
 crypto/rsa.c                              |  14 ++--
 crypto/rsa_helper.c                       | 127 ++++++++++++++++++++++++++++++
 crypto/testmgr.c                          |   7 ++
 crypto/testmgr.h                          |  87 ++++++++++++++++++++
 include/crypto/internal/rsa.h             |  25 +++++-
 include/keys/asymmetric-type.h            |   6 ++
 include/linux/oid_registry.h              |   2 +
 security/integrity/digsig_asymmetric.c    |  34 ++++----
 12 files changed, 363 insertions(+), 29 deletions(-)

-- 
1.8.3.1

