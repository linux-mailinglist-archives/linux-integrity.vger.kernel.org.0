Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8BC7D8530
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Oct 2023 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjJZOtH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Oct 2023 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjJZOs7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:59 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F5D4C
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 07:48:51 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-458289fb60bso451625137.0
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698331730; x=1698936530; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6lzK1pFiQoRniXEGjF6tOObNRoBOW1hYjV90v0xvTKY=;
        b=XIsBta2gqorH+eW1Tl5gX/6yDCS3r+s/cKlITjSWU+mnuMN0AyOiNMu6UJs4jgBgsZ
         E2SjWe0+5yAusnUReHe6sqUBR21Sc2Igl9v/yZm328P6J/T/+DTh/p/TiT6rXJNUEeUu
         wdLUF572YEKcVH1pI2MPpa8kIHUPdPcssA7p4DFdXE8fYUWMlHm9vgvYfkoztI/OfkQM
         xlI3WZSeqDepVZpfg9oda6eYM2mCGXUMoOmF1hTRyxVISY4i6bCIXL0U/kqb1NB7OrDN
         lE+NLOti8OCm4TSm5iEz2nOKq++oktT2Vb6t3E9nQrcbTLQuHmFsMKK254D93ENsedLH
         UnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331730; x=1698936530;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lzK1pFiQoRniXEGjF6tOObNRoBOW1hYjV90v0xvTKY=;
        b=SpAZFg6iOSKFlgJRc63SRJp5HkBxbSPR4jCK3RntUG0ss451VkJgDba9pnwFpuwtJG
         GDiL038n5utq0xedqBYQcIBrO3u/dTDbV2JLxe4tGMdkz2c9Xha0SG58dqdpgNn+iGDn
         0hZT3UWRW2IjzOO2KRZyN6eDbuIQagTsaTU4aCSp0irY0hLSd/aXmHBboQ6XXl6/C2+H
         08KeMboFBiOWitX9L8MXuIyf6DBsNVe3GqSwzn7VgLv1hau3bFBhysQjSI0NjRPyVHKn
         i3jjO7kVafKZPxyySKe9iE1CJNKeADy2tQypvvnAwkP1KqkjUgi6lkBXFoHUXzskrxlQ
         sEWg==
X-Gm-Message-State: AOJu0YwGD1tmZXEXZ0gmfVU2iYPo90Ot0VwX2K1AtRGLN6gtmUYjIEQ4
        bDypQ6QxJc7ByoNgKQQnm0UGXwqJgPse9xbf3Q==
X-Google-Smtp-Source: AGHT+IFOXcomS2z3Xzc1G+uf0v//E62w4tPep5wRMeQeBOXCc+hIrVPCulRaJjMdlYiUzKHt5WCX0g==
X-Received: by 2002:a67:e050:0:b0:457:e32d:1732 with SMTP id n16-20020a67e050000000b00457e32d1732mr15674294vsl.4.1698331730343;
        Thu, 26 Oct 2023 07:48:50 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r13-20020a0cf60d000000b0064f4ac061b0sm5252286qvm.12.2023.10.26.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:48:49 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:48:49 -0400
Message-ID: <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT  calculation
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Since IMA is not yet an LSM, don't account for it in the LSM_CONFIG_COUNT
> calculation, used to limit how many LSMs can invoke security_add_hooks().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into lsm/dev-staging, thanks!

--
paul-moore.com
