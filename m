Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34903327B0A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhCAJpg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 04:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234081AbhCAJp2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 04:45:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E17F64E40;
        Mon,  1 Mar 2021 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614591888;
        bh=Ue0k5j3MtCiB24FO15otD66DYpHCo6x1PQ/QgaqypX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOvmDCvyoZjtWpfgZ1S06TNq9TnNMaEOJJk+eJDfwbl83wW1HYrfjPHQTa4oXfA0f
         /DxDRDeuhIQNqf7VQkjdLU1AyzBgtxM2DuBovb5dqSPBA9ho/xQcNP8rRQHzAuasE4
         oNsVLqet3qmdYB9oaVX+7F+Yxo6L3sVmEQY+jvxf5yKm+FRjmCqfBDIOkOlPX5vxwA
         g69zYufBLnO9+6gTj/uJUvsZn+99/pX2o+SbCWQu30kuClOasPDhxOCeNAIYpq54y1
         bphuVpP/gObFAYKQ0zgOowGall6rcjGzSOuEWct6KQw4R7V8bewEzSdML7WleEhlno
         AIztfEf9R0t3Q==
Date:   Mon, 1 Mar 2021 11:44:28 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/ppi: Constify static struct attribute_group
Message-ID: <YDy3fC3gP1ydzbY0@kernel.org>
References: <20210204215427.49047-1-rikard.falkeborn@gmail.com>
 <YBynopNwhIhGBXv/@kernel.org>
 <YDlufJLcYN2bzNYV@rikard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDlufJLcYN2bzNYV@rikard>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 26, 2021 at 10:56:12PM +0100, Rikard Falkeborn wrote:
> On Fri, Feb 05, 2021 at 04:04:18AM +0200, Jarkko Sakkinen wrote:
> > On Thu, Feb 04, 2021 at 10:54:27PM +0100, Rikard Falkeborn wrote:
> > > The only usage of ppi_attr_grp is to put its address in an array of
> > > pointers to const struct attribute_group. Make it const to allow the
> > > compiler to put it in read-only memory.
> > > 
> > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > 
> > Thanks.
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > /Jarkko
> > 
> 
> Hi Jarkko,
> I saw this was merged as commit
> 90cba8d20f8b09d62a25f9864cb8e67722d76c3a, but in the commit, there was an
> additional change where a call to dump_stack() was added in
> drivers/char/tpm/tpm-chip.c, was this intentional?
 
No, thanks for reporting. I sent a fixup. Can you ack it?

/Jarkko
