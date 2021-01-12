Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2692F3282
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 15:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbhALOCt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 09:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbhALOCt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C9CC2310E;
        Tue, 12 Jan 2021 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610460128;
        bh=197eIm3QcYcnlpX6+Ihqh4zYVko6lSXitDPlicqbmNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRTAQNkhfpEqmUQ4mvHC9E/j8JnDE8szs5C9n9rf0Jepjr2lnxz0ZJwbvrqU6ttTY
         h+a0z9lnJ5a0/d9qr/Lsd6sS6ibuXoNe45/VXZ1uoA8YKdUQRLua1G2sDeU5V8KiTr
         93J4OsajTsju8AgrQqH35lJyqiNKNFFNRSzzmjQeyO2ZsUoYDPpgV/ZJteNjvJNXLV
         V5uY1f5F3/Uu9YMACX9Igjoml8exXFgtzX0Z/lMnYSiSbHJLJ4DqM+qqx3EhbP06u1
         8U4sc6xtaUr1ky12ozUsU3QvYNFM+QnwahMraJ9zhc6QBlUoMSfUFOsEWRwS+Vbi9/
         2mu6h1njuZ/Ew==
Date:   Tue, 12 Jan 2021 14:02:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        takahiro.akashi@linaro.org, catalin.marinas@arm.com,
        mpe@ellerman.id.au, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        zohar@linux.ibm.com, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [RFC PATCH 3/4] arm64: Use common of_kexec_setup_new_fdt()
Message-ID: <20210112140159.GB9277@willie-the-truck>
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211221006.1052453-4-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 11, 2020 at 04:10:05PM -0600, Rob Herring wrote:
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

-ENOCOMMITMSG

>  arch/arm64/kernel/machine_kexec_file.c | 123 +------------------------
>  1 file changed, 3 insertions(+), 120 deletions(-)

But I can't argue with that diffstat, so:

Acked-by: Will Deacon <will@kernel.org>

Will
