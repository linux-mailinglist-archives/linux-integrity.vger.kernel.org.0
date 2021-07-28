Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB8E3D97BF
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhG1Vui (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 17:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhG1Vuh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 17:50:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DFD560F59;
        Wed, 28 Jul 2021 21:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627509035;
        bh=9HITTAP0mO9pNbJehhI3bMrmmENeTLIzuEJOv4tJcJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVxmDsiFPJNvir+m2KnZ6wouXCpmyKxHJQZv683A5hhEYOpcuCmj3Pey6pPjiJMer
         6vaMKV6RgMlNRkVP+qD7T57yyOv4Z/pjxqK2l9t4Rt2JnPhbaoSq6Soqys0i394xXh
         AAW/kxDoBJB4A1wmql91Sstvnp7Wkd+5VnwoAQb2yxgDxVJtChVfxmvQodf0hwnJLn
         pKvJEcoeI4dvpcwAMBf49qN1tqC7MgIW2g3MVardb/1qhWj5wRUx5xatz0cuGst7Cq
         mkHUfuM0ogfbbwacoRaPZj32Nme3PTyogg3lQIik+VgX+thTLwS5ANTQam0ycrRRht
         hq7YD5KK+y2mA==
Date:   Thu, 29 Jul 2021 00:50:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
Message-ID: <20210728215033.dhnekvksekalhcrn@kernel.org>
References: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
 <20210727024225.swqy5ypcytsngpd6@kernel.org>
 <ad4011fb-fc1f-4019-9856-7d171db3255c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4011fb-fc1f-4019-9856-7d171db3255c@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 26, 2021 at 11:00:51PM -0400, Stefan Berger wrote:
> 
> On 7/26/21 10:42 PM, Jarkko Sakkinen wrote:
> > On Mon, Jul 12, 2021 at 12:25:05PM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > When rngd is run as root then lots of these types of message will appear
> > > in the kernel log if the TPM has been configure to provide random bytes:
> > > 
> > > [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
> > > 
> > > The issue is caused by the following call that is interrupted while
> > > waiting for the TPM's response.
> > > 
> > > sig = wait_event_interruptible(ibmvtpm->wq,
> > >                                 !ibmvtpm->tpm_processing_cmd);
> > > 
> > > The solution is to use wait_event() instead.
> > Why?
> 
> So it becomes uninterruptible and these error messages go away.

We do not want to make a process uninterruptible. That would prevent
killing it.

/Jarkko
