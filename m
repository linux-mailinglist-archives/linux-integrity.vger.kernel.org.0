Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B063A14BD
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jun 2021 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhFIMqJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Jun 2021 08:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhFIMqJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Jun 2021 08:46:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 266616128A;
        Wed,  9 Jun 2021 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623242654;
        bh=We1DBBAALTBp1bajPkqkYTVL2X6KZ1QbIzNi3rCtTOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2JSYgx5ai8OmKZ3iST6pbh269okTzcQCA2nj4UsFejbeMS+2lSeE6da2FW5/iXe2
         RSXi+KW8qE+1hT9Gi1H0YVfCdAfEY6GpBkDyu6PX8zPIBdXL38P9fyVLifiWvsVMRe
         xUNzmAE43WmPzqedAsGp2DZql3yiJPj3FO5+yMEiZhqqkg+tk5JcnkHWuWdGr42UrV
         s4nJYWAU/dxrv8svsYRLjp0OfZ7t9Kwv8odPwx6SN8wL5mH8MbkPtBuGC+uMfxPQXh
         UolVHFSs9JJqsj7ocpYZoqGAp0CqVKMOdBgltCaf5dpCoYfIrLSmQ+CAb+w0vz/qgF
         6Apa06G9BgpLg==
Date:   Wed, 9 Jun 2021 15:44:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add support for ECDSA-signed kernel modules
Message-ID: <20210609124412.engcrbo3fezuzyoq@kernel.org>
References: <20210602143537.545132-1-stefanb@linux.ibm.com>
 <20210603064738.pwfq3n7erzmncdmw@kernel.org>
 <8b79651b-1fe4-48c0-3498-529344ac6243@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b79651b-1fe4-48c0-3498-529344ac6243@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 03, 2021 at 08:32:59AM -0400, Stefan Berger wrote:
> 
> On 6/3/21 2:47 AM, Jarkko Sakkinen wrote:
> > 
> > > -- 
> > > 2.29.2
> > > 
> > > 
> > Please instead send a fix.
> 
> We have a Fixes tag in 1/2, so we want this to propagate to older kernels
> and need the fix in 1/2 for that reason.
> 
>    Stefan

So please do an additional fix and send it.

/Jarkko
