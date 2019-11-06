Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301D1F1ECB
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 20:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKFTa4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 14:30:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727208AbfKFTa4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573068655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aeX/qY1kX0rqtY4ZWvOU/pUsOw1F+ValWUfiLNkyXZg=;
        b=gZeQbIAYIhfwGpg88TORXtq9NJmgqf++afH5MBZZbXG+Zztqh11QyPXVPs4DPGIf8973NK
        ClRq9LjpAUntFxE7km0DYUWzpepehIGyuhU3sE2Qt7dQ1fkrbqeYUaBJ6ys069hcmzqeTv
        FGe5nPkJcoGGKhNkR4YgvnmRWqtIrQk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-wYCyg_abNq64Ihxfy9wtAw-1; Wed, 06 Nov 2019 14:30:53 -0500
Received: by mail-wr1-f69.google.com with SMTP id e7so892510wro.22
        for <linux-integrity@vger.kernel.org>; Wed, 06 Nov 2019 11:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ap8fkxx4yLMWcULoh/+cxbh7DAc/eP+v7lAKsSEk07o=;
        b=rSF20mzVuMUAClVbu2RFVoF3h+nsPv3DxfyKxj69tEP7H0T2As1R0iRmhSNjyaWsV4
         YIB+dAnFjQTYBfhXOfL1VgOZ/U7u58gTpLtLu3sJDBqDa1D+1UHAnf2hkSdw2hPslyB3
         9ohY7xZTXbRzFdDhLLVD3FD2XlIWDK/ZkHX0dscNnoiOjFjtHTlBKGrtPwcUb64jaeC4
         2DI0noubRHMfpcreSNTLxfl6QyIFp+cqVAQf8bEQ7DCQVw4lyYHl0krZxfSa3Qlg1Tl7
         fVeVE1Ya11Q1DF6zfJcXQjLKu/5dC+eyNqyF0ivh22PQzcxQSAsyhlhMhu7N+NNvmXFH
         yv0Q==
X-Gm-Message-State: APjAAAWrwcNJlvCt+p6+qWo7cg3agozXZJui5xj9e+4BwgrTDe/UpE3H
        geyE2cDm464nVV4CcObBNw4BTsoiPp1yG2CvmsIKTUMURsKcNAEQ7lPR9dojVPyglk8Cn0eCug5
        zGtmJKI4KotXHcOEEVRs+gWRcJmOsGovlRnaHoH2DYj3l
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr4066566wrt.195.1573068651931;
        Wed, 06 Nov 2019 11:30:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8gOOV9zETgEEeYugO22mnL3B69ra5hfcyxrpsi9CKsuINmUNfJkvueKYaC0Kodb8lDhXcFeDCyloqPTRuM3A=
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr4066535wrt.195.1573068651450;
 Wed, 06 Nov 2019 11:30:51 -0800 (PST)
MIME-Version: 1.0
References: <01af8d01-30ef-c4e2-ab16-5d660a060fd5@linux.microsoft.com>
In-Reply-To: <01af8d01-30ef-c4e2-ab16-5d660a060fd5@linux.microsoft.com>
From:   Patrick Uiterwijk <puiterwijk@redhat.com>
Date:   Wed, 6 Nov 2019 20:30:40 +0100
Message-ID: <CAJmMGNvXYPDqPCmPmjaxc5n8j9OD+e5Ku9QE6ZihwSyAE4sbOg@mail.gmail.com>
Subject: Re: Mail to David Howells @ redhat bounced
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org
X-MC-Unique: wYCyg_abNq64Ihxfy9wtAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Wed, Nov 6, 2019 at 8:08 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> I'd copied David Howells on a patch set related to key measurement. The
> mail bounced:
>
> David Howells <dhowells@redhat.com>
>
> <dhowells@redhat.com>: Host or domain name not found. Name service error =
for
>      name=3Dint-mx-nasa.corp.redhat.com type=3DA: Host not found

This seems like problems at the time of sending with the Red Hat
mailservers, and as far as I can see, his email address is still the
same.

Could you send the full bounce email to me, so I can forward it to our IT t=
eam?

>
> Please let me know his current email address.
>
> thanks,
>   -lakshmi

Regards,
Patrick

