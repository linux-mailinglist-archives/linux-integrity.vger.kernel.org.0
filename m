Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3D55D562
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 15:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiF0Wd4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jun 2022 18:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbiF0Wd4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jun 2022 18:33:56 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39630186DD;
        Mon, 27 Jun 2022 15:33:55 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id m13so11208329ioj.0;
        Mon, 27 Jun 2022 15:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32Nxg6F78wS9IwAB+Cxihgn8oha1HxjScddi+4nCHG4=;
        b=MFjl4T8BhY+ZkdPda+caNxtnUdckkOz6NIz5Mxzvw2HAj9PYycbXNKcFd7cbmj3XDO
         HauwaYrdjrtnZIk73vXETqvWJnXIbolQ9SG3GUuRiFhgRkgy2WxoTz8SlMDUoQdxAzaT
         XHH4nbbPCzgf32z3fGsYNmo4gzqF3GqeOKG00VgNp9/UfSqsdBi7a2p4GFQ3Ae1dhKKu
         XxaEpoa62hpCqkJK5KW13DCYGpwfZFK48uL3DUVS8jRd/mMNjCkgfeEWwsB/tu/BvoMO
         8f8UzjuHQM/8OHWKlHVR1e7XvVzjOqG5ISDP2vYDa536yh5tBc5hbgG879nHzwQT0orP
         LPFw==
X-Gm-Message-State: AJIora/PN1bRV5F54WcXHnTw5QQ53dZvnpVsb8ZzQWbIPC7JRUklHWOY
        iH9ypoTtgmLFw+tTieuumw==
X-Google-Smtp-Source: AGRyM1uizCsd2c8405104reVZ4+WqtbFQDYdp2onLnzKzFfvElEFQ48+N7iSI1kQlWIgwkVWg4FWcw==
X-Received: by 2002:a05:6638:d4d:b0:333:1aea:4b9f with SMTP id d13-20020a0566380d4d00b003331aea4b9fmr9645855jak.149.1656369234311;
        Mon, 27 Jun 2022 15:33:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d87c4000000b0066961821575sm5863196ios.34.2022.06.27.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:33:53 -0700 (PDT)
Received: (nullmailer pid 3088698 invoked by uid 1000);
        Mon, 27 Jun 2022 22:33:52 -0000
Date:   Mon, 27 Jun 2022 16:33:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com
Subject: Re: [PATCH v2 0/3] tpm: Preserve TPM measurement log across kexec
Message-ID: <20220627223352.GA3082294-robh@kernel.org>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616154130.2052541-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 16, 2022 at 11:41:27AM -0400, Stefan Berger wrote:
> The of-tree driver does not currently preserve the IBM vTPM 1.2 and
> vTPM 2.0 measurement logs across a kexec. This series fixes this for the
> kexec_file_load() syscall using the flattened device tree (fdt) to
> carry the measurement log's buffer across kexec.

As mentioned in v1, please Cc other folks that might care about TPMs 
and kexec. I'm sure it's not only IBM.

Rob
