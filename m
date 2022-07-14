Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05625753F0
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jul 2022 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiGNRVk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jul 2022 13:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiGNRVj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jul 2022 13:21:39 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3552457;
        Thu, 14 Jul 2022 10:21:38 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id n7so1953431ioo.7;
        Thu, 14 Jul 2022 10:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TwlP1i3DseYJRbHuqOfV0GFqZdryH2G33X6Mm9Jm2CM=;
        b=YpzSu3HTJc2LdbWx25T3piHljMqbRRYDIIpn4+UR5HEJaVeadGUn1t0wheKcm4tNG0
         yYVf9Y9NjCPNPNuRE2FVlzwy/1E+0bJVI7pKQZh/b2oa8YfFa5hde/DFoS5Gygwq4CzT
         NSgsmbQO6CJFfCYN+L9vMXNxPEKxN4lMUOEsD0eDBfQ+ZK1E+oF32Ong7QFmrsuLOhPR
         yqQ7LJUCjPcvO4TmYCUl5/MfYhS5E+tEY4MKqnkMDzxMfFk3kqf+TZP/DBOvrb16bZ37
         pfjAPe81b3GsBthfKg0eZXgx5v23FXyqVj5yLTWflHRRnCBoOOhuj+/jC3JhVy5ADOuv
         ZT2Q==
X-Gm-Message-State: AJIora9yVOusF35tIHCRiU7J0Yaj/rww11arxt9Xmv/ZYOE8S8ihwyKb
        Pm+xOUz4FIIcgH5Uvmyurw==
X-Google-Smtp-Source: AGRyM1vO9dGrA7Y7SKsg+5554fBaotiNHywW1yLUMUZ53GyvbeVEnUtAvGac2Q1pjgYrrT0HbEWTiw==
X-Received: by 2002:a05:6602:1682:b0:65d:f539:e30 with SMTP id s2-20020a056602168200b0065df5390e30mr4768576iow.81.1657819297971;
        Thu, 14 Jul 2022 10:21:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p32-20020a056638192000b00339da678a7csm970726jal.78.2022.07.14.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:21:37 -0700 (PDT)
Received: (nullmailer pid 2584872 invoked by uid 1000);
        Thu, 14 Jul 2022 17:21:36 -0000
Date:   Thu, 14 Jul 2022 11:21:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v6 5/6] of: kexec: Refactor IMA buffer related functions
 to make them reusable
Message-ID: <20220714172136.GA2575969-robh@kernel.org>
References: <20220707172026.831614-1-stefanb@linux.ibm.com>
 <20220707172026.831614-6-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707172026.831614-6-stefanb@linux.ibm.com>
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

On Thu, Jul 07, 2022 at 01:20:25PM -0400, Stefan Berger wrote:
> Refactor IMA buffer related functions to make them reusable for carrying
> TPM logs across kexec.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> 
> ---
> v6:
>  - Add __init to get_kexec_buffer as suggested by Jonathan
> 
> v5:
>  - Rebased on Jonathan McDowell's commit "b69a2afd5afc x86/kexec: Carry
>    forward IMA measurement log on kexec"
> v4:
>  - Move debug output into setup_buffer()
> ---
>  drivers/of/kexec.c | 126 ++++++++++++++++++++++++++-------------------
>  1 file changed, 74 insertions(+), 52 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
