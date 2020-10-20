Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBFB293543
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 08:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbgJTGyA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 02:54:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbgJTGyA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 02:54:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63CCBACDB;
        Tue, 20 Oct 2020 06:53:59 +0000 (UTC)
Date:   Tue, 20 Oct 2020 08:53:57 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] file2bin: Pass the right values to size and count
 parameters for fread()
Message-ID: <20201020065357.GA15734@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201019200526.12678-1-nramas@linux.microsoft.com>
 <9dd83103f724484a8f1febb37b54616d136930fe.camel@linux.ibm.com>
 <d4c7c8f3-e6b4-a962-c402-88982f86b79f@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c7c8f3-e6b4-a962-c402-88982f86b79f@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

> > Wasn't this problem addressed by Vitaly's patch.  Please look at commit
> > c89e8508864b ("ima-evm-utils: Fix reading of sigfile").


> You are right Mimi. I missed the patch posted by Vitaly. Sorry for the
> duplicate one.

> Looks like Vitaly's change hasn't been merged to "master" branch yet in
> https://github.com/pevik/ima-evm-utils
FYI: this is my fork, although I update it regularly, next time please check
with the real upstream: https://git.code.sf.net/p/linux-ima/ima-evm-utils

> thanks,
>  -lakshmi

Kind regards,
Petr
