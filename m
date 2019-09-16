Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 899ECB36A8
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfIPIwy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 04:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfIPIwy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 04:52:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48F2D368CF;
        Mon, 16 Sep 2019 08:52:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9B52608C0;
        Mon, 16 Sep 2019 08:52:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com>
References: <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com> <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com> <11580.1568387033@warthog.procyon.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring subsystems
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32691.1568623971.1@warthog.procyon.org.uk>
Date:   Mon, 16 Sep 2019 09:52:51 +0100
Message-ID: <32692.1568623971@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 16 Sep 2019 08:52:54 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Joe Perches <joe@perches.com> wrote:

> > I would recommend splitting the patch in two and putting something like:
> > 
> > 	keys: Add Jarkko Sakkinen as co-maintainer
> > 
> > as the subject of the keyrings maintainership one.
> 
> Why is there utility in micro splitting such a trivial patch?

Because the keyrings maintainership piece is addressing a major procedural
concern on Linus's part - and I think it needs to go in its own patch with the
subject I suggested.

David
