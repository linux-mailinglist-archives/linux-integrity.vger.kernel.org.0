Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14AD52F5CB
	for <lists+linux-integrity@lfdr.de>; Sat, 21 May 2022 00:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353946AbiETWmt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 18:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiETWms (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 18:42:48 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186F185408;
        Fri, 20 May 2022 15:42:48 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e93bbb54f9so11832452fac.12;
        Fri, 20 May 2022 15:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=azdu1pWAgwViwv7ELQ/aqUGNmN2fRBBuvMjhaKlYBAM=;
        b=Ar676pyMEiif83tmX+vl9fMtekFisVYcei4fDa1uva+15e5yl4NF720lVk9K9Wkyaa
         W9da2Qx2NcJ9QrWNw4jGMdPvabhVB9iGMKHNCXYmbOy/wnSeixvFpfe0rBaAQYnmQ/Sv
         xZnUPkcHb0/DhElFlRgsN8se7F0wGNxRQG2AqnkA7yjjNlj4YldNf+3fzyEtUn3XYm7/
         F80zTerFZ7uH800Kxo2uFkapm7AApWugNBOvv/+etukDvW/zqphzMNKOJu5DU2hU1yKr
         aTQJzD5SH5/ca9dnQK395YEEdFjvsWF8HX96OSbgc1LKWrrGErwcx3z/1K6ioclt0gqX
         LxtA==
X-Gm-Message-State: AOAM531jNOcCjpnR2a+Nrw11X12qxIA6v4qiKBu39Wx1uWKk3H2Lzbdu
        BcwAgXA/V361r9abZ4Is+A==
X-Google-Smtp-Source: ABdhPJyfg2alBejsld9ZUdZbsybzuds4RCSyXYGj21XRzYKGKqSXGreA1gnu4Og7xPrbNxKE4KO6aQ==
X-Received: by 2002:a05:6870:610f:b0:f1:9314:8005 with SMTP id s15-20020a056870610f00b000f193148005mr7504540oae.77.1653086567460;
        Fri, 20 May 2022 15:42:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j15-20020a9d7f0f000000b006060322124esm1437488otq.30.2022.05.20.15.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:42:46 -0700 (PDT)
Received: (nullmailer pid 388541 invoked by uid 1000);
        Fri, 20 May 2022 22:42:45 -0000
Date:   Fri, 20 May 2022 17:42:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     lizhengyu3@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        liaochang1@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v1 1/5] drivers: of: kexec ima: Support 32-bit platforms
Message-ID: <20220520224245.GA385188-robh@kernel.org>
References: <20220520154430.18593-1-palmer@rivosinc.com>
 <20220520154430.18593-2-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520154430.18593-2-palmer@rivosinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 20, 2022 at 08:44:27AM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> RISC-V recently added kexec_file() support, which uses enables kexec
> IMA.  We're the first 32-bit platform to support this, so we found a
> build bug.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  drivers/of/kexec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Assuming you don't want me to apply it:

Acked-by: Rob Herring <robh@kernel.org>
