Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4D248E2A
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHRSt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 14:49:29 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53884 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbgHRSt2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 14:49:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3F0488EE183;
        Tue, 18 Aug 2020 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597776568;
        bh=qcEv2iFqzrs99Zj7q2RCHBHzVs37mJs/A42AhG7YMHc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gZF0xcVXd+HYWHVst88KG+xYvhx5HHFNwm4gKmplxscwW7OXMquAmI8DTgyZddE0M
         fIEvBbi5NhUf74DzCkpT1sg4G6ZoVscnxodXasuDkmA/NsL25XhuyNjF/4xRoE8ZSZ
         rMuKoEOPa+IYp30T8QKCD2ADqyVzDF7/Y52oNnl4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o6K9nuLQjnf4; Tue, 18 Aug 2020 11:49:28 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C32288EE17F;
        Tue, 18 Aug 2020 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597776568;
        bh=qcEv2iFqzrs99Zj7q2RCHBHzVs37mJs/A42AhG7YMHc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gZF0xcVXd+HYWHVst88KG+xYvhx5HHFNwm4gKmplxscwW7OXMquAmI8DTgyZddE0M
         fIEvBbi5NhUf74DzCkpT1sg4G6ZoVscnxodXasuDkmA/NsL25XhuyNjF/4xRoE8ZSZ
         rMuKoEOPa+IYp30T8QKCD2ADqyVzDF7/Y52oNnl4=
Message-ID: <1597776566.3898.52.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date:   Tue, 18 Aug 2020 11:49:26 -0700
In-Reply-To: <20200818171712.GZ24045@ziepe.ca>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <1597769070.3898.36.camel@HansenPartnership.com>
         <20200818171712.GZ24045@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-18 at 14:17 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 09:44:30AM -0700, James Bottomley wrote:
> 
> > The question you should be asking isn't whether the information
> > *could*
> > be obtained by other means, but whether providing it in this form
> > facilitates current operations and whether the interface would have
> > users.
> 
> Sure. What are the use cases that need PCRs but no other TPM
> operations?
> 
> The cover letter didn't say. As PCR is really only useful in the
> context of the local TPM I'm not thinking of anything..

The three use cases I picked up at the Boot and Security MC were:

   1. local log verification: a script can run through the IMA ascii log
      and construct the PCR 10 hash which can then be verified
   2. Knowing what the PCR values actually are for sealed keys.  With the
      current trusted key infrastructure you have to calculate and supply
      the hash yourself.  With the new proposed infrastructure, the hash
      would be calculated by the seal operation, but you're still going to
      need the actual PCR values to debug unseal failures.
   3. As a stability check for log shipping: you read the PCR take the log
      then read the PCR: if the two reads are the same the PCR backing the
      log is stable for quoting.

James

