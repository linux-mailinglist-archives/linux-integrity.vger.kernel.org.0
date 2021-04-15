Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8717361024
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Apr 2021 18:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhDOQ2b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Apr 2021 12:28:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:33684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232759AbhDOQ2b (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 12:28:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FD91B2E1;
        Thu, 15 Apr 2021 16:28:07 +0000 (UTC)
Date:   Thu, 15 Apr 2021 18:28:06 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] travis: Fix openSUSE Tumbleweed
Message-ID: <YHhplvJDF56YHj/U@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210415112728.9307-1-pvorel@suse.cz>
 <31a1d0cbc858c14b51ee33b6861fb36d3ffbde4d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a1d0cbc858c14b51ee33b6861fb36d3ffbde4d.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

...
> > Changes v2->v3:
> > * remove sudo (replaced by --no-same-owner)

> Thanks, Petr.  Other than actually removing the "sudo",  the patch
> looks good and works properly on our internal travis too.  Assuming you
> don't object, I'll remove the "sudo".
Yes, and sorry for leaving it there.

Kind regards,
Petr
