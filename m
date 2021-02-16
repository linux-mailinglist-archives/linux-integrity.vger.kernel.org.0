Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA81C31C957
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBPLF4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 06:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhBPLDw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 06:03:52 -0500
Received: from ithil.bigon.be (ithil.bigon.be [IPv6:2001:bc8:25f1:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE5C061574
        for <linux-integrity@vger.kernel.org>; Tue, 16 Feb 2021 03:03:12 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id CFA181FDD8;
        Tue, 16 Feb 2021 12:02:24 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id AXlyKYqFou0B; Tue, 16 Feb 2021 12:02:24 +0100 (CET)
Received: from [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3] (unknown [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Tue, 16 Feb 2021 12:02:24 +0100 (CET)
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in tpm_tis_gen_interrupt()
 and tpm_get_timeouts()
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <20210216081750.191250-1-jarkko@kernel.org>
From:   Laurent Bigonville <bigon@debian.org>
Message-ID: <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
Date:   Tue, 16 Feb 2021 12:02:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210216081750.191250-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le 16/02/21 à 09:17, Jarkko Sakkinen a écrit :
> From: Lukasz Majczak <lma@semihalf.com>
>
> This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
> (SLB 9670):
>
> [    4.324298] TPM returned invalid status
> [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
>
> Background
> ==========
>
> TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 FIFO
> Interface Locality Usage per Register, Table 39 Register Behavior Based on
> Locality Setting for FIFO - a read attempt to TPM_STS_x Registers returns
> 0xFF in case of lack of locality. The described situation manifests itself
> with the following warning trace:
>
> The fix
> =======
>
> Add the proper decorations to tpm_tis_gen_interrupt() and
> tpm_get_timeouts().

I tried that patch (alone on the top of the HEAD of Linus master) and I 
still get the same trace in dmesg

