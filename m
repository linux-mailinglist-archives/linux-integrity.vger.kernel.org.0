Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223C915CB61
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 20:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgBMTub (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 14:50:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41416 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgBMTua (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 14:50:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so5307287qtr.8
        for <linux-integrity@vger.kernel.org>; Thu, 13 Feb 2020 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hzt8XbslsdiswWQVmdnVazMhSDm06KMVCyU2O+0BGmE=;
        b=bBtGLz1CQrqbjYCYHiFeB2d7GTZWvvTRlXT6WnAOSAM8BsPgGUhHfoMWGo1F5pEge4
         94c2ZX7MHD2AE3xko/8f0Cg413+93l9guQTeglN7+8GPUDFimVFM8YDsopLWhTlxhETc
         wDD4bXB3gD+KhSxgeLotPdyM4xq+x66Ny04ax1uRn/rZY7yP62b1tWopbxG66dpU2lfT
         zkLwChWR6S5Tci/SLOOrGjJiODJv6k1O61CIRPAnZ8GnP6RK/N342IJqxnYzrqpRVAVn
         RqFVTLJURqT0di56YLJNT1GmapB+AqY2muHVicGzWyGbraOitWrAQOg+S0LOjs+U/nd7
         enKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hzt8XbslsdiswWQVmdnVazMhSDm06KMVCyU2O+0BGmE=;
        b=Rvba9b3O6qefmTLXpIgzfkGyOmYbCjbYnLAdNGXubuHxR8eyuR9yYDHpmSS0rgkc7M
         8qZdNE2GkhR1ph408cmvItLpM66tXlFs+gPfhsLssvaJqMDARNG7887MmUJ1vf+4Zh6A
         X73IrWkcyljgyTraeA/xcupTh/KV2PeVlSXnHO5OpuYfy3+OWom1sKrslDT2fjIbog7Z
         zcuM5YwpZDKn1BH2b0m9WAMuY5lsZkAc2kE92jUTzykBx6dA1a8zVb4LW7z+phTULitM
         L0nLvIkLr4ftDBJX51x+xi70q7jXgutdRvU/hC0NGKd2Uq9Krch2yKe5ncNANGYTjsb+
         bVow==
X-Gm-Message-State: APjAAAVdA1vqCFdmMiieSWKDoMcM0bdkFlcY57FxnXMP82vgHiEItFYf
        etlE+8U3HLP3IwWwpXN3eLSlUQ==
X-Google-Smtp-Source: APXvYqzaVjNoq4PrtV5wCDMWzHnF/LP90+x7iaI7lc5kEgC2BCXBdlXyjg5EhEOoxDXViT6/M13QHg==
X-Received: by 2002:ac8:7309:: with SMTP id x9mr17518032qto.338.1581623428031;
        Thu, 13 Feb 2020 11:50:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t2sm1893885qkc.31.2020.02.13.11.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 11:50:27 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2KVG-0005ah-VX; Thu, 13 Feb 2020 15:50:26 -0400
Date:   Thu, 13 Feb 2020 15:50:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        gcwilson@linux.ibm.com
Subject: Re: [PATCH 3/3] tpm: ibmvtpm: Add support for TPM 2
Message-ID: <20200213195026.GQ31668@ziepe.ca>
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
 <a23872ef-aa23-e6b0-4b69-602d79671d4b@linux.vnet.ibm.com>
 <d805c04b-3680-97d5-8ea7-82409c7ef308@linux.ibm.com>
 <20200213183508.GL31668@ziepe.ca>
 <b424faea-33a7-8e5a-caac-f322fad68118@linux.ibm.com>
 <20200213191108.GO31668@ziepe.ca>
 <1e301947-a8f3-0b7d-d86c-5bfe04a68a75@linux.ibm.com>
 <20200213193908.GP31668@ziepe.ca>
 <8406ff6d-c24f-0815-25f8-fa9a97dcde8b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8406ff6d-c24f-0815-25f8-fa9a97dcde8b@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 13, 2020 at 02:45:49PM -0500, Stefan Berger wrote:
> > Any driver that knows the TPM must be started prior to Linux
> > booting should not use the flag.  vtpm drivers in general would seem
> > to be the case where we can make this statement.
> 
> Wouldn't this statement apply to all systems, including embedded ones? 
> Basically all firmwares should implement the CRTM and do the TPM
> initialization.

It is not mandatory that systems with TPMs start it in the
firmware. That is only required if the TPM PCR feature is going to be
used. A TPM can quite happily be used for key storage without FW
support.

Arguably this is sort of done wrong. eg if the platform has provided
TPM information through uEFI or something then we shouldn't try to
auto start the system TPM. At least for TPM1 detecting a non-started
TPM was harmless, so nobody really cared. I wonder if TPM2 is much
different..

But certainly auto startup should *not* be required to have a working
TPM driver, that is just fundamentally wrong.

Jason
