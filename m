Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72889611C2F
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Oct 2022 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ1VIj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Oct 2022 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJ1VIc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Oct 2022 17:08:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E956724AAEC
        for <linux-integrity@vger.kernel.org>; Fri, 28 Oct 2022 14:08:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 17so1535361pfv.4
        for <linux-integrity@vger.kernel.org>; Fri, 28 Oct 2022 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DpCDCfgix6fhBcWBNBseudtoBNtCW3+LdSSUlRuRRE=;
        b=fmOAu0FnuQec1OaBOKSLImzDv6UdMN/T5vknhvPk+r5OhWxejfFyt1cmbSqFLwMbhf
         eBz36iQ5T6qLODbZX/9dGAcD58xA+Z2yZU8aZNsKPgFv9Lkws7fsvc78HtgEYDn7spLY
         MPXB6dvc9pcR5Dcz9wS3HD073TSOD1PHbTf+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DpCDCfgix6fhBcWBNBseudtoBNtCW3+LdSSUlRuRRE=;
        b=oPHPwCCg59gLTGbeVdTPfG5yIxF4OkTBDL1v4wojZ9DSgzK2k4yb9L11T09wJQbz9A
         0hYL7q/iMpAs/p0mK7SY8kdRwdtxUY8zYCzizRb4ECCMNo5ZNA6TZlOqHQ6IBF4MRSXV
         DwwBWEkQCgqiiSmZmTm758eGA384+/RDTLQJ1Sa7hdr1Cdw8+8tGQGGVYurS5ByroMGO
         MHs+oaPoB7wYOEWE8kVCKg/xK0y7dHIWVImjCNBc02nqfJOVFQNfV/q0GttdUGNwPRZ4
         MAGXmAc6oBehlod4uhEcRPK0FBBfAd3izTp0ys8DzxJ1GcAVOB7ZMUV46GwjUhDF2b2Q
         xSMQ==
X-Gm-Message-State: ACrzQf0Ylb5xcdPUxsUSgRZGnABNRkdytH2l39VozoSIWGiqKJKEhR+7
        tujPNsek26Khp0byLTQjMOQi+Q==
X-Google-Smtp-Source: AMsMyM58AFzdnBpI+k19m++SDxgNek0dlsX3H4HcMS4Yghg2VZxjANmtnyYSexE9cimQ5Cvbfz+zYg==
X-Received: by 2002:a63:e218:0:b0:448:5163:478f with SMTP id q24-20020a63e218000000b004485163478fmr1248136pgh.415.1666991306407;
        Fri, 28 Oct 2022 14:08:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b00174c1855cd9sm3509621plf.267.2022.10.28.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:08:25 -0700 (PDT)
Date:   Fri, 28 Oct 2022 14:08:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        samitolvanen@google.com
Subject: Re: [PATCH] tpm: Avoid function type cast of put_device()
Message-ID: <202210281407.29FF39D8@keescook>
References: <20221021123309.2770740-1-ardb@kernel.org>
 <Y1WxtIjnJvX0jAk1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1WxtIjnJvX0jAk1@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 24, 2022 at 12:27:16AM +0300, Jarkko Sakkinen wrote:
> [...]
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Who's tree can this land in?

-- 
Kees Cook
