Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F116522929C
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 09:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgGVHyW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 03:54:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:34482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbgGVHyV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 03:54:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23C56AEDA;
        Wed, 22 Jul 2020 07:54:28 +0000 (UTC)
Date:   Wed, 22 Jul 2020 09:54:18 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: ima-evm-utils: version 1.3 released
Message-ID: <20200722075418.GA7507@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1595379262.5311.31.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595379262.5311.31.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> The last ima-evm-utils release v1.2.1 was last July, a year ago, way
> too long ago.  Going forward I really would like to have more frequent
> releases.  New to v1.3 is ima-evm-utils regression tests, support for
> re-calculating the per TPM 2.0 bank template data digest, and much
> more.  For the details refer to the ChangeLog.

> I'd like to take this opportunity to thank you for your contributions,
> reviews, and testing!

Thanks for making the release.
BTW you uploaded 1.3 into linux-ima [1] directory (where old kernel releases
are) instead of ima-evm-utils [2]. Is that intentional? (some people / distros
might get confused).

Kind regards,
Petr

[1] https://sourceforge.net/projects/linux-ima/files/linux-ima/
[2] https://sourceforge.net/projects/linux-ima/files/ima-evm-utils/
