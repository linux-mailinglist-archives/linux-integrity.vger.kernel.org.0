Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A3520094A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgFSNBo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 09:01:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbgFSNBo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 09:01:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AC36EAC91;
        Fri, 19 Jun 2020 13:01:41 +0000 (UTC)
Date:   Fri, 19 Jun 2020 15:01:40 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Bruno Meneguele <bmeneg@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, ltp@lists.linux.it,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200619130140.GA30256@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch>
 <1592252491.11061.181.camel@linux.ibm.com>
 <20200617012148.hhpvxqov2py7fvvc@cantor>
 <20200617204500.GB40831@glitch>
 <20200619082134.GB23036@dell5510>
 <1592570638.17802.8.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592570638.17802.8.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> > ...
> > > > > I'd appreciate if someone could send me a TPM event log, the PCRs, and
> > > > > the associated IMA ascii_runtime_measurements "boot_aggregate" from a
> > > > > system with a discrete TPM 2.0 with PCRs 8 & 9 events.


> > > Maybe Maurizio already have it at hand?
> > I'd appreciate to have these files as well.

> > > I can try to setup a system with grub2+tpm to get the log with pcr 8 and
> > > 9 filled.

> Both RHEL 8 and Ubuntu 20.04 LTS have PCRs 8 & 9.  I'll include one as
> another example for the tests/boot_aggregate.test.
Thank you!

Kind regards,
Petr
