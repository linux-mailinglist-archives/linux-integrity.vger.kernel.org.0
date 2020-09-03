Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0925C75E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Sep 2020 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgICQr3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Sep 2020 12:47:29 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48648 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728902AbgICQr1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Sep 2020 12:47:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A7E9D8EE112;
        Thu,  3 Sep 2020 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599151645;
        bh=ORSlGEz7I1sbplWG1dVNCqNQKy9pWevOmXKvPR6xbYc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=NiKd26CvtoY7awCdfSEqdYxvZ+Meqz62PxhHioRJCb2SuUoglrp3fTlV9mILdhE9B
         rYP7OodLcAM1owaFf6CNsU/G3NXGCsCQ8ZBCMUv8izw0cuvxermXUxFMHtc6WhnG6q
         8VKjZHuhLZAd2Cl9xaS34WCXfBiFPhfAFQbR95aY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HtVfkH_VWtdG; Thu,  3 Sep 2020 09:47:25 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C3A8A8EE0C6;
        Thu,  3 Sep 2020 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599151645;
        bh=ORSlGEz7I1sbplWG1dVNCqNQKy9pWevOmXKvPR6xbYc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=NiKd26CvtoY7awCdfSEqdYxvZ+Meqz62PxhHioRJCb2SuUoglrp3fTlV9mILdhE9B
         rYP7OodLcAM1owaFf6CNsU/G3NXGCsCQ8ZBCMUv8izw0cuvxermXUxFMHtc6WhnG6q
         8VKjZHuhLZAd2Cl9xaS34WCXfBiFPhfAFQbR95aY=
Message-ID: <1599151643.27597.8.camel@HansenPartnership.com>
Subject: Re: tpm:warn(2.0): out of memory for object contexts
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     William Roberts <bill.c.roberts@gmail.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@intel.com
Date:   Thu, 03 Sep 2020 09:47:23 -0700
In-Reply-To: <CAFftDdoA=XBqseT5JfRbTK2HLVbLkZ=QRpTzmcooNijXvtAhaw@mail.gmail.com>
References: <CAFftDdoA=XBqseT5JfRbTK2HLVbLkZ=QRpTzmcooNijXvtAhaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-09-03 at 10:07 -0500, William Roberts wrote:
> Hello,
> 
> I maintain a lot of the userspace components in the tpm2-software
> opensource community. We had a bug come in where we're getting oom
> TPM errors when using /dev/tpmrm0. The bug seems to go away when we
> use the userspace resource manager tpm2-abrmd. Thai leads me to
> believe that there is a kernel bug.
> 
> The question is, "is anyone aware of any bugs in the kernel RM that
> could cause this?"
> 
> The kernel version is:
> 5.4.0-42-generic #46-Ubuntu
> 
> The discussion can be found here:
>   - https://github.com/tpm2-software/tpm2-pkcs11/issues/567

That bug report is pretty unhelpful.  What specific error messages does
the kernel give?  I'm a heavy TPM key user (so lots of sessions and
volatile handles) I run RSA keys through the TPM for all my openvpn
sessions, ssh sessions and gpg transactions (mostly with RSA keys),
admittedly using the IBM TSS, and I've never seen this in any of my
systems.

James

