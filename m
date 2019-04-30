Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD010293
	for <lists+linux-integrity@lfdr.de>; Wed,  1 May 2019 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfD3Wnr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Apr 2019 18:43:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36342 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfD3Wnr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Apr 2019 18:43:47 -0400
Received: by mail-io1-f68.google.com with SMTP id d19so13674629ioc.3
        for <linux-integrity@vger.kernel.org>; Tue, 30 Apr 2019 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q47pUKKllDZ/WLwX6haqwshGKbOUYi5iTs4E/o0EZTA=;
        b=vUpaIuipBePHKbXJNcG9ek0gtjxXsgAhzaHNWL1ubj4mKVcmrhuCRp3Qd2df1YK4El
         uJxzMd89BCcXzWEaitLp3Ei1cwyGeGrWEI1dTR4XX36tC1xLotGmlkKBjFEpgRs7Uutm
         micIxyjG1eo6S7V1Kpy2Wg33dYu/A8p0gm8c/JnpuiPGOBWXFdrP5s35tidA0bp6N/CM
         Uq4i3Az4+KuHNHK5cLrWtnCOk8CHVXC8ay4oiX8HFD5ADuXSuzyetIK97Bx2l96/COn2
         0yJC8YDn35HV1m3fgyndjx2diR73FFCOHkaKRNxxM0B1Zp350xD693DxjS8y47ljbmMn
         9Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q47pUKKllDZ/WLwX6haqwshGKbOUYi5iTs4E/o0EZTA=;
        b=mpEp3pS8ATurZBsPxcmpIn9cHHN/e4We7daRgyqOLEWF8mEHXt2/wAHQeLrpxLJWRQ
         GzVVxNyNHt02Q4zalM6uTc87P+zB7AlhWTpu3ZTcreeFX3UuZk9pBl38nXnyDkcG+9nP
         b0wHFLoRz0tngGmPqgDlo6uQkz8pC2H0ylEl/a71yaSI+zEj+TKIH2vpp77RPDdhN6xv
         dlP/dRHTHmdyTdIFCf+PvrboP59PlR0Vm4KyAn+aLAaTL0EBj5I3jiXNq2G1rzhjo+Fb
         0EzpEbxKfM/1ZvWRZKpyQRwqhDDuuTkXVwjRuxuYtOcEY/eD9VTdEWWhwWobi1F0jpMD
         kKqA==
X-Gm-Message-State: APjAAAVjWTJW6430NTJG6lsEiXqrQNok0ZgQ7pEjMCuYOwbNmnRVbmgA
        wWNZT4m7eJGpAoP0ysUkKhK6b1mWuVru9Q6ENkD06WLFRtU=
X-Google-Smtp-Source: APXvYqyA6bzsaAN3qu2N0dL/HlUDtX//ZskbIhkiF+7b41/h9XdpZtdiC+LUI5nLhGA664600SDIbuZt9cyKZRlpA6I=
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr1774479ioc.169.1556664226324;
 Tue, 30 Apr 2019 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
 <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com>
 <6373c67f-ea2f-ae1d-0343-4bb774f1d52f@linux.microsoft.com>
 <CACdnJusXEq=7LXB=Ry0zH4CTRkQLHPC+5DnP07yXi0TNPeCYTw@mail.gmail.com>
 <b4f9cc9d-bded-fb0a-1d53-40fa1460ddec@linux.microsoft.com>
 <CACdnJuuK=BqaHLDFU0+zXk539gobvaJFUpHuNL7nYZcpw8E0ZA@mail.gmail.com> <93b9433f-cc99-c1fe-f7d1-bc8d26fd4dc1@linux.microsoft.com>
In-Reply-To: <93b9433f-cc99-c1fe-f7d1-bc8d26fd4dc1@linux.microsoft.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 30 Apr 2019 15:43:35 -0700
Message-ID: <CACdnJuvpe6_O8jPb-2pBPqgAZ7J1NbuPvbOO4kDd4d80k8p8OA@mail.gmail.com>
Subject: Re: linux-tpmdd self signed kernel failing to boot with secreboot on
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 30, 2019 at 9:28 AM Jordan Hand <jorhand@linux.microsoft.com> wrote:

> 1st Gen (SKU Number from dmidecode is LENOVO_MT_3448)

Ok, unfortunately not able to grab one of those. If you boot with
earlyprintk=efi on the kernel command line, do you get any output
around the hang?
