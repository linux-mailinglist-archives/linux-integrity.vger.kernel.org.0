Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB67E8612E
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfHHLzl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Aug 2019 07:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHHLzl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Aug 2019 07:55:41 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A7621874;
        Thu,  8 Aug 2019 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565265340;
        bh=ajExdD9MvUPvivWKAOCCP3Sh0ZevjX8wHl40d2Wi3pw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WQZS0gjA5IFKfD6MwKv4d7aU6i1/Nv24C2lUrPTxl/84BjOJ4O8PLUDINcaseMng0
         +HNZ1fcel3pNCa2w0QcnzUe3MT8+1Qyf59m/HdpXCky07wBxGpqYryXImV2uV+sR0Z
         IDSP11tG3TVNULp5a1f9UZ4N5EF0K2Bx9nBoIkPI=
Message-ID: <1565265338.4077.1.camel@kernel.org>
Subject: Re: [PATCH] ima: Fix a use after free in ima_read_modsig()
From:   Mimi Zohar <zohar@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Thu, 08 Aug 2019 07:55:38 -0400
In-Reply-To: <20190808114549.GJ1935@kadam>
References: <20190808103310.GC30506@mwanda>
         <1565263042.4220.25.camel@kernel.org> <20190808114549.GJ1935@kadam>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-08-08 at 14:45 +0300, Dan Carpenter wrote:
> On Thu, Aug 08, 2019 at 07:17:22AM -0400, Mimi Zohar wrote:
> > On Thu, 2019-08-08 at 13:33 +0300, Dan Carpenter wrote:
> > > This code frees "hdr" and then dereferences it on the next line to get
> > > the error code.
> > > 
> > > Fixes: 39b07096364a ("ima: Implement support for module-style appended signatures")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > Thanks, Dan.  Julia already reported this.  Thiago posted a patch last
> > night.  Just getting to it now.  Can I add your Reviewed-by or Tested-
> > by?
> 
> I haven't seen the other patch so Reviewed-by seems like the wrong
> thing.  I don't really need any sort of credit.  I'm just going through
> my backlog of warnings from being out of office.  Perhaps Reported-by?

That works.  FYI, your solution and Thiago's are exactly the same.[1]

Mimi

[1] https://lore.kernel.org/linux-integrity/8736ico5ax.fsf@morokweng.localdomain/T/#u
