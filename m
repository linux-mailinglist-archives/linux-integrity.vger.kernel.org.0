Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90DE356182
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 04:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhDGC5x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhDGC5w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 22:57:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E98C06174A;
        Tue,  6 Apr 2021 19:57:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso529064pjb.3;
        Tue, 06 Apr 2021 19:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L2ZahL3BM9zMTRN6qi10FAZfrxjb2GT5DQ+NiJkPnJE=;
        b=Hd0UTjhJSstOUBcrTdU2wjrY+VSKdETfSSQe4iTsMvGfbJShPm2Wzex9b+7epOFKd7
         jYdcuppeXpj65MXNWExMgnOuiM2eNjcs8qxED1BiwiuwMCYQaB9JagW4zUoLJjghGUPd
         bdsRe7KuTWAHqYQG9yTWrZn2WdVlHrgFfKjyQXXjb0e7PJAEJUmxVqUyLX1KvbA5/IwP
         Y1T+23bjBUx1ip7/tZi4o/xF1nWSpu0Gb0aOhfTX21brm/sLY9k43rdbK7F9MI3SnkuL
         9I8f54vEZvvbruTlUkebnovK8empXmrhbaz+UgazTy9LW/nc6QP4B4YUejN7A2c6frd6
         4kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L2ZahL3BM9zMTRN6qi10FAZfrxjb2GT5DQ+NiJkPnJE=;
        b=DcRAj5Tq9F0yq9SinqoX4Pj7M+8Dv0WSH06r034w/96YVLwfz5zLlVcEBzoquBjz1I
         RUeJfligap4+v/LkGVWUSo6PSTPIgjLnRhl7jXdpoPkWLB0WxaiR1uchvRSsLfnIhZNH
         8UdwHENPk2JQuKVsH16wlbqHkNxdO4Lq3avFz92w7chrTmzQlJTDkvCEca1y/5d2sbuA
         kCeQgJu19HQD2wqL8tBLGj9Mzx7lEQTqB8cSAB79YW1wE11ql/WNjkKqQ3eB/e8DKDQr
         QUqkLkUBzbJrsQPU7KbXQzhvABfeDksOkbLa0sbGvqVA0X+BcNLfQ+r4VXY4rBQt+WAr
         6iRQ==
X-Gm-Message-State: AOAM5332wBb+DYAB4O80Zia+BfJqaATW9aHYyc1NXp7oiN+zKqX8goW+
        qb7FK0Eseui9NtaqG3zd8p5nGQK5JQ5T8A==
X-Google-Smtp-Source: ABdhPJywRWd5lwTeaMP5a3F/XyWkE5jFJEABf4BHjoe3C57uaYS7xSCQKFak727DO6g//sB+q8w1mQ==
X-Received: by 2002:a17:902:708b:b029:e6:77ca:3cb6 with SMTP id z11-20020a170902708bb02900e677ca3cb6mr1079572plk.84.1617764260995;
        Tue, 06 Apr 2021 19:57:40 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s22sm3574981pjs.42.2021.04.06.19.57.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 19:57:40 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH 0/5] crypto: add rsa pss support for x509
Date:   Wed,  7 Apr 2021 10:56:59 +0800
Message-Id: <1617764223-14275-1-git-send-email-herbert.tencent@gmail.com>
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

