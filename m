Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33619549B81
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jun 2022 20:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbiFMS34 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Jun 2022 14:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245090AbiFMS3n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jun 2022 14:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93F8BBF89F
        for <linux-integrity@vger.kernel.org>; Mon, 13 Jun 2022 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655131688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=OZLx4+2sATDiPCht8symnOxJpn6+yxE3cL5S4KV5z2s=;
        b=hahlxZo7PXz92byaDEej31WIv6parcMLOCz7lZrzi2r+PmElHDHXesC2wThYHPS/98d8a7
        jcSownjeGeNvv8BI6NF5ef8UHXZLxnz46yK8HhkqIWa9R2Ldv2TS/H25/dEiXP75ilSs26
        mhJGkUWvIL6/Vs0jPyBAwUv9kJGWff4=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-mRJJmiQ9OgGqhO-7oGPZ0A-1; Mon, 13 Jun 2022 10:48:07 -0400
X-MC-Unique: mRJJmiQ9OgGqhO-7oGPZ0A-1
Received: by mail-vk1-f200.google.com with SMTP id az42-20020a0561220d2a00b0035e02b5f627so1028420vkb.22
        for <linux-integrity@vger.kernel.org>; Mon, 13 Jun 2022 07:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OZLx4+2sATDiPCht8symnOxJpn6+yxE3cL5S4KV5z2s=;
        b=W9XWEcanj9zlpuFGc8l9XZhE+GynhrRbRnGgegIx3xOxFN3WwjJ/b6Y1nLR2bh/N9x
         EbLLyQ3gBnZdTINK2RISCV6ajxNzw0k9ksCBHU/1BOUp8RKgG2xf38Y57US+TcIdmoQB
         5Ro5GZWZyNJQ4Gal/9dXSKT14XNV90IfGpjIwRnPXv14rndeoqamkK1vDNb2L2qB1qnA
         OSQ9MztcrIhl3pwbEuR/L/kWW7NdM56CPqNIR4ByM4x0RY1Ha42eDbyBQ9887vNyplkU
         Hfxb3TsuNURQD2XAe44azpXTXZJu0FNCuTg0ZYoHNWjZg0tSihYa3Voch9S0TdrGsDom
         TXyw==
X-Gm-Message-State: AJIora8w7uE4KETYMGAcXEoFNPIzOzcu8xk6M/VmZRCTsqlMh44M8yrP
        x8vg2QNJ1qEtbtnPbA94G/J/4YPv4RbcmPmXzqT8Vl4oIMxJjnAVAU0hgc0lnBOqpjOeb1qatqo
        tAbLM6csnCaTehPK6NpggyGUDYxfnSMVm2Bp5P8RkquQs
X-Received: by 2002:a05:6102:1272:b0:34c:5ffa:2665 with SMTP id q18-20020a056102127200b0034c5ffa2665mr40432vsg.14.1655131686688;
        Mon, 13 Jun 2022 07:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u9s819N9SlHoJUqZ06H3Bu3e9J7WnX9Bto5UgZRjJwstgMQj1FpqShnHyQsWDM2RvMrNFpNT8yE2besIeJm6Q=
X-Received: by 2002:a05:6102:1272:b0:34c:5ffa:2665 with SMTP id
 q18-20020a056102127200b0034c5ffa2665mr40419vsg.14.1655131686437; Mon, 13 Jun
 2022 07:48:06 -0700 (PDT)
MIME-Version: 1.0
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Mon, 13 Jun 2022 07:47:40 -0700
Message-ID: <CALzcddv+khkc4vy4n0m6EAn=d2+9M5RRc92_TbxdCPMViJUC3w@mail.gmail.com>
Subject: CKI team seeing boot failures with 5.19 kernels on VMs with tpm device
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This came to my attention this morning, and I was able to do a quick
test and reproduce in a vm locally, using both the crb and tis
emulation. 5.18 boots up fine.

The only thing I see that could impact both crb and tis in the tpm
changes would be:

af402ee3c045 tpm: Add field upgrade mode support for Infineon TPM2
modules | 2022-05-23 | (Stefan Mahnke-Hartmann)
e57b2523bd37 tpm: Fix buffer access in tpm2_get_tpm_pt() | 2022-05-23
| (Stefan Mahnke-Hartmann)

I'm going to poke around some more and see if I can figure out what is
going on, but wanted to give you a heads up.

Regards,
Jerry

