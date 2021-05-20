Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AAB38AF1B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 14:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbhETMvR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242944AbhETMvF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 08:51:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06111C06916C
        for <linux-integrity@vger.kernel.org>; Thu, 20 May 2021 05:13:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u133so9047295wmg.1
        for <linux-integrity@vger.kernel.org>; Thu, 20 May 2021 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+rsDWAMv4x1ZiNx5AapS5e6MR/cbmzAQ/wF+EUOxGU=;
        b=cR3MbNlHRY+hSafJx7VAjfSope7BFgR94/44HuaDrveC1bGEnVAaWRp72T7xvM0XoU
         OTDDqMvOLczZa0Yvp5vjEaVW5Exg5f5iypjfSszL7Pv/7/5oSjatQAHxdeMrD/CSxPmP
         8XbqrDRkkfYJAlnaICjiZD7MIHTWYiFNH0cEy/lXgNFMkwo28P57IbtdVRsrhxAn+q9p
         S5SSJBsrkkm8/LbtosRlsbtzn7QgwanZfaqwoxfOHC69k6CHIljV5dyJ9RWYnRzTlG6R
         v1m1BolGX8TjunA9APuGjMSeBGGGxaMaO6jVTKKwGm+M2rQw3SEwbNWRVcLOeUzuHSC3
         YHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+rsDWAMv4x1ZiNx5AapS5e6MR/cbmzAQ/wF+EUOxGU=;
        b=kn2WN5xK5adHyvVsYjX0N9zbOKeK9gQcMGsFg1MWGt6HGstMy3BpRcEfj0mSpD6+Wz
         BQoY8JUg+fYMGyWBcis3kDz8XPT97SD2eN1feU7eB1mdICUlwiVW2JtNjAcQ6aAXjup5
         EdohxTUCKpFgDXTGhrxeuAF7+Ent9YMKnwrpOmAiXAz58qRJp+oJfi6/5/aN+kViVfcH
         Ub5w35su5J5O364u5nJAyJAhXjwrNoTjOGMK5pcIEwzUZoJ1NxiPrlshz5pTOHUYV0V5
         02rRvOQgWYTzs1JWosdFURUbDxJfFbvzKRGesZozaUtrMJVaU/qXwqvPJtp5qCWOXP9d
         OkcQ==
X-Gm-Message-State: AOAM5311jVapUmEMRZoBeZSytMr12PbvxsCHd/ukN3Zry2/PbwqO3jXX
        pbkro0soTdnBs2gc57X0VwtVFg==
X-Google-Smtp-Source: ABdhPJyASSt/x1V8q95MVvVq2U/YMyWW3NXlYBCB6FmxOMXdwlT2RPBDCPtfjX12ceL8X8BK7YpF8Q==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr3390379wmj.46.1621512835550;
        Thu, 20 May 2021 05:13:55 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:13:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bob Picco <robert.picco@hp.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        "cs.c" <support.linux@omnikey.com>,
        Dave Safford <safford@watson.ibm.com>,
        David Airlie <airlied@linux.ie>, dwmw2@infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harald Welte <laforge@gnumonks.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <j.glisse@gmail.com>,
        Kanoj Sarcar <kanoj@sgi.com>, Kylene Hall <kjhall@us.ibm.com>,
        Lijun Pan <ljp@linux.ibm.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Matt Mackall <mpm@selenic.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>, paulkf@microgate.com,
        Paul Mackerras <paulus@samba.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Reiner Sailer <sailer@watson.ibm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        van Doorn <leendert@watson.ibm.com>
Subject: [PATCH 00/16] Rid W=1 warnings from Char
Date:   Thu, 20 May 2021 13:13:31 +0100
Message-Id: <20210520121347.3467794-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (16):
  char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
  char: pcmcia: cm4040_cs: Remove unused variable 'uc'
  char: random: Include header containing our prototypes
  char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
  char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
  char: applicom: Remove 3 unused variables 'ret' and 2 instances of
    'byte_reset_it'
  char: tpm: tpm1-cmd: Fix a couple of misnamed functions
  char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
  char: agp: backend: Demote some non-conformant kernel-doc headers
  char: agp: frontend: Include header file containing our prototypes
  char: agp: via-agp: Remove unused variable 'current_size'
  char: hpet: Remove unused variable 'm'
  char: agp: generic: Place braces around optimised out function in if()
  char: agp: uninorth-agp: Remove unused variable 'size'
  char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
  char: mem: Provide local prototype for non-static function

 drivers/char/agp/backend.c           |  4 +-
 drivers/char/agp/frontend.c          |  1 +
 drivers/char/agp/generic.c           |  3 +-
 drivers/char/agp/uninorth-agp.c      |  3 --
 drivers/char/agp/via-agp.c           |  3 --
 drivers/char/applicom.c              | 10 ++--
 drivers/char/hpet.c                  |  4 +-
 drivers/char/hw_random/pseries-rng.c |  2 +-
 drivers/char/mem.c                   |  2 +
 drivers/char/pcmcia/cm4000_cs.c      |  3 +-
 drivers/char/pcmcia/cm4040_cs.c      |  3 +-
 drivers/char/pcmcia/synclink_cs.c    | 74 +++++++++++++++-------------
 drivers/char/random.c                |  1 +
 drivers/char/tpm/tpm1-cmd.c          |  4 +-
 drivers/char/tpm/tpm_ftpm_tee.c      |  6 +--
 15 files changed, 60 insertions(+), 63 deletions(-)

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bob Picco <robert.picco@hp.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Cc: "cs.c" <support.linux@omnikey.com>
Cc: Dave Safford <safford@watson.ibm.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dwmw2@infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harald Welte <laforge@gnumonks.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jerome Glisse <j.glisse@gmail.com>
Cc: Kanoj Sarcar <kanoj@sgi.com>
Cc: Kylene Hall <kjhall@us.ibm.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Lijun Pan <ljp@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Matt Mackall <mpm@selenic.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>
Cc: paulkf@microgate.com
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Reiner Sailer <sailer@watson.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: "Uwe Kleine-König" <uwe@kleine-koenig.org>
Cc: van Doorn <leendert@watson.ibm.com>
-- 
2.31.1

