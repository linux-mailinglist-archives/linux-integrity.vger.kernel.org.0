Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D6CA1BA
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfJCP6o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 11:58:44 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35344 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730091AbfJCP6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 11:58:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 68A958EE10A;
        Thu,  3 Oct 2019 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1570118322;
        bh=VGwKHrqo6RFIDXSp9d41IuoxbN3n8/Kz+Lwg6xjLoZw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=AiHYIoZYGmrIUuj7MKt7JTvnambaqSUxiteZ4NFfMNsfoy9mTzPAM3+ueLN03PJri
         vypdXNzf8E1WPU5nfZ5toeYBZmkZYmCzCTcysVDHQiSfuRotJyNOATIyx8bmaOdrET
         sXN1GHcFCdGaInS4xspfifxJlHWfDTSt692rJ3Ws=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A7vNSQBWBHIQ; Thu,  3 Oct 2019 08:58:41 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7DC898EE0FD;
        Thu,  3 Oct 2019 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1570118321;
        bh=VGwKHrqo6RFIDXSp9d41IuoxbN3n8/Kz+Lwg6xjLoZw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=lKz23HNxYWNTLOypbiOlGSlDe1h5JCL5x2lrozpYw6QAl3jRj/6ds1TZhw+z6iyhe
         MBL7d7ooYt6mGvLj4XClehOYvyHzslY6glPI1LbzmuP5fcJjiNxbahFJOdfGm6dBti
         yx6BpzvrV2CamkvGwSYTH/KfoXiaVnKbFiCIHZs0=
Message-ID: <1570118319.17805.9.camel@HansenPartnership.com>
Subject: Re: ima_tpm_chip is queried and saved only at IMA init, but never
 later
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 03 Oct 2019 08:58:39 -0700
In-Reply-To: <d5aef823-9428-65d4-c045-c23d3466033e@linux.microsoft.com>
References: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
         <1569364624.5364.23.camel@HansenPartnership.com>
         <d5aef823-9428-65d4-c045-c23d3466033e@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-03 at 08:40 -0700, Lakshmi Ramasubramanian wrote:
> On 9/24/19 3:37 PM, James Bottomley wrote:
> > On Tue, 2019-09-24 at 15:31 -0700, Lakshmi Ramasubramanian wrote:
> > 
> > There has been some discussion that we could, for UEFI systems, use
> > the
> > UEFI runtime drivers for the TPM until the actual driver is
> > inserted
> > but no-one's looked into doing that.
> > 
> > James
> 
> Can IMA take a dependency on TPM and postpone IMA initialization
> until a TPM device shows up?

I don't believe we can postpone IMA initialization because it has to
start before any user space execution so it logs everything correctly
and the measurement chain is unbroken.

There are potentially two ways of fixing the IMA before TPM is ready
problem: one is to use the TPM BIOS device ... or really the UEFI
device since getting non-UEFI to measure external things is very non-
standard. And the other is to cache all the measurements and then
replay them through the TPM when it shows up.

> Has anyone looked into this?

I don't believe anyone has, no.

James

