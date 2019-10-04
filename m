Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043D1CC1E6
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbfJDRlq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 13:41:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59140 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387428AbfJDRlq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 13:41:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 23C988EE21D;
        Fri,  4 Oct 2019 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1570210905;
        bh=y8xVxeb1DPLNLrDZFN+unjwHoSTFwPC/Cd11izdlLAQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nbt7KltFzo16aqLKNy9oVeUZIgtOvuYOBq7C0N5+S/2m/+2EhYTJCQ1nbPzJgwdPx
         XJyT5FsShIR7Ht9vZUhXKX2YD8g+WQkZ+RpLmfMpWMG9X+2lr6Api+GQ834actiEfw
         0T1Gcv5+uK+wHD9+weCeVB8PxeVa3D5baVXQNfLE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gr9W5rhU80Li; Fri,  4 Oct 2019 10:41:44 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3E71B8EE0EE;
        Fri,  4 Oct 2019 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1570210904;
        bh=y8xVxeb1DPLNLrDZFN+unjwHoSTFwPC/Cd11izdlLAQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sQnuD25aRhJ5dz5g6P8NxE8n+RNDS4c0UiDrBplsp6Q79HYORhVGkHsYUT7kX3JHd
         s4H9wMX19V4E4JiITW7FUB3HqVpzwaJN+y+YDRTUoUed02E8HTJS2/CRgurje8YLar
         s26TaVdwX0BsbQ9BFoyEhxvY/VU0Z2dOJlteRH34=
Message-ID: <1570210902.3563.19.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 2/2] tpm: Detach page allocation from tpm_buf
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Oct 2019 10:41:42 -0700
In-Reply-To: <1570210647.5046.78.camel@linux.ibm.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
         <20191003185103.26347-3-jarkko.sakkinen@linux.intel.com>
         <1570207062.3563.17.camel@HansenPartnership.com>
         <1570210647.5046.78.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-04 at 13:37 -0400, Mimi Zohar wrote:
> On Fri, 2019-10-04 at 09:37 -0700, James Bottomley wrote:
> > On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
> > > As has been seen recently, binding the buffer allocation and
> > > tpm_buf
> > > together is sometimes far from optimal.
> > 
> > Can you elaborate on this a bit more?  I must have missed the
> > discussion.
> 
> Refer to e13cd21ffd50 ("tpm: Wrap the buffer from the caller to
> tpm_buf in tpm_send()") for the details.

Yes, I get that, but to my mind that calls for moving the
tpm_init/destroy_buf into the callers of tpm_send (which, for the most
part, already exist), which means there's no need to separate the buf
and data lifetimes.

James

