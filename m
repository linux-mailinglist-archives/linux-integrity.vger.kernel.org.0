Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C81860B1
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfHHLRZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Aug 2019 07:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730722AbfHHLRZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Aug 2019 07:17:25 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB459216C8;
        Thu,  8 Aug 2019 11:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565263044;
        bh=EgmzTvbmBPtgyJmYpImp81JbvFmYHBfzw7jbIIcUCDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=okDjrn1P8Gj8H4K5zBGi+k4oVfmwUO2LCPYquP2801qQ22GoIsWryj5FZmEKRS88q
         lpCPRbLxHDbeAT+1ccqMJXswwIDg4OsH/vV/pFv5q4ciTAUbHK7pNsAL7mmC/2NMOV
         qjJPuRCnwyAWXNmdX5bHA0opjXIHoN5HUOna1qjE=
Message-ID: <1565263042.4220.25.camel@kernel.org>
Subject: Re: [PATCH] ima: Fix a use after free in ima_read_modsig()
From:   Mimi Zohar <zohar@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Thu, 08 Aug 2019 07:17:22 -0400
In-Reply-To: <20190808103310.GC30506@mwanda>
References: <20190808103310.GC30506@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-08-08 at 13:33 +0300, Dan Carpenter wrote:
> This code frees "hdr" and then dereferences it on the next line to get
> the error code.
> 
> Fixes: 39b07096364a ("ima: Implement support for module-style appended signatures")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, Dan.  Julia already reported this.  Thiago posted a patch last
night.  Just getting to it now.  Can I add your Reviewed-by or Tested-
by?

Mimi
