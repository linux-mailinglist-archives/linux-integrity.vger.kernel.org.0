Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A865BA7A
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Jan 2023 06:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjACFlg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Jan 2023 00:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjACFlf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jan 2023 00:41:35 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC8BB50
        for <linux-integrity@vger.kernel.org>; Mon,  2 Jan 2023 21:41:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y25so44263262lfa.9
        for <linux-integrity@vger.kernel.org>; Mon, 02 Jan 2023 21:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz7ISG2BpHIoIRrSJAcKiMUt9+jdy0XfxLJ4rnu4AbY=;
        b=RUZjtrIFgGN4z8iikfkC80fdyf0mx/j2+UFLys/NJMD1HW0Z2RScNGLO/KTUGxfTxk
         y4Knvv0X8qb5rDF7qbo02T2FAtgoR3zKRkZaR9WmHI9vXpBLWDla71PQPTa1PYPSDCwq
         eQ3CE0jOJz6lRAhXCJt81iTMX+mfzk8NmN6xcHqd2ae899nvAlpCet/QyZ9lLuki+T6T
         XbqRxOHuqjE6ljEWbrNF0gmpev3D/1lQoCpli7+x4JZF/QhfJP4Nn/L+fbRPW9+XEgw4
         FYo4kvs1Kh/MNMBM0gs/28UxKbe7/kMyhycLwiDjec8BHwHZb5X1MhYVwLUhLRJ60Gls
         jGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz7ISG2BpHIoIRrSJAcKiMUt9+jdy0XfxLJ4rnu4AbY=;
        b=fYzG3o+J9Rxyq0+TX1XMNzXoqpfumYCFXYmPoYm9Hjmj3BBRtqBhJbJNbIq8PW2sNC
         CYDBGjHLYEEPjCDWyLtE3SZ7NHte2y11EDg6ylODpEBV2FpnmKvbRclrBjWLHi5S1Fpl
         f6rKiSH97/i8Pdtl0leF05raXaRsbwWFyONbUuynIJMjHRVDQyrm8g76q5MtYk5/0kwh
         smV4Kc59K2HAbNUO7wG7ca7kDXq9olSTSCqShzVKeo05FDqsG63f2b3g/7xXSrJbgqPv
         L2D76OkT5f6elMT9pE97ClapYwVwRP5EubkMfmGt3GI/OIa6jOlOew5vlO55IudCVK1m
         bq1w==
X-Gm-Message-State: AFqh2krCMvv/ciM+DPVzjGofzs+jDlA1q4OZq6ZUm6a5Fo2CPi9NvGlH
        kek9nlJzbc708JC1C4Ss9XN+Qw==
X-Google-Smtp-Source: AMrXdXv+N2Q4HlPZHT4MZNrXe9IAVCEvCnR2o9ZtZ6QFltge7ivhbn/aIVu5jwXmzBA3mijiHml8HA==
X-Received: by 2002:ac2:51b6:0:b0:4b6:ed8b:4f16 with SMTP id f22-20020ac251b6000000b004b6ed8b4f16mr11224891lfk.52.1672724492326;
        Mon, 02 Jan 2023 21:41:32 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id y1-20020ac24461000000b004a8f824466bsm4714901lfl.188.2023.01.02.21.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 21:41:31 -0800 (PST)
Date:   Tue, 3 Jan 2023 05:41:26 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, paul@paul-moore.com,
        eparis@redhat.com
Subject: ima: zeroed out digest values
Message-ID: <Y7PABtHq14jMGrgK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi/Dmitry,

In commit 54f03916fb892 [0] the way which errors [1, 2] are being
handled by some of the IMA measurement routines had slightly
changed. Specifically, in the ima_collect_measurement() helper if the
hash calculation failed for whatever reason (i.e. received a software
interrupt whilst executing in a late stage of the ima_bprm_check
security hook), rather than returning to the caller early we continue
with populating the ima_digest_data within the respective iint entry,
in which case is all zeroes given that we initialize the hash buffer
with zeroes prior to calculating a hash. Some interfaces that piggy
back of IMA measurements i.e. BPF and Audit, are now left with
reporting zeroed hash values in some cases.

I wanted to confirm whether this is expected behavior?

[0]
https://github.com/torvalds/linux/commit/54f03916fb892441f9a9b579db9ad7925cdeb395
[1] https://github.com/torvalds/linux/commit/54f03916fb892441f9a9b579db9ad7925cdeb395#diff-a7813ab229aa21485d06aed8f7f36aef97e38d8a0b18a77ecccd64c9abe91194L254
[2] https://github.com/torvalds/linux/commit/54f03916fb892441f9a9b579db9ad7925cdeb395#diff-7fb0c7b8604559abf88f1313cd798710a86e2f0fa2fab3b0f32bc7972c82846fL338

/M
