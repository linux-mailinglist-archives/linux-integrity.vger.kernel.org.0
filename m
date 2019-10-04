Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2DCC0E9
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfJDQhp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 12:37:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58154 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbfJDQhp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 12:37:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D65978EE21D;
        Fri,  4 Oct 2019 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1570207064;
        bh=9/gg/H5bLdJpnhTAPNXhRv5fbH+hAXHLjl54w4KDegA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xx+Yvr2iM0hWVGfwX6Yxv+cFT/nml/QHdp3Q13C7ZVjlBfDGG+Zo+F8iCRW8kZ2ac
         9hYNEGirPm5X1TDVcSh11p0bJBwWRz/18fCuS6T5hjHw2BMdFhxhhUeIb/1wdnwVH3
         zgy9oekEIV4CozsTDuEm3VzBpefUII+duC2HXYzE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XXIx5vitGsIk; Fri,  4 Oct 2019 09:37:44 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 199BC8EE0EE;
        Fri,  4 Oct 2019 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1570207064;
        bh=9/gg/H5bLdJpnhTAPNXhRv5fbH+hAXHLjl54w4KDegA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xx+Yvr2iM0hWVGfwX6Yxv+cFT/nml/QHdp3Q13C7ZVjlBfDGG+Zo+F8iCRW8kZ2ac
         9hYNEGirPm5X1TDVcSh11p0bJBwWRz/18fCuS6T5hjHw2BMdFhxhhUeIb/1wdnwVH3
         zgy9oekEIV4CozsTDuEm3VzBpefUII+duC2HXYzE=
Message-ID: <1570207062.3563.17.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 2/2] tpm: Detach page allocation from tpm_buf
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Oct 2019 09:37:42 -0700
In-Reply-To: <20191003185103.26347-3-jarkko.sakkinen@linux.intel.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
         <20191003185103.26347-3-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
> As has been seen recently, binding the buffer allocation and tpm_buf
> together is sometimes far from optimal.

Can you elaborate on this a bit more?  I must have missed the
discussion.

>  The buffer might come from the caller namely when tpm_send() is used
> by another subsystem. In addition we can stability in call sites w/o
> rollback (e.g. power events)>
> 
> Take allocation out of the tpm_buf framework and make it purely a
> wrapper for the data buffer.

What you're doing here is taking a single object with a single lifetime
and creating two separate objects with separate lifetimes and a
dependency.  The problem with doing that is that it always creates
subtle and hard to debug corner cases where the dependency gets
violated, so it's usually better to simplify the object lifetimes by
reducing the dependencies and combining as many dependent objects as
possible into a single object with one lifetime.  Bucking this trend
for a good reason is OK, but I think a better reason than "is sometimes
far from optimal" is needed.

James

