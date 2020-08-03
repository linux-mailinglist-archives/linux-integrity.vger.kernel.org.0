Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB823A74B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCNLU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 09:11:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCNLU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 09:11:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65D6AB61B;
        Mon,  3 Aug 2020 13:11:34 +0000 (UTC)
Date:   Mon, 3 Aug 2020 15:11:17 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200803131117.GB30440@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
 <20200731201808.GA27841@dell5510>
 <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
 <20200731204044.GC27841@dell5510>
 <c28c63ca748236c0db4594d2ddc2f5b63cd75528.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c28c63ca748236c0db4594d2ddc2f5b63cd75528.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> Thanks, Vitaly, Petr, for catching this.  SSL isn't define yet.   The
> test should be removed.  If/when libressl is added, it would look like:

> -     - env: TSS=ibmtss
> -     - env: TSS=tpm2-tss
> +     - env: TSS=ibmtss SSL=openssl
> +     - env: TSS=ibmtss SSL=libressl;
> +     - env: TSS=tpm2-tss SSL=openssl

>  before_install:
> +   - if [ "${SSL}" = "libressl" ]; then
> +        ./tests/install-libressl.sh;
> +     fi

FYI: Libressl is packaged for some distros (if docker based Travis is used):

https://pkgs.org/download/libressl

Kind regards,
Petr
