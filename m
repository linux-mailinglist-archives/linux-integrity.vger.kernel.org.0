Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4500F23B623
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgHDHy4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 03:54:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:47002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgHDHy4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 03:54:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 164F1AB7D;
        Tue,  4 Aug 2020 07:55:11 +0000 (UTC)
Date:   Tue, 4 Aug 2020 09:54:53 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200804075453.GA7285@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
 <20200731204044.GC27841@dell5510>
 <20200731210653.p5m4efy52melqwgs@altlinux.org>
 <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
 <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
 <20200803130755.GA30440@dell5510>
 <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
 <20200803164635.GB4914@dell5510>
 <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
 <20200804072234.GA4337@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804072234.GA4337@dell5510>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> ...
> > I left off the list TPM 2.0 --pcr support, but the kernel code for
> > exporting the sysfs TPM 2.0 pcrs hasn't been upstreamed yet.   I guess
> > we should wait for that to be upstreamed or at least queued to be
> > upstreamed.
> OK, we have to wait. BTW is the patch somewhere on ML? Is it part of this
> pathset https://patchwork.kernel.org/cover/11656949/ ?
Oh, that's for ima_evm_utils. I meant patchset for kernel space.

Kind regards,
Petr
