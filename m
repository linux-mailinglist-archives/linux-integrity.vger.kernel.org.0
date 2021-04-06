Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC035549E
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Apr 2021 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhDFNMQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 09:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhDFNMQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 09:12:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1D3C06174A;
        Tue,  6 Apr 2021 06:12:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v8so7461221plz.10;
        Tue, 06 Apr 2021 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iUJRnae525igOtU2pGteMCCuQD7DoQU6/WP5Ua7GG1M=;
        b=C96ZIezqpY+q/dYaGCtHnQA9I3d9CL3nPm0uimpoN6uaRqoJ0JJ759eK87RwGp7wqX
         aHAr3vHBmfhbjhSYfwqeDCSf7zfn/b8/V262/eJslnRZTyL/U6uLgiRyWh6UbXM/sylH
         Y9ZfgoiDK1Tv5jAsycK0q8acG0NgTkrtMA+7RDCWFn6qXvhkAuS4u82/9Cfnhwme3F34
         3HLNLqMG+8XvL5BmUHjmDV5iugNoZjMkojEFobnXtlbi0FkS+6+M5qHl5EP0HQ3DQZDU
         nak4Ypza6meu81f8LX+UZ5XU4SXyF0mBlB9AxL5C/gacal/cYfx7ytAob0JjFE6MJYxW
         VEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iUJRnae525igOtU2pGteMCCuQD7DoQU6/WP5Ua7GG1M=;
        b=H6D7MNZWui198M/Lp7OFHijhFPRRpj0S5+Q/f9iAYn6e1ardYws6SmOXQEeJiJ4yjd
         t1x6SDW5qIEzMX2gGdVq0yz5zMiCs0LS3eicV4klcJRN4/dq+iTFPLFMb+YMOj3sMA35
         aspLzryAByGzRt1oZOEhObp0eSiHyOq3oZl1w5a4bD9JX0D6bY2TOLk0iCX6+9AAbLml
         PDcSkeZ9HPRBjSOu4uS4fOrrnUMSNIadyRuuejTPO+zGxFCjPlHGcnoV9C9BE29qBI0v
         FPEavDa5ikoXx8Qp7+yOKunKcRG0dCDICPAwCFbtkZJ2vN8/NxOK7JwOinx1+J9e+e7Q
         KjDQ==
X-Gm-Message-State: AOAM532ZARNaL3iTBsWIl4xww2JP/qnMFkPnzTOCyCRWnUtIcsU+bRbM
        4jXpCPqVgxNIxBnRjr98sV1s4xocXn66DA==
X-Google-Smtp-Source: ABdhPJxgh5GDM8zEB8ETcAd9fGYLW1Eu1ebUogDfSjz51hEnf7Cym9wGYFZoEbPVLjdfvFrC3yemJw==
X-Received: by 2002:a17:902:7896:b029:e8:fa73:ad22 with SMTP id q22-20020a1709027896b02900e8fa73ad22mr11007709pll.66.1617714726428;
        Tue, 06 Apr 2021 06:12:06 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id i73sm13801351pgc.9.2021.04.06.06.12.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:12:05 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH 0/5] crypto: add rsa pss support for x509
Date:   Tue,  6 Apr 2021 21:11:21 +0800
Message-Id: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This series of patches adds support for x509 cert signed by RSA
with PSS encoding method. RSA PSS is described in rfc8017.

This series of patches adds support for x509 cert signed by RSA
with PSS encoding method. RSA PSS is described in rfc8017.

Patch1 make x509 support rsa pss algo and parse hash parameter.

Patch2 add rsa pss template.

Patch3 add test vector for rsa pss.

Patch4 is the ecdsa ima patch borrowed from Stefan Berge's ecdsa
       patch series, rsa-pss's ima patch is made on top of this patch.

Patch5 is the rsa-pss's ima patch.

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

