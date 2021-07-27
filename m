Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EDF3D6C09
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 04:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhG0CCA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233727AbhG0CCA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:02:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4B0D60FEB;
        Tue, 27 Jul 2021 02:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627353748;
        bh=h722ui9p7cZx2trWIxgwS3kbBtiKtNTRWxfhr5joFv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmL4MuHTUBp8sGwxo68Fr0J9weoE8oOSBxduyBxdu9OgWEx8e8OqdcJGVpSPf52Wb
         1FkGEYVHWGHlakQulJSQNUmutG6wr+mPInUO+6B4ddeuSVQwfutvjzR8x7AxW66eJD
         l5lFUYFQXgC7ccdmNG1hbbJu7MQ448c8uCrP4eC7gRYiF3wGR8neXscCe2Nfm/7hKA
         MXr2GAJb/oc+56jxVJeGiAlfRqSmnx00LRDUA0F6108qudfTNdF66srWDd9zJ9yNZ3
         VF3IrQv7lI0/ZWasYfLkJkk8sqMim1hViMBTD/uVz5ygVfPjQry/ItOAOCGXtIOYCS
         7wWDNV0mkhWOw==
Date:   Tue, 27 Jul 2021 05:42:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
Message-ID: <20210727024225.swqy5ypcytsngpd6@kernel.org>
References: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 12, 2021 at 12:25:05PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> When rngd is run as root then lots of these types of message will appear
> in the kernel log if the TPM has been configure to provide random bytes:
> 
> [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
> 
> The issue is caused by the following call that is interrupted while
> waiting for the TPM's response.
> 
> sig = wait_event_interruptible(ibmvtpm->wq,
>                                !ibmvtpm->tpm_processing_cmd);
> 
> The solution is to use wait_event() instead.

Why?

/Jarkko
