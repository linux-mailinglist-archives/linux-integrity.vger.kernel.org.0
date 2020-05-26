Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E211E313D
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 23:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbgEZVdQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 17:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgEZVdP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 17:33:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A0BC061A0F;
        Tue, 26 May 2020 14:33:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p30so10679871pgl.11;
        Tue, 26 May 2020 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j3hVOp0liWWCUJVNOiyTPzyXy/QJ2NvCerFTV87ycss=;
        b=GGjDmsOgTTiI7R3BLlJU0vbgxubrZ+ftnl+Kxc9bQzyy6vDvKwg9v/AqfXsXUU0IDK
         ZRplh83OMgY21yAFIstEpcR+9ctXjScECvQtGp22jjO/MuE7a0XBeSdKzDVBt0za/a1J
         tAH6yK88ahQBRMmXsqpZrBYXMBrzQ0UjkIW7mVcqm5MNRHQe3oypGxbI3H4tLns0wgyb
         7ANZp1vnP3+ZOA9iirLWvk4DNmiOUycwOSIBDWNVImUXUqTnsL8arQgpIwdOZuXzZxC7
         WzqKdRY267IApA3aeh9NSDrI1XQSegY6BDlvoovndg2aRxpRfXUv7qg8cPt4FbRSsbXr
         hYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3hVOp0liWWCUJVNOiyTPzyXy/QJ2NvCerFTV87ycss=;
        b=CdtODL+iPgA4CEqWxyFU/e1fgpWDOEdko+o+3kTuO11Vy9swJXRIqCw/Yg1K2D75WS
         f0L1CFb8M0kJ9ddMvIA/HC6kcQHpj8NIoIveZz0jkrffTNqPN2Mebj5nZUjjTGhONOeY
         WDbc8pzI5r0Rz4WhyjLgPyAiLTaIb5EuXgor2qoLxPP4pw8qkDqYYg46zq14E6BlfLjS
         sUqi1idgeB23jygmh+P3HP2eSRU/WowSLUZpOLJgDyTPgtyFx5oKdE7zoj3ZYViq/Hfx
         jmbgh27/4yBVMnZMxwBkvs1/G2B7uM/h2rMelrXfZN2/uo393iSA9GoI5O3ZRWbocwmv
         1xww==
X-Gm-Message-State: AOAM532vWzOXnm5jBTYGKninDmO511EpXUlCOu2yg2Bo3xwYcl3D/F6h
        e2fT9FzpV9jHwl2dPVT00/LrFSGy7aY=
X-Google-Smtp-Source: ABdhPJwadwvNjSPXipWEqKXGx3b6nE58nTZY95Z4jOnwtALHI/c2AodDJbsWEm+Ml1xxXssTWtL0Pg==
X-Received: by 2002:a62:834b:: with SMTP id h72mr712713pfe.237.1590528794658;
        Tue, 26 May 2020 14:33:14 -0700 (PDT)
Received: from [192.168.1.5] ([75.164.7.205])
        by smtp.gmail.com with ESMTPSA id p1sm352318pjz.36.2020.05.26.14.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 14:33:13 -0700 (PDT)
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Alex Guzman <alex@guzman.io>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
 <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
 <1590523214.15108.4.camel@HansenPartnership.com>
From:   Tadeusz Struk <tstruk@gmail.com>
Message-ID: <705c9df6-e8cd-2829-c579-2bf039360eec@gmail.com>
Date:   Tue, 26 May 2020 14:33:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590523214.15108.4.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/26/20 1:00 PM, James Bottomley wrote:
> I don't think there is a root cause other than a TIS TPM is getting
> annoyed by us cycling localities too rapidly because we don't do an
> actual TPM operation between request and relinquish.  Since the first
> request/relinquish seems unnecessary for the async case, moving the ops
> get eliminates the problem.

Could be, so maybe we could try both patches.
More debug info on the error path won't hurt.
Thanks,
Tadeusz
