Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADD93A807E
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFONke (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 09:40:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36708 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhFONjl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 09:39:41 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3FBC920B83DE;
        Tue, 15 Jun 2021 06:37:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FBC920B83DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623764257;
        bh=nodB4PIcC8nFUjJXE/cS3JeyunNLJfPdZ+FTM5WBP3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUbGylFgj3+J+uh7xGxRVT1Qj+gghypKLZLYKaJlegBjtTjotBcjFgeI10Kj+CGjM
         fW+seh8raZWTSLPTEZpLC5WNgYdMbBBqtEHpdGHpsd646kJgDPVngkOGnaVEOU0f9u
         c8aarTUQ4MlJ7ey484Y/rIhfU+XaT7LaB74/ZfEI=
Date:   Tue, 15 Jun 2021 08:37:34 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/8] tee: Improve support for kexec and kdump
Message-ID: <20210615133734.GY4910@sequoia>
References: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
 <CAHUa44ErgoxT3L1W-ouoQwUg1fNC-zagOOgy=KBuGN_pETnYaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44ErgoxT3L1W-ouoQwUg1fNC-zagOOgy=KBuGN_pETnYaw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-06-15 09:23:25, Jens Wiklander wrote:
> It looks like we're almost done now. Thanks for your patience to see
> this through.
> 
> I suppose it makes most sense to take this via my tree, but before I
> can do that I'll need acks from the maintainers of
> drivers/char/tpm/tpm_ftpm_tee.c ("tpm_ftpm_tee: Free and unregister
> TEE shared memory during kexec") and
> drivers/firmware/broadcom/tee_bnxt_fw.c ("firmware: tee_bnxt: Release
> TEE shm, session, and context during kexec").

@Rafał Miłecki, we just need an ack from you for the tee_bnxt_fw.c
change:

 https://lore.kernel.org/lkml/20210614223317.999867-9-tyhicks@linux.microsoft.com/

Jarkko just gave us an ack for tpm_ftpm_tee.c on the v4 series:

 https://lore.kernel.org/lkml/20210615130411.hvpnaxnhimjloiz3@kernel.org/

The patch tpm_ftpm_tee.c patch didn't change from v4 to v5 and the
underlying concept of not using TEE_SHM_DMA_BUF remained the same so I
don't think we need a separate v5 ack.

Tyler

> 
> Cheers,
> Jens
> 
