Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA7B948E
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404632AbfITPxb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Sep 2019 11:53:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37706 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404583AbfITPxb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Sep 2019 11:53:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 16E368EE19C;
        Fri, 20 Sep 2019 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568994811;
        bh=pLZxfGnwgV0W/U6tVbXsrcOVpVeJXJ9PgmIXKjKhaM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c9fcWv65wre+1MQv9uN6OJoZ6S0aOhkxGirxDTPiEn176gszxlr6Crn/jEg2IsgXu
         pC+cyPwLIOZF4iTtMV1+gK8hbKo58QvkHMzbXi6lahMZkpra3QJYZw2ZxRjI9K9kr4
         TgHgLxL36O7QkpMcIMerf4GO1umAGocE2Wuvb17c=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 03Zw01ncXwbb; Fri, 20 Sep 2019 08:53:30 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 71CE28EE109;
        Fri, 20 Sep 2019 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568994810;
        bh=pLZxfGnwgV0W/U6tVbXsrcOVpVeJXJ9PgmIXKjKhaM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YMyChGGA6Y6XBcqBUTwwugNdf1tWlhLBz1IpNw8w2wgyfVjlb3YcQDISwHhQXDPiN
         Ohw1uZ4qSsCGP9Zhbg0Orl0GDBpyb+ZqgY6R4OsAUgUf6BSi4KkwsO/otzsvQON3cT
         h309a/0Dw652hHHGqIFNGeXoB+mdSieh6ivHV8Ks=
Message-ID: <1568994809.3645.2.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 01/12] tpm-buf: move from static inlines to real
 functions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 20 Sep 2019 08:53:29 -0700
In-Reply-To: <20190920140642.GB9578@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
         <1568031476.6613.30.camel@HansenPartnership.com>
         <20190920140459.GA9578@linux.intel.com>
         <20190920140642.GB9578@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-09-20 at 17:06 +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 20, 2019 at 05:06:15PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 09, 2019 at 01:17:56PM +0100, James Bottomley wrote:
> > > This separates out the old tpm_buf_... handling functions from
> > > static
> > > inlines in tpm.h and makes them their own tpm-buf.c file.  This
> > > is a
> > > precursor so we can add new functions for other TPM type handling
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership
> > > .com>
> > 
> > What about TPM_BUF_2B that gets added in this commit?
> 
> Probably just a glitch in rebasing/squashing?

Well a glitch in splitting one patch into three, yes.  I'll fix it up.

James

