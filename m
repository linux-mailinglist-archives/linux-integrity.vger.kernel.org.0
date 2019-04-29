Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A119EAC2
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2019 21:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfD2TRW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Apr 2019 15:17:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40102 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2TRW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Apr 2019 15:17:22 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so820157itb.5
        for <linux-integrity@vger.kernel.org>; Mon, 29 Apr 2019 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NzJQz5xL7MiQ2OMfm+a1KJ0/8Yp30LWVmMH28GMmU80=;
        b=qlFzZFCxT20cELKT3ntBJ403eyKThcmAPcAxhbU9YXqcsUF+iVxlYAdUq0RIslqrOV
         Dg9wfThzoPnujPGEyqAb+jD9jUwrg6jbt1tFNo9qOo+gLxdilP8P6GvAiQQAOj2cMetK
         Slk1apCsxKGouuzZM+NSKWvowXea/KEhycLIk1GncUgncj66HUcSklp3yTnd7dJF/NFE
         vBtvpUpIQfSWA8e41i0fLSUhuRcDWc99whb2rLAYjSs6/YTIYfscbgaPcTkIypBvRsCv
         eZTzfQUCKIWvgnHcsU3EyGcdyMmVwMqvt39ViEa4E+fr/QKm0ISA3V6RFNXY9W63XWSw
         U/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NzJQz5xL7MiQ2OMfm+a1KJ0/8Yp30LWVmMH28GMmU80=;
        b=V0jXrGYuR2By0vV51bDxzIFYH8yKMyOxWdDMM5bmZYRXtUXNmVYpzf/lty1+lA21Ev
         4fIiBfbZIiCKdz2lpLxXRSv8lexDPlZIqKiyOCbAnenyKS19PNb8IsKIiN+2qIFjlAlg
         qP8ihkoMAD0lvmXsmm7qAGYooBM6zSZstAri1ARR8edyg5toNVPqFTCvjPWvmhg0/155
         w0v+1wSIQOyNQLGYuqFo7/oShv5EY90fqh16SepYvBjxStWHrVlM29YQOEyDhuZHKZym
         /WuFz9dMnKT3wvUXHDeLZLxyHpS9qVhC7E6nWQFy/gycsyK5nDLecLQCIsTJnYcDF4jD
         NnSQ==
X-Gm-Message-State: APjAAAVXlQrzYBCzYc/VR8kjECaH/LGOfyKa20Rlu3wwIKlIA6j6DiHN
        8oRCJEZWZQhvZd8DEoTPmz+dbH+9T+UR7OAjOt414888c08=
X-Google-Smtp-Source: APXvYqxMR/m+jT6ZZzLdkuHjRK3l7Ds9rVVFyamtOegdRNvL3SZrYldNA/fNNfqHM9CmkyNhP4v12KYcRPAUd6LL8IU=
X-Received: by 2002:a24:6b92:: with SMTP id v140mr547686itc.161.1556565440822;
 Mon, 29 Apr 2019 12:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
 <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com> <6373c67f-ea2f-ae1d-0343-4bb774f1d52f@linux.microsoft.com>
In-Reply-To: <6373c67f-ea2f-ae1d-0343-4bb774f1d52f@linux.microsoft.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Apr 2019 12:17:09 -0700
Message-ID: <CACdnJusXEq=7LXB=Ry0zH4CTRkQLHPC+5DnP07yXi0TNPeCYTw@mail.gmail.com>
Subject: Re: linux-tpmdd self signed kernel failing to boot with secreboot on
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 29, 2019 at 8:31 AM Jordan Hand <jorhand@linux.microsoft.com> w=
rote:
>
> On 4/25/19 2:47 PM, Matthew Garrett wrote:
> > On Wed, Apr 24, 2019 at 11:30 AM 'Jordan' via mjg59 <mjg59@google.com> =
wrote:
> >> Under the following circumstances my kernel will not boot:
> >
> > Will it boot under other circumstances (ie, if you disable Secure
> > Boot, does it work fine with the patches?)
>
> Yes it works fine if secure boot is disabled.

That is=E2=80=A6 very strange. Disabling secure boot will change the conten=
ts
of PCR7, but I can't think of any reason that would matter. What
hardware is this on?
