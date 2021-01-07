Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4023E2ED058
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 14:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbhAGNDw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 08:03:52 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38952 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbhAGNDw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 08:03:52 -0500
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2021 08:03:51 EST
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AF37D72C8B0;
        Thu,  7 Jan 2021 15:53:59 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 989EF4A473A;
        Thu,  7 Jan 2021 15:53:59 +0300 (MSK)
Date:   Thu, 7 Jan 2021 15:53:59 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Patrick Uiterwijk <patrick@puiterwijk.org>,
        linux-integrity@vger.kernel.org, pbrobinson@redhat.com
Subject: Re: [PATCH 2/2] Add test for using sign_hash API
Message-ID: <20210107125359.flz7qupax2bhynzy@altlinux.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
 <20210106094335.3178261-3-patrick@puiterwijk.org>
 <021868cb0faadd4a61440974808880ff520f9bd6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <021868cb0faadd4a61440974808880ff520f9bd6.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 07, 2021 at 07:25:03AM -0500, Mimi Zohar wrote:
> > diff --git a/tests/sign_verify.apitest.c b/tests/sign_verify.apitest.c
> > new file mode 100644
> > index 0000000..20e2160
> > --- /dev/null
> > +++ b/tests/sign_verify.apitest.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * sign_verify.apitest: Test program for verifying sign_hash
> > + *
> > + * Copyright (C) 2020 Patrick Uiterwijk <patrick@puiterwijk.org>
> > + * Copyright (C) 2013,2014 Samsung Electronics
> > + * Copyright (C) 2011,2012,2013 Intel Corporation
> > + * Copyright (C) 2011 Nokia Corporation
> > + * Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
> > + */

Woah, so much copyright for a simple sign_hash() call?

> 
> Looking at the history, Dmitry Kasatkin must have been involved.  From
> which software package is this from?
