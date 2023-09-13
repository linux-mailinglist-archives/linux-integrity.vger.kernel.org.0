Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C4579F167
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Sep 2023 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjIMSwS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Sep 2023 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjIMSwQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Sep 2023 14:52:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E6170F
        for <linux-integrity@vger.kernel.org>; Wed, 13 Sep 2023 11:52:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so1930351fa.3
        for <linux-integrity@vger.kernel.org>; Wed, 13 Sep 2023 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694631130; x=1695235930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Qj9Z1rQiOVRFuIxsKJDJyO2OoNyojeG35brwDaLZgQ=;
        b=d5QJbEoRWpQ2nEetGEM2hXNIrWKepyH9sc02Igli9Z4bvlcITQXh4jZwq3ino2bEJg
         J+2A7eiUQeTgEV72fi+ooGNvZsuGaAK3WI4ntzb/nIKbsPUcFDUAOS8tjQpG5BWuSZyt
         kEGtw8f1YzU8zbMIfmWGu/V/gf5tbsETnu3V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631130; x=1695235930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Qj9Z1rQiOVRFuIxsKJDJyO2OoNyojeG35brwDaLZgQ=;
        b=s3jtjdvOKSmundDIKOWaYzdXgiZ61V5HSmtCboaVsM13Bc5m7ygyzaun08t3IWrYPS
         /99BlKb4SjONZLMIFkTqwextLzcUHfrOOdN8JhKTyhLzDOAZb9DOWnIzoVfTNeYeF4LF
         606Ss0PUc+f4ZWEifZfy85XFp16+oPZvFgSutZByOSyZbf5KsIg8lEo6HhswAuLC4a1K
         QMtboRc4uMPetPib1uqOHqZHNZgd8GkX2eTvBVMq7UcgeDznsj8cymLLT3FPk1+cxIKz
         p+/HbQm9NWgYibKoi5zwpBY+k+CpEyu9h0I0bvgPET5v1+qVRglvpXg5kH+iaaZ64PDG
         1X7w==
X-Gm-Message-State: AOJu0YykkXfqkARDMLmSw9qoJmropDrzE7AB3YdbBtRdpRfFzr0Igqhw
        jxzXHiASHtTCJlxmsqsWB4IaoA8N/s4sr4Zy+kvs+36R
X-Google-Smtp-Source: AGHT+IGLQrstF7MYSI2s4ojfUHkU8dym/UZv4Wji9kUmWwN+EhgvPW9gne0h5NoduJFs5OIRzTLWtQ==
X-Received: by 2002:a2e:781a:0:b0:2bd:1fee:aacf with SMTP id t26-20020a2e781a000000b002bd1feeaacfmr2915263ljc.24.1694631130500;
        Wed, 13 Sep 2023 11:52:10 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b009ad8338aafasm3116768ejn.13.2023.09.13.11.52.09
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:52:09 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so90638a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 13 Sep 2023 11:52:09 -0700 (PDT)
X-Received: by 2002:a17:907:761a:b0:9a2:185b:5376 with SMTP id
 jx26-20020a170907761a00b009a2185b5376mr2470433ejc.49.1694631129472; Wed, 13
 Sep 2023 11:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230912201102.1012306-1-jarkko@kernel.org>
In-Reply-To: <20230912201102.1012306-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2023 11:51:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
Message-ID: <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 12 Sept 2023 at 13:11, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This pull request contains a critical fix for my previous pull request.

Please, less sarcasm and more actual helpful merge commit fodder, ok?

              Linus
