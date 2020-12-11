Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB912D7400
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgLKKfn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 05:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388923AbgLKKfa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 05:35:30 -0500
Date:   Fri, 11 Dec 2020 12:34:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607682889;
        bh=RxLguaip6eAFD602x8RxLNaRpnJiw4iK1s1yEniLyX4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdATM7AX03CEGeL4h5FRY7F6jbeVKs+pb3piPWc8ungFq5OrBiDRufdmUYnqpJtQo
         GJ9yvChWDCDF6KpPS7alzs85WO5c3R5Ej0J4caUji6Tc0GzAqgSLAU6DaZ9PY4XZrH
         1lIPMighTE97mpqOdG6ZyjrlmYMwZBgJlLeRrM3CPHyooHKoP4btBJbfDHf5nH+9l8
         Qi3qnaAxxKri3ZXrwyCJaVAm6DmzlqgKmq2iDkOzF+UYh1E0ceAX/FskkIetYsmC0Z
         Quit9VftK/AWdt1y6iiF3SwQ8TSAvfaZg9kYyWgGAvJAjHJTa9WJEJ1T8cCYkwZNqZ
         qGk+Foexo9o6g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        "dlaurie@chromium.org" <dlaurie@chromium.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v6] char: tpm: add i2c driver for cr50
Message-ID: <20201211103443.GA12091@kernel.org>
References: <20201207142016.482122-1-adrian.ratiu@collabora.com>
 <20201208173906.GA58213@kernel.org>
 <87y2i7b186.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2i7b186.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 09, 2020 at 02:41:45PM +0200, Adrian Ratiu wrote:
> On Tue, 08 Dec 2020, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Mon, Dec 07, 2020 at 04:20:16PM +0200, Adrian Ratiu wrote:
> > > From: "dlaurie@chromium.org" <dlaurie@chromium.org>  Add TPM 2.0
> > > compatible I2C interface for chips with cr50 firmware. The firmware
> > > running on the currently supported H1 MCU requires a special driver
> > > to handle its specific protocol, and this makes it unsuitable to use
> > > tpm_tis_core_* and instead it must implement the underlying TPM
> > > protocol similar to the other I2C TPM drivers.   - All 4 bytes of
> > > status register must be read/written at once.  - FIFO and burst
> > > count is limited to 63 and must be drained by AP.  - Provides an
> > > interrupt to indicate when read response data is ready and when the
> > > TPM is finished processing write data.   This driver is based on the
> > > existing infineon I2C TPM driver, which most closely matches the
> > > cr50 i2c protocol behavior.
> > 
> > Starts to look legit. Has anyone tested this?
> 
> I tested on an x86_64 Chromebook EVE (aka Google Pixelbook) by chainloading
> in legacy mode and booting into a Yocto-based userspace (meta-chromebook)
> where I used tpm2-tools to communicate with the chip and also built and
> tested a ChromiumOS userspace in developer mode.
> 
> I do not have access to other HW which has this chip, so it is about as much
> testing I can do to confirm the driver works on this HW.
> 
> Adrian

So can you respond to this with tested-by. It's sufficient because
collateral effects of driver failing are insignificant for the kernel
as whole.
 
 /Jarkko
