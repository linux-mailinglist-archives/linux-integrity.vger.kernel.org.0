Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE4221DD7
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGPIHZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 04:07:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgGPIHY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 04:07:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D23EB772;
        Thu, 16 Jul 2020 08:07:27 +0000 (UTC)
Date:   Thu, 16 Jul 2020 10:07:22 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Check for tsspcrread in runtime
Message-ID: <20200716080722.GA18117@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200715132817.8529-1-pvorel@suse.cz>
 <1594864066.12900.356.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594864066.12900.356.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

...
> > changes v1->v2:
> > * Log used binary/library.
> > * Drop using **errmsg in tpm2_pcr_supported() use log_info() and
> > log_debug() instead.
> > * Formatting changes in includes

> > Feel free to amend this patch to suit your needs.

> log_info() is not displaying the method of reading the PCRs.  To
> resolve this add the necessary USE_FPRINTF definitions.
Thanks for fixing this!

Kind regards,
Petr
