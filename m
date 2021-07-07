Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB03BE58C
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhGGJ0y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 05:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230429AbhGGJ0x (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 05:26:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6302661CB6;
        Wed,  7 Jul 2021 09:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625649853;
        bh=UftJy229NqfMRKDWquzf1cpCDdyuS2uSgYnTFRXr5MM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWY0ctdIf2XxSOmh2+UeySo4yM4sQ+Z8na+oMOn6+FxIkxo2mNxclET+tthEXb9dB
         cpd73hCpCBPGQ0HrZJjBojF1BAQ7uyEm/bzzhcMGWLijwKNWkcLF54d2619TxOYirx
         IEeJPbYPWMlXQ/9i6LB+ZD0IA7kKDnf4T6HHg8wQ/oZUWtEQyoDOAvYe844Tb0kPCh
         ILe6a9PiyUcFH+wVnFrDDmdMWBEYAuGHzO5PmLi7MxjYe1KWbNWub8mz8+QHm77I+K
         eapKAChH4xMfmVZIDOyPh3E/TjTLCzw3QvY8OMdgdUi9oI21UEX4opXtRn0YDOLQ4F
         XjWrtHbRPU1Tg==
Date:   Wed, 7 Jul 2021 12:24:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     shrihari.kalkar@rubrik.com, seungyeop.han@rubrik.com,
        anish.jhaveri@rubrik.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v2] tpm: fix ATMEL TPM crash caused by too frequent
 queries
Message-ID: <20210707092411.onk6ewfmhxj5kf3v@kernel.org>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210707043135.33434-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707043135.33434-1-hao.wu@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 06, 2021 at 09:31:35PM -0700, Hao Wu wrote:
> Since kernel 4.14, there was a commit (9f3fc7bcddcb)
> fixed the TPM sleep logic from msleep to usleep_range,
> so that the TPM sleeps exactly with TPM_TIMEOUT (=5ms) afterward.
> Before that fix, msleep(5) actually sleeps for around 15ms.

What is TPM sleep logic?

/Jarkko
