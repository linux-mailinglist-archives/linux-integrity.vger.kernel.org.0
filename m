Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1ED316C99
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhBJR1b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 12:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhBJR12 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 12:27:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75CF064E05;
        Wed, 10 Feb 2021 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612978007;
        bh=L+9ZY6K3T2erGZBQk5+t7RI7BYJvkEJbar4mTVy5H0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYxXK7GDNBqNxrfsDcFg0krA6Xt4Z+erkFS7v3V7XiOxi5ybzH73uGmPfgz0KgzGV
         rYVPv2YB0pV8PGQnVJDaECb58s8GPGHBB1IiiU2QfmIMkmrt/HUQKdx49BOzdWGqqK
         ZOb1/dAJnElc+yDzDkvYGXVnu5zGnyPuSpzO6wsakYFMQzZWpUV5ftndbWZ+HwSdhO
         3/Ba9fYhBMru5owRfcT3fK4u4/TNUdgbHrsyHHiuP+4dOmA78huCa4/v87+JFG0FKn
         d+mpcP5/OBABfK6ng6UpK+7/MvRQifQjt1Bysohv2GIBVhgLKgriM8l6blDbGj/Vlh
         P/szDaZsUQ0mA==
Date:   Wed, 10 Feb 2021 17:26:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        joe@perches.com, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v17 03/10] arm64: Use common
 of_kexec_alloc_and_setup_fdt()
Message-ID: <20210210172638.GA29087@willie-the-truck>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-4-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209182200.30606-4-nramas@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 09, 2021 at 10:21:53AM -0800, Lakshmi Ramasubramanian wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The code for setting up the /chosen node in the device tree
> and updating the memory reservation for the next kernel has been
> moved to of_kexec_alloc_and_setup_fdt() defined in "drivers/of/kexec.c".
> 
> Use the common of_kexec_alloc_and_setup_fdt() to setup the device tree
> and update the memory reservation for kexec for arm64.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 180 ++-----------------------
>  1 file changed, 8 insertions(+), 172 deletions(-)

I mean, of course I'm going to Ack that!

Acked-by: Will Deacon <will@kernel.org>

Will
