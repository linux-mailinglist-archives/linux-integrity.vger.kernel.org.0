Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7E418C02C
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 20:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSTQL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 15:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgCSTQL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 15:16:11 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4000F2072C;
        Thu, 19 Mar 2020 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584645370;
        bh=Dcozg62z2SKypxSnCN+0tV7YcD7G5e2bZPgjZn3NX6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpIkVnDsUk2CxtsjRWoZNIZS9vt3251G2lOZFE2XfPiGViHQBrtTXBNJQ3kCZebCK
         uc8WcZdTCqizOeHTh0WgpCTSIGmczK9zqSY24XKrL6TL/7he3m438QPiFVX0T94ZjM
         UOYQgkU5xbIFdyPqZSE7lHNVeJGsiolDy0huLbsE=
Date:   Thu, 19 Mar 2020 12:16:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
Message-ID: <20200319191608.GC86395@gmail.com>
References: <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
 <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 09, 2020 at 10:16:00PM -0700, James Bottomley wrote:
> We have a need in the TPM2 trusted keys to return the ASN.1 form of
> the TPM key blob so it can be operated on by tools outside of the
> kernel.  The specific tools are the openssl_tpm2_engine, openconnect
> and the Intel tpm2-tss-engine.  To do that, we have to be able to read
> and write the same binary key format the tools use.  The current ASN.1
> decoder does fine for reading, but we need pieces of an ASN.1 encoder
> to write the key blob in binary compatible form.
> 
> For backwards compatibility, the trusted key reader code will still
> accept the two TPM2B quantities that it uses today, but the writer
> will only output the ASN.1 form.
> 
> The current implementation only encodes the ASN.1 bits we actually need.
[...]
> diff --git a/lib/Makefile b/lib/Makefile
> index 611872c06926..1a9169ef2bed 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -237,7 +237,7 @@ obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
>  
>  obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
>  
> -obj-$(CONFIG_ASN1) += asn1_decoder.o
> +obj-$(CONFIG_ASN1) += asn1_decoder.o asn1_encoder.o
>  
>  obj-$(CONFIG_FONT_SUPPORT) += fonts/
>  

Shouldn't there be separate kconfig options CONFIG_ASN1_DECODER and
CONFIG_ASN1_ENCODER so that the kernel doesn't get bloated for most users, who
will only need the decoder?

- Eric
