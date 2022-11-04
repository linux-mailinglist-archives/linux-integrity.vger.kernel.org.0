Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D54619FDA
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 19:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiKDS16 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 14:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiKDS14 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 14:27:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050624B99C
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 11:27:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5so5211854pjo.5
        for <linux-integrity@vger.kernel.org>; Fri, 04 Nov 2022 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUqszso6Ws0bgIO+Fn99YX+rUGif2Q1cUmfl0WM0vmw=;
        b=odecLGRhxOwhsXd0tqsJnLvySgK1wwL5EuKjfVW2c3GzswA2SuTOPOMGHpRE8Oo5jF
         L45owvgVsVwiX3yrJTEPO3I5oqc25pHMej0OGi+/D3BFS/EyoVBztE7WTQMpAaqf+Rgg
         AknDcr7HTObIsDEivNuvIS1OvsxZeWIyfLnAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUqszso6Ws0bgIO+Fn99YX+rUGif2Q1cUmfl0WM0vmw=;
        b=mq7vtFHl44YpAUE7RQe/BdJ0InSL6Vwb38mEKkref5FF6IZ4sWkESEkJMhREtOtyRs
         gDRqBW6sbBiolGmlemWQGGIrXMrd/RgVH2SD8+W0Byzufa1+MlHybwjZnHSr+hjWjqNV
         Am2OiEk3B/5rEWEvbUfmHF3BR1BkON3APjDW7NnW8ObwOTOd5v7UemkmG4VO7uH8XHbc
         j4L6PmOg73P9F01YalfxIK725DbkTpscqcdPESEpocIOwMn3A6DsfuYK2U5PKHjm2whY
         vbAN51/O3MMgya+PxJthk4AE6f66u6dhq7tJ+7lDnfZTmsOwFW7AKNPD9E/I7EGErSfe
         YlOA==
X-Gm-Message-State: ACrzQf0nbDejX81f3irX11pCRLjCTrdfTDNbCSiWrg3upwOte4yLcCRf
        M8Ao8R4JfCrVozK56q5WARtPcA==
X-Google-Smtp-Source: AMsMyM4tInOtgbMjfF6aNdaiuKY8s8KWXpkz40UU3nzPEwdRYEQVO8XJ8Joli67e3QuEsGHMoa0zKA==
X-Received: by 2002:a17:90b:3a81:b0:213:ff6a:aa0d with SMTP id om1-20020a17090b3a8100b00213ff6aaa0dmr23344938pjb.86.1667586474491;
        Fri, 04 Nov 2022 11:27:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 101-20020a17090a0fee00b0020669c8bd87sm45503pjz.36.2022.11.04.11.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:27:54 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:27:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v4 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <202211041127.55ED2921E5@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 11:01:11AM -0700, Evan Green wrote:
> From: Matthew Garrett <matthewgarrett@google.com>
> 
> Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> restricts usermode's ability to extend or reset PCR 23.
> 
> Under certain circumstances it might be desirable to enable the creation
> of TPM-backed secrets that are only accessible to the kernel. In an
> ideal world this could be achieved by using TPM localities, but these
> don't appear to be available on consumer systems. An alternative is to
> simply block userland from modifying one of the resettable PCRs, leaving
> it available to the kernel. If the kernel ensures that no userland can
> access the TPM while it is carrying out work, it can reset PCR 23,
> extend it to an arbitrary value, create or load a secret, and then reset
> the PCR again. Even if userland somehow obtains the sealed material, it
> will be unable to unseal it since PCR 23 will never be in the
> appropriate state.
> 
> This Kconfig is only properly supported for systems with TPM2 devices.
> For systems with TPM1 devices, having this Kconfig enabled completely
> restricts usermode's access to the TPM. TPM1 contains support for
> tunnelled transports, which usermode could use to smuggle commands
> through that this Kconfig is attempting to restrict.
> 
> Link: https://lore.kernel.org/lkml/20210220013255.1083202-3-matthewgarrett@google.com/
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> Changes in v4:
>  - Augment the commit message (Jarkko)
> 
> Changes in v3:
>  - Fix up commit message (Jarkko)
>  - tpm2_find_and_validate_cc() was split (Jarkko)
>  - Simply fully restrict TPM1 since v2 failed to account for tunnelled
>    transport sessions (Stefan and Jarkko).
> 
> Changes in v2:
>  - Fixed sparse warnings

Since you've changed this patch from the original, I would follow the
same advice I gave here:
https://lore.kernel.org/lkml/202209201620.A886373@keescook/

>
-- 
Kees Cook
