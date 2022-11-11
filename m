Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E562501F
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Nov 2022 03:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiKKC0a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 21:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiKKC03 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 21:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE1627CF
        for <linux-integrity@vger.kernel.org>; Thu, 10 Nov 2022 18:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668133532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WaG6D9NPul5lwMcNCuIe3sGhugQZUKvnrKFJmGoro3c=;
        b=PWTZZynKGvfUR+JqAZVPOYCA2ZWbXYR3k49Prqqfk4ZoNFNUmD+lz54BXhMMCezCS6Cb69
        pBcffh+pcDKt1wpNpRgvUns8fT7jSGgCdRZDHhfJNBa34AhNJEAvmPp6ytexH0GSEsgVxa
        qeTLvdloFXhwus9Nks8QNylQy/L0bGk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-461--LaH2EWGP_CpzQZph6Sbww-1; Thu, 10 Nov 2022 21:25:30 -0500
X-MC-Unique: -LaH2EWGP_CpzQZph6Sbww-1
Received: by mail-pg1-f198.google.com with SMTP id k71-20020a63844a000000b004701e90da0dso1916177pgd.22
        for <linux-integrity@vger.kernel.org>; Thu, 10 Nov 2022 18:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaG6D9NPul5lwMcNCuIe3sGhugQZUKvnrKFJmGoro3c=;
        b=ABaLNxA1gDuBIJH667EVkSWer1d4agvQeSv3IRXCfuvJ0ra86jfARPe1U07xc580j0
         zvjLCTvo0tT0fPAlcuIK3TpwP6ncD1QY1nfpAzklv8aUvoY7R82S/ZKouuHJB1Fwx3M5
         IXnOAHvbxQ+W5MyaVGyMz+9C1hMo9MQcEOG2d0XeU0gqGBRye4Tk7XQwafKQUjrdG10M
         oWxrjswM0a6iUkcBVkpl5Q/F/frCkM/E/r2M4Pj8gdI56qfVc0HOc68mbhRFtpT2ZUSO
         Qa+e+JHuQSa3F7QELHsbVT+KmsExi7xxay0UTsoMREDPoWUe7X2ilZh+skhzIIBNyP8A
         KBwQ==
X-Gm-Message-State: ANoB5plFW9TCEjxKnyk67WNTP0Qk5mSy6cQKb3i0OfLpYzZJT5C/1mpt
        qfRUFO3kCAt5YzGX5jPu8/hEnUE6Z51992qKeoEJ/LzHw/2kdBLOSUJkxkijev9VJ7wKeeZdwA3
        rmiHGGagnZpNnt/onyHqT+wiFu2WR
X-Received: by 2002:a17:902:f811:b0:187:19c4:373a with SMTP id ix17-20020a170902f81100b0018719c4373amr321321plb.163.1668133529854;
        Thu, 10 Nov 2022 18:25:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5JE5CicYQ2l/VDcgKu1A3Opx/g/1lm/7vpkfRaW5I/+bVsxwi+MrsKOPNQCArSCBYFvx9qNQ==
X-Received: by 2002:a17:902:f811:b0:187:19c4:373a with SMTP id ix17-20020a170902f81100b0018719c4373amr321304plb.163.1668133529575;
        Thu, 10 Nov 2022 18:25:29 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0018544ad1e8esm358845plk.238.2022.11.10.18.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:25:28 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:21:43 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nayna@linux.ibm.com, nasastry@in.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Message-ID: <20221111022143.xvpi3pfwwrw4qda2@Rk>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220901214610.768645-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Michael,

Could the PowerPC tree take this patch set which resolves a
PowerVM/KVM-specific issue?

On Thu, Sep 01, 2022 at 05:46:06PM -0400, Stefan Berger wrote:
>The of-tree subsystem does not currently preserve the IBM vTPM 1.2 and
>vTPM 2.0 measurement logs across a kexec on PowerVM and PowerKVM. This
>series fixes this for the kexec_file_load() syscall using the flattened
>device tree (fdt) to carry the TPM measurement log's buffer across kexec.
>
>   Stefan
>
>v8:
> - Added Jarkko's, Coiby's, and Rob's tags
> - Rebase on v6.0-rc3 that absorbed 2 already upstreamed patches
>
>v7:
> - Added Nageswara's Tested-by tags
> - Added back original comment to inline function and removed Jarkko's R-b tag
>
>v6:
> - Add __init to get_kexec_buffer as suggested by Jonathan
> - Fixed issue detected by kernel test robot
>
>v5:
> - Rebased on 1 more patch that would otherwise create merge conflicts
>
>v4:
> - Rebased on 2 patches that would otherwise create merge conflicts;
>   posting these patches in this series with several tags removed so
>   krobot can test the series already
> - Changes to individual patches documented in patch descripitons
>
>v3:
> - Moved TPM Open Firmware related function to drivers/char/tpm/eventlog/tpm_of.c
>
>v2:
> - rearranged patches
> - fixed compilation issues for x86
>
>Palmer Dabbelt (1):
>  drivers: of: kexec ima: Support 32-bit platforms
>
>Stefan Berger (3):
>  tpm: of: Make of-tree specific function commonly available
>  of: kexec: Refactor IMA buffer related functions to make them reusable
>  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
>
> drivers/char/tpm/eventlog/of.c |  31 +--
> drivers/of/kexec.c             | 336 ++++++++++++++++++++++++++++-----
> include/linux/kexec.h          |   6 +
> include/linux/of.h             |   9 +-
> include/linux/tpm.h            |  36 ++++
> kernel/kexec_file.c            |   6 +
> 6 files changed, 346 insertions(+), 78 deletions(-)
>
>
>base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
>-- 
>2.35.1
>

-- 
Best regards,
Coiby

